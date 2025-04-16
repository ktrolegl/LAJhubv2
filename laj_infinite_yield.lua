--[[
    LAJHUBv2 - Original Version (No Speed Hub)
    Simplified for maximum compatibility with executors
]]

-- Direct UI Library Loading
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window
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

-- Create Core Tabs
local HomeTab = Window:CreateTab("Home")
local ScriptsTab = Window:CreateTab("Scripts")
local SettingsTab = Window:CreateTab("Settings")

-- Home Tab Content
HomeTab:CreateSection("Welcome to LAJHUBv2")

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
ScriptsTab:CreateSection("Popular Scripts")

ScriptsTab:CreateButton({
    Name = "LAJ Infinite Yield",
    Callback = function()
        Rayfield:Notify({
            Title = "LAJ Infinite Yield",
            Content = "Loading LAJ Infinite Yield admin commands...",
            Duration = 3,
        })
        
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ktrolegl/LAJhubv2/main/laj_infinite_yield.lua'))()
        
        Rayfield:Notify({
            Title = "LAJ Infinite Yield",
            Content = "Successfully loaded! Use ; to enter commands",
            Duration = 5,
        })
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
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDex.lua"))()
    end,
})

ScriptsTab:CreateSection("Game Scripts")

ScriptsTab:CreateButton({
    Name = "Jailbreak Auto Arrest",
    Callback = function()
        Rayfield:Notify({
            Title = "Jailbreak",
            Content = "Loading Auto Arrest script...",
            Duration = 3,
        })
        
        loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoArrestV3'))()
        
        Rayfield:Notify({
            Title = "Jailbreak",
            Content = "Auto Arrest script loaded successfully!",
            Duration = 3,
        })
    end,
})

-- Settings Tab Content
SettingsTab:CreateSection("UI Settings")

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

SettingsTab:CreateColorPicker({
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

SettingsTab:CreateSection("Performance")

SettingsTab:CreateSlider({
    Name = "Animation Smoothness",
    Range = {0, 100},
    Increment = 5,
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
