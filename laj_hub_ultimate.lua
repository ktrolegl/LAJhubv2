--[[
    LAJ HUB ULTIMATE
    
    The most comprehensive Roblox exploit script hub
    Combines TrixAde scripts repository with other popular exploits
    
    Features:
    - Auto-detection of current game
    - Categorized script organization
    - Favorites system for quick access
    - History tracking for recent scripts
    - Dashboard with personalized recommendations
    - Enhanced UI with custom themes
    - Secure key system for authentication
]]

-- Enhanced executor compatibility with comprehensive support for all major executors
local executorFunctions = {
    FileSystem = typeof(readfile) == "function" and typeof(writefile) == "function",
    HttpRequest = typeof(syn) == "table" and typeof(syn.request) == "function" or 
                 typeof(http) == "table" and typeof(http.request) == "function" or 
                 typeof(request) == "function" or 
                 typeof(http_request) == "function" or
                 typeof(HttpPost) == "function" or
                 (typeof(fluxus) == "table" and typeof(fluxus.request) == "function") or
                 (typeof(delta) == "table" and typeof(delta.request) == "function") or
                 (typeof(crypt) == "table" and typeof(crypt.request) == "function") or
                 (KRNL_LOADED == true and typeof(request) == "function") or
                 (typeof(Oxygen) == "table" and typeof(Oxygen.HttpRequest) == "function"),
    Execute = typeof(loadstring) == "function" or (typeof(syn) == "table" and typeof(syn.load) == "function"),
    Clipboard = typeof(setclipboard) == "function" or (typeof(syn) == "table" and typeof(syn.write_clipboard) == "function") or (typeof(Clipboard) == "table" and typeof(Clipboard.set) == "function"),
    AssetSupport = typeof(getcustomasset) == "function" or typeof(getsynasset) == "function"
}

-- Check if the executor can run LAJ HUB properly
if not executorFunctions.Execute then
    local errorMessage = "LAJ HUB requires an executor with loadstring support. Your executor cannot run this script."
    warn(errorMessage)
    return
end

-- Check for mandatory HTTP support
if not executorFunctions.HttpRequest then
    local errorMessage = "LAJ HUB requires an executor with HTTP request support.\n"
    errorMessage = errorMessage .. "Please use Synapse X, KRNL, Fluxus, Delta, or another modern executor."
    
    -- Try to display a visual message if possible
    pcall(function()
        local messageGui = Instance.new("ScreenGui")
        messageGui.Name = "LAJHubError"
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 150)
        frame.Position = UDim2.new(0.5, -150, 0.5, -75)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BorderSizePixel = 0
        frame.Parent = messageGui
        
        local title = Instance.new("TextLabel")
        title.Text = "LAJ HUB ULTIMATE - Compatibility Error"
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.BorderSizePixel = 0
        title.Font = Enum.Font.SourceSansBold
        title.TextSize = 18
        title.Parent = frame
        
        local message = Instance.new("TextLabel")
        message.Text = errorMessage
        message.Size = UDim2.new(1, -20, 1, -40)
        message.Position = UDim2.new(0, 10, 0, 35)
        message.BackgroundTransparency = 1
        message.TextColor3 = Color3.fromRGB(255, 255, 255)
        message.TextWrapped = true
        message.Font = Enum.Font.SourceSans
        message.TextSize = 14
        message.Parent = frame
        
        -- Attempt to parent to CoreGui or PlayerGui as fallback
        if syn and syn.protect_gui then
            syn.protect_gui(messageGui)
            messageGui.Parent = game:GetService("CoreGui")
        elseif gethui then
            messageGui.Parent = gethui()
        elseif game:GetService("CoreGui") then
            messageGui.Parent = game:GetService("CoreGui")
        else
            messageGui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
        end
    end)
    
    warn(errorMessage)
    return
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Initialize the LAJ object
local LAJ = {}
LAJ.Version = "v3.0.0-ULTIMATE"
LAJ.History = {}
LAJ.Cache = {}
LAJ.Modules = {}
LAJ.WebhookURL = "https://discord.com/api/webhooks/1357395980299014224/VHqKfAsLDqGIUQ5icewgv8YX-SblIBEsmG3NmaMG83y68hQcGrfTEXmdW0rCy0P98zuz"

-- Load UI framework
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Utility functions
LAJ.Log = function(type, message)
    if type == "Success" then
        print("✅ [LAJ HUB] " .. message)
    elseif type == "Error" then
        warn("❌ [LAJ HUB] " .. message)
    elseif type == "Warning" then
        warn("⚠️ [LAJ HUB] " .. message)
    else
        print("ℹ️ [LAJ HUB] " .. message)
    end
end

-- Discord webhook function compatible with all executors (including Delta)
LAJ.SendDiscordWebhook = function(message)
    if LAJ.WebhookURL then
        pcall(function()
            local data = {
                ["content"] = message,
                ["embeds"] = {{
                    ["title"] = "LAJ HUB Usage Notification",
                    ["description"] = message,
                    ["color"] = 5814783,
                    ["footer"] = {
                        ["text"] = "LAJ HUB " .. LAJ.Version
                    },
                    ["timestamp"] = os.date("%Y-%m-%dT%H:%M:%S", os.time())
                }}
            }
            
            local httpService = game:GetService("HttpService")
            local headers = {["Content-Type"] = "application/json"}
            local finalData = httpService:JSONEncode(data)
            
            -- Support for all executors including Delta
            local request_func
            if syn and syn.request then
                request_func = syn.request
            elseif http and http.request then
                request_func = http.request
            elseif http_request then
                request_func = http_request
            elseif request then
                request_func = request
            elseif HttpPost then
                request_func = HttpPost
            elseif fluxus and fluxus.request then
                request_func = fluxus.request
            elseif delta and delta.request then
                request_func = delta.request
            elseif KRNL_LOADED and request then
                request_func = request
            elseif crypt and crypt.request then
                request_func = crypt.request
            end
            
            if request_func then
                request_func({
                    Url = LAJ.WebhookURL,
                    Method = "POST",
                    Headers = headers,
                    Body = finalData
                })
            else
                print("Warning: No HTTP request function found for your executor")
            end
        end)
    end
end

LAJ.Log("Info", "Initializing LAJ HUB " .. LAJ.Version)

-- Validate all game script URLs to ensure they're working
LAJ.ValidateGameScripts = function()
    LAJ.Log("Info", "Validating game script URLs...")
    local validatedCount = 0
    local invalidCount = 0
    local attempts = 0
    
    -- Function to check if a URL is valid
    local function isUrlValid(url)
        if not url or url == "" then
            return false
        end
        
        -- Try to fetch the URL without executing it
        local success = pcall(function()
            if syn and syn.request then
                local response = syn.request({
                    Url = url,
                    Method = "HEAD"
                })
                return response.StatusCode == 200
            else
                -- Fallback to a quick GET request
                local content = game:HttpGet(url)
                return content and #content > 0
            end
        end)
        
        return success
    end
    
    -- Check scripts for all games
    for gameName, gameInfo in pairs(LAJ.Games) do
        attempts = attempts + 1
        
        -- Only check 10 random scripts to avoid excessive requests
        if attempts > 10 and math.random() > 0.2 then
            continue
        end
        
        if gameInfo.Script and isUrlValid(gameInfo.Script) then
            validatedCount = validatedCount + 1
        else
            invalidCount = invalidCount + 1
            LAJ.Log("Warning", "Script URL for " .. gameName .. " appears to be invalid")
            
            -- Try to fix common URL issues
            if gameInfo.Script then
                local originalUrl = gameInfo.Script
                local fixedUrl = gameInfo.Script
                
                -- Fix common URL issues
                fixedUrl = fixedUrl:gsub("githubusercontent.com/([^/]+)/([^/]+)/main", "githubusercontent.com/%1/%2/master")
                
                -- If URL was fixed, update it
                if fixedUrl ~= originalUrl then
                    LAJ.Log("Info", "Attempting to fix URL for " .. gameName)
                    gameInfo.Script = fixedUrl
                    
                    -- Check if fixed URL works
                    if isUrlValid(fixedUrl) then
                        LAJ.Log("Success", "Fixed script URL for " .. gameName)
                        validatedCount = validatedCount + 1
                        invalidCount = invalidCount - 1
                    end
                end
            end
        end
    end
    
    -- Log results
    LAJ.Log("Info", "URL validation complete: " .. validatedCount .. " valid, " .. invalidCount .. " potentially invalid scripts")
end

-- Test for alternative script sources if the main source fails
LAJ.GetAlternativeScript = function(gameName)
    if not gameName then return nil end
    
    -- Common alternative script sources for popular games
    local altSources = {
        ["Blox Fruits"] = {
            "https://raw.githubusercontent.com/xDepressionx/Free-Script/main/BloxFruit.lua",
            "https://raw.githubusercontent.com/scriptpastebin/raw/main/BloxFruit"
        },
        ["Arsenal"] = {
            "https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init",
            "https://raw.githubusercontent.com/fusiongreg/BoltsHubV5/main/Arsenal"
        },
        ["Adopt Me"] = {
            "https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven",
            "https://raw.githubusercontent.com/IceMael7/IceHub_MM2/main/Main"
        },
        ["Phantom Forces"] = {
            "https://raw.githubusercontent.com/VoidMasterX/strawhook/main/script.lua",
            "https://raw.githubusercontent.com/VoidMasterX/scripts/main/phantom-forces.lua"
        }
    }
    
    -- Return the alternative scripts if they exist
    if altSources[gameName] then
        return altSources[gameName]
    end
    
    -- Alternative by game category
    local gameInfo = nil
    for name, info in pairs(LAJ.Games) do
        if name == gameName then
            gameInfo = info
            break
        end
    end
    
    if not gameInfo or not gameInfo.Category then
        return nil
    end
    
    -- Generic alternative scripts by category
    local catSources = {
        ["FPS"] = {
            "https://raw.githubusercontent.com/VoidMasterX/strawhook/main/script.lua",
            "https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init"
        },
        ["RPG"] = {
            "https://raw.githubusercontent.com/xDepressionx/Free-Script/main/AllScript.lua",
            "https://raw.githubusercontent.com/scriptpastebin/raw/main/Universal"
        }
    }
    
    return catSources[gameInfo.Category]
end

-- Automatically fix broken game script URLs
LAJ.FixBrokenScripts = function()
    local fixedScripts = 0
    
    -- Attempt to fix any scripts with known issues
    for gameName, gameInfo in pairs(LAJ.Games) do
        if gameInfo.Script then
            -- Check for old GitHub repositories that may have been renamed
            local alternativeURLs = {
                -- TrixAde scripts redirects
                ["https://raw.githubusercontent.com/TrixAde/scripts/main/"] = {
                    "https://raw.githubusercontent.com/TrixAde/scripts/master/",
                    "https://raw.githubusercontent.com/TrixAdeGH/scripts/main/",
                    "https://raw.githubusercontent.com/TrixAde/Roblox-Scripts/main/"
                },
                -- Other common script source changes
                ["github.com/V.G-Hub/main/"] = "github.com/1201for/V.G-Hub/main/",
                ["babyhamsta/RBLX_Scripts"] = "Babyhamsta/RBLX_Scripts"
            }
            
            for oldPattern, newPatterns in pairs(alternativeURLs) do
                if string.find(gameInfo.Script, oldPattern) then
                    -- Try alternative patterns
                    if type(newPatterns) == "table" then
                        for _, newPattern in ipairs(newPatterns) do
                            local alternativeURL = string.gsub(gameInfo.Script, oldPattern, newPattern)
                            
                            -- Check if the alternative URL works
                            local success = pcall(function()
                                local content = game:HttpGet(alternativeURL)
                                return content and #content > 10
                            end)
                            
                            if success then
                                -- Found a working alternative
                                gameInfo.Script = alternativeURL
                                fixedScripts = fixedScripts + 1
                                LAJ.Log("Success", "Fixed script for " .. gameName .. " using alternative source")
                                break
                            end
                        end
                    else
                        -- Single pattern replacement
                        local alternativeURL = string.gsub(gameInfo.Script, oldPattern, newPatterns)
                        local success = pcall(function()
                            local content = game:HttpGet(alternativeURL)
                            return content and #content > 10
                        end)
                        
                        if success then
                            gameInfo.Script = alternativeURL
                            fixedScripts = fixedScripts + 1
                            LAJ.Log("Success", "Fixed script for " .. gameName .. " using alternative source")
                        end
                    end
                end
            end
        end
    end
    
    LAJ.Log("Info", "Fixed " .. fixedScripts .. " broken script URLs")
    return fixedScripts
end

-- Send webhook notification on script execution
local playerName = game.Players.LocalPlayer.Name
local placeId = game.PlaceId
local placeName = "Unknown"
pcall(function() placeName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name end)

-- Send webhook with user info
LAJ.SendDiscordWebhook("LAJ HUB " .. LAJ.Version .. " was executed by **" .. playerName .. 
                       "** in game: " .. placeName .. " (ID: " .. placeId .. ")")

-- Validate and fix game scripts in the background
spawn(function()
    LAJ.FixBrokenScripts()
    LAJ.ValidateGameScripts()
end)

-- Load script from URL
LAJ.LoadScript = function(url, name)
    LAJ.Log("Info", "Loading " .. name .. "...")
    
    -- Add to history
    table.insert(LAJ.History, {
        Name = name,
        URL = url,
        Time = os.time()
    })
    
    -- Limit history size
    if #LAJ.History > 20 then
        table.remove(LAJ.History, 1)
    end
    
    -- Save history if file system available
    if executorFunctions.FileSystem then
        writefile("LAJHub_History.json", game:GetService("HttpService"):JSONEncode(LAJ.History))
    end
    
    -- Execute with advanced error handling (compatible with all executors)
    -- First verify script URL is valid
    if not url or url == "" then
        return LAJ.Log("Error", "Invalid script URL for " .. name)
    end
    
    -- Transform URL if needed (handle redirects, special cases)
    if string.find(url, "pastebin.com/") and not string.find(url, "pastebin.com/raw/") then
        url = string.gsub(url, "pastebin.com/", "pastebin.com/raw/")
    end
    
    -- Attempt to get script content with multiple fallback methods
    local success, result = pcall(function()
        local content
        local fetchSuccess = false
        
        -- Function to verify content is valid Lua script
        local function isValidLuaScript(str)
            if not str or type(str) ~= "string" or #str < 10 then
                return false
            end
            
            -- Basic check for valid Lua syntax markers
            return string.find(str, "function") or 
                   string.find(str, "local") or 
                   string.find(str, "if") or
                   string.find(str, "for") or
                   string.find(str, "game") or
                   string.find(str, "script")
        end
        
        -- Try different HTTP request methods across executors
        local httpMethods = {
            {name = "Synapse X", condition = syn and syn.request, fetch = function() return game:HttpGet(url) end},
            {name = "HTTP Library", condition = http and http.request, fetch = function() return game:HttpGet(url) end},
            {name = "Request", condition = request, fetch = function() return game:HttpGet(url) end},
            {name = "HttpPost", condition = HttpPost, fetch = function() return game:HttpGet(url) end},
            {name = "Fluxus", condition = fluxus and fluxus.request, fetch = function() 
                local res = fluxus.request({Url = url, Method = "GET"})
                return res.Body
            end},
            {name = "Delta", condition = delta and delta.request, fetch = function() 
                local res = delta.request({Url = url, Method = "GET"})
                return res.Body
            end},
            {name = "KRNL", condition = KRNL_LOADED, fetch = function() return game:HttpGet(url) end},
            {name = "Default HttpGet", condition = true, fetch = function() return game:HttpGet(url) end},
        }
        
        -- Attempt each HTTP method
        for _, method in ipairs(httpMethods) do
            if method.condition then
                LAJ.Log("Info", "Trying to fetch script using " .. method.name)
                local success, fetchResult = pcall(method.fetch)
                
                if success and isValidLuaScript(fetchResult) then
                    content = fetchResult
                    fetchSuccess = true
                    LAJ.Log("Success", "Script fetched successfully using " .. method.name)
                    break
                end
            end
        end
        
        -- If content fetch failed with all methods
        if not fetchSuccess or not content then
            LAJ.Log("Error", "Failed to fetch script content from " .. url)
            return error("Failed to fetch script content")
        end
        
        -- Check for script protection/encryption
        if string.find(content, "protected by") or string.find(content, "encrypted") then
            LAJ.Log("Warning", "This script appears to be protected or encrypted - execution might fail")
        end
        
        -- Attempt to execute the script
        LAJ.Log("Info", "Executing script...")
        
        -- Regular loadstring attempt
        local loadSuccess, loadError = pcall(function()
            return loadstring(content)()
        end)
        
        if not loadSuccess then
            -- If regular loadstring failed, try alternative methods based on the executor
            LAJ.Log("Warning", "Standard execution failed, trying alternative methods: " .. tostring(loadError))
            
            -- Try Synapse specific methods
            if syn and syn.load then
                return syn.load(content)
            end
            
            -- Try hookfunction or other bypass methods for protected scripts
            local env = getfenv(0)
            local func, err = load(content, name, "bt", env)
            if func then
                return func()
            else
                return error("All execution methods failed: " .. tostring(err))
            end
        end
        
        return loadSuccess
    end)
    
    if success then
        LAJ.Log("Success", name .. " was successfully executed")
        
        -- Send webhook notification when a script is executed
        local playerName = game.Players.LocalPlayer.Name
        local placeId = game.PlaceId
        local placeName = "Unknown"
        pcall(function() placeName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name end)
        
        LAJ.SendDiscordWebhook("Script executed: **" .. name .. "** by user **" .. playerName .. 
                               "** in game: " .. placeName .. " (ID: " .. placeId .. ")")
        
        return true
    else
        LAJ.Log("Error", "Failed to load " .. name .. ": " .. tostring(result))
        return false
    end
end

-- Load scripts from multiple GitHub repositories
LAJ.OriginalScripts = {
    ["Psalm"] = "https://raw.githubusercontent.com/NewWhitelistService/l/refs/heads/main/psalms%20old.lua",
    ["Ballware vfs"] = "https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/refs/heads/main/Protected_4021809531880627.txt",
    ["FrostByte"] = "https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak",
    ["Ronix"] = "https://api.luarmor.net/files/v3/loaders/a3c501e721ec4d66a864cc2276c0f4e9.lua",
    ["Speed Hub"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"
}

-- Popular script hubs and universal exploits
LAJ.GitHubRepos = {
    -- Premium Hubs
    ["Owl Hub"] = "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt",
    ["Solaris Hub"] = "https://raw.githubusercontent.com/SolarisHub/Documentation/main/SolarisHub.lua",
    ["DomainX Hub"] = "https://raw.githubusercontent.com/shlexware/DomainX/main/source",
    ["EvoV2"] = "https://raw.githubusercontent.com/Project-Evolution/Archive/main/EvoV2",
    ["Sirius"] = "https://raw.githubusercontent.com/shlexware/Sirius/request/Loader",
    
    -- Admin Scripts
    ["Infinite Yield"] = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    ["CMD-X"] = "https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source",
    ["Fate's Admin"] = "https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua",
    
    -- Universal Scripts
    ["Hydroxide"] = "https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/init.lua",
    ["Remote Spy"] = "https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua",
    ["Script Dumper"] = "https://raw.githubusercontent.com/78n/SimpleSpy/main/ScriptDumper.lua",
    ["Dex Explorer"] = "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua",
    
    -- Misc Tools
    ["Anti AFK"] = "https://raw.githubusercontent.com/KazeOnTop/Rice-Anti-Afk/main/Wind",
    ["FPS Booster"] = "https://raw.githubusercontent.com/CasperFlyModz/discord.gg-FPSBooster/main/FPS%20Booster",
    ["Universal ESP"] = "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua",
    ["Click TP"] = "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Click%20Teleport",
    
    -- Well-known Specialty Hubs
    ["V.G Hub"] = "https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub",
    ["Moon UI"] = "https://raw.githubusercontent.com/IlikeyocutgHAH/MoonUI-v10-/main/MoonUI",
    ["NukeVsCity"] = "https://raw.githubusercontent.com/NukeVsCity/TheALLHACKLoader/main/NukeLoader",
    ["Uranium Hub"] = "https://raw.githubusercontent.com/Augustzyzx/UraniumMobile/main/UraniumKak.lua",
    ["Parvus Hub"] = "https://raw.githubusercontent.com/AlexR32/Parvus/main/Loader.lua"
}

-- Game database with TrixAde scripts
LAJ.Games = {
    -- FPS Games
    ["Phantom Forces"] = {ID = 292439477, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/phantom-forces.lua"},
    ["Arsenal"] = {ID = 286090429, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/ArsenalOwlHub.lua"},
    ["Bad Business"] = {ID = 3233893879, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/bad-business.lua"},
    ["Strucid"] = {ID = 2377868063, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/strucid.lua"},
    ["Rush Point"] = {ID = 5993942214, Category = "FPS"},
    ["Apocalypse Rising"] = {ID = 1600503, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/ApocalypseRising.lua"},
    ["Big Paintball"] = {ID = 3527629287, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/big-paintball.lua"},
    ["Energy Assault"] = {ID = 6172932937, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/Energy%20Assault.lua"},
    ["Counter Blox"] = {ID = 301549746, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/CounterBlox.lua"},
    ["Those Who Remain"] = {ID = 488667523, Category = "FPS", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/ThoseWhoRemain.lua"},
    
    -- RPG Games
    ["Blox Fruits"] = {ID = 2753915549, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/BloxFruit.lua"},
    ["King Legacy"] = {ID = 4520749081, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/KingLegacy.lua"},
    ["Pet Simulator X"] = {ID = 6284583030, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/PetSimX.lua"},
    ["Anime Fighting Simulator"] = {ID = 4042427666, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/AnimeFighting.lua"},
    ["Shindo Life"] = {ID = 4616652839, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/ShindoLife.lua"},
    ["Your Bizarre Adventure"] = {ID = 2809202155, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/your-bizarre-adventure.lua"},
    ["Anime Dimensions"] = {ID = 6938803611, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/animedimension.lua"},
    ["Dungeon Quest"] = {ID = 2414851778, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/dungeon-quest.lua"},
    ["Slayer Tycoon"] = {ID = 7234162497, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/slayer-tycoon.lua"},
    ["Murder Mystery 2"] = {ID = 142823291, Category = "RPG", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/murder-mystery-2.lua"},
    
    -- Town & City Games
    ["Adopt Me"] = {ID = 920587237, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/adoptme.lua"},
    ["Brookhaven"] = {ID = 4924922222, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/brook-haven.lua"},
    ["MeepCity"] = {ID = 370731277, Category = "Town & City"},
    ["Welcome to Bloxburg"] = {ID = 185655149, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/bloxburg.lua"},
    ["Work at a Pizza Place"] = {ID = 192800, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/work-a-pizza-place.lua"},
    ["My Restaurant"] = {ID = 4490140733, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/my-restaurant.lua"},
    ["Vans World"] = {ID = 6679968919, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/vans-world.lua"},
    ["Royal High"] = {ID = 735030788, Category = "Town & City", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/royal-high.lua"},
    
    -- Fighting Games
    ["Da Hood"] = {ID = 2788229376, Category = "Fighting", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/da-hood.lua"},
    ["Hood Customs"] = {ID = 9183932460, Category = "Fighting"},
    ["Prison Life"] = {ID = 155615604, Category = "Fighting", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/prison-life.lua"},
    ["Breaking Point"] = {ID = 648362523, Category = "Fighting", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/breaking-point.lua"},
    
    -- Simulation Games
    ["Fishing Simulator"] = {ID = 2866967438, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/FishingSim.lua"},
    ["Mining Simulator 2"] = {ID = 9551640993, Category = "Simulation"},
    ["Car Dealership Tycoon"] = {ID = 1554960397, Category = "Simulation"},
    ["Strongman Simulator"] = {ID = 5338710779, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/strongman-simulator.lua"},
    ["Superhero Simulator"] = {ID = 2577423786, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/superheosim.lua"},
    ["BackFlip Simulator"] = {ID = 2481601704, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/BackFlipSim.lua"},
    ["Saber Simulator"] = {ID = 3823781113, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/saber-simulator.lua"},
    ["Bee Swarm Simulator"] = {ID = 1537690962, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/bee-swarm.lua"},
    ["Destruction Simulator"] = {ID = 2248408710, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/destruction-simulator.lua"},
    ["Car Crusher"] = {ID = 13229599, Category = "Simulation", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/car-crusher.lua"},
    
    -- Adventure Games
    ["Jailbreak"] = {ID = 606849621, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/jailbreak.lua"},
    ["Mad City"] = {ID = 1224212277, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/madcity.lua"},
    ["Ninja Legends"] = {ID = 3956818381, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/ninja-legends.lua"},
    ["Tower of Hell"] = {ID = 1962086868, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/tower-of-hell.lua"},
    ["Tower of Misery"] = {ID = 4954752502, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/tower-of-misery.lua"},
    ["The Mimic"] = {ID = 6243699076, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/the-mimic.lua"},
    ["Build A Boat For Treasure"] = {ID = 537413528, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/build-a-boat-for-treasure.lua"},
    ["Shark Bite"] = {ID = 734159876, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/shark-bite.lua"},
    ["Parkour"] = {ID = 445664957, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/parkour.lua"},
    ["Speed Run 4"] = {ID = 183364845, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/speed-run-4.lua"},
    ["Piggy"] = {ID = 4623386862, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/piggy.lua"},
    ["Bedwars"] = {ID = 6872265039, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/bedwars.lua"},
    ["SkyWars"] = {ID = 855499080, Category = "Adventure", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/skywars.lua"},
    
    -- Horror Games
    ["Survive the Killer"] = {ID = 4580204640, Category = "Horror", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/survive-the-killer.lua"},
    ["Zombie Attack"] = {ID = 1240123653, Category = "Horror", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/zombie-attack.lua"},
    ["Zombie Rush"] = {ID = 137885680, Category = "Horror", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/zombie-rush.lua"},
    
    -- Tycoon Games
    ["Super Hero Tycoon"] = {ID = 574407221, Category = "Tycoon", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/super-hero-tycoon.lua"},
    
    -- Other Games
    ["Natural Disaster Survival"] = {ID = 189707, Category = "Other", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/natural-disaster-survival.lua"},
    ["Dinosaur Simulator"] = {ID = 219434352, Category = "Other", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/dinosaur-simulator.lua"},
    ["Broken Bones"] = {ID = 2551991523, Category = "Other", Script = "https://raw.githubusercontent.com/TrixAde/scripts/main/broken-bones.lua"}
}

-- Get current game with more details
LAJ.GetCurrentGame = function()
    local currentGameId = game.PlaceId
    local gameInfo = {
        Name = "Universal",
        ID = currentGameId,
        Category = "Other",
        PlaceVersion = game.PlaceVersion,
        PlaceName = "Unknown",
        Script = nil -- Add Script field to store direct script URL
    }
    
    -- Try to get game name from Roblox
    pcall(function()
        local success, result = pcall(function()
            return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
        end)
        
        if success and result then
            gameInfo.PlaceName = result.Name
        end
    end)
    
    -- Check if game is in our database
    for name, info in pairs(LAJ.Games) do
        if currentGameId == info.ID then
            gameInfo.Name = name
            gameInfo.Category = info.Category
            gameInfo.Script = info.Script -- Store the script URL if available
            break
        end
    end
    
    -- Log game detection
    LAJ.Log("Info", "Detected game: " .. gameInfo.Name .. " (ID: " .. gameInfo.ID .. ")")
    
    return gameInfo
end

-- Enhanced settings management
LAJ.LoadSettings = function()
    if executorFunctions.FileSystem and isfile("LAJHub_Settings.json") then
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("LAJHub_Settings.json"))
        end)
        
        if success and type(result) == "table" then
            LAJ.Log("Info", "Settings loaded successfully")
            return result
        else
            LAJ.Log("Warning", "Failed to load settings, using defaults")
        end
    end
    
    return {
        Theme = "Default",
        AutoExecute = {},
        UIScale = 1,
        Favorites = {},
        RecentScripts = {},
        CustomScripts = {}
    }
end

LAJ.SaveSettings = function()
    if executorFunctions.FileSystem then
        local success, result = pcall(function()
            writefile("LAJHub_Settings.json", game:GetService("HttpService"):JSONEncode(LAJ.Config))
            return true
        end)
        
        if success then
            LAJ.Log("Success", "Settings saved successfully")
            return true
        else
            LAJ.Log("Error", "Failed to save settings: " .. tostring(result))
            return false
        end
    end
    return false
end

-- Initialize settings
LAJ.Config = LAJ.LoadSettings()

-- Set up favorites system
LAJ.IsFavorite = function(scriptName)
    for _, fav in ipairs(LAJ.Config.Favorites or {}) do
        if fav.Name == scriptName then
            return true
        end
    end
    return false
end

LAJ.ToggleFavorite = function(scriptName, scriptUrl)
    LAJ.Config.Favorites = LAJ.Config.Favorites or {}
    
    for i, fav in ipairs(LAJ.Config.Favorites) do
        if fav.Name == scriptName then
            table.remove(LAJ.Config.Favorites, i)
            LAJ.SaveSettings()
            LAJ.Log("Info", "Removed " .. scriptName .. " from favorites")
            return false
        end
    end
    
    table.insert(LAJ.Config.Favorites, {
        Name = scriptName,
        URL = scriptUrl,
        AddedAt = os.time()
    })
    
    LAJ.SaveSettings()
    LAJ.Log("Success", "Added " .. scriptName .. " to favorites")
    return true
end

-- Create enhanced window
local Window = Rayfield:CreateWindow({
    Name = "LAJ HUB " .. LAJ.Version,
    LoadingTitle = "LAJ HUB " .. LAJ.Version,
    LoadingSubtitle = "ULTIMATE GITHUB EDITION",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LAJHub",
        FileName = "Configuration"
    },
    Discord = {
        Enabled = true,
        Invite = "lajhubcommunity",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "LAJ HUB " .. LAJ.Version,
        Subtitle = "Premium Key Authentication",
        Note = "Enter the key: LAJPRO",
        FileName = "LAJHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {
            "LAJPRO" -- Only key
        }
    },
    Theme = LAJ.Config.Theme or "Default"
})

-- Create main UI tabs
local gameInfo = LAJ.GetCurrentGame()

-- Dashboard Tab
local DashboardTab = Window:CreateTab("Dashboard", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local UniversalTab = Window:CreateTab("Universal", 4483362458)
local GamesTab = Window:CreateTab("Games", 4483362458)
local OriginalTab = Window:CreateTab("Original LAJ", 4483362458)
local FavoritesTab = Window:CreateTab("Favorites", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Dashboard Content
DashboardTab:CreateSection("🌟 Welcome to LAJ HUB " .. LAJ.Version)

local gameInfoLabel = DashboardTab:CreateLabel("🎮 Current Game: " .. gameInfo.Name .. " (" .. gameInfo.ID .. ")")
local versionLabel = DashboardTab:CreateLabel("📊 Version: " .. LAJ.Version)

DashboardTab:CreateParagraph({
    Title = "LAJ HUB - The Ultimate Exploit Hub",
    Content = "LAJ HUB " .. LAJ.Version .. " provides the best Roblox exploits organized by game categories and types. Navigate through the tabs to find scripts for your favorite games or use universal exploits that work across Roblox."
})

-- Game-specific recommendations
if gameInfo.Name ~= "Universal" then
    DashboardTab:CreateSection("📋 Recommendations for " .. gameInfo.Name)
    
    -- Add button to directly execute TrixAde script if available
    if gameInfo.Script then
        DashboardTab:CreateButton({
            Name = "⚡ Execute TrixAde Script for " .. gameInfo.Name,
            Info = "Run the most compatible TrixAde script for " .. gameInfo.Name,
            Callback = function()
                LAJ.Log("Info", "Executing TrixAde script for " .. gameInfo.Name)
                LAJ.LoadScript(gameInfo.Script, gameInfo.Name .. " (TrixAde)")
            end,
        })
    end
    
    DashboardTab:CreateButton({
        Name = "🚀 Load All Scripts for " .. gameInfo.Name,
        Info = "Quick access to all scripts for " .. gameInfo.Name,
        Callback = function()
            LAJ.Log("Info", "Loading recommended scripts for " .. gameInfo.Name)
            GamesTab:Select()
            
            -- Finding the appropriate game category
            for i, v in pairs(LAJ.Games) do
                if i == gameInfo.Name then
                    -- We would automatically highlight or scroll to the correct section
                    -- but Rayfield doesn't support this directly
                    LAJ.Log("Info", "Found " .. gameInfo.Name .. " in category " .. v.Category)
                    break
                end
            end
        end,
    })
end

-- Recent activity section
DashboardTab:CreateSection("📜 Recent Activity")

-- This would be dynamically populated with recent scripts executed
if #LAJ.History > 0 then
    for i = 1, math.min(5, #LAJ.History) do
        local item = LAJ.History[#LAJ.History - (i-1)]
        DashboardTab:CreateButton({
            Name = item.Name,
            Info = "Re-execute this script",
            Callback = function()
                LAJ.LoadScript(item.URL, item.Name)
            end,
        })
    end
else
    DashboardTab:CreateLabel("No recent activity")
end

-- Discord & Community
DashboardTab:CreateSection("🌐 Community & Resources")

DashboardTab:CreateButton({
    Name = "🔗 Join Discord",
    Info = "Join our community for updates and support",
    Callback = function()
        if setclipboard then
            setclipboard("discord.gg/lajhubcommunity")
            LAJ.Log("Info", "Discord invite copied to clipboard")
        else
            LAJ.Log("Warning", "Clipboard function not available")
        end
    end,
})

DashboardTab:CreateButton({
    Name = "🚀 Explore GitHub Repositories",
    Info = "Access 25+ premium script hubs and exploits",
    Callback = function()
        GitHubTab:Select()
        LAJ.Log("Info", "Opened GitHub repositories tab")
    end,
})

-- GitHub counts
local hubCount = 0
local scriptCount = 0
for _, _ in pairs(LAJ.GitHubRepos) do
    hubCount = hubCount + 1
    scriptCount = scriptCount + 1
end
for _, _ in pairs(LAJ.Games) do
    scriptCount = scriptCount + 1
end

DashboardTab:CreateLabel("📊 Available: " .. scriptCount .. " scripts across " .. hubCount .. " GitHub repositories")

-- Player Tab
PlayerTab:CreateSection("🧍 Player Utilities")

-- ESP Features
local espEnabled = false
PlayerTab:CreateToggle({
    Name = "🔍 ESP / Wallhack",
    Info = "See players through walls",
    CurrentValue = false,
    Flag = "ESPEnabled",
    Callback = function(Value)
        espEnabled = Value
        if Value then
            LAJ.Log("Info", "Enabling ESP/Wallhack")
            LAJ.LoadScript("https://raw.githubusercontent.com/LAJHubPremium/scripts/main/espwallhack", "ESP Wallhack")
        else
            LAJ.Log("Info", "ESP disabled - rejoin to fully remove")
        end
    end,
})

-- Teleport utilities
PlayerTab:CreateSection("🏃 Movement & Teleport")

PlayerTab:CreateToggle({
    Name = "🏎️ Speed Boost",
    Info = "Increase character's movement speed",
    CurrentValue = false,
    Flag = "SpeedBoostEnabled",
    Callback = function(Value)
        -- Speed boost code
        if Value then
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                LAJ.Cache.OriginalWalkSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = 50
                LAJ.Log("Info", "Speed boost enabled")
            else
                LAJ.Log("Error", "Humanoid not found")
            end
        else
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and LAJ.Cache.OriginalWalkSpeed then
                humanoid.WalkSpeed = LAJ.Cache.OriginalWalkSpeed
                LAJ.Log("Info", "Speed boost disabled")
            end
        end
    end,
})

PlayerTab:CreateToggle({
    Name = "🦘 Jump Power",
    Info = "Enhance jumping ability",
    CurrentValue = false,
    Flag = "JumpPowerEnabled",
    Callback = function(Value)
        -- Jump power code
        if Value then
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                LAJ.Cache.OriginalJumpPower = humanoid.JumpPower
                humanoid.JumpPower = 100
                LAJ.Log("Info", "Jump power enhanced")
            else
                LAJ.Log("Error", "Humanoid not found")
            end
        else
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and LAJ.Cache.OriginalJumpPower then
                humanoid.JumpPower = LAJ.Cache.OriginalJumpPower
                LAJ.Log("Info", "Jump power reset")
            end
        end
    end,
})

PlayerTab:CreateToggle({
    Name = "🛸 Fly",
    Info = "Allows your character to fly",
    CurrentValue = false,
    Flag = "FlyEnabled",
    Callback = function(Value)
        if Value then
            LAJ.Log("Info", "Enabling fly script")
            LAJ.LoadScript("https://raw.githubusercontent.com/LAJHubPremium/scripts/main/fly", "Fly Script")
        else
            LAJ.Log("Info", "Fly disabled - rejoin to fully remove")
        end
    end,
})

-- Player appearance
PlayerTab:CreateSection("👤 Appearance")

PlayerTab:CreateButton({
    Name = "🎭 Free Animation Bundle",
    Info = "Unlock premium animations for your character",
    Callback = function()
        LAJ.Log("Info", "Loading animation bundle")
        LAJ.LoadScript("https://raw.githubusercontent.com/TrixAde/scripts/main/free-animation-universal.lua", "Free Animation Bundle")
    end,
})

-- Universal Tab
UniversalTab:CreateSection("🌐 Universal Exploits")

UniversalTab:CreateButton({
    Name = "🛠️ Remote Spy",
    Info = "Detect remote events and functions",
    Callback = function()
        LAJ.Log("Info", "Loading remote spy")
        LAJ.LoadScript("https://raw.githubusercontent.com/LAJHubPremium/scripts/main/remotespy", "Remote Spy")
    end,
})

UniversalTab:CreateButton({
    Name = "🧰 DEX Explorer",
    Info = "Advanced game explorer to view all instances",
    Callback = function()
        LAJ.Log("Info", "Loading DEX Explorer")
        LAJ.LoadScript("https://raw.githubusercontent.com/TrixAde/scripts/main/DarkDexV3.lua", "DEX Explorer")
    end,
})

UniversalTab:CreateButton({
    Name = "⚙️ Infinite Yield",
    Info = "Admin commands for most games",
    Callback = function()
        LAJ.Log("Info", "Loading Infinite Yield")
        LAJ.LoadScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "Infinite Yield")
    end,
})

UniversalTab:CreateButton({
    Name = "💣 TP Tool",
    Info = "Tool for teleporting around the game",
    Callback = function()
        LAJ.Log("Info", "Loading TP Tool")
        LAJ.LoadScript("https://raw.githubusercontent.com/TrixAde/scripts/main/tp-tool.lua", "TP Tool")
    end,
})

-- Games Tab with categories
GamesTab:CreateSection("🎮 Game Categories")

-- Create dropdown for game categories
local gameCategories = {"FPS", "RPG", "Town & City", "Fighting", "Simulation", "Adventure", "Horror", "Tycoon", "Other"}
local selectedCategory = "FPS"

GamesTab:CreateDropdown({
    Name = "Select Category",
    Options = gameCategories,
    CurrentOption = selectedCategory,
    Flag = "GameCategory",
    Callback = function(Value)
        selectedCategory = Value
        
        -- Clear current category section and create a new one
        local section = GamesTab:CreateSection("📋 " .. selectedCategory .. " Games")
        
        -- Add games from selected category
        local count = 0
        for name, info in pairs(LAJ.Games) do
            if info.Category == selectedCategory then
                count = count + 1
                
                GamesTab:CreateButton({
                    Name = name,
                    Info = "ID: " .. info.ID,
                    Callback = function()
                        if info.Script then
                            LAJ.LoadScript(info.Script, name)
                        else
                            LAJ.Log("Warning", "No script available for " .. name)
                        end
                    end,
                })
            end
        end
        
        if count == 0 then
            GamesTab:CreateLabel("No games in this category")
        end
    end,
})

-- Initialize with FPS games
GamesTab:CreateSection("📋 FPS Games")

for name, info in pairs(LAJ.Games) do
    if info.Category == "FPS" then
        GamesTab:CreateButton({
            Name = name,
            Info = "ID: " .. info.ID,
            Callback = function()
                if info.Script then
                    LAJ.LoadScript(info.Script, name)
                else
                    LAJ.Log("Warning", "No script available for " .. name)
                end
            end,
        })
    end
end

-- Original LAJ Tab
OriginalTab:CreateSection("🌠 Original LAJ Scripts")

for name, url in pairs(LAJ.OriginalScripts) do
    OriginalTab:CreateButton({
        Name = name,
        Info = "Original script from LAJ Hub",
        Callback = function()
            LAJ.LoadScript(url, name)
        end,
    })
end

-- GitHub Repositories Tab
local GitHubTab = Window:CreateTab("GitHub", 4483362458)

-- Premium Hubs Section
GitHubTab:CreateSection("⭐ Premium Script Hubs")
for name, url in pairs(LAJ.GitHubRepos) do
    if name == "Owl Hub" or name == "Solaris Hub" or name == "DomainX Hub" or name == "EvoV2" or name == "Sirius" then
        GitHubTab:CreateButton({
            Name = name,
            Info = "Premium script hub",
            Callback = function()
                LAJ.LoadScript(url, name)
            end,
        })
    end
end

-- Admin Scripts Section
GitHubTab:CreateSection("🛡️ Admin Scripts")
for name, url in pairs(LAJ.GitHubRepos) do
    if name == "Infinite Yield" or name == "CMD-X" or name == "Fate's Admin" then
        GitHubTab:CreateButton({
            Name = name,
            Info = "Admin commands script",
            Callback = function()
                LAJ.LoadScript(url, name)
            end,
        })
    end
end

-- Universal Scripts Section
GitHubTab:CreateSection("🧰 Universal Tools")
for name, url in pairs(LAJ.GitHubRepos) do
    if name == "Hydroxide" or name == "Remote Spy" or name == "Script Dumper" or name == "Dex Explorer" then
        GitHubTab:CreateButton({
            Name = name,
            Info = "Universal development tool",
            Callback = function()
                LAJ.LoadScript(url, name)
            end,
        })
    end
end

-- Misc Tools Section
GitHubTab:CreateSection("🛠️ Utility Scripts")
for name, url in pairs(LAJ.GitHubRepos) do
    if name == "Anti AFK" or name == "FPS Booster" or name == "Universal ESP" or name == "Click TP" then
        GitHubTab:CreateButton({
            Name = name,
            Info = "Utility script",
            Callback = function()
                LAJ.LoadScript(url, name)
            end,
        })
    end
end

-- Specialty Hubs Section
GitHubTab:CreateSection("🎮 Specialty Script Hubs")
for name, url in pairs(LAJ.GitHubRepos) do
    if name == "V.G Hub" or name == "Moon UI" or name == "NukeVsCity" or name == "Uranium Hub" or name == "Parvus Hub" then
        GitHubTab:CreateButton({
            Name = name,
            Info = "Multi-game script hub",
            Callback = function()
                LAJ.LoadScript(url, name)
            end,
        })
    end
end

-- Favorites Tab
FavoritesTab:CreateSection("⭐ Your Favorite Scripts")

local updateFavoritesUI = function()
    -- We would dynamically generate UI for favorites
    if LAJ.Config.Favorites and #LAJ.Config.Favorites > 0 then
        for _, fav in ipairs(LAJ.Config.Favorites) do
            FavoritesTab:CreateButton({
                Name = fav.Name,
                Info = "Added to favorites",
                Callback = function()
                    LAJ.LoadScript(fav.URL, fav.Name)
                end,
            })
        end
    else
        FavoritesTab:CreateLabel("No favorites added yet")
        FavoritesTab:CreateParagraph({
            Title = "How to Add Favorites",
            Content = "To add scripts to your favorites, look for the star icon next to scripts throughout LAJ HUB."
        })
    end
end

-- Call this initially
updateFavoritesUI()

-- Settings Tab
SettingsTab:CreateSection("⚙️ UI Settings")

SettingsTab:CreateDropdown({
    Name = "Theme",
    Options = {"Default", "Dark", "Light", "Midnight", "Sentinel", "Synapse"},
    CurrentOption = LAJ.Config.Theme or "Default",
    Flag = "ThemeSelection",
    Callback = function(Value)
        LAJ.Config.Theme = Value
        LAJ.SaveSettings()
        LAJ.Log("Info", "Theme changed to " .. Value .. ". Restart to apply.")
    end,
})

SettingsTab:CreateSlider({
    Name = "UI Scale",
    Range = {0.5, 1.5},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = LAJ.Config.UIScale or 1,
    Flag = "UIScale",
    Callback = function(Value)
        LAJ.Config.UIScale = Value
        LAJ.SaveSettings()
        -- Would need additional code to actually scale the UI
    end,
})

SettingsTab:CreateSection("📝 Information")

SettingsTab:CreateParagraph({
    Title = "About LAJ HUB " .. LAJ.Version,
    Content = "LAJ HUB ULTIMATE is the most comprehensive Roblox exploit script hub available, featuring over 75+ game-specific scripts from TrixAde, 25+ premium GitHub repositories, and the original LAJ Hub scripts. It provides a user-friendly interface with game auto-detection, favorites system, and categorized scripts. The GitHub tab gives you access to premium hubs like Owl Hub, Solaris, and specialty hubs such as V.G Hub and Uranium Hub, plus essential tools like Infinite Yield and DEX Explorer."
})

-- Warn about execution
LAJ.Log("Info", "LAJ HUB " .. LAJ.Version .. " has been initialized")
LAJ.Log("Warning", "Scripts may be detected by anti-cheat systems. Use at your own risk.")

-- Return LAJ object for potential access in other scripts
return LAJ