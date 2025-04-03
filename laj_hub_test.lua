-- LAJ HUB Test Script
-- This test script validates basic functionality of the LAJ HUB code
-- Note: This can't test Roblox-specific functions but validates Lua syntax

print("Starting LAJ HUB test...")

-- Mock Roblox environment
local mockRoblox = {
    game = {
        PlaceId = 12345,
        Players = {
            LocalPlayer = {
                Name = "TestPlayer"
            }
        },
        GetService = function(self, serviceName)
            if serviceName == "HttpService" then
                return {
                    JSONEncode = function(_, data)
                        -- Simple JSON encoding mock
                        local json = "{"
                        for k, v in pairs(data) do
                            if type(v) == "string" then
                                json = json .. '"' .. k .. '":"' .. v .. '",'
                            elseif type(v) == "number" then
                                json = json .. '"' .. k .. '":' .. v .. ','
                            end
                        end
                        if json:sub(-1) == "," then
                            json = json:sub(1, -2)
                        end
                        return json .. "}"
                    end,
                    JSONDecode = function(_, jsonStr)
                        -- Very simple mock, not a real JSON parser
                        return {parsed = true}
                    end
                }
            elseif serviceName == "MarketplaceService" then
                return {
                    GetProductInfo = function(_, placeId)
                        return {Name = "Test Game"}
                    end
                }
            end
            return {}
        end,
        HttpGet = function(self, url)
            print("Mocked HttpGet call to: " .. url)
            return "-- Mock Lua script content\nprint('Hello from mock script')\nreturn true"
        end
    }
}

-- Override global environment with mocks
_G.game = mockRoblox.game

-- Create LAJ namespace
local LAJ = {
    Version = "3.0 ULTRA",
    History = {},
    Cache = {},
    Log = function(self, level, message)
        print("[" .. level .. "] " .. message)
    end,
    Games = {
        ["Test Game"] = {ID = 12345, Category = "Test", Script = "https://example.com/test.lua"}
    },
    Config = {
        Theme = "Dark",
        Favorites = {}
    },
    SendDiscordWebhook = function(self, message)
        print("Discord webhook called with: " .. message)
        return true
    end
}

print("Testing basic LAJ HUB utility functions...")

-- Test URL validation function
LAJ.ValidateGameScripts = function()
    print("Testing URL validation...")
    local validatedCount = 0
    local invalidCount = 0
    
    -- Function to check if a URL is valid (simplified for testing)
    local function isUrlValid(url)
        if not url or url == "" then
            return false
        end
        
        -- For testing, just check if the URL starts with http
        return url:sub(1, 4) == "http"
    end
    
    -- Check scripts for test games
    for gameName, gameInfo in pairs(LAJ.Games) do
        if gameInfo.Script and isUrlValid(gameInfo.Script) then
            validatedCount = validatedCount + 1
            print("  ✓ Valid script URL for " .. gameName)
        else
            invalidCount = invalidCount + 1
            print("  ✗ Invalid script URL for " .. gameName)
        end
    end
    
    print("URL validation complete: " .. validatedCount .. " valid, " .. invalidCount .. " invalid scripts")
end

-- Test alternative script finder
LAJ.GetAlternativeScript = function(gameName)
    print("Testing alternative script finder for: " .. (gameName or "nil"))
    
    -- Test data
    local altSources = {
        ["Blox Fruits"] = {
            "https://raw.githubusercontent.com/test/test1.lua",
            "https://raw.githubusercontent.com/test/test2.lua"
        }
    }
    
    if altSources[gameName] then
        print("  ✓ Found alternative scripts for " .. gameName)
        return altSources[gameName]
    end
    
    print("  ✗ No alternative scripts found for " .. gameName)
    return nil
end

-- Test script loading function (simplified)
LAJ.LoadScript = function(url, name)
    print("Loading script: " .. name .. " from " .. url)
    
    -- Add to history
    table.insert(LAJ.History, {
        Name = name,
        URL = url,
        Time = os.time()
    })
    
    -- Simulate script execution
    local success = pcall(function()
        local content = _G.game:HttpGet(url)
        -- In a real scenario, we would loadstring(content)()
        print("  Script content fetched successfully")
        return true
    end)
    
    if success then
        print("  ✓ " .. name .. " was successfully executed (simulated)")
        return true
    else
        print("  ✗ Failed to load " .. name)
        return false
    end
end

-- Run tests
print("\n--- Starting LAJ HUB Tests ---\n")

-- Test webhook
print("\nTesting webhook notification:")
LAJ:SendDiscordWebhook("LAJ HUB " .. LAJ.Version .. " test notification")

-- Test URL validation
print("\nTesting URL validation:")
LAJ.ValidateGameScripts()

-- Test alternative script finding
print("\nTesting alternative script finder:")
local bloxFruitsAlts = LAJ.GetAlternativeScript("Blox Fruits")
local unknownGameAlts = LAJ.GetAlternativeScript("Unknown Game")

-- Test script loading
print("\nTesting script loading:")
LAJ.LoadScript("https://example.com/test.lua", "Test Script")

-- Test history functionality
print("\nTesting history:")
print("History entries: " .. #LAJ.History)
if #LAJ.History > 0 then
    print("Last executed script: " .. LAJ.History[#LAJ.History].Name)
end

print("\n--- LAJ HUB Tests Completed ---\n")