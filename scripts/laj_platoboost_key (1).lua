--[[
    LAJ HUB Key System using PlatoBoost
    Professional key verification system with LootLink monetization
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local LocalPlayer = Players.LocalPlayer

-- Settings
local Settings = {
    Colors = {
        Primary = Color3.fromRGB(32, 34, 37),
        Secondary = Color3.fromRGB(47, 49, 54),
        Accent = Color3.fromRGB(114, 137, 218),
        Text = Color3.fromRGB(255, 255, 255),
        Success = Color3.fromRGB(67, 181, 129),
        Error = Color3.fromRGB(240, 71, 71),
        Hover = Color3.fromRGB(57, 60, 67)
    },
    DefaultHubVersion = "Standard", -- Default script to load
    HubScripts = {
        ["Standard"] = "laj_hub_modern.lua",
        ["Premium"] = "laj_hub_premium_ronix.lua",
        ["Elite"] = "laj_hub_elite.lua", 
        ["Mobile"] = "laj_hub_mobile.lua",
        ["Futuristic"] = "laj_hub_futuristic.lua"
    }
}

-------------------------------------------------------------------------------
--! PlatoBoost Integration
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=h~=i and 1 or 0;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function p(d,...)local e=d;for q=1,select('#',...)do e=k(e,select(q,...))end;return e end;local function r(d,...)local e=d;for q=1,select('#',...)do e=n(e,select(q,...))end;return e end;local function s(d,e)d=d%a;e=e%a;return(d+e)%a end;local function t(d,e)d=d%a;e=e%a;return(d-e)%a end;local function u(d,e)d=d%a;e=e%a;return(d*e)%a end;local function v(d,e)d=d%a;e=e%a;return math.floor(d/e)%a end;local function w(d,e)if e<0 then return w(d,e+32)end;d=d%a;e=e%a;e=e%32;if e==0 then return d end;return(d*(2^e))%a end;local function x(d,e)if e<0 then return x(d,e+32)end;d=d%a;e=e%a;e=e%32;if e==0 then return d end;return math.floor(d/(2^e))%a end;local function y(d,e)d=d%a;e=e%a;e=e%32;local z=2^e-1;local A=math.floor(d/(2^e))*(2^e)return d-A+A%(2^(32-e)*(2^e)) end;local function B(C)return t(0,C)%a end;local D={[0]=bit and bit.bnot or B,k,n,bit and bit.bxor or o,bit and bit.lshift or w,bit and bit.rshift or x,bit and bit.bswap or y,s,t,u,v,bit and bit.rol or function(d,e)e=e%32;d=d%a;e=e%32;return w(d,e)+x(d,32-e)%a end,bit and bit.ror or function(d,e)e=e%32;d=d%a;e=e%32;return x(d,e)+w(d,32-e)%a end,}local function E(F,G)G=G or"Error while parsing JSON"error({message=G,at=F,text=G},2)end;local H;local function I(F,J)local K=H(F,J)local L=J or 1;if type(F)~='string'then E(L,"expected argument of type string")end;return K end;local M={['"']='"',['\\']='\\',['/']='\/',['b']='\b',['f']='\f',['n']='\n',['r']='\r',['t']='\t'}local N={['\\"']='"',['\\\\']='\\',['\\/']='\/',['\\b']='\b',['\\f']='\f',['\\n']='\n',['\\r']='\r',['\\t']='\t'}local O={[9]=true,[10]=true,[13]=true,[32]=true}local function P(F,L)local Q=string.sub(F,L,L)return O[string.byte(Q)]and L+1 or L end;local function R(F,L)if L>#F then return end;local S=string.byte(F,L)if S<0x80 then return S,L+1 elseif S<0xE0 then if L+1>#F then return end;return(S-0xC0)*0x40+string.byte(F,L+1)-0x80,L+2 elseif S<0xF0 then if L+2>#F then return end;return(S-0xE0)*0x1000+string.byte(F,L+1)%0x40*0x40+string.byte(F,L+2)%0x40,L+3 elseif S<0xF8 then if L+3>#F then return end;return(S-0xF0)*0x40000+string.byte(F,L+1)%0x40*0x1000+string.byte(F,L+2)%0x40*0x40+string.byte(F,L+3)%0x40,L+4 else return E(L,"invalid UTF-8 code")end end;local T;local U="\u"local V="0123456789abcdef"local function W(X)return string.char(tonumber(X,16))end;local function Y(X,L)X=string.lower(X)local Z=0;for q=1,#X do Z=Z*16;local _=string.sub(X,q,q)local a0;for a1=1,#V do if string.sub(V,a1,a1)==_ then a0=a1-1;break end end;if not a0 then E(L,"invalid Unicode escape sequence")end;Z=Z+a0 end;return R(T(Z),1)end;local function a2(F,L)local a3=string.match(F,"^[0-9]+",L)if a3 then local a4=tonumber(a3)if a4 and a4<=0x10FFFF then return Y(string.format("%x",a4),L)end end;E(L,"invalid Unicode escape sequence")end;local function a5(F,L)if string.sub(F,L,L+1)~="u"then return string.char(string.byte(F,L))end;local a6=string.sub(F,L+1,L+5)if string.sub(a6,1,1)=="{"then local _,a7=string.find(F,"}",L+2,true)if not a7 then E(L,"invalid Unicode escape sequence")end;return a2(string.sub(F,L+3,a7-1),L)end;return Y(a6,L)end;local function a8(F,L)local a9=L+1;while a9<=#F do local S,aa=R(F,a9)if not S then E(L,"expected closing quote for string")end;if S==34 then local ab=string.sub(F,L+1,a9-1)local ac=string.find(ab,"\\")if ac then local ad=1;local ae=""repeat local af=string.sub(ab,ad,ac-1)ae=ae..af;local ag=string.sub(F,L+ac,L+ac+1)local ah=N[ag]if ag=="\\u"then ah=a5(F,L+ac+1)a9=a9+4 end;if not ah then E(L+ac,"invalid escape sequence")end;ae=ae..ah;ad=ac+2;ac=string.find(ab,"%\\",ad)until not ac;ae=ae..string.sub(ab,ad)return ae,aa elseif ab==""then return ab,aa end;return ab,aa else a9=a9+1 end end;E(L,"expected closing quote for string")end;local ai={}local function aj(ak)local al=getmetatable(ak)if al then if al.__jsontype then return al.__jsontype end;if al.__tostring then return nil end end;return nil end;function ai.null()return{__jsontype="null"}end;function ai.object(ak)ak=ak or{}return setmetatable(ak,{__jsontype="object"})end;function ai.array(ak)ak=ak or{}return setmetatable(ak,{__jsontype="array"})end;local function am(F,L)L=P(F,L or 1)if L>#F then return nil,L end;local an=string.sub(F,L,L)if an=="{" then local ak={}local ao=L;local ap=true;L=P(F,L+1)if string.sub(F,L,L)=="}"then return ai.object(ak),L+1 end;while true do if L>#F then E(ao,"unclosed '{'")end;if not ap then L=P(F,L)local aq=string.sub(F,L,L)if aq=="}"then return ai.object(ak),L+1 elseif aq==","then L=P(F,L+1)else E(L,"object '}' or ',' expected")end end;L=P(F,L)if string.sub(F,L,L)=="}"then return ai.object(ak),L+1 end;if string.sub(F,L,L)~='"'then E(L,"string expected")end;local a_,L=am(F,L)if type(a_)~='string'then E(L,"string expected")end;L=P(F,L)if string.sub(F,L,L)~=":"then E(L,"':' expected")end;L=P(F,L+1)local a0,L=am(F,L)ak[a_]=a0;ap=false end elseif an=="["then local ar={}local ao=L;local ap=true;L=P(F,L+1)if string.sub(F,L,L)=="]"then return setmetatable(ar,{__jsontype="array"}),L+1 end;while true do if L>#F then E(ao,"unclosed '['")end;if not ap then L=P(F,L)local aq=string.sub(F,L,L)if aq=="]"then return ai.array(ar),L+1 elseif aq==","then L=P(F,L+1)else E(L,"array ] or , expected")end end;L=P(F,L)if string.sub(F,L,L)=="]"then return ai.array(ar),L+1 end;local a0,as=am(F,L)table.insert(ar,a0)L=as;ap=false end elseif an=='"'then return a8(F,L)elseif string.sub(F,L,L+3)=="null"then return ai.null(),L+4 elseif string.sub(F,L,L+3)=="true"then return true,L+4 elseif string.sub(F,L,L+4)=="false"then return false,L+5 else local at=tonumber(string.match(F,"^-?[%d%.]+[eE]?[%+%-]?%d*",L))if at then local a3=string.match(F,"^-?[%d%.]+[eE]?[%+%-]?%d*",L)return at,L+#a3 end;E(L,"value expected")end end;local function au(value,av,aw,ax)local ay=math.floor;local az=type;local function aA(value)local aB=aj(value)if aB=="array"then return"array"elseif aB=="object"then return"object"elseif aB=="null"then return"null"end;local aC=az(value)if aC=="userdata"or aC=="function"or aC=="thread"or aC=="cdata"then error("unsupported type:"..aC)end;return aC end;local function aD(aE,aF)for q=1,#aF do if aF[q]==aE then error("circular reference detected")end end end;local function aG(a_)a_=tostring(a_)if a_:match('^".*"$')then return a_ end;return'"'..a_:gsub('[%z\1-\31\\"/]',function(aH)local ah=M[aH]if ah then return'\\'..ah end;return string.format('\\u00%02x',string.byte(aH))end)..'"'end;local function aI(ak,aF)if next(ak)==nil then return"{}"end;aF=aF or{}aD(ak,aF)table.insert(aF,ak)local aJ={"{"..aw}local aK=true;local function aL(a_,aM)if not aK then aJ[#aJ+1]="," end;aK=false;if av then aJ[#aJ+1]=aw..string.rep(ax,#aF)end;aJ[#aJ+1]=aG(a_)aJ[#aJ+1]=":"if av then aJ[#aJ+1]=" "end;aJ[#aJ+1]=aM end;local aN={}for a_ in pairs(ak)do if az(a_)=='string'or az(a_)=='number'then table.insert(aN,a_)end end;table.sort(aN)for q,a_ in ipairs(aN)do aL(a_,au(ak[a_],av,aw,ax,aF))end;aF[#aF]=nil;if av then aJ[#aJ+1]=aw..string.rep(ax,#aF)end;aJ[#aJ+1]="}"return table.concat(aJ)end;local function aO(ar,aF)if #ar==0 then return"[]"end;aF=aF or{}aD(ar,aF)table.insert(aF,ar)local aJ={"["..aw}local aK=true;for q,aP in ipairs(ar)do if not aK then aJ[#aJ+1]="," end;aK=false;if av then aJ[#aJ+1]=aw..string.rep(ax,#aF)end;aJ[#aJ+1]=au(aP,av,aw,ax,aF)end;aF[#aF]=nil;if av then aJ[#aJ+1]=aw..string.rep(ax,#aF)end;aJ[#aJ+1]="]"return table.concat(aJ)end;local aC=aA(value)if value==ai.null()or value==nil then return"null"elseif aC=="string"then return aG(value)elseif aC=="number"then local aQ;if value==ay(value)then aQ=tostring(ay(value))else aQ=tostring(value)end;if aQ=="nan"then aQ="NaN"elseif aQ=="inf"then aQ="Infinity"elseif aQ=="-inf"then aQ="-Infinity"end;return aQ elseif aC=="boolean"then return tostring(value)elseif aC=="array"then return aO(value,aF)elseif aC=="object"then return aI(value,aF)else error("unsupported type:"..aC)end end;local function av(F,G)local aR=ax or"    "local aS=aw or"\n"local at,L=am(F,1)if L<=#F then E(L,G)end;return au(at,true,aS,aR)end;H=am;local lEncoder,lDecoder={}lEncoder.encode=function(aT)return au(aT,false)end;lEncoder.encode_pretty=function(aT)return au(aT,true,"\n","    ")end;lEncoder.encode_pretty=function(aT,ax,aw)return au(aT,true,aw or"\n",ax or"    ")end;lDecoder.decode=I;local function a3(aU)local aV={}for i=1,#aU do aV[i]=string.char(aU[i])end;return table.concat(aV)end;T=a3;local function Z(aU)if type(aU)=='string'then aU={string.byte(aU,1,#aU)}end;local aW={(D[0](255)),128,0,D[3](D[5](aU[1],56),D[5](aU[2],48),D[5](aU[3],40),D[5](aU[4],32),D[5](aU[5],24),D[5](aU[6],16),D[5](aU[7],8),aU[8]),D[3](D[5](aU[9],56),D[5](aU[10],48),D[5](aU[11],40),D[5](aU[12],32),D[5](aU[13],24),D[5](aU[14],16),D[5](aU[15],8),aU[16]),D[3](D[5](aU[17],56),D[5](aU[18],48),D[5](aU[19],40),D[5](aU[20],32),D[5](aU[21],24),D[5](aU[22],16),D[5](aU[23],8),aU[24]),D[3](D[5](aU[25],56),D[5](aU[26],48),D[5](aU[27],40),D[5](aU[28],32),D[5](aU[29],24),D[5](aU[30],16),D[5](aU[31],8),aU[32]),D[3](D[5](aU[33],56),D[5](aU[34],48),D[5](aU[35],40),D[5](aU[36],32),D[5](aU[37],24),D[5](aU[38],16),D[5](aU[39],8),aU[40]),D[3](D[5](aU[41],56),D[5](aU[42],48),D[5](aU[43],40),D[5](aU[44],32),D[5](aU[45],24),D[5](aU[46],16),D[5](aU[47],8),aU[48]),D[3](D[5](aU[49],56),D[5](aU[50],48),D[5](aU[51],40),D[5](aU[52],32),D[5](aU[53],24),D[5](aU[54],16),D[5](aU[55],8),aU[56]),D[3](D[5](aU[57],56),D[5](aU[58],48),D[5](aU[59],40),D[5](aU[60],32),D[5](aU[61],24),D[5](aU[62],16),D[5](aU[63],8),aU[64])}local aX={{0,"i64",8},{1,"i64",8},{2,"i64",8},{3,"i64",8},{4,"i64",8},{5,"i64",8},{6,"i64",8},{7,"i64",8},{8,"i64",8},{9,"i64",8},{10,"i64",8},{11,"i64",8},{12,"i64",8},{13,"i64",8},{14,"i64",8},{15,"i64",8}}local function aY(aZ,a_)local aV={}for i=1,#aZ do aV[i]=aZ[i]end;for i=1,#a_ do aV[#aZ+i]=a_[i]end;return aV end;local function b0()local aZ=aW;local a_={};a_[#a_+1]=0;local b1=128;a_[#a_+1]=D[2](b1,0);a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=0;a_[#a_+1]=D[2](0,0);aZ=aY(aZ,a_);local b2=D[3](D[10](aZ[1],aZ[2],aZ[3],aZ[4],aZ[5],aZ[6],aZ[7],aZ[8]),D[11](aZ[1],1),D[11](aZ[1],8),D[11](aZ[1],7),D[11](aZ[1],1));local b3=string.format("%x",b2);while#b3<16 do b3="0"..b3 end;local b4={}for i=1,16 do b4[i]=tonumber(b3:sub(i,i),16)end;return b4 end;return b0()end;local lEncode, lDecode, lDigest = lEncoder.encode, lDecoder.decode, Z;

--! platoboost library
--! configuration
local service = 3461;  -- your service id from PlatoBoost dashboard
local secret = "426ceb40-3cd6-4633-9ab9-80ad6ce3a49d";  -- your secret key from PlatoBoost
local useNonce = true;  -- use a nonce to prevent replay attacks

--! callbacks
local onMessage = function(message) 
    -- We'll override this with our UI notifications
end

--! wait for game to load
repeat task.wait(1) until game:IsLoaded();

--! functions
local requestSending = false;
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local cachedLink, cachedTime = "", 0;

--! Your Direct-Link URL that points to PlatoBoost tasks
local directLinkURL = "https://direct-link.net/1335874/key-step-1";
local cachedLink = directLinkURL; -- No need to fetch dynamically

--! Simplified host setup
local host = "https://api.platoboost.com";
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
});
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net";
end

--! nonce generator
local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--! verify nonce generation
for _ = 1, 5 do
    local oNonce = generateNonce();
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "PlatoBoost nonce error.";
        onMessage(msg);
        error(msg);
    end
end

--! copy link function
local copyLink = function()
    -- Copy the Direct Link URL to clipboard
    fSetClipboard(directLinkURL);
    return true;
end

--! redeem key function
local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("Failed to verify integrity.");
                        return false;
                    end    
                else
                    return true;
                end
            else
                onMessage("Key is invalid.");
                return false;
            end
        else
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("You already have an active key, please wait for it to expire before redeeming it.");
                return false;
            else
                onMessage(decoded.message);
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("You are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("Server returned an invalid status code, please try again later.");
        return false; 
    end
end

--! verify key function
local verifyKey = function(key)
    if requestSending == true then
        onMessage("A request is already being sent, please slow down.");
        return false;
    else
        requestSending = true;
    end

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false;

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("Failed to verify integrity.");
                        return false;
                    end
                else
                    return true;
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    return redeemKey(key);
                else
                    onMessage("Key is invalid.");
                    return false;
                end
            end
        else
            onMessage(decoded.message);
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("You are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("Server returned an invalid status code, please try again later.");
        return false;
    end
end

--! get flag function
local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value;
                else
                    onMessage("Failed to verify integrity.");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message);
            return nil;
        end
    else
        return nil;
    end
end
-------------------------------------------------------------------------------

-- Load the script from GitHub repository
local function LoadScript()
    -- Direct link to the main script on GitHub
    local githubScriptUrl = "https://raw.githubusercontent.com/ktrolegl/LAJhubv2/refs/heads/main/DFISCH"
    
    -- Load the script from GitHub
    local success, result = pcall(function()
        return game:HttpGet(githubScriptUrl)
    end)
    
    if success then
        loadstring(result)()
    else
        -- Fallback in case of error
        print("[LAJ HUB] Failed to load script from GitHub. Error: " .. tostring(result))
        
        -- Try loading from Settings as fallback
        pcall(function()
            local scriptName = Settings.HubScripts[hubVersion] or Settings.HubScripts[Settings.DefaultHubVersion]
            loadstring(game:HttpGet("https://raw.githubusercontent.com/laj-hub/scripts/main/" .. scriptName))()
        end)
    end
end

-- UI Framework
local KeyUI = {}

function KeyUI:Create()
    -- Destroy existing GUI if present
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
    
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "LAJHubKeySystem"
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    
    -- Use protective measures to prevent detection
    if syn and syn.protect_gui then
        syn.protect_gui(self.ScreenGui)
        self.ScreenGui.Parent = game.CoreGui
    elseif gethui then
        self.ScreenGui.Parent = gethui()
    else
        self.ScreenGui.Parent = game.CoreGui
    end
    
    -- Create main frame
    self.Main = Instance.new("Frame")
    self.Main.Name = "Main"
    self.Main.Size = UDim2.new(0, 380, 0, 280)
    self.Main.Position = UDim2.new(0.5, -190, 0.5, -140)
    self.Main.BackgroundColor3 = Settings.Colors.Primary
    self.Main.BorderSizePixel = 0
    self.Main.AnchorPoint = Vector2.new(0.5, 0.5)
    self.Main.Parent = self.ScreenGui
    
    -- Make the UI draggable
    self:MakeDraggable(self.Main)
    
    -- Create top bar with title
    self.TopBar = Instance.new("Frame")
    self.TopBar.Name = "TopBar"
    self.TopBar.Size = UDim2.new(1, 0, 0, 36)
    self.TopBar.BackgroundColor3 = Settings.Colors.Secondary
    self.TopBar.BorderSizePixel = 0
    self.TopBar.Parent = self.Main
    
    -- Title text
    self.Title = Instance.new("TextLabel")
    self.Title.Name = "Title"
    self.Title.Size = UDim2.new(1, -10, 1, 0)
    self.Title.Position = UDim2.new(0, 10, 0, 0)
    self.Title.BackgroundTransparency = 1
    self.Title.Text = "LAJ HUB Key System"
    self.Title.TextColor3 = Settings.Colors.Text
    self.Title.TextSize = 18
    self.Title.Font = Enum.Font.GothamBold
    self.Title.TextXAlignment = Enum.TextXAlignment.Left
    self.Title.Parent = self.TopBar
    
    -- Close button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 36, 0, 36)
    self.CloseButton.Position = UDim2.new(1, -36, 0, 0)
    self.CloseButton.BackgroundTransparency = 1
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Settings.Colors.Text
    self.CloseButton.TextSize = 24
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.Parent = self.TopBar
    
    -- Close button hover effect
    self.CloseButton.MouseEnter:Connect(function()
        self.CloseButton.TextColor3 = Settings.Colors.Error
    end)
    
    self.CloseButton.MouseLeave:Connect(function()
        self.CloseButton.TextColor3 = Settings.Colors.Text
    end)
    
    self.CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(self.Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        wait(0.3)
        self.ScreenGui:Destroy()
    end)
    
    -- Create body content
    self.Content = Instance.new("Frame")
    self.Content.Name = "Content"
    self.Content.Size = UDim2.new(1, 0, 1, -36)
    self.Content.Position = UDim2.new(0, 0, 0, 36)
    self.Content.BackgroundTransparency = 1
    self.Content.Parent = self.Main
    
    -- Logo/icon
    self.LogoFrame = Instance.new("Frame")
    self.LogoFrame.Name = "LogoFrame"
    self.LogoFrame.Size = UDim2.new(0, 90, 0, 90)
    self.LogoFrame.Position = UDim2.new(0.5, -45, 0, 15)
    self.LogoFrame.BackgroundColor3 = Settings.Colors.Secondary
    self.LogoFrame.BorderSizePixel = 0
    self.LogoFrame.Parent = self.Content
    
    -- Make the logo frame circular
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = self.LogoFrame
    
    -- Logo text
    self.LogoText = Instance.new("TextLabel")
    self.LogoText.Name = "LogoText"
    self.LogoText.Size = UDim2.new(1, 0, 1, 0)
    self.LogoText.BackgroundTransparency = 1
    self.LogoText.Text = "LAJ"
    self.LogoText.TextColor3 = Settings.Colors.Accent
    self.LogoText.TextSize = 42
    self.LogoText.Font = Enum.Font.GothamBlack
    self.LogoText.Parent = self.LogoFrame
    
    -- Create glow effect
    self.GlowEffect = Instance.new("Frame")
    self.GlowEffect.Name = "GlowEffect"
    self.GlowEffect.Size = UDim2.new(0, 100, 0, 100)
    self.GlowEffect.Position = UDim2.new(0.5, -50, 0, 10)
    self.GlowEffect.BackgroundTransparency = 0.5
    self.GlowEffect.BackgroundColor3 = Settings.Colors.Accent
    self.GlowEffect.ZIndex = -1
    self.GlowEffect.Parent = self.LogoFrame
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(1, 0)
    UICorner2.Parent = self.GlowEffect
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.75),
        NumberSequenceKeypoint.new(1, 1)
    })
    UIGradient.Parent = self.GlowEffect
    
    -- Animate glow
    spawn(function()
        local rotation = 0
        while self.ScreenGui and self.ScreenGui.Parent do
            rotation = rotation + 0.5
            if UIGradient then
                UIGradient.Rotation = rotation
            else
                break
            end
            RunService.RenderStepped:Wait()
        end
    end)
    
    -- Create tabs for key options
    self.TabsFrame = Instance.new("Frame")
    self.TabsFrame.Name = "TabsFrame"
    self.TabsFrame.Size = UDim2.new(0, 340, 0, 40)
    self.TabsFrame.Position = UDim2.new(0.5, -170, 0, 115)
    self.TabsFrame.BackgroundTransparency = 1
    self.TabsFrame.Parent = self.Content
    
    -- Tab 1: Enter Key
    self.KeyTab = Instance.new("TextButton")
    self.KeyTab.Name = "KeyTab"
    self.KeyTab.Size = UDim2.new(0.5, -5, 1, 0)
    self.KeyTab.Position = UDim2.new(0, 0, 0, 0)
    self.KeyTab.BackgroundColor3 = Settings.Colors.Secondary
    self.KeyTab.BorderSizePixel = 0
    self.KeyTab.Text = "Enter Key"
    self.KeyTab.TextColor3 = Settings.Colors.Text
    self.KeyTab.TextSize = 14
    self.KeyTab.Font = Enum.Font.GothamBold
    self.KeyTab.Parent = self.TabsFrame
    
    local KeyTabCorner = Instance.new("UICorner")
    KeyTabCorner.CornerRadius = UDim.new(0, 6)
    KeyTabCorner.Parent = self.KeyTab
    
    -- Tab 2: Get Key
    self.GetKeyTab = Instance.new("TextButton")
    self.GetKeyTab.Name = "GetKeyTab"
    self.GetKeyTab.Size = UDim2.new(0.5, -5, 1, 0)
    self.GetKeyTab.Position = UDim2.new(0.5, 5, 0, 0)
    self.GetKeyTab.BackgroundColor3 = Settings.Colors.Secondary
    self.GetKeyTab.BorderSizePixel = 0
    self.GetKeyTab.Text = "Get Key"
    self.GetKeyTab.TextColor3 = Settings.Colors.Text
    self.GetKeyTab.TextSize = 14
    self.GetKeyTab.Font = Enum.Font.Gotham
    self.GetKeyTab.Parent = self.TabsFrame
    
    local GetKeyTabCorner = Instance.new("UICorner")
    GetKeyTabCorner.CornerRadius = UDim.new(0, 6)
    GetKeyTabCorner.Parent = self.GetKeyTab
    
    -- Create content frames for each tab
    self.KeyContent = Instance.new("Frame")
    self.KeyContent.Name = "KeyContent"
    self.KeyContent.Size = UDim2.new(1, -40, 0, 100)
    self.KeyContent.Position = UDim2.new(0, 20, 0, 160)
    self.KeyContent.BackgroundTransparency = 1
    self.KeyContent.Visible = true
    self.KeyContent.Parent = self.Content
    
    self.GetKeyContent = Instance.new("Frame")
    self.GetKeyContent.Name = "GetKeyContent"
    self.GetKeyContent.Size = UDim2.new(1, -40, 0, 100)
    self.GetKeyContent.Position = UDim2.new(0, 20, 0, 160)
    self.GetKeyContent.BackgroundTransparency = 1
    self.GetKeyContent.Visible = false
    self.GetKeyContent.Parent = self.Content
    
    -- Tab switching logic
    self.KeyTab.MouseButton1Click:Connect(function()
        self.KeyTab.Font = Enum.Font.GothamBold
        self.KeyTab.BackgroundColor3 = Settings.Colors.Secondary
        self.GetKeyTab.Font = Enum.Font.Gotham
        self.GetKeyTab.BackgroundColor3 = Color3.fromRGB(37, 39, 44)
        self.KeyContent.Visible = true
        self.GetKeyContent.Visible = false
    end)
    
    self.GetKeyTab.MouseButton1Click:Connect(function()
        self.KeyTab.Font = Enum.Font.Gotham
        self.KeyTab.BackgroundColor3 = Color3.fromRGB(37, 39, 44)
        self.GetKeyTab.Font = Enum.Font.GothamBold
        self.GetKeyTab.BackgroundColor3 = Settings.Colors.Secondary
        self.KeyContent.Visible = false
        self.GetKeyContent.Visible = true
    end)
    
    -- Key input content
    self.KeyLabel = Instance.new("TextLabel")
    self.KeyLabel.Name = "KeyLabel"
    self.KeyLabel.Size = UDim2.new(1, 0, 0, 20)
    self.KeyLabel.Position = UDim2.new(0, 0, 0, 0)
    self.KeyLabel.BackgroundTransparency = 1
    self.KeyLabel.Text = "Enter your key"
    self.KeyLabel.TextColor3 = Settings.Colors.Text
    self.KeyLabel.TextSize = 14
    self.KeyLabel.Font = Enum.Font.Gotham
    self.KeyLabel.Parent = self.KeyContent
    
    self.KeyInput = Instance.new("TextBox")
    self.KeyInput.Name = "KeyInput"
    self.KeyInput.Size = UDim2.new(1, 0, 0, 36)
    self.KeyInput.Position = UDim2.new(0, 0, 0, 25)
    self.KeyInput.BackgroundColor3 = Settings.Colors.Secondary
    self.KeyInput.BorderSizePixel = 0
    self.KeyInput.Text = ""
    self.KeyInput.PlaceholderText = "Paste key here..."
    self.KeyInput.TextColor3 = Settings.Colors.Text
    self.KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    self.KeyInput.TextSize = 14
    self.KeyInput.Font = Enum.Font.Gotham
    self.KeyInput.ClearTextOnFocus = false
    self.KeyInput.Parent = self.KeyContent
    
    -- Rounded corners for the input
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 6)
    InputCorner.Parent = self.KeyInput
    
    -- Submit button
    self.SubmitButton = Instance.new("TextButton")
    self.SubmitButton.Name = "SubmitButton"
    self.SubmitButton.Size = UDim2.new(1, 0, 0, 36)
    self.SubmitButton.Position = UDim2.new(0, 0, 0, 70)
    self.SubmitButton.BackgroundColor3 = Settings.Colors.Accent
    self.SubmitButton.BorderSizePixel = 0
    self.SubmitButton.Text = "Verify Key"
    self.SubmitButton.TextColor3 = Settings.Colors.Text
    self.SubmitButton.TextSize = 14
    self.SubmitButton.Font = Enum.Font.GothamBold
    self.SubmitButton.Parent = self.KeyContent
    
    -- Button corner radius
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = self.SubmitButton
    
    -- Get Key content
    self.GetKeyLabel = Instance.new("TextLabel")
    self.GetKeyLabel.Name = "GetKeyLabel"
    self.GetKeyLabel.Size = UDim2.new(1, 0, 0, 20)
    self.GetKeyLabel.Position = UDim2.new(0, 0, 0, 0)
    self.GetKeyLabel.BackgroundTransparency = 1
    self.GetKeyLabel.Text = "Complete Direct-Link to get a key"
    self.GetKeyLabel.TextColor3 = Settings.Colors.Text
    self.GetKeyLabel.TextSize = 14
    self.GetKeyLabel.Font = Enum.Font.Gotham
    self.GetKeyLabel.Parent = self.GetKeyContent
    
    self.GetKeyInfo = Instance.new("TextLabel")
    self.GetKeyInfo.Name = "GetKeyInfo"
    self.GetKeyInfo.Size = UDim2.new(1, 0, 0, 40)
    self.GetKeyInfo.Position = UDim2.new(0, 0, 0, 20)
    self.GetKeyInfo.BackgroundTransparency = 1
    self.GetKeyInfo.Text = "Click the button below to copy the link to your clipboard, then paste in your browser to complete the steps"
    self.GetKeyInfo.TextColor3 = Settings.Colors.Text
    self.GetKeyInfo.TextSize = 12
    self.GetKeyInfo.TextWrapped = true
    self.GetKeyInfo.Font = Enum.Font.Gotham
    self.GetKeyInfo.Parent = self.GetKeyContent
    
    -- Copy link button
    self.CopyLinkButton = Instance.new("TextButton")
    self.CopyLinkButton.Name = "CopyLinkButton"
    self.CopyLinkButton.Size = UDim2.new(1, 0, 0, 36)
    self.CopyLinkButton.Position = UDim2.new(0, 0, 0, 70)
    self.CopyLinkButton.BackgroundColor3 = Settings.Colors.Accent
    self.CopyLinkButton.BorderSizePixel = 0
    self.CopyLinkButton.Text = "Copy Link to Clipboard"
    self.CopyLinkButton.TextColor3 = Settings.Colors.Text
    self.CopyLinkButton.TextSize = 14
    self.CopyLinkButton.Font = Enum.Font.GothamBold
    self.CopyLinkButton.Parent = self.GetKeyContent
    
    -- Copy button corner radius
    local CopyButtonCorner = Instance.new("UICorner")
    CopyButtonCorner.CornerRadius = UDim.new(0, 6)
    CopyButtonCorner.Parent = self.CopyLinkButton
    
    -- Status message
    self.StatusMessage = Instance.new("TextLabel")
    self.StatusMessage.Name = "StatusMessage"
    self.StatusMessage.Size = UDim2.new(1, -40, 0, 20)
    self.StatusMessage.Position = UDim2.new(0, 20, 0, 255)
    self.StatusMessage.BackgroundTransparency = 1
    self.StatusMessage.Text = ""
    self.StatusMessage.TextColor3 = Settings.Colors.Text
    self.StatusMessage.TextSize = 14
    self.StatusMessage.Font = Enum.Font.Gotham
    self.StatusMessage.Parent = self.Content
    
    -- Add rounded corners to the main frame
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = self.Main
    
    -- Add slight shadow
    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 14, 1, 14)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BorderSizePixel = 0
    Shadow.BackgroundTransparency = 0.5
    Shadow.ZIndex = -1
    Shadow.Parent = self.Main
    
    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 8)
    ShadowCorner.Parent = Shadow
    
    -- Button hover and click effects
    self.SubmitButton.MouseEnter:Connect(function()
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(94, 117, 198)
        }):Play()
    end)
    
    self.SubmitButton.MouseLeave:Connect(function()
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Settings.Colors.Accent
        }):Play()
    end)
    
    self.CopyLinkButton.MouseEnter:Connect(function()
        TweenService:Create(self.CopyLinkButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(94, 117, 198)
        }):Play()
    end)
    
    self.CopyLinkButton.MouseLeave:Connect(function()
        TweenService:Create(self.CopyLinkButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Settings.Colors.Accent
        }):Play()
    end)
    
    -- Intro animation
    self.Main.Size = UDim2.new(0, 0, 0, 0)
    self.Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(self.Main, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 380, 0, 280),
        Position = UDim2.new(0.5, -190, 0.5, -140)
    }):Play()
    
    -- Connect buttons to actions
    self.SubmitButton.MouseButton1Click:Connect(function()
        self:VerifyKeyAction()
    end)
    
    self.CopyLinkButton.MouseButton1Click:Connect(function()
        self:CopyLinkAction()
    end)
    
    -- Connect key input to allow Enter key
    self.KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            self:VerifyKeyAction()
        end
    end)
    
    -- Override the onMessage callback
    onMessage = function(message)
        self:SetStatusMessage(message, Settings.Colors.Error)
    end
    
    return self
end

function KeyUI:MakeDraggable(frame)
    local dragToggle = nil
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateInput(input)
        end
    end)
end

function KeyUI:SetStatusMessage(message, color)
    TweenService:Create(self.StatusMessage, TweenInfo.new(0.3), {
        TextTransparency = 1
    }):Play()
    
    wait(0.3)
    
    self.StatusMessage.Text = message
    self.StatusMessage.TextColor3 = color
    
    TweenService:Create(self.StatusMessage, TweenInfo.new(0.3), {
        TextTransparency = 0
    }):Play()
end

function KeyUI:VerifyKeyAction()
    local key = self.KeyInput.Text
    
    if key == "" then
        self:SetStatusMessage("Please enter a key", Settings.Colors.Error)
        return
    end
    
    -- Animate button
    TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0.98, 0, 0, 36),
        Position = UDim2.new(0.01, 0, 0, 70)
    }):Play()
    
    wait(0.1)
    
    TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 70)
    }):Play()
    
    -- Disable input during verification
    self.SubmitButton.Active = false
    self.KeyInput.Active = false
    self.SubmitButton.Text = "Verifying..."
    
    -- Verify the key using PlatoBoost
    local success = verifyKey(key)
    
    if success then
        self:SetStatusMessage("Key verified successfully!", Settings.Colors.Success)
        self.SubmitButton.Text = "Success!"
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Settings.Colors.Success
        }):Play()
        
        wait(1)
        
        -- Fade out animation
        TweenService:Create(self.Main, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play()
        
        for _, object in pairs(self.Main:GetDescendants()) do
            if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
                TweenService:Create(object, TweenInfo.new(0.5), {
                    TextTransparency = 1
                }):Play()
            elseif object:IsA("Frame") or object:IsA("UIStroke") then
                TweenService:Create(object, TweenInfo.new(0.5), {
                    BackgroundTransparency = 1
                }):Play()
            end
        end
        
        wait(0.5)
        
        -- Load the hub script based on key
        local hubLevel = "Standard"
        
        -- Always load the main script regardless of key level
        -- We're no longer using hubLevel since we're loading directly from GitHub
        LoadScript()
        
        -- Remove the UI
        self.ScreenGui:Destroy()
    else
        self:SetStatusMessage("Invalid key. Please try again or get a new key.", Settings.Colors.Error)
        self.SubmitButton.Text = "Verify Key"
        
        -- Shake animation to indicate failure
        local origPos = self.KeyInput.Position
        for i = 1, 5 do
            self.KeyInput.Position = origPos + UDim2.new(0, (i % 2 == 0) and 5 or -5, 0, 0)
            wait(0.05)
        end
        self.KeyInput.Position = origPos
        
        -- Re-enable input
        self.SubmitButton.Active = true
        self.KeyInput.Active = true
    end
end

function KeyUI:CopyLinkAction()
    -- Animate button
    TweenService:Create(self.CopyLinkButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0.98, 0, 0, 36),
        Position = UDim2.new(0.01, 0, 0, 70)
    }):Play()
    
    wait(0.1)
    
    TweenService:Create(self.CopyLinkButton, TweenInfo.new(0.2), {
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 70)
    }):Play()
    
    -- Try to copy link
    local success = copyLink()
    
    if success then
        self.CopyLinkButton.Text = "Link Copied!"
        self:SetStatusMessage("Link copied to clipboard! Paste in your browser.", Settings.Colors.Success)
        
        -- Reset text after 2 seconds
        spawn(function()
            wait(2)
            self.CopyLinkButton.Text = "Copy Link to Clipboard"
        end)
    else
        self:SetStatusMessage("Failed to copy link. Try again later.", Settings.Colors.Error)
    end
end

-- Main Execution
local function Main()
    -- Create and show the key system UI
    local UI = KeyUI:Create()
end

-- Run the key system
Main()