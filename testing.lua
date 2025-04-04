local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Discord webhook for usage tracking
local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1357395980299014224/VHqKfAsLDqGIUQ5icewgv8YX-SblIBEsmG3NmaMG83y68hQcGrfTEXmdW0rCy0P98zuz"

-- Function to send usage data to Discord webhook with improved error handling
local function sendUsageData()
    local success, error_message = pcall(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local HttpService = game:GetService("HttpService")
        
        -- Get device info and game info
        local deviceInfo = {}
        local executor = "Unknown"
        pcall(function() 
            executor = identifyexecutor() or "Unknown" 
        end)
        
        local gameName = "Unknown"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)
        
        -- Prepare embed data for Discord
        local data = {
            content = "**LAJ HUB Execution Alert**",
            embeds = {
                {
                    title = "LAJ HUB Script Usage",
                    description = "A player has executed LAJ HUB",
                    color = 5814783, -- Purple color
                    fields = {
                        {
                            name = "User",
                            value = LocalPlayer.Name,
                            inline = true
                        },
                        {
                            name = "User ID",
                            value = tostring(LocalPlayer.UserId),
                            inline = true
                        },
                        {
                            name = "Game",
                            value = gameName,
                            inline = true
                        },
                        {
                            name = "Game ID",
                            value = tostring(game.PlaceId),
                            inline = true
                        },
                        {
                            name = "Executor",
                            value = executor,
                            inline = true
                        },
                        {
                            name = "Time",
                            value = os.date("%Y-%m-%d %H:%M:%S"),
                            inline = true
                        }
                    },
                    timestamp = DateTime.now():ToIsoDate()
                }
            }
        }
        
        -- Convert to JSON
        local jsonData = HttpService:JSONEncode(data)
        
        -- Direct HTTP request (alternative method)
        request({
            Url = DISCORD_WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
        
        -- Try HttpService as backup
        HttpService:PostAsync(DISCORD_WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson, false)
    end)
    
    if not success then
        warn("Failed to send webhook: " .. tostring(error_message))
    end
end

-- Send usage data right at the start
sendUsageData()

-- Note: Ban system has been removed to allow all users to access the script

local Window = Rayfield:CreateWindow({
   Name = "LAJ HUB",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "LAJ HUB",
   LoadingSubtitle = "Premium Scripts",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false, 
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "4mgdcfvAJU", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Key system disabled for now
   KeySettings = {
      Title = "LAJ HUB", 
      Subtitle = "Key System",
      Note = "Join our Discord server: https://discord.gg/4mgdcfvAJU",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"LAJPRO", "yessir"}
   }
})

-- Create a main tab for important utilities
local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Tab = Window:CreateTab("Da Strike", 4483362458) -- Title, Image
local Fin = Window:CreateTab("Fisch", 4483362458) -- Title, Image
local BballZero = Window:CreateTab("Basketball Zero", 4483362458) -- Title, Image
local BlueLock = Window:CreateTab("Blue Lock Rivals", 4483362458) -- Title, Image
local DeadRails = Window:CreateTab("Dead Rails [Alpha]", 4483362458) -- Dead Rails tab
local BloxFruits = Window:CreateTab("Blox Fruits", 4483362458) -- Blox Fruits tab
local Universal = Window:CreateTab("Universal", 4483362458) -- Universal scripts tab

-- Discord link copy button
MainTab:CreateButton({
   Name = "Copy Discord Link",
   Callback = function()
       setclipboard("https://discord.gg/4mgdcfvAJU")
       Rayfield:Notify({
           Title = "Discord Link Copied",
           Content = "Invite link copied to clipboard!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Create a button to manually trigger webhook
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

-- Da Strike Scripts
Tab:CreateSection("Da Strike Scripts")

Tab:CreateButton({
   Name = "Kill Aura",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Dastrikekill.lua"))()
       Rayfield:Notify({
           Title = "Kill Aura",
           Content = "Kill Aura script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

Tab:CreateButton({
   Name = "Super Speed [J]",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Dastrikesuper.lua"))()
       Rayfield:Notify({
           Title = "Super Speed",
           Content = "Super Speed script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

Tab:CreateButton({
   Name = "Inf Air [K]",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Dastrikeinf.lua"))()
       Rayfield:Notify({
           Title = "Infinite Air",
           Content = "Infinite Air script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Fisch Scripts
Fin:CreateSection("Fisch Scripts")

Fin:CreateButton({
   Name = "Teleport to Shark",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Fisch1.lua"))()
       Rayfield:Notify({
           Title = "Teleport to Shark",
           Content = "Teleport to Shark script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

Fin:CreateButton({
   Name = "Teleport to Whale",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Fisch2.lua"))()
       Rayfield:Notify({
           Title = "Teleport to Whale",
           Content = "Teleport to Whale script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Basketball Zero Scripts
BballZero:CreateSection("Basketball Zero Scripts")

BballZero:CreateButton({
   Name = "Auto Green",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Autogreen.lua"))()
       Rayfield:Notify({
           Title = "Auto Green",
           Content = "Auto Green script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

BballZero:CreateButton({
   Name = "Shoot from anywhere",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/Bbno.lua"))()
       Rayfield:Notify({
           Title = "Shoot from Anywhere",
           Content = "Shoot from Anywhere script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Blue Lock Rivals Scripts
BlueLock:CreateSection("Blue Lock Rivals Scripts")

BlueLock:CreateButton({
   Name = "Auto Goal",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/AutoGoalBlue.lua"))()
       Rayfield:Notify({
           Title = "Auto Goal",
           Content = "Auto Goal script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Dead Rails Scripts
DeadRails:CreateSection("Dead Rails [Alpha] Scripts")

DeadRails:CreateButton({
   Name = "Silent Aim",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/DeadRailsSilent.lua"))()
       Rayfield:Notify({
           Title = "Silent Aim",
           Content = "Silent Aim script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

DeadRails:CreateButton({
   Name = "ESP",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/DeadRailsESP.lua"))()
       Rayfield:Notify({
           Title = "ESP",
           Content = "ESP script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Blox Fruits Scripts
BloxFruits:CreateSection("Blox Fruits Scripts")

BloxFruits:CreateButton({
   Name = "Neva Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/VEZ2/NEVAHUB/main/2"))()
       Rayfield:Notify({
           Title = "Neva Hub",
           Content = "Neva Hub script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

BloxFruits:CreateButton({
   Name = "Hoho Hub",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
       Rayfield:Notify({
           Title = "Hoho Hub",
           Content = "Hoho Hub script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Universal Scripts
Universal:CreateSection("Universal Scripts")

Universal:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       Rayfield:Notify({
           Title = "Infinite Yield",
           Content = "Infinite Yield loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

Universal:CreateButton({
   Name = "Fly Script",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/UniversalFly.lua"))()
       Rayfield:Notify({
           Title = "Fly Script",
           Content = "Fly script loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

Universal:CreateButton({
   Name = "CMD-X Admin",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
       Rayfield:Notify({
           Title = "CMD-X Admin",
           Content = "CMD-X Admin loaded successfully!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})
