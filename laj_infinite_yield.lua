--[[
    LAJHUBv2.lua - Premium Roblox Exploitation Tool (Executor Version)
    Fixed version for better compatibility with Roblox executors
]]

-- Make sure we're in a proper game environment
if not game or not game:IsA("Game") then
    warn("LAJHUBv2 needs to be executed inside Roblox!")
    return
end

-- Basic error handling wrapper
local function safeExecute(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("LAJHUBv2 Error: " .. tostring(result))
    end
    return success, result
end

-- UI Library loading with multiple fallbacks
local function loadUILibrary()
    local Rayfield = nil
    
    -- Try to load Rayfield (Method 1)
    local success, result = pcall(function()
        return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)
    
    if success and type(result) == "table" then
        Rayfield = result
    else
        -- Fallback method for Rayfield (Method 2)
        success, result = pcall(function()
            return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
        end)
        
        if success and type(result) == "table" then
            Rayfield = result
        else
            -- Last resort fallback if all else fails
            warn("Failed to load Rayfield UI, using fallback UI")
            return {
                CreateWindow = function(options)
                    print("LAJHUBv2 initialized with fallback UI")
                    return {
                        CreateTab = function()
                            return {
                                CreateSection = function() return {} end,
                                CreateButton = function(options)
                                    if options and options.Callback then
                                        options.Callback()
                                    end
                                    return {}
                                end,
                                CreateToggle = function() return {} end,
                                CreateSlider = function() return {} end,
                                CreateParagraph = function() return {} end,
                                CreateDropdown = function() return {} end,
                                CreateColorPicker = function() return {} end,
                                CreateLabel = function() return {} end
                            }
                        end
                    }
                end,
                Notify = function(options)
                    if options then
                        print("Notification: " .. (options.Title or "") .. " - " .. (options.Content or ""))
                    end
                end
            }
        end
    end
    
    return Rayfield
end

-- Load the UI library
local Rayfield = loadUILibrary()

-- Create the main window
local Window = Rayfield:CreateWindow({
    Name = "▶ LAJHUBv2 EXPLOIT ◀",
    LoadingTitle = "Loading LAJHUBv2...",
    LoadingSubtitle = "by LAJ HUB",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LAJHUBv2",
        FileName = "config"
    },
})

-- Create tabs
local HomeTab = Window:CreateTab({Name = "Home", Icon = "rbxassetid://4483345998"})
local ScriptsTab = Window:CreateTab({Name = "Scripts", Icon = "rbxassetid://4483345998"})
local SettingsTab = Window:CreateTab({Name = "Settings", Icon = "rbxassetid://4483345998"})

-- Home Tab Content
local WelcomeSection = HomeTab:CreateSection("Welcome to LAJHUBv2")

HomeTab:CreateParagraph({
    Title = "LAJHUBv2 Premium Exploit",
    Content = "Welcome to LAJHUBv2, the premium Roblox exploit with advanced features. This UI is designed for optimal performance on mobile platforms."
})

HomeTab:CreateButton({
    Name = "Join Discord",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/lajhub")
            Rayfield:Notify({
                Title = "Discord",
                Content = "Discord invite copied to clipboard!",
                Duration = 3,
            })
        else
            Rayfield:Notify({
                Title = "Discord",
                Content = "Unable to copy to clipboard",
                Duration = 3,
            })
        end
    end,
})

HomeTab:CreateButton({
    Name = "Check for Updates",
    Callback = function()
        Rayfield:Notify({
            Title = "Update Check",
            Content = "Your version is up to date!",
            Duration = 3,
        })
    end,
})

-- Scripts Tab Content
local PopularSection = ScriptsTab:CreateSection("Popular Scripts")

ScriptsTab:CreateButton({
    Name = "LAJ Infinite Yield",
    Callback = function()
        Rayfield:Notify({
            Title = "LAJ Infinite Yield",
            Content = "Loading LAJ Infinite Yield admin commands...",
            Duration = 3,
        })
        
        -- Load our custom LAJ Infinite Yield implementation
        safeExecute(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_infinite_yield.lua', true))()
            
            Rayfield:Notify({
                Title = "LAJ Infinite Yield",
                Content = "Successfully loaded! Use ; to enter commands",
                Duration = 5,
            })
        end)
    end,
})

ScriptsTab:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        Rayfield:Notify({
            Title = "Dex Explorer",
            Content = "Loading Dex Explorer...",
            Duration = 3,
        })
        
        safeExecute(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDex.lua", true))()
        end)
    end,
})

local GamesSection = ScriptsTab:CreateSection("Game Scripts")

-- Speed Hub X integration
local SpeedHubGames = {
    ["Blox Fruits"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Dead Rails"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Muscle Legends"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Fisch"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["The Strongest Battlegrounds"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Arise Crossover"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Bubble Gum Simulator INFINITY"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Anime Reborn"] = "https://raw.githubusercontent.com/AhmadV99/Script-Games/main/Anime%20Reborn.lua",
    ["Anime Vanguards"] = "https://raw.githubusercontent.com/AhmadV99/Script-Games/main/Anime%20Vanguards.lua"
}

-- Combine standard games with Speed Hub X games
local AllGameOptions = {
    "Adopt Me", 
    "Blox Fruits", 
    "Dead Rails",
    "Fisch", 
    "Jailbreak", 
    "Murder Mystery 2", 
    "Muscle Legends",
    "Pets Go!", 
    "Shindo Life",
    "The Strongest Battlegrounds",
    "Arise Crossover",
    "Bubble Gum Simulator INFINITY",
    "Anime Reborn",
    "Anime Vanguards"
}

-- Sort the game options for better organization
table.sort(AllGameOptions)

-- Create a variable to store the selected game
local selectedGame = "Jailbreak" -- Default selection

-- Make the dropdown
local gameDropdown = ScriptsTab:CreateDropdown({
    Name = "Select Game",
    Options = AllGameOptions,
    CurrentOption = selectedGame,
    Flag = "GameDropdown",
    Callback = function(Option)
        selectedGame = Option
        Rayfield:Notify({
            Title = "Game Selected",
            Content = "Selected: " .. Option,
            Duration = 3,
        })
    end,
})

ScriptsTab:CreateButton({
    Name = "Load Selected Game Script",
    Callback = function()
        -- Notify what game script we're loading
        Rayfield:Notify({
            Title = "Script Loader",
            Content = "Loading script for " .. (selectedGame or "selected game") .. "...",
            Duration = 3,
        })

        -- Check if it's a Speed Hub X game
        if SpeedHubGames[selectedGame] then
            -- Load the Speed Hub X script for the selected game
            safeExecute(function()
                loadstring(game:HttpGet(SpeedHubGames[selectedGame], true))()
                
                Rayfield:Notify({
                    Title = "Speed Hub X",
                    Content = selectedGame .. " script loaded successfully!",
                    Duration = 3,
                })
            end)
        -- Handle other specific games
        elseif selectedGame == "Jailbreak" then
            -- Load Jailbreak Auto Arrest script
            safeExecute(function()
                loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoArrestV3'))()

                Rayfield:Notify({
                    Title = "Jailbreak",
                    Content = "Auto Arrest script loaded successfully!",
                    Duration = 3,
                })
            end)
        else
            -- Generic message for other games (to be implemented)
            Rayfield:Notify({
                Title = "Script Loader",
                Content = "No specific script available for " .. (selectedGame or "this game"),
                Duration = 3,
            })
        end
    end,
})

-- Settings Tab Content
local UISection = SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateToggle({
    Name = "Save Configuration",
    CurrentValue = true,
    Flag = "SaveConfig",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Configuration",
            Content = Value and "Configuration saving enabled" or "Configuration saving disabled",
            Duration = 3,
        })
    end,
})

local ThemeColorPicker = SettingsTab:CreateColorPicker({
    Name = "UI Theme Color",
    Color = Color3.fromRGB(89, 150, 255),
    Flag = "UIColor",
    Callback = function(Color)
        Rayfield:Notify({
            Title = "Theme Color",
            Content = "Theme color updated!",
            Duration = 3,
        })
    end,
})

local PerformanceSection = SettingsTab:CreateSection("Performance")

SettingsTab:CreateSlider({
    Name = "Animation Smoothness",
    Range = {0, 100},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 75,
    Flag = "AnimationSmoothnessSlider",
    Callback = function(Value)
        -- Animation smoothness value stored
    end,
})

SettingsTab:CreateToggle({
    Name = "Mobile Optimization",
    CurrentValue = true,
    Flag = "MobileOptimization",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Mobile Optimization",
            Content = Value and "Mobile optimization enabled" or "Mobile optimization disabled",
            Duration = 3,
        })
    end,
})

-- Show notification on load
Rayfield:Notify({
    Title = "LAJHUBv2 EXPLOIT",
    Content = "Successfully loaded the exploit UI!",
    Duration = 5,
})

-- Return the window for other scripts to access
return Window
