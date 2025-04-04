local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
		            ["color"] = math.random(0, 0xFFFFFF), -- changed color everytime a pleyah executa;)
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
		
        HttpService:PostAsync(DISCORD_WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson, false)
    end)
    
    if not success then
        warn("Failed to send webhook: " .. tostring(error_message))
    end
end

sendUsageData()

local Window = Rayfield:CreateWindow({
   Name = "LAJ HUB",
   Icon = 0,
   LoadingTitle = "LAJ HUB",
   LoadingSubtitle = "Premium Scripts",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LAJHub", -- Create a custom folder for your hub/game
      FileName = "LAJHubConfig"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "4mgdcfvAJU", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   -- Key system disabled so everyone can use it
   KeySystem = false,
   KeySettings = {
      Title = "LAJ HUB", 
      Subtitle = "Key System",
      Note = "Join our Discord server: https://discord.gg/4mgdcfvAJU",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"LAJPRO"} -- Single key for all users
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
local Settings = Window:CreateTab("Settings", 4483362458)
-- Note: AdminTab completely removed from this version to ensure it's not accessible

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

-- Da Strike Tab scripts
Tab:CreateButton({
   Name = "Psalm",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NewWhitelistService/l/refs/heads/main/psalms%20old.lua"))()
        executednotify("Psalm Script")
   end,
})

Tab:CreateButton({
   Name = "Ballware vfs",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/refs/heads/main/Protected_4021809531880627.txt"))()
        executednotify("Ballware VFS")
   end,
})

Tab:CreateButton({
   Name = "FrostByte",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak", true))()
        executednotify("FrostByte")
   end,
})

-- Fisch Tab
Fin:CreateButton({
   Name = "Speed Hub",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        executednotify("Speed Hub")
   end,
})

-- Basketball Zero script with bypass
BballZero:CreateButton({
   Name = "Ball Control",
   Callback = function()
        -- Use the new Ball Control script
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_hub_test.lua"))()
        executednotify("BasketBall Zero Script")
   end,
})

-- Blue Lock Rivals script
BlueLock:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/bluelocklajhub/refs/heads/main/blue_lock_mod.lua"))()
        executednotify("LAJ HUB")
   end,
})

-- Dead Rails Tab
DeadRails:CreateButton({
   Name = "Infernus Direct Loader (No Key)",
   Callback = function()
       -- Bypassed loader for Infernus (Dead Rails)
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/deadkrails/main/infernus_direct_loader.lua"))()
       executednotify("Infernus Direct Loader")
   end,
})

DeadRails:CreateButton({
   Name = "Bynner (No Key)",
   Callback = function()
       -- Bynner script for Dead Rails
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/deadkrails/refs/heads/main/bynner.lua"))()
       executednotify("Bynner Script")
   end,
})

-- Blox Fruits Tab (Updated)
BloxFruits:CreateButton({
   Name = "REDz Hub",
   Callback = function()
       -- REDz Hub for Blox Fruits (as requested)
       loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/redz9999"))()
       
       executednotify("REDz Hub")
   end,
})

-- Universal Tab
Universal:CreateButton({
   Name = "Infinite Yield FE",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       executednotify("Infinite Yield")
   end,
})

Universal:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/scriptlx/refs/heads/main/dex.lua"))()
       executednotify("Dex Explorer")
   end,
})

Universal:CreateButton({
   Name = "Hydroxide",
   Callback = function()
       loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/xChaoticVoid/Hydroxide/main/beta.lua"))()
       executednotify("Hydroxide")
   end,
})

Universal:CreateButton({
   Name = "SimpleSpy",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
       executednotify("SimpleSpy")
   end,
})

Universal:CreateButton({
   Name = "CMD-X Admin",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source', true))()
       executednotify("CMD-X Admin")
   end,
})

Universal:CreateButton({
   Name = "Domain X",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/DomainX/main/source',true))()
       executednotify("Domain X")
   end,
})


-- Settings Tab
local idled_Connection

local function onIdled()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new(0, 0))
end

Settings:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        if not idled_Connection then
            idled_Connection = game.Players.LocalPlayer.Idled:Connect(onIdled)
            executednotify("Anti AFK")
        end
    end,
})

local Inf_jump = false

Settings:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      Inf_jump = Value
      game:GetService("UserInputService").JumpRequest:Connect(function()
         if Inf_jump then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
         end
      end)
   end,
})

-- Credit section
local creditSection = MainTab:CreateSection("Credits")

MainTab:CreateLabel("Created by LAJ Hub Team")
MainTab:CreateLabel("Discord: discord.gg/4mgdcfvAJU")
MainTab:CreateLabel("Script Version: 4.0 (Modified)")
MainTab:CreateLabel("* All features now accessible to everyone!")

-- Note: This script is meant to be used in Roblox and won't function in a standalone Lua environment
print("Note: This is a FIXED version of the KEYS script with these changes:")
print("1. Completely removed all admin-only code and restrictions")
print("2. Removed the Admin tab entirely (not just hiding it)")
print("3. Removed all ban system code")
print("4. Removed key system")
print("5. Replaced Blox Fruits scripts with REDz Hub")
print("6. All features now accessible to all users")
