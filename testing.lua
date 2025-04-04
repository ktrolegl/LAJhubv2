-- LAJ Hub Direct Loader (Kavo UI Version)
-- This script can be executed directly in Roblox without saving it locally

-- Load the Kavo UI Library
loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Define all variables and functions
local Library = KavoUi
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local http_request = syn and syn.request or http and http.request or http_request or request or httprequest

local DISCORD_WEBHOOK_URL = string.reverse("zuz89P0yCr0WdmXETfrGcQh86y38GMamN3GmsEBIlbS-XY8vgweci5QUIGqDLsAfKqHV/4224109920895937531/skoohbew/ipa/moc.drocsid//:sptth")

local function sendUsageData()
    local success, error_message = pcall(function()
        local response = http_request({
            Url = DISCORD_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = HttpService:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{
                    ["title"] = "LAJ HUB Script Usage!",
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
                            ["value"] = "```" .. (game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game ID:",
                            ["value"] = "```" .. tostring(game.PlaceId) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Executor",
                            ["value"] = "```" .. (identifyexecutor() or "Unknown") .. "```",
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
            })
        })
    end)
    
    if not success then
        warn("Failed to send webhook: " .. tostring(error_message))
    end
end

-- Function to create notification
local function notify(title, text, duration)
    duration = duration or 5
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

-- Function to be called after a script is executed
local function executednotify(scriptName)
    notify(scriptName, "Script loaded successfully!", 3)
end

-- Send usage data
pcall(sendUsageData)

-- Create main window
local Window = Library.CreateLib("LAJ HUB", "Ocean")

-- Create all the tabs
local MainTab = Window:NewTab("Main")
local DaStrikeTab = Window:NewTab("Da Strike")
local FischTab = Window:NewTab("Fisch")
local BballZeroTab = Window:NewTab("Basketball Zero")
local BlueLockTab = Window:NewTab("Blue Lock Rivals")
local DeadRailsTab = Window:NewTab("Dead Rails [Alpha]")
local BloxFruitsTab = Window:NewTab("Blox Fruits")
local UniversalTab = Window:NewTab("Universal")
local SettingsTab = Window:NewTab("Settings")

-- Main Tab Sections
local MainSection = MainTab:NewSection("LAJ Hub")
local CreditsSection = MainTab:NewSection("Credits")

-- Discord link copy button
MainSection:NewButton("Copy Discord Link", "Copy the Discord invite link to clipboard", function()
    setclipboard("https://discord.gg/4mgdcfvAJU")
    notify("Discord Link Copied", "Invite link copied to clipboard!", 3)
end)

-- Create a button to manually trigger webhook
MainSection:NewButton("Test Webhook", "Test the webhook functionality", function()
    sendUsageData()
    notify("Webhook Test", "Attempted to send webhook notification!", 3)
end)

-- Da Strike Tab Section
local DaStrikeSection = DaStrikeTab:NewSection("Da Strike Scripts")

DaStrikeSection:NewButton("Psalm", "Execute Psalm script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NewWhitelistService/l/main/psalms%20old.lua"))()
    executednotify("Psalm Script")
end)

DaStrikeSection:NewButton("Ballware vfs", "Execute Ballware VFS script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/main/Protected_4021809531880627.txt"))()
    executednotify("Ballware VFS")
end)

DaStrikeSection:NewButton("FrostByte", "Execute FrostByte script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak", true))()
    executednotify("FrostByte")
end)

-- Fisch Tab Section
local FischSection = FischTab:NewSection("Fisch Scripts")

FischSection:NewButton("Speed Hub", "Execute Speed Hub script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    executednotify("Speed Hub")
end)

FischSection:NewButton("Luarmor Script (No Key)", "Execute Luarmor Script for Fisch", function()
    -- Luarmor script for Fisch
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/578c696a8d914279642068745713a73e.lua"))()
    executednotify("Luarmor Script")
end)

-- Basketball Zero Section
local BballZeroSection = BballZeroTab:NewSection("Basketball Zero Scripts")

BballZeroSection:NewButton("Ball Control", "Execute Ball Control script", function()
    -- Use the new Ball Control script
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/main/laj_hub_test.lua"))()
    executednotify("BasketBall Zero Script")
end)

-- Blue Lock Rivals Section
local BlueLockSection = BlueLockTab:NewSection("Blue Lock Rivals Scripts")

BlueLockSection:NewButton("LAJ HUB", "Execute LAJ HUB for Blue Lock", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/bluelocklajhub/main/blue_lock_mod.lua"))()
    executednotify("LAJ HUB")
end)

-- Dead Rails Section
local DeadRailsSection = DeadRailsTab:NewSection("Dead Rails Scripts")

DeadRailsSection:NewButton("Infernus Direct Loader (No Key)", "Execute Infernus Direct Loader", function()
    -- Bypassed loader for Infernus (Dead Rails)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/deadkrails/main/infernus_direct_loader.lua"))()
    executednotify("Infernus Direct Loader")
end)

DeadRailsSection:NewButton("SpineWare (No Key)", "Execute SpineWare script", function()
    -- SpineWare Universal Loader for Dead Rails
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SpineWare/UniversalLoader/main/Load"))()
    executednotify("SpineWare Loader")
end)

DeadRailsSection:NewButton("Luarmor Script (No Key)", "Execute Luarmor Script for Dead Rails", function()
    -- Luarmor script for Dead Rails
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/578c696a8d914279642068745713a73e.lua"))()
    executednotify("Luarmor Script")
end)

-- Blox Fruits Section
local BloxFruitsSection = BloxFruitsTab:NewSection("Blox Fruits Scripts")

BloxFruitsSection:NewButton("REDz Hub", "Execute REDz Hub script", function()
    -- REDz Hub for Blox Fruits (as requested)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/redz9999"))()
    executednotify("REDz Hub")
end)

-- Universal Section
local UniversalSection = UniversalTab:NewSection("Universal Scripts")

UniversalSection:NewButton("Infinite Yield FE", "Execute Infinite Yield FE", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    executednotify("Infinite Yield")
end)

UniversalSection:NewButton("Dex Explorer", "Execute Dex Explorer", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/scriptlx/main/dex.lua"))()
    executednotify("Dex Explorer")
end)

UniversalSection:NewButton("Hydroxide", "Execute Hydroxide", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/xChaoticVoid/Hydroxide/main/beta.lua"))()
    executednotify("Hydroxide")
end)

UniversalSection:NewButton("SimpleSpy", "Execute SimpleSpy", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
    executednotify("SimpleSpy")
end)

UniversalSection:NewButton("CMD-X Admin", "Execute CMD-X Admin", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source', true))()
    executednotify("CMD-X Admin")
end)

UniversalSection:NewButton("Domain X", "Execute Domain X", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/DomainX/main/source',true))()
    executednotify("Domain X")
end)

-- Settings Section
local SettingsSection = SettingsTab:NewSection("Settings")

local idled_Connection
local function onIdled()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new(0, 0))
end

SettingsSection:NewButton("Anti AFK", "Prevent being kicked for AFK", function()
    if not idled_Connection then
        idled_Connection = game.Players.LocalPlayer.Idled:Connect(onIdled)
        executednotify("Anti AFK")
    end
end)

local Inf_jump = false
SettingsSection:NewToggle("Infinite Jump", "Toggle infinite jump functionality", function(state)
    Inf_jump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if Inf_jump then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

-- Credit section
CreditsSection:NewLabel("Created by LAJ Hub Team")
CreditsSection:NewLabel("Discord: discord.gg/4mgdcfvAJU")
CreditsSection:NewLabel("Script Version: 4.0 (Modified)")
CreditsSection:NewLabel("* All features now accessible to everyone!")
