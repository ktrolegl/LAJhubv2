--[[
    LAJ HUB - General Script Template
    
    This template provides a foundation for creating scripts with the LAJ HUB UI Library.
    It's designed to be easily adaptable for different games while maintaining a consistent structure.
    
    Features:
    - Game detection system
    - UI protection for different executors
    - Tab organization with common features
    - Easy-to-customize sections for game-specific functionality
    - Error handling and recovery
    
    How to use:
    1. Customize the gameScripts table with your specific games
    2. Implement the functions in the gameFeatures section
    3. Adjust the UI elements as needed
]]

-- Main configuration
local CONFIG = {
    HUB_NAME = "LAJ HUB",
    VERSION = "1.0",
    DISCORD_LINK = "https://discord.gg/lajhub",
    GITHUB_REPO = "https://github.com/ktrolegl/LAJHUBUIRAYFIELD",
    DEFAULT_THEME = "Default", -- Options: Default, Dark, Light, Midnight
    DEBUG_MODE = false,
    AUTO_SAVE_CONFIG = true,
    NOTIFICATION_DURATION = 5,
    CHECK_FOR_UPDATES = true
}

-- Utility functions
local Utilities = {}

function Utilities.Print(message, messageType)
    messageType = messageType or "Info"
    local prefix = "[LAJ HUB] [" .. messageType .. "] "
    
    if messageType == "Error" then
        warn(prefix .. message)
    elseif messageType == "Debug" and CONFIG.DEBUG_MODE then
        print(prefix .. message)
    elseif messageType == "Info" then
        print(prefix .. message)
    end
end

function Utilities.GetExecutor()
    local executor = {
        name = "Unknown",
        mobile = false,
        protectUI = function(gui) return gui end
    }
    
    -- Check for common executor identifiers
    if syn and syn.protect_gui then
        executor.name = "Synapse X"
        executor.protectUI = syn.protect_gui
    elseif getexecutorname then
        executor.name = getexecutorname()
    elseif KRNL_LOADED then
        executor.name = "KRNL"
    elseif is_sirhurt_closure then
        executor.name = "SirHurt"
    elseif secure_load then
        executor.name = "Sentinel"
    elseif SHADOWSENSE then
        executor.name = "Shadow"
    elseif identifyexecutor then
        executor.name = identifyexecutor()
    elseif fluxus and fluxus.is_fluxus then
        executor.name = "Fluxus"
        executor.mobile = fluxus.is_mobile and fluxus.is_mobile()
    elseif OXYGEN_LOADED then
        executor.name = "Oxygen U"
    elseif IS_VIVA_LOADED then
        executor.name = "Viva"
    elseif IS_ELECTRON_LOADED then
        executor.name = "Electron"
    end
    
    -- Generic protectUI function if not already defined
    if not executor.protectUI then
        executor.protectUI = function(gui)
            -- Apply best-effort protection based on executor capabilities
            if gethui and typeof(gethui) == "function" then
                gui.Parent = gethui()
            elseif get_hidden_gui then
                gui.Parent = get_hidden_gui()
            elseif hiddenUI and typeof(hiddenUI) == "Instance" then
                gui.Parent = hiddenUI
            elseif game:GetService("CoreGui"):FindFirstChild("RobloxGui") then
                gui.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
            else
                gui.Parent = game:GetService("CoreGui")
            end
            return gui
        end
    end
    
    return executor
end

function Utilities.LoadLibrary(url)
    local success, result
    
    -- First try HttpGet from the game service
    if game and game.HttpGet then
        success, result = pcall(function()
            return game:HttpGet(url)
        end)
    end
    
    -- If that failed, try other methods based on executor
    if not success then
        -- Try syn.request
        if syn and syn.request then
            success, result = pcall(function()
                return syn.request({
                    Url = url,
                    Method = "GET"
                }).Body
            end)
        -- Try http_request
        elseif http_request then
            success, result = pcall(function()
                return http_request({
                    Url = url,
                    Method = "GET"
                }).Body
            end)
        -- Try request
        elseif request then
            success, result = pcall(function()
                return request({
                    Url = url,
                    Method = "GET"
                }).Body
            end)
        end
    end
    
    -- If we got the content, try to load it
    if success and result then
        local loadSuccess, loadedContent = pcall(function()
            return loadstring(result)()
        end)
        
        if loadSuccess then
            return loadedContent
        else
            Utilities.Print("Failed to load library: " .. tostring(loadedContent), "Error")
            return nil
        end
    else
        Utilities.Print("Failed to fetch library from URL: " .. url, "Error")
        return nil
    end
end

function Utilities.DetectGame()
    local placeId = game.PlaceId
    local gameId = game.GameId
    
    -- Define known games
    local knownGames = {
        [142823291] = {name = "Murder Mystery 2", shortName = "MM2"},
        [2753915549] = {name = "Blox Fruits", shortName = "BF"},
        [286090429] = {name = "Arsenal", shortName = "Arsenal"},
        [2316994223] = {name = "Pet Simulator X", shortName = "PSX"},
        [4620170611] = {name = "Shindo Life", shortName = "Shindo"},
        [3956818381] = {name = "Ninja Legends", shortName = "NL"},
        [920587237] = {name = "Adopt Me", shortName = "AdoptMe"},
        [855499080] = {name = "Skywars", shortName = "Skywars"},
        [3101667897] = {name = "Legends of Speed", shortName = "LOS"},
        [3652625463] = {name = "Lifting Simulator", shortName = "LS"},
        [1224212277] = {name = "Mad City", shortName = "MC"},
        [2202352383] = {name = "Super Power Fighting Simulator", shortName = "SPFS"},
    }
    
    -- Check if it's a known game
    local gameInfo = knownGames[placeId]
    
    if gameInfo then
        return placeId, gameInfo.name, gameInfo.shortName, true
    else
        -- Try to get game name from DataModel
        local gameName = "Unknown Game"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name
        end)
        return placeId, gameName, "Unknown", false
    end
end

-- Game-specific features (to be implemented)
local gameFeatures = {}

-- Example for MM2
gameFeatures.MM2 = {
    -- ESP Feature
    EnableESP = function()
        Utilities.Print("MM2 ESP Enabled", "Info")
        -- Implementation would go here
    end,
    
    -- Coin Collector
    EnableCoinCollector = function()
        Utilities.Print("MM2 Coin Collector Enabled", "Info")
        -- Implementation would go here
    end,
    
    -- Teleport to lobby
    TeleportToLobby = function()
        Utilities.Print("Teleporting to MM2 Lobby", "Info")
        -- Implementation would go here
    end
}

-- Example for Blox Fruits
gameFeatures.BF = {
    -- Auto Farm
    EnableAutoFarm = function()
        Utilities.Print("Blox Fruits Auto Farm Enabled", "Info")
        -- Implementation would go here
    end,
    
    -- Teleport to island
    TeleportToIsland = function(islandName)
        Utilities.Print("Teleporting to " .. islandName, "Info")
        -- Implementation would go here
    end
}

-- Universal features
gameFeatures.Universal = {
    -- WalkSpeed Modifier
    SetWalkSpeed = function(speed)
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
            Utilities.Print("Set WalkSpeed to " .. speed, "Info")
            return true
        else
            Utilities.Print("Failed to set WalkSpeed", "Error")
            return false
        end
    end,
    
    -- JumpPower Modifier
    SetJumpPower = function(power)
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = power
            Utilities.Print("Set JumpPower to " .. power, "Info")
            return true
        else
            Utilities.Print("Failed to set JumpPower", "Error")
            return false
        end
    end,
    
    -- Infinite Jump
    ToggleInfiniteJump = function(enabled)
        local UserInputService = game:GetService("UserInputService")
        local infJumpConnection = nil
        
        if enabled then
            local player = game:GetService("Players").LocalPlayer
            
            infJumpConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            
            Utilities.Print("Infinite Jump Enabled", "Info")
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
                Utilities.Print("Infinite Jump Disabled", "Info")
            end
        end
        
        return infJumpConnection
    end,
    
    -- NoClip
    ToggleNoClip = function(enabled)
        local player = game:GetService("Players").LocalPlayer
        local noClipConnection = nil
        
        if enabled then
            local runService = game:GetService("RunService")
            
            noClipConnection = runService.Stepped:Connect(function()
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            
            Utilities.Print("NoClip Enabled", "Info")
        else
            if noClipConnection then
                noClipConnection:Disconnect()
                noClipConnection = nil
                
                -- Reset collision
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.CanCollide = true
                        end
                    end
                end
                
                Utilities.Print("NoClip Disabled", "Info")
            end
        end
        
        return noClipConnection
    end
}

-- Main execution
local function Main()
    -- Initialize
    Utilities.Print("Initializing LAJ HUB " .. CONFIG.VERSION, "Info")
    
    -- Get executor info
    local executor = Utilities.GetExecutor()
    Utilities.Print("Detected executor: " .. executor.name, "Info")
    
    -- Detect current game
    local placeId, gameName, gameShortName, isSupported = Utilities.DetectGame()
    Utilities.Print("Detected game: " .. gameName .. " (PlaceId: " .. placeId .. ")", "Info")
    
    -- Load LAJ HUB UI Library
    local LAJHubUI = Utilities.LoadLibrary(CONFIG.GITHUB_REPO .. "/main/Library.lua")
    
    if not LAJHubUI then
        Utilities.Print("Failed to load LAJ HUB UI Library. Using fallback method.", "Error")
        -- Try direct loadstring as fallback
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJHUBUIRAYFIELD/main/Library.lua"))()
        end)
        
        if success then
            LAJHubUI = result
        else
            Utilities.Print("Critical error loading UI library. Cannot continue.", "Error")
            return
        end
    end
    
    -- Create window
    local Window = LAJHubUI:CreateWindow({
        Name = CONFIG.HUB_NAME,
        LoadingTitle = CONFIG.HUB_NAME .. " - " .. CONFIG.VERSION,
        LoadingSubtitle = "by LAJ Team",
        ConfigurationSaving = {
            Enabled = CONFIG.AUTO_SAVE_CONFIG,
            FolderName = "LAJHubConfig",
            FileName = gameShortName .. "_Config"
        },
        Discord = {
            Enabled = true,
            Invite = CONFIG.DISCORD_LINK:gsub("https://discord.gg/", ""),
            RememberJoins = true
        },
        KeySystem = false -- Set to true if you want to add a key system
    })
    
    -- Create tabs
    local MainTab = Window:CreateTab("Main", 4483362458)
    local UniversalTab = Window:CreateTab("Universal", 4483362458)
    local GameTab = nil
    
    if isSupported then
        GameTab = Window:CreateTab(gameName, 4483362458)
    end
    
    local SettingsTab = Window:CreateTab("Settings", 4483362458)
    
    -- Main Tab Content
    MainTab:CreateSection("Welcome to LAJ HUB")
    
    MainTab:CreateButton({
        Name = "Copy Discord Link",
        Callback = function()
            setclipboard(CONFIG.DISCORD_LINK)
            LAJHubUI:Notify({
                Title = "Discord Link Copied",
                Content = "The Discord invite has been copied to your clipboard",
                Duration = 3,
                Image = 4483362458
            })
        end
    })
    
    MainTab:CreateParagraph({
        Title = "About LAJ HUB",
        Content = "LAJ HUB provides high-quality scripts for various Roblox games. Our goal is to enhance your gameplay experience with clean, optimized scripts."
    })
    
    -- Game-specific Tab Content (if supported)
    if isSupported and GameTab then
        if gameShortName == "MM2" then
            GameTab:CreateSection("Murder Mystery 2 Features")
            
            GameTab:CreateButton({
                Name = "Enable ESP",
                Callback = function()
                    gameFeatures.MM2.EnableESP()
                end
            })
            
            GameTab:CreateButton({
                Name = "Enable Coin Collector",
                Callback = function()
                    gameFeatures.MM2.EnableCoinCollector()
                end
            })
            
            GameTab:CreateButton({
                Name = "Teleport to Lobby",
                Callback = function()
                    gameFeatures.MM2.TeleportToLobby()
                end
            })
            
        elseif gameShortName == "BF" then
            GameTab:CreateSection("Blox Fruits Features")
            
            GameTab:CreateToggle({
                Name = "Auto Farm",
                CurrentValue = false,
                Flag = "BFAutoFarm",
                Callback = function(Value)
                    if Value then
                        gameFeatures.BF.EnableAutoFarm()
                    else
                        -- Disable auto farm
                    end
                end
            })
            
            -- Island teleport dropdown
            local islands = {"Starter Island", "Middle Island", "Jungle", "Pirate Village", "Desert", "Frozen Village", "Marine Fortress"}
            
            GameTab:CreateDropdown({
                Name = "Teleport to Island",
                Options = islands,
                CurrentOption = islands[1],
                Flag = "BFTeleportIsland",
                Callback = function(Option)
                    gameFeatures.BF.TeleportToIsland(Option)
                end
            })
        end
    end
    
    -- Universal Tab Content
    UniversalTab:CreateSection("Character Modifications")
    
    UniversalTab:CreateSlider({
        Name = "WalkSpeed",
        Range = {16, 500},
        Increment = 1,
        Suffix = "speed",
        CurrentValue = 16,
        Flag = "WalkSpeedSlider",
        Callback = function(Value)
            gameFeatures.Universal.SetWalkSpeed(Value)
        end,
    })
    
    UniversalTab:CreateSlider({
        Name = "JumpPower",
        Range = {50, 500},
        Increment = 5,
        Suffix = "power",
        CurrentValue = 50,
        Flag = "JumpPowerSlider",
        Callback = function(Value)
            gameFeatures.Universal.SetJumpPower(Value)
        end,
    })
    
    local infiniteJumpConnection = nil
    UniversalTab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Flag = "InfiniteJumpToggle",
        Callback = function(Value)
            infiniteJumpConnection = gameFeatures.Universal.ToggleInfiniteJump(Value)
        end,
    })
    
    local noClipConnection = nil
    UniversalTab:CreateToggle({
        Name = "NoClip",
        CurrentValue = false,
        Flag = "NoClipToggle",
        Callback = function(Value)
            noClipConnection = gameFeatures.Universal.ToggleNoClip(Value)
        end,
    })
    
    -- Settings Tab Content
    SettingsTab:CreateSection("UI Settings")
    
    local themes = {"Default", "Dark", "Light", "Midnight"}
    SettingsTab:CreateDropdown({
        Name = "UI Theme",
        Options = themes,
        CurrentOption = CONFIG.DEFAULT_THEME,
        Flag = "UITheme",
        Callback = function(Option)
            LAJHubUI:ChangeTheme(Option)
        end,
    })
    
    SettingsTab:CreateToggle({
        Name = "Debug Mode",
        CurrentValue = CONFIG.DEBUG_MODE,
        Flag = "DebugMode",
        Callback = function(Value)
            CONFIG.DEBUG_MODE = Value
            Utilities.Print("Debug Mode: " .. tostring(Value), "Info")
        end,
    })
    
    SettingsTab:CreateButton({
        Name = "Destroy UI",
        Callback = function()
            -- Clean up connections
            if infiniteJumpConnection then
                infiniteJumpConnection:Disconnect()
                infiniteJumpConnection = nil
            end
            
            if noClipConnection then
                noClipConnection:Disconnect()
                noClipConnection = nil
            end
            
            -- Destroy UI
            LAJHubUI:Destroy()
        end,
    })
    
    -- Version display
    SettingsTab:CreateSection("About")
    SettingsTab:CreateParagraph({
        Title = "LAJ HUB Version",
        Content = "Version: " .. CONFIG.VERSION .. "\nExecutor: " .. executor.name .. "\nGame: " .. gameName
    })
    
    -- Show success notification
    LAJHubUI:Notify({
        Title = "LAJ HUB Loaded",
        Content = "Successfully loaded for " .. gameName,
        Duration = CONFIG.NOTIFICATION_DURATION,
        Image = 4483362458
    })
    
    -- Check for updates if enabled
    if CONFIG.CHECK_FOR_UPDATES then
        -- Implementation for update checking would go here
    end
    
    Utilities.Print("LAJ HUB initialization complete", "Info")
end

-- Execute main function with error handling
local success, err = pcall(Main)
if not success then
    warn("[LAJ HUB] Critical error during initialization: " .. tostring(err))
end
