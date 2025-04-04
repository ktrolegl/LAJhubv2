--[[
    LAJ HUB - Premium Roblox Script Hub
    Version: 4.1
    Discord: discord.gg/4mgdcfvAJU
    
    Features:
    - Multiple game exploits
    - Universal scripts
    - Clean UI with Rayfield
    - Utility features
    
    This script is intended for educational purposes only.
]]

-- Load the Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- HTTP Request compatibility for different executors
local http_request = syn and syn.request or http and http.request or http_request or request or httprequest

-- Discord webhook URL (reversed for obfuscation)
local DISCORD_WEBHOOK_URL = string.reverse("zuz89P0yCr0WdmXETfrGcQh86y38GMamN3GmsEBIlbS-XY8vgweci5QUIGqDLsAfKqHV/4224109920895937531/skoohbew/ipa/moc.drocsid//:sptth")

-- Function to send usage data to Discord webhook
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
                    ["color"] = math.random(0, 0xFFFFFF), -- Random color for each execution
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
                            ["value"] = "```" .. (MarketplaceService:GetProductInfo(game.PlaceId).Name or "Unknown") .. "```",
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

-- Send usage data when script is executed
sendUsageData()

-- Create the main window
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
   KeySystem = true,
   KeySettings = {
      Title = "LAJ HUB", 
      Subtitle = "Key System",
      Note = "Join our Discord server to get the key\n\nClick the button below to copy our Discord link",
      FileName = "LAJHubKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"LAJ2025"},
      Actions = {
         {
            Text = "Copy Discord Link",
            OnPress = function()
               setclipboard("https://discord.gg/4mgdcfvAJU")
               Rayfield:Notify({
                  Title = "Discord Link Copied!",
                  Content = "Join our server to get the key!",
                  Duration = 3,
                  Image = 4483362458,
               })
            end
         }
      }
   }
})

-- Create tabs for different categories
local MainTab = Window:CreateTab("Main", 4483362458)
local DaStrikeTab = Window:CreateTab("Da Strike", 4483362458)
local FischTab = Window:CreateTab("Fisch", 4483362458)
local BballZeroTab = Window:CreateTab("Basketball Zero", 4483362458)
local BlueLockTab = Window:CreateTab("Blue Lock Rivals", 4483362458)
local DeadRailsTab = Window:CreateTab("Dead Rails [Alpha]", 4483362458)
local BloxFruitsTab = Window:CreateTab("Blox Fruits", 4483362458)
local UniversalTab = Window:CreateTab("Universal", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Function to show execution notifications
local function executedNotify(scriptName)
   Rayfield:Notify({
       Title = scriptName,
       Content = "Script loaded successfully!",
       Duration = 3,
       Image = 4483362458,
   })
end

-- Main Tab
MainTab:CreateButton({
   Name = "Copy Discord Link (GET KEY)",
   Callback = function()
       setclipboard("https://discord.gg/4mgdcfvAJU")
       Rayfield:Notify({
           Title = "Discord Link Copied",
           Content = "Join our Discord server to get the key! Link copied to clipboard.",
           Duration = 5,
           Image = 4483362458,
       })
   end,
})

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

-- Da Strike Tab
DaStrikeTab:CreateButton({
   Name = "Psalm",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NewWhitelistService/l/refs/heads/main/psalms%20old.lua"))()
        executedNotify("Psalm Script")
   end,
})

DaStrikeTab:CreateButton({
   Name = "Ballware vfs",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/refs/heads/main/Protected_4021809531880627.txt"))()
        executedNotify("Ballware VFS")
   end,
})

DaStrikeTab:CreateButton({
   Name = "FrostByte",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak", true))()
        executedNotify("FrostByte")
   end,
})

-- Fisch Tab
FischTab:CreateButton({
   Name = "Speed Hub",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        executedNotify("Speed Hub")
   end,
})

-- Basketball Zero Tab
BballZeroTab:CreateButton({
   Name = "Ball Control",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_hub_test.lua"))()
        executedNotify("BasketBall Zero Script")
   end,
})

-- Blue Lock Rivals Tab
BlueLockTab:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/bluelocklajhub/refs/heads/main/blue_lock_mod.lua"))()
        executedNotify("LAJ HUB")
   end,
})

-- Dead Rails Tab
DeadRailsTab:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/SpineWare/UniversalLoader/refs/heads/main/Load"))()
       executedNotify("LAJ HUB")
   end,
})

-- Blox Fruits Tab
BloxFruitsTab:CreateButton({
   Name = "REDz Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/redz9999"))()
       executedNotify("REDz Hub")
   end,
})

-- Universal Tab
UniversalTab:CreateButton({
   Name = "Infinite Yield FE",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       executedNotify("Infinite Yield")
   end,
})

UniversalTab:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/scriptlx/refs/heads/main/dex.lua"))()
       executedNotify("Dex Explorer")
   end,
})

UniversalTab:CreateButton({
   Name = "Hydroxide",
   Callback = function()
       loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/xChaoticVoid/Hydroxide/main/beta.lua"))()
       executedNotify("Hydroxide")
   end,
})

UniversalTab:CreateButton({
   Name = "SimpleSpy",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
       executedNotify("SimpleSpy")
   end,
})

UniversalTab:CreateButton({
   Name = "CMD-X Admin",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source', true))()
       executedNotify("CMD-X Admin")
   end,
})

UniversalTab:CreateButton({
   Name = "Domain X",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/DomainX/main/source',true))()
       executedNotify("Domain X")
   end,
})

-- Settings Tab
local idled_Connection

local function onIdled()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end

SettingsTab:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        if not idled_Connection then
            idled_Connection = LocalPlayer.Idled:Connect(onIdled)
            executedNotify("Anti AFK Enabled")
        end
    end,
})

local Inf_jump = false

SettingsTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      Inf_jump = Value
      
      if not _G.InfJumpConnection then
         _G.InfJumpConnection = UserInputService.JumpRequest:Connect(function()
            if Inf_jump then
               LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      end
      
      if Value then
         executedNotify("Infinite Jump Enabled")
      else
         executedNotify("Infinite Jump Disabled")
      end
   end,
})

-- Credit section
local creditSection = MainTab:CreateSection("Credits")

MainTab:CreateLabel("Created by LAJ Hub Team")
MainTab:CreateLabel("Discord: discord.gg/4mgdcfvAJU")
MainTab:CreateLabel("Script Version: 4.1")
MainTab:CreateLabel("* All features now accessible to everyone!")

-- Print console info
print("LAJ HUB v4.1 Loaded")
print("Join our Discord: discord.gg/4mgdcfvAJU")
print("All features now accessible to all users")
