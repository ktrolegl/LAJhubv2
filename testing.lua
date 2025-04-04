--[[
    LAJ HUB - Premium Roblox Script Hub
    Version: 4.1
    Discord: https://discord.com/invite/4mgdcfvAJU
    
    Features:
    - Multiple game exploits
    - Universal scripts
    - Clean UI with buttons for key system
    - Utility features
    
    This script is intended for educational purposes only.
]]

-- Alternative key system implementation with buttons
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "LAJ HUB | Key System", 
    HidePremium = true,
    SaveConfig = false, 
    ConfigFolder = "LAJHubOrion",
    IntroEnabled = false
})

-- Variables
local KeyInput = ""
local CorrectKey = "LAJ2025"
local DiscordLink = "https://discord.com/invite/4mgdcfvAJU"

-- Create the key system tab
local KeyTab = Window:MakeTab({
    Name = "Key System",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Add description
KeyTab:AddParagraph("LAJ HUB Key System", "Enter the key to access the hub")

-- Create the text input
KeyTab:AddTextbox({
    Name = "Enter Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        KeyInput = Value
    end  
})

-- Create verification button
KeyTab:AddButton({
    Name = "Verify Key",
    Callback = function()
        if KeyInput == CorrectKey then
            OrionLib:MakeNotification({
                Name = "Key System",
                Content = "Correct key! Loading scripts...",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            
            -- Close this UI
            OrionLib:Destroy()
            
            -- Small delay to ensure UI is closed
            task.wait(0.5)
            
            -- Load the main script
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/KEYS"))()
        else
            OrionLib:MakeNotification({
                Name = "Key System",
                Content = "Incorrect key! Please try again.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end    
})

-- Create Discord button
KeyTab:AddButton({
    Name = "Join Discord",
    Callback = function()
        setclipboard(DiscordLink)
        OrionLib:MakeNotification({
            Name = "Discord Link",
            Content = "Discord link copied to clipboard!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

-- Add instructions
KeyTab:AddParagraph("How to get key:", "1. Copy Discord link with button above\n2. Join our Discord server\n3. Get the key in the #key channel\n4. Enter key here and verify")
