--[[
   LAJ HUB Discord Webhook Functions
   
   This script provides webhook functionality for:
   1. Usage tracking (when users execute your script)
   2. User count tracking (increment counter for each new user)
   3. Key verification and logging
   4. Ban/kick detection and alerting
   5. Rate limiting to prevent webhook abuse
   
   How to use:
   1. Add this script to your GitHub repo
   2. Update the webhook URLs with your Discord webhook URLs
   3. Load this module in your main script
   4. Call the functions when needed in your script
]]

-- Define webhook URLs for usage tracking
local DISCORD_WEBHOOK_URL = string.reverse("zuz89P0yCr0WdmXETfrGcQh86y38GMamN3GmsEBIlbS-XY8vgweci5QUIGqDLsAfKqHV/4224109920895937531/skoohbew/ipa/moc.drocsid//:sptth")
local USER_COUNT_WEBHOOK_URL = "https://discord.com/api/webhooks/1357978591928782933/2HF0z8dfhWcXjbPQwhTcCPrTkSPX-Eu2WP15-jNCAngiLbW5YODPsA835wVkucjya_MN"
local KEY_VERIFICATION_WEBHOOK_URL = DISCORD_WEBHOOK_URL -- Using the same webhook for key verification

-- Initialize user counter
local userCounter = 0

-- Last time a webhook was sent (to prevent spam)
local lastWebhookTime = 0

-- Cooldown between webhook requests (5 minutes)
local WEBHOOK_COOLDOWN = 300

-- Initialize game services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")

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

-- Function to send usage data to Discord webhook
local function sendUsageData()
    -- Calculate current time for rate limiting
    local currentTime = os.time()
    
    -- Rate limit to 1 request per 5 minutes to prevent webhook abuse
    if currentTime - lastWebhookTime < WEBHOOK_COOLDOWN then
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
                        ["value"] = "```" .. Player.Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "User ID:",
                        ["value"] = "```" .. tostring(Player.UserId) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game:",
                        ["value"] = "```" .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "```",
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
                        ["value"] = "```" .. Player.Name .. " (" .. tostring(Player.UserId) .. ")```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🎮 Game",
                        ["value"] = "```" .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "```",
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
                    ["icon_url"] = "https://i.imgur.com/QV7nVFU.png"
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
        warn("Failed to send usage webhook: " .. tostring(error_message))
    end
end

-- Function to log key usage via webhook
local function logKeyUsage(key, success)
    -- Rate limiting check
    local currentTime = os.time()
    if currentTime - lastWebhookTime < WEBHOOK_COOLDOWN then
        return
    end
    
    local success_pcall, error_message = pcall(function()
        -- Update the timestamp for rate limiting
        lastWebhookTime = currentTime
        
        -- Prepare webhook data
        local webhookData = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = success and "LAJ HUB Key Used Successfully" or "Failed Key Attempt",
                ["color"] = success and 65280 or 16711680, -- Green for success, red for failure
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
                        ["name"] = "Key Used",
                        ["value"] = "```" .. key .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game",
                        ["value"] = "```" .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game ID",
                        ["value"] = "```" .. tostring(game.PlaceId) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Executor",
                        ["value"] = "```" .. (identifyexecutor and identifyexecutor() or (swift and "Swift" or "Unknown")) .. "```",
                        ["inline"] = true
                    }
                },
                ["footer"] = {
                    ["text"] = "Key Usage Timestamp: " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }}
        }
        
        -- Send webhook with proper error handling
        local jsonData = HttpService:JSONEncode(webhookData)
        makeHttpRequest({
            Url = KEY_VERIFICATION_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = jsonData
        })
    end)
    
    if not success_pcall then
        warn("Failed to send key webhook: " .. tostring(error_message))
    end
end

-- Function to log ban/kick events via webhook
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
        
        -- Prepare the webhook data
        local webhookData = {
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
                        ["value"] = "```" .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "```",
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
        }
        
        -- Send the webhook
        local jsonData = HttpService:JSONEncode(webhookData)
        makeHttpRequest({
            Url = DISCORD_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = jsonData
        })
    end)
    
    if not success then
        warn("Failed to send ban webhook: " .. tostring(error_message))
    end
end

-- Set up event listeners for kick/ban detection
Players.PlayerRemoving:Connect(function(player)
    if player == Player then
        logBanEvent("Player removed from game (possibly kicked/banned)")
    end
end)

-- Hook for kick detection
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

-- Monitor teleport failures as they often occur during bans
game:GetService("TeleportService").TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
    if player == Player and (teleportResult == Enum.TeleportResult.Banned or teleportResult == Enum.TeleportResult.GameEnded) then
        logBanEvent("Teleport failed due to ban: " .. errorMessage)
    end
end)

-- Call sendUsageData when this module is loaded
spawn(function()
    wait(2) -- Wait 2 seconds to ensure game is fully loaded
    sendUsageData()
end)

-- Return the functions for use in other scripts
return {
    sendUsageData = sendUsageData,
    logKeyUsage = logKeyUsage,
    logBanEvent = logBanEvent
}
