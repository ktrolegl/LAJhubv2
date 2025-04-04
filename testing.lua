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

-- Variables
local KeyInput = ""
local CorrectKey = "LAJ2025"
local DiscordLink = "https://discord.com/invite/4mgdcfvAJU"

-- Load the Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the key system window
local Window = Rayfield:CreateWindow({
    Name = "LAJ HUB | Key System",
    LoadingTitle = "LAJ HUB",
    LoadingSubtitle = "by LAJ Team",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = nil
    },
    Discord = {
        Enabled = false,
        Invite = nil,
        RememberJoins = false
    },
    KeySystem = false,
})

-- Create the key tab
local KeyTab = Window:CreateTab("Key System", 4483345998)

-- Add description
local KeyParagraph = KeyTab:CreateParagraph({Title = "LAJ HUB Key System", Content = "Enter the key to access the hub"})

-- Create the text input
local KeyBox = KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Enter the key...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        KeyInput = Text
    end,
})

-- Create verification button
local VerifyButton = KeyTab:CreateButton({
    Name = "Verify Key",
    Callback = function()
        if KeyInput == CorrectKey then
            Rayfield:Notify({
                Title = "Key System",
                Content = "Correct key! Loading scripts...",
                Duration = 3,
                Image = 4483345998,
            })
            
            -- Close this UI
            Rayfield:Destroy()
            
            -- Small delay to ensure UI is closed
            task.wait(0.5)
            
            -- Load the main script
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/main/KEYS"))()
        else
            Rayfield:Notify({
                Title = "Key System",
                Content = "Incorrect key! Please try again.",
                Duration = 3,
                Image = 4483345998,
            })
        end
    end,
})

-- Create Discord button
local DiscordButton = KeyTab:CreateButton({
    Name = "Join Discord",
    Callback = function()
        setclipboard(DiscordLink)
        Rayfield:Notify({
            Title = "Discord Link",
            Content = "Discord link copied to clipboard!",
            Duration = 3,
            Image = 4483345998,
        })
    end,
})
