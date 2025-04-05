-- LAJ HUB Key System with Enhanced Webhook Functionality
-- Combines key verification system with advanced webhook tracking
-- Created for GitHub deployment

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Configuration (edit these)
local VALID_KEYS = {
    "LAJPRO",
    "LAJVIP456",
    "LAJHUB789",
    "LAJSPECIAL",
    "LAJULTRA",
    "LAJEXCLUSIVE",
    "LAJPREMIUM", 
    "LAJELITE"
}

-- Discord server link
local DISCORD_LINK = "https://discord.gg/4mgdcfvAJU"

-- Webhook URLs for tracking (reversed for obfuscation)
local DISCORD_WEBHOOK_URL = string.reverse("zuz89P0yCr0WdmXETfrGcQh86y38GMamN3GmsEBIlbS-XY8vgweci5QUIGqDLsAfKqHV/4224109920895937531/skoohbew/ipa/moc.drocsid//:sptth")
local USER_COUNT_WEBHOOK_URL = "https://discord.com/api/webhooks/1357978591928782933/2HF0z8dfhWcXjbPQwhTcCPrTkSPX-Eu2WP15-jNCAngiLbW5YODPsA835wVkucjya_MN"

-- GitHub script URL (where your main script is hosted)
local SCRIPT_URL = "https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/testingv2"

-- Initialize user counter and last webhook time
local userCounter = 0
local lastWebhookTime = 0
local WEBHOOK_COOLDOWN = 300 -- 5 minutes cooldown

-- Request function for different executors
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

-- UI Colors
local Theme = {
    Background = Color3.fromRGB(35, 35, 35),
    DarkBackground = Color3.fromRGB(25, 25, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(65, 105, 225),
    ErrorColor = Color3.fromRGB(220, 60, 60),
    SuccessColor = Color3.fromRGB(60, 220, 60)
}

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
            Url = DISCORD_WEBHOOK_URL,
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

-- Function to verify a key
local function verifyKey(key)
    for _, validKey in ipairs(VALID_KEYS) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- Function to load the main script
local function loadMainScript()
    local success, error_message = pcall(function()
        loadstring(game:HttpGet(SCRIPT_URL))()
    end)
    
    if not success then
        warn("Failed to load main script: " .. tostring(error_message))
    end
end

-- Set up kick/ban detection
local function setupKickDetection()
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
end

-- Creating UI Elements
local function createKeySystemUI()
    -- Check if UI already exists and remove it
    if CoreGui:FindFirstChild("LAJHubKeySystem") then
        CoreGui:FindFirstChild("LAJHubKeySystem"):Destroy()
    end
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LAJHubKeySystem"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300) -- Slightly increased height for Discord button
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Apply corner radius
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = MainFrame
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Theme.DarkBackground
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 6)
    TitleCorner.Parent = TitleBar
    
    -- Fix corners
    local TitleCornerFix = Instance.new("Frame")
    TitleCornerFix.Name = "TitleCornerFix"
    TitleCornerFix.Size = UDim2.new(1, 0, 0.5, 0)
    TitleCornerFix.Position = UDim2.new(0, 0, 0.5, 0)
    TitleCornerFix.BackgroundColor3 = Theme.DarkBackground
    TitleCornerFix.BorderSizePixel = 0
    TitleCornerFix.Parent = TitleBar
    
    -- Make the title bar draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "LAJ HUB - Key System"
    TitleLabel.TextColor3 = Theme.TextColor
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Position = UDim2.new(1, -28, 0, 3)
    CloseButton.BackgroundColor3 = Theme.ErrorColor
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.TextColor
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
    MinimizeButton.Position = UDim2.new(1, -56, 0, 3)
    MinimizeButton.BackgroundColor3 = Theme.Background
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Theme.TextColor
    MinimizeButton.TextSize = 18
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Parent = TitleBar
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeButton
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -20, 1, -40)
    ContentArea.Position = UDim2.new(0, 10, 0, 35)
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel = 0
    ContentArea.Parent = MainFrame
    
    -- Key input elements
    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Name = "KeyLabel"
    KeyLabel.Size = UDim2.new(1, 0, 0, 20)
    KeyLabel.Position = UDim2.new(0, 0, 0, 10)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "Enter your key:"
    KeyLabel.TextColor3 = Theme.TextColor
    KeyLabel.TextSize = 14
    KeyLabel.Font = Enum.Font.SourceSans
    KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeyLabel.Parent = ContentArea
    
    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Size = UDim2.new(1, 0, 0, 35)
    KeyInput.Position = UDim2.new(0, 0, 0, 35)
    KeyInput.BackgroundColor3 = Theme.DarkBackground
    KeyInput.PlaceholderText = "Enter your LAJ HUB key here..."
    KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Theme.TextColor
    KeyInput.TextSize = 14
    KeyInput.Font = Enum.Font.SourceSans
    KeyInput.BorderSizePixel = 0
    KeyInput.ClearTextOnFocus = false
    KeyInput.Parent = ContentArea
    
    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 4)
    KeyInputCorner.Parent = KeyInput
    
    -- Button for key verification
    local VerifyButton = Instance.new("TextButton")
    VerifyButton.Name = "VerifyButton"
    VerifyButton.Size = UDim2.new(1, 0, 0, 35)
    VerifyButton.Position = UDim2.new(0, 0, 0, 80)
    VerifyButton.BackgroundColor3 = Theme.AccentColor
    VerifyButton.Text = "Verify Key"
    VerifyButton.TextColor3 = Theme.TextColor
    VerifyButton.TextSize = 16
    VerifyButton.Font = Enum.Font.SourceSansBold
    VerifyButton.BorderSizePixel = 0
    VerifyButton.Parent = ContentArea
    
    local VerifyCorner = Instance.new("UICorner")
    VerifyCorner.CornerRadius = UDim.new(0, 4)
    VerifyCorner.Parent = VerifyButton
    
    -- Status label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.Position = UDim2.new(0, 0, 0, 125)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Enter your key above"
    StatusLabel.TextColor3 = Theme.TextColor
    StatusLabel.TextSize = 14
    StatusLabel.Font = Enum.Font.SourceSans
    StatusLabel.Parent = ContentArea
    
    -- Discord button
    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Name = "DiscordButton"
    DiscordButton.Size = UDim2.new(1, 0, 0, 35)
    DiscordButton.Position = UDim2.new(0, 0, 0, 155)
    DiscordButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218) -- Discord color
    DiscordButton.Text = "Join Discord for Key"
    DiscordButton.TextColor3 = Theme.TextColor
    DiscordButton.TextSize = 16
    DiscordButton.Font = Enum.Font.SourceSansBold
    DiscordButton.BorderSizePixel = 0
    DiscordButton.Parent = ContentArea
    
    local DiscordCorner = Instance.new("UICorner")
    DiscordCorner.CornerRadius = UDim.new(0, 4)
    DiscordCorner.Parent = DiscordButton
    
    -- Credits
    local CreditsLabel = Instance.new("TextLabel")
    CreditsLabel.Name = "CreditsLabel"
    CreditsLabel.Size = UDim2.new(1, 0, 0, 20)
    CreditsLabel.Position = UDim2.new(0, 0, 1, -25)
    CreditsLabel.BackgroundTransparency = 1
    CreditsLabel.Text = "LAJ HUB © 2023-2024 | Swift Compatible"
    CreditsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    CreditsLabel.TextSize = 12
    CreditsLabel.Font = Enum.Font.SourceSans
    CreditsLabel.Parent = ContentArea
    
    -- Button actions
    VerifyButton.MouseButton1Click:Connect(function()
        local key = KeyInput.Text
        
        if verifyKey(key) then
            -- Successful verification
            StatusLabel.Text = "Key verified! Loading script..."
            StatusLabel.TextColor3 = Theme.SuccessColor
            
            -- Log key usage
            logKeyUsage(key, true)
            
            -- Initialize kick detection
            setupKickDetection()
            
            -- Send usage data to webhook
            sendUsageData()
            
            -- Create success animation
            local oldColor = VerifyButton.BackgroundColor3
            VerifyButton.BackgroundColor3 = Theme.SuccessColor
            VerifyButton.Text = "Success!"
            
            wait(1)
            
            -- Load main script after UI success feedback
            loadMainScript()
            
            -- Close the UI after loading the script
            wait(0.5)
            ScreenGui:Destroy()
        else
            -- Failed verification
            StatusLabel.Text = "Invalid key. Try again or join Discord."
            StatusLabel.TextColor3 = Theme.ErrorColor
            
            -- Log failed key attempt
            logKeyUsage(key, false)
            
            -- Create error animation
            local oldColor = VerifyButton.BackgroundColor3
            VerifyButton.BackgroundColor3 = Theme.ErrorColor
            VerifyButton.Text = "Invalid Key"
            
            wait(1)
            
            -- Reset button
            VerifyButton.BackgroundColor3 = Theme.AccentColor
            VerifyButton.Text = "Verify Key"
        end
    end)
    
    DiscordButton.MouseButton1Click:Connect(function()
        -- Open Discord invite
        pcall(function()
            setclipboard(DISCORD_LINK)
        end)
        
        StatusLabel.Text = "Discord link copied to clipboard!"
        StatusLabel.TextColor3 = Color3.fromRGB(114, 137, 218)
    end)
    
    -- Minimize button action
    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        
        if isMinimized then
            -- Minimize animation
            local targetSize = UDim2.new(0, 400, 0, 30)
            local targetContentPos = UDim2.new(0, 0, 0, 0)
            
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
            ContentArea.Visible = false
            MinimizeButton.Text = "+"
        else
            -- Restore animation
            local targetSize = UDim2.new(0, 400, 0, 300)
            
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
            wait(0.3)
            ContentArea.Visible = true
            MinimizeButton.Text = "-"
        end
    end)
    
    -- Drop shadow effect
    local DropShadow = Instance.new("ImageLabel")
    DropShadow.Name = "DropShadow"
    DropShadow.Size = UDim2.new(1, 20, 1, 20)
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Image = "rbxassetid://6014261993"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    DropShadow.ZIndex = -1
    DropShadow.Parent = MainFrame
end

-- Main function to start the key system
local function startKeySystem()
    -- Create the UI
    createKeySystemUI()
    
    -- Set up kick detection
    spawn(function()
        setupKickDetection()
    end)
end

-- Start the key system
startKeySystem()
