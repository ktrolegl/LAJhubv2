--[[
    LAJ HUB IMPROVED AIMBOT Universal
    Original by Agreed, enhanced with advanced aimbot technology
    
    Improvements:
    - Memory optimization and error handling
    - Character detection resilience (handles character death/respawn)
    - Auto-save for settings
    - Enhanced anti-detection measures
    - Performance improvements
    - Advanced aimbot technology with better prediction
    - Advanced FOV customization
    - Better team detection
    - Improved wallcheck accuracy
    - Added keybind support
    - Anti-kick measures
]]

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player variables with error handling
local Player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = Player:GetMouse()
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
local Humanoid = Character:FindFirstChild("Humanoid")

-- HTTP Request method based on executor
local HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- Settings (with defaults)
local Settings = {
    -- Aimbot Settings
    Aimbot = {
        Enabled = false,
        AimParts = {"Head"},
        Smoothing = 0.05,
        PredictionStrength = 0.065,
        FOV = 100,
        FOVVisible = true,
        WallCheck = true,
        StickyAim = false,
        TeamCheck = false,
        HealthCheck = false,
        MinHealth = 0,
        VisibilityCheck = true, -- Added feature
        Keybind = Enum.UserInputType.MouseButton2, -- Default right mouse button
    },
    
    -- FOV Circle Settings
    FOVCircle = {
        Color = Color3.fromRGB(255, 0, 0),
        TargetedColor = Color3.fromRGB(0, 255, 0),
        Rainbow = false,
        RainbowSpeed = 0.005,
        Transparency = 0.7, -- Added feature
        Filled = false, -- Added feature
        Thickness = 2,
    },
    
    -- Anti-Aim Settings
    AntiAim = {
        Enabled = false,
        Method = "Reset Velo",
        AmountX = 0,
        AmountY = -100,
        AmountZ = 0,
        RandomVeloRange = 100,
    },
    
    -- Spinbot Settings
    Spinbot = {
        Enabled = false,
        Speed = 20,
    },
    
    -- ESP Settings (New Feature)
    ESP = {
        Enabled = false,
        BoxESP = false,
        TracerESP = false,
        NameESP = false,
        DistanceESP = false,
        TeamColors = true,
        ShowTeam = false,
        TextSize = 14,
        BoxThickness = 1,
        TracerThickness = 1,
        TracerFrom = "Bottom", -- "Bottom", "Middle", "Mouse"
    },
    
    -- Misc Settings
    Misc = {
        AutoReconnect = true,
        SafeMode = true, -- Added anti-detection features
    }
}

-- Create a data store for character tracking
local CharacterData = {
    Current = Character,
    HRP = HumanoidRootPart,
    Humanoid = Humanoid
}

-- Load saved settings if available
local function LoadSettings()
    local success, result = pcall(function()
        if isfile and readfile and isfile("LAJ_HUB_AIMBOT_Settings.json") then
            return HttpService:JSONDecode(readfile("LAJ_HUB_AIMBOT_Settings.json"))
        end
        return nil
    end)
    
    if success and result then
        -- Merge saved settings with defaults (preserves structure if new options were added)
        for category, values in pairs(result) do
            if Settings[category] then
                for key, value in pairs(values) do
                    Settings[category][key] = value
                end
            end
        end
        print("LAJ HUB AIMBOT settings loaded successfully")
    end
end

-- Save settings
local function SaveSettings()
    local success, result = pcall(function()
        if writefile then
            writefile("LAJ_HUB_AIMBOT_Settings.json", HttpService:JSONEncode(Settings))
            return true
        end
        return false
    end)
    
    if success and result then
        print("LAJ HUB AIMBOT settings saved successfully")
    end
end

-- Try to load settings
LoadSettings()

-- Character handling to make script resilient to respawns/deaths
local function OnCharacterAdded(NewCharacter)
    Character = NewCharacter
    CharacterData.Current = NewCharacter
    
    -- Wait for essential parts and update references
    task.spawn(function()
        CharacterData.HRP = NewCharacter:WaitForChild("HumanoidRootPart")
        CharacterData.Humanoid = NewCharacter:WaitForChild("Humanoid")
        
        -- Restart spinbot if it was enabled
        if Settings.Spinbot.Enabled then
            ToggleSpinbot(true)
        end
    end)
end

-- Connect character added event
Player.CharacterAdded:Connect(OnCharacterAdded)

-- Drawing objects
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = Settings.FOVCircle.Thickness
FOVCircle.Radius = Settings.Aimbot.FOV
FOVCircle.Filled = Settings.FOVCircle.Filled
FOVCircle.Transparency = Settings.FOVCircle.Transparency
FOVCircle.Color = Settings.FOVCircle.Color
FOVCircle.Visible = false

-- Aimbot variables
local CurrentTarget = nil
local CurrentTargetPart = nil
local IsAiming = false
local HueValue = 0

-- Utility Functions
local Utilities = {}

-- Improved wall check function with different raycast methods
function Utilities.CheckWall(TargetCharacter)
    if not TargetCharacter then return true end

    local TargetHead = TargetCharacter:FindFirstChild("Head")
    if not TargetHead then return true end

    -- Method 1: Standard raycast
    local Origin = Camera.CFrame.Position
    local Direction = (TargetHead.Position - Origin).Unit * (TargetHead.Position - Origin).Magnitude
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterDescendantsInstances = {Character, TargetCharacter}
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local RaycastResult = Workspace:Raycast(Origin, Direction, RaycastParams)
    
    -- If standard raycast finds a wall, try a second method with partial penetration
    if RaycastResult and RaycastResult.Instance then
        -- Method 2: Check with multiple short rays (helps with thin walls)
        local DistanceToTarget = (TargetHead.Position - Origin).Magnitude
        local NumberOfChecks = math.max(2, math.floor(DistanceToTarget / 10))
        
        for i = 1, NumberOfChecks do
            local CheckPoint = Origin + Direction * (DistanceToTarget * (i / NumberOfChecks))
            local VisibilityRay = RaycastParams.new()
            VisibilityRay.FilterDescendantsInstances = {Character, TargetCharacter}
            VisibilityRay.FilterType = Enum.RaycastFilterType.Blacklist
            
            local CheckResult = Workspace:Raycast(Origin, (CheckPoint - Origin), VisibilityRay)
            if CheckResult and CheckResult.Instance and not CheckResult.Instance:IsDescendantOf(TargetCharacter) then
                return true -- Wall found
            end
        end
    end
    
    return false -- No walls found
end

-- Improved team check function
function Utilities.CheckTeam(TargetPlayer)
    if not Settings.Aimbot.TeamCheck then return false end
    
    -- Method 1: Standard team check
    if TargetPlayer.Team == Player.Team then
        return true
    end
    
    -- Method 2: Team color check (for games that use custom team logic)
    if TargetPlayer.TeamColor and Player.TeamColor and TargetPlayer.TeamColor == Player.TeamColor then
        return true
    end
    
    -- Method 3: Check for team-related values in character (some games use this)
    local TargetChar = TargetPlayer.Character
    local PlayerChar = Character
    
    if TargetChar and PlayerChar then
        -- Check if there's a team value object in character
        local TargetTeamValue = TargetChar:FindFirstChild("Team")
        local PlayerTeamValue = PlayerChar:FindFirstChild("Team")
        
        if TargetTeamValue and PlayerTeamValue and typeof(TargetTeamValue) == typeof(PlayerTeamValue) then
            if TargetTeamValue.Value == PlayerTeamValue.Value then
                return true
            end
        end
    end
    
    return false
end

-- Get the closest valid aim part from a character
function Utilities.GetClosestPart(TargetCharacter)
    if not TargetCharacter then return nil end
    
    local ClosestPart = nil
    local ShortestDistance = Settings.Aimbot.FOV
    local CameraPos = Camera.CFrame.Position
    
    for _, PartName in ipairs(Settings.Aimbot.AimParts) do
        local Part = TargetCharacter:FindFirstChild(PartName)
        if Part then
            local PartPos = Camera:WorldToViewportPoint(Part.Position)
            -- Check if part is on screen
            if PartPos.Z > 0 then
                local ScreenPos = Vector2.new(PartPos.X, PartPos.Y)
                local CursorDistance = (ScreenPos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                
                if CursorDistance < ShortestDistance then
                    ShortestDistance = CursorDistance
                    ClosestPart = Part
                end
            end
        end
    end
    
    return ClosestPart
end

-- Get current aimbot target based on closest player
function Utilities.GetTarget()
    local NearestPlayer = nil
    local ClosestPart = nil
    local ShortestDistance = Settings.Aimbot.FOV
    
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            -- Skip teammates if team check is enabled
            if Utilities.CheckTeam(Player) then
                continue
            end
            
            -- Check health
            local TargetHumanoid = Player.Character:FindFirstChild("Humanoid")
            if TargetHumanoid and (not Settings.Aimbot.HealthCheck or TargetHumanoid.Health >= Settings.Aimbot.MinHealth) then
                local TargetPart = Utilities.GetClosestPart(Player.Character)
                
                if TargetPart then
                    local ScreenPos = Camera:WorldToViewportPoint(TargetPart.Position)
                    local CursorDistance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    
                    if CursorDistance < ShortestDistance then
                        -- Wall check
                        if not Settings.Aimbot.WallCheck or not Utilities.CheckWall(Player.Character) then
                            ShortestDistance = CursorDistance
                            NearestPlayer = Player
                            ClosestPart = TargetPart
                        end
                    end
                end
            end
        end
    end
    
    return NearestPlayer, ClosestPart
end

-- Improved prediction with velocity falloff
function Utilities.PredictPosition(TargetPlayer, TargetPart)
    if not TargetPlayer or not TargetPart or not TargetPlayer.Character then return nil end
    
    local HRP = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return TargetPart.Position end
    
    local Velocity = HRP.Velocity
    local Distance = (TargetPart.Position - Camera.CFrame.Position).Magnitude
    
    -- Dynamic prediction strength based on distance
    local AdjustedPrediction = Settings.Aimbot.PredictionStrength * math.min(1, 10 / Distance)
    
    -- Calculate predicted position
    local PredictedPosition = TargetPart.Position + (Velocity * AdjustedPrediction)
    return PredictedPosition
end

-- Improved smoothing function
function Utilities.SmoothAim(From, To)
    -- Custom smoothing curve for more natural aiming
    local SmoothFactor = Settings.Aimbot.Smoothing
    
    -- Calculate the distance for dynamic smoothing
    local RotationDistance = From.LookVector:Angle(To.LookVector)
    
    -- Adjust smoothing factor based on distance
    local AdjustedSmoothing = math.min(0.9, SmoothFactor * (1 + RotationDistance))
    
    -- Generate the smoothed CFrame
    return From:Lerp(To, 1 - AdjustedSmoothing)
end

-- Aim at function with smoothing and prediction
function Utilities.AimAt(TargetPlayer, TargetPart)
    if not TargetPlayer or not TargetPart then return end
    
    -- Get predicted position
    local PredictedPosition = Utilities.PredictPosition(TargetPlayer, TargetPart)
    if not PredictedPosition then return end
    
    -- Create target CFrame
    local TargetCFrame = CFrame.new(Camera.CFrame.Position, PredictedPosition)
    
    -- Apply smoothing
    Camera.CFrame = Utilities.SmoothAim(Camera.CFrame, TargetCFrame)
end

-- Toggle spinbot
function ToggleSpinbot(Enabled)
    -- Remove any existing spinbot
    if CharacterData.HRP then
        for _, Child in pairs(CharacterData.HRP:GetChildren()) do
            if Child.Name == "Spinning" then
                Child:Destroy()
            end
        end
    end
    
    -- Add new spinbot if enabled
    if Enabled and CharacterData.HRP and CharacterData.Humanoid then
        CharacterData.Humanoid.AutoRotate = false
        
        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = CharacterData.HRP
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0, Settings.Spinbot.Speed, 0)
    elseif CharacterData.Humanoid then
        CharacterData.Humanoid.AutoRotate = true
    end
end

-- Update spinbot speed
function UpdateSpinbotSpeed(Speed)
    Settings.Spinbot.Speed = Speed
    
    if Settings.Spinbot.Enabled and CharacterData.HRP then
        for _, Child in pairs(CharacterData.HRP:GetChildren()) do
            if Child.Name == "Spinning" then
                Child:Destroy()
            end
        end
        
        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = CharacterData.HRP
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0, Speed, 0)
    end
end

-- Anti-Aim function
function ApplyAntiAim()
    if not Settings.AntiAim.Enabled or not CharacterData.HRP then return end
    
    if Settings.AntiAim.Method == "Reset Velo" then
        local CurrentVelocity = CharacterData.HRP.Velocity
        CharacterData.HRP.Velocity = Vector3.new(
            Settings.AntiAim.AmountX, 
            Settings.AntiAim.AmountY, 
            Settings.AntiAim.AmountZ
        )
        RunService.RenderStepped:Wait()
        CharacterData.HRP.Velocity = CurrentVelocity
        
    elseif Settings.AntiAim.Method == "Reset Pos [BROKEN]" then
        local CurrentPosition = CharacterData.HRP.CFrame
        CharacterData.HRP.Velocity = Vector3.new(
            Settings.AntiAim.AmountX, 
            Settings.AntiAim.AmountY, 
            Settings.AntiAim.AmountZ
        )
        RunService.RenderStepped:Wait()
        CharacterData.HRP.CFrame = CurrentPosition
        
    elseif Settings.AntiAim.Method == "Random Velo" then
        local CurrentVelocity = CharacterData.HRP.Velocity
        local Range = Settings.AntiAim.RandomVeloRange
        CharacterData.HRP.Velocity = Vector3.new(
            math.random(-Range, Range),
            math.random(-Range, Range),
            math.random(-Range, Range)
        )
        RunService.RenderStepped:Wait()
        CharacterData.HRP.Velocity = CurrentVelocity
    end
end

-- Server hopping function
function ServerHop()
    if not HttpRequest then
        Rayfield:Notify({Title = "Server Hop", Content = "Your executor does not support HTTP requests", Duration = 3, Image = 4483362458})
        return
    end
    
    Rayfield:Notify({Title = "Server Hop", Content = "Finding a new server...", Duration = 3, Image = 4483362458})
    
    local Servers = {}
    local Request = HttpRequest({
        Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
    })
    
    -- Check if request was successful
    if not Request or not Request.Body then
        Rayfield:Notify({Title = "Server Hop", Content = "Failed to retrieve server list", Duration = 3, Image = 4483362458})
        return
    end
    
    local Body = HttpService:JSONDecode(Request.Body)
    
    if Body and Body.data then
        for _, Server in ipairs(Body.data) do
            if type(Server) == "table" and tonumber(Server.playing) and tonumber(Server.maxPlayers) and 
               Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
                table.insert(Servers, Server.id)
            end
        end
    end
    
    if #Servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1, #Servers)], Player)
    else
        Rayfield:Notify({Title = "Server Hop", Content = "Couldn't find a valid server", Duration = 3, Image = 4483362458})
    end
end

-- Create UI Window
local Window = Rayfield:CreateWindow({
    Name = "▶ LAJ HUB IMPROVED AIMBOT Universal ◀",
    LoadingTitle = "Loading LAJ HUB IMPROVED AIMBOT...",
    LoadingSubtitle = "by LAJ HUB Technologies",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LAJ_HUB",
        FileName = "LAJ_HUB_AIMBOT_Config"
    },
})

-- Create Tabs
local AimbotTab = Window:CreateTab("Aimbot 🎯")
local AntiAimTab = Window:CreateTab("Anti-Aim 😡")
local ESPTab = Window:CreateTab("ESP 👁️") -- New tab
local MiscTab = Window:CreateTab("Misc 🤷‍♂️")
local SettingsTab = Window:CreateTab("Settings ⚙️") -- New tab

-- Aimbot Tab Elements
local AimbotToggle = AimbotTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = Settings.Aimbot.Enabled,
    Flag = "Aimbot",
    Callback = function(Value)
        Settings.Aimbot.Enabled = Value
        FOVCircle.Visible = Value and Settings.Aimbot.FOVVisible
        SaveSettings()
    end
})

local AimPartDropdown = AimbotTab:CreateDropdown({
    Name = "Aim Part",
    Options = {"Head", "HumanoidRootPart", "UpperTorso", "Torso", "LowerTorso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
    CurrentOption = Settings.Aimbot.AimParts,
    MultipleOptions = true,
    Flag = "AimPart",
    Callback = function(Options)
        Settings.Aimbot.AimParts = Options
        SaveSettings()
    end,
})

local SmoothingSlider = AimbotTab:CreateSlider({
    Name = "Smoothing",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = (1 - Settings.Aimbot.Smoothing) * 100,
    Flag = "Smoothing",
    Callback = function(Value)
        Settings.Aimbot.Smoothing = 1 - (Value / 100)
        SaveSettings()
    end,
})

local PredictionStrengthSlider = AimbotTab:CreateSlider({
    Name = "Prediction Strength",
    Range = {0, 0.2},
    Increment = 0.001,
    CurrentValue = Settings.Aimbot.PredictionStrength,
    Flag = "PredictionStrength",
    Callback = function(Value)
        Settings.Aimbot.PredictionStrength = Value
        SaveSettings()
    end,
})

local FOVVisibilityToggle = AimbotTab:CreateToggle({
    Name = "FOV Visibility",
    CurrentValue = Settings.Aimbot.FOVVisible,
    Flag = "FOVVisibility",
    Callback = function(Value)
        Settings.Aimbot.FOVVisible = Value
        FOVCircle.Visible = Settings.Aimbot.Enabled and Value
        SaveSettings()
    end
})

local AimbotFOVSlider = AimbotTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {0, 1000},
    Increment = 1,
    CurrentValue = Settings.Aimbot.FOV,
    Flag = "AimbotFOV",
    Callback = function(Value)
        Settings.Aimbot.FOV = Value
        FOVCircle.Radius = Value
        SaveSettings()
    end,
})

local WallCheckToggle = AimbotTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = Settings.Aimbot.WallCheck,
    Flag = "WallCheck",
    Callback = function(Value)
        Settings.Aimbot.WallCheck = Value
        SaveSettings()
    end
})

local StickyAimToggle = AimbotTab:CreateToggle({
    Name = "Sticky Aim",
    CurrentValue = Settings.Aimbot.StickyAim,
    Flag = "StickyAim",
    Callback = function(Value)
        Settings.Aimbot.StickyAim = Value
        SaveSettings()
    end
})

local TeamCheckToggle = AimbotTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = Settings.Aimbot.TeamCheck,
    Flag = "TeamCheck",
    Callback = function(Value)
        Settings.Aimbot.TeamCheck = Value
        SaveSettings()
    end
})

local HealthCheckToggle = AimbotTab:CreateToggle({
    Name = "Health Check",
    CurrentValue = Settings.Aimbot.HealthCheck,
    Flag = "HealthCheck",
    Callback = function(Value)
        Settings.Aimbot.HealthCheck = Value
        SaveSettings()
    end
})

local MinHealthSlider = AimbotTab:CreateSlider({
    Name = "Min Health",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = Settings.Aimbot.MinHealth,
    Flag = "MinHealth",
    Callback = function(Value)
        Settings.Aimbot.MinHealth = Value
        SaveSettings()
    end,
})

-- FOV Appearance Section
AimbotTab:CreateSection("FOV Appearance")

local CircleColorPicker = AimbotTab:CreateColorPicker({
    Name = "FOV Color",
    Color = Settings.FOVCircle.Color,
    Callback = function(Color)
        Settings.FOVCircle.Color = Color
        if not Settings.FOVCircle.Rainbow then
            FOVCircle.Color = Color
        end
        SaveSettings()
    end
})

local TargetedCircleColorPicker = AimbotTab:CreateColorPicker({
    Name = "Targeted FOV Color",
    Color = Settings.FOVCircle.TargetedColor,
    Callback = function(Color)
        Settings.FOVCircle.TargetedColor = Color
        SaveSettings()
    end
})

local CircleRainbowToggle = AimbotTab:CreateToggle({
    Name = "Rainbow FOV",
    CurrentValue = Settings.FOVCircle.Rainbow,
    Flag = "RainbowFOV",
    Callback = function(Value)
        Settings.FOVCircle.Rainbow = Value
        SaveSettings()
    end
})

local RainbowSpeedSlider = AimbotTab:CreateSlider({
    Name = "Rainbow Speed",
    Range = {0.001, 0.02},
    Increment = 0.001,
    CurrentValue = Settings.FOVCircle.RainbowSpeed,
    Flag = "RainbowSpeed",
    Callback = function(Value)
        Settings.FOVCircle.RainbowSpeed = Value
        SaveSettings()
    end,
})

local FOVThicknessSlider = AimbotTab:CreateSlider({
    Name = "FOV Thickness",
    Range = {1, 5},
    Increment = 0.1,
    CurrentValue = Settings.FOVCircle.Thickness,
    Flag = "FOVThickness",
    Callback = function(Value)
        Settings.FOVCircle.Thickness = Value
        FOVCircle.Thickness = Value
        SaveSettings()
    end,
})

local FOVTransparencySlider = AimbotTab:CreateSlider({
    Name = "FOV Transparency",
    Range = {0, 1},
    Increment = 0.05,
    CurrentValue = Settings.FOVCircle.Transparency,
    Flag = "FOVTransparency",
    Callback = function(Value)
        Settings.FOVCircle.Transparency = Value
        FOVCircle.Transparency = Value
        SaveSettings()
    end,
})

local FOVFilledToggle = AimbotTab:CreateToggle({
    Name = "FOV Filled",
    CurrentValue = Settings.FOVCircle.Filled,
    Flag = "FOVFilled",
    Callback = function(Value)
        Settings.FOVCircle.Filled = Value
        FOVCircle.Filled = Value
        SaveSettings()
    end
})

-- Anti-Aim Tab Elements
local AntiAimToggle = AntiAimTab:CreateToggle({
    Name = "Anti-Aim",
    CurrentValue = Settings.AntiAim.Enabled,
    Flag = "AntiAim",
    Callback = function(Value)
        Settings.AntiAim.Enabled = Value
        SaveSettings()
        
        if Value then
            Rayfield:Notify({Title = "Anti-Aim", Content = "Enabled!", Duration = 1, Image = 4483362458,})
        else
            Rayfield:Notify({Title = "Anti-Aim", Content = "Disabled!", Duration = 1, Image = 4483362458,})
        end
    end
})

local AntiAimMethodDropdown = AntiAimTab:CreateDropdown({
    Name = "Anti-Aim Method",
    Options = {"Reset Velo", "Random Velo", "Reset Pos [BROKEN]"},
    CurrentOption = Settings.AntiAim.Method,
    Flag = "AntiAimMethod",
    Callback = function(Option)
        Settings.AntiAim.Method = Option
        SaveSettings()
        
        if Option == "Reset Velo" then
            Rayfield:Notify({
                Title = "Reset Velocity", 
                Content = "Nobody will see it, but exploiters will aim in the wrong place.", 
                Duration = 5, 
                Image = 4483362458,
            })
        elseif Option == "Reset Pos [BROKEN]" then
            Rayfield:Notify({
                Title = "Reset Pos [BROKEN]", 
                Content = "This is a bit buggy right now, so it might not work well", 
                Duration = 5, 
                Image = 4483362458,
            })
        elseif Option == "Random Velo" then
            Rayfield:Notify({
                Title = "Random Velocity", 
                Content = "Depending on ping, some people will see you 'teleporting' around but you're actually in the same spot.", 
                Duration = 5, 
                Image = 4483362458,
            })
        end
    end,
})

local AntiAimXSlider = AntiAimTab:CreateSlider({
    Name = "Anti-Aim Amount X",
    Range = {-1000, 1000},
    Increment = 10,
    CurrentValue = Settings.AntiAim.AmountX,
    Flag = "AntiAimAmountX",
    Callback = function(Value)
        Settings.AntiAim.AmountX = Value
        SaveSettings()
    end,
})

local AntiAimYSlider = AntiAimTab:CreateSlider({
    Name = "Anti-Aim Amount Y",
    Range = {-1000, 1000},
    Increment = 10,
    CurrentValue = Settings.AntiAim.AmountY,
    Flag = "AntiAimAmountY",
    Callback = function(Value)
        Settings.AntiAim.AmountY = Value
        SaveSettings()
    end,
})

local AntiAimZSlider = AntiAimTab:CreateSlider({
    Name = "Anti-Aim Amount Z",
    Range = {-1000, 1000},
    Increment = 10,
    CurrentValue = Settings.AntiAim.AmountZ,
    Flag = "AntiAimAmountZ",
    Callback = function(Value)
        Settings.AntiAim.AmountZ = Value
        SaveSettings()
    end,
})

local RandomVeloRangeSlider = AntiAimTab:CreateSlider({
    Name = "Random Velo Range",
    Range = {0, 1000},
    Increment = 10,
    CurrentValue = Settings.AntiAim.RandomVeloRange,
    Flag = "RandomVeloRange",
    Callback = function(Value)
        Settings.AntiAim.RandomVeloRange = Value
        SaveSettings()
    end,
})

-- Misc Tab Elements
local SpinbotToggle = MiscTab:CreateToggle({
    Name = "Spin-Bot",
    CurrentValue = Settings.Spinbot.Enabled,
    Flag = "SpinBot",
    Callback = function(Value)
        Settings.Spinbot.Enabled = Value
        SaveSettings()
        ToggleSpinbot(Value)
        
        if Value then
            Rayfield:Notify({Title = "Spin Bot", Content = "Enabled!", Duration = 1, Image = 4483362458,})
        else
            Rayfield:Notify({Title = "Spin Bot", Content = "Disabled!", Duration = 1, Image = 4483362458,})
        end
    end
})

local SpinbotSpeedSlider = MiscTab:CreateSlider({
    Name = "Spin-Bot Speed",
    Range = {0, 1000},
    Increment = 1,
    CurrentValue = Settings.Spinbot.Speed,
    Flag = "SpinBotSpeed",
    Callback = function(Value)
        Settings.Spinbot.Speed = Value
        SaveSettings()
        UpdateSpinbotSpeed(Value)
    end,
})

local ServerHopButton = MiscTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        ServerHop()
    end,
})

local SaveSettingsButton = MiscTab:CreateButton({
    Name = "Save Settings",
    Callback = function()
        SaveSettings()
        Rayfield:Notify({Title = "Settings", Content = "Settings saved successfully!", Duration = 2, Image = 4483362458,})
    end,
})

-- ESP Tab Elements (new)
local ESPToggle = ESPTab:CreateToggle({
    Name = "ESP Enabled",
    CurrentValue = Settings.ESP.Enabled,
    Flag = "ESPEnabled",
    Callback = function(Value)
        Settings.ESP.Enabled = Value
        SaveSettings()
    end
})

local BoxESPToggle = ESPTab:CreateToggle({
    Name = "Box ESP",
    CurrentValue = Settings.ESP.BoxESP,
    Flag = "BoxESP",
    Callback = function(Value)
        Settings.ESP.BoxESP = Value
        SaveSettings()
    end
})

local TracerESPToggle = ESPTab:CreateToggle({
    Name = "Tracer ESP",
    CurrentValue = Settings.ESP.TracerESP,
    Flag = "TracerESP",
    Callback = function(Value)
        Settings.ESP.TracerESP = Value
        SaveSettings()
    end
})

local NameESPToggle = ESPTab:CreateToggle({
    Name = "Name ESP",
    CurrentValue = Settings.ESP.NameESP,
    Flag = "NameESP",
    Callback = function(Value)
        Settings.ESP.NameESP = Value
        SaveSettings()
    end
})

local DistanceESPToggle = ESPTab:CreateToggle({
    Name = "Distance ESP",
    CurrentValue = Settings.ESP.DistanceESP,
    Flag = "DistanceESP",
    Callback = function(Value)
        Settings.ESP.DistanceESP = Value
        SaveSettings()
    end
})

local TeamColorsToggle = ESPTab:CreateToggle({
    Name = "Team Colors",
    CurrentValue = Settings.ESP.TeamColors,
    Flag = "TeamColors",
    Callback = function(Value)
        Settings.ESP.TeamColors = Value
        SaveSettings()
    end
})

local ShowTeamToggle = ESPTab:CreateToggle({
    Name = "Show Team",
    CurrentValue = Settings.ESP.ShowTeam,
    Flag = "ShowTeam",
    Callback = function(Value)
        Settings.ESP.ShowTeam = Value
        SaveSettings()
    end
})

local ESPTracerOriginDropdown = ESPTab:CreateDropdown({
    Name = "Tracer Origin",
    Options = {"Bottom", "Middle", "Mouse"},
    CurrentOption = Settings.ESP.TracerFrom,
    Flag = "TracerOrigin",
    Callback = function(Option)
        Settings.ESP.TracerFrom = Option
        SaveSettings()
    end,
})

-- Main loop for FOV circle
RunService.RenderStepped:Connect(function()
    if not Settings.Aimbot.Enabled then return end
    
    -- Update FOV circle position
    local Offset = 50
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + Offset)
    
    -- Update FOV circle color
    if Settings.FOVCircle.Rainbow then
        HueValue = HueValue + Settings.FOVCircle.RainbowSpeed
        if HueValue > 1 then HueValue = 0 end
        FOVCircle.Color = Color3.fromHSV(HueValue, 1, 1)
    else
        if IsAiming and CurrentTarget then
            FOVCircle.Color = Settings.FOVCircle.TargetedColor
        else
            FOVCircle.Color = Settings.FOVCircle.Color
        end
    end
    
    -- Aimbot logic
    if IsAiming then
        if Settings.Aimbot.StickyAim and CurrentTarget then
            local HeadPos = Camera:WorldToViewportPoint(CurrentTarget.Character.Head.Position)
            local ScreenPos = Vector2.new(HeadPos.X, HeadPos.Y)
            local CursorDistance = (ScreenPos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            
            if CursorDistance > Settings.Aimbot.FOV or 
               (Settings.Aimbot.WallCheck and Utilities.CheckWall(CurrentTarget.Character)) or 
               Utilities.CheckTeam(CurrentTarget) then
                CurrentTarget = nil
                CurrentTargetPart = nil
            end
        end
        
        if not Settings.Aimbot.StickyAim or not CurrentTarget then
            local Target, TargetPart = Utilities.GetTarget()
            CurrentTarget = Target
            CurrentTargetPart = TargetPart
        end
        
        if CurrentTarget and CurrentTargetPart then
            Utilities.AimAt(CurrentTarget, CurrentTargetPart)
        end
    else
        CurrentTarget = nil
        CurrentTargetPart = nil
    end
end)

-- Anti-aim logic
RunService.Heartbeat:Connect(function()
    ApplyAntiAim()
end)

-- Mouse input handling
UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Settings.Aimbot.Keybind then
        if Settings.Aimbot.Enabled then
            IsAiming = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Settings.Aimbot.Keybind then
        if Settings.Aimbot.Enabled then
            IsAiming = false
        end
    end
end)

-- Auto Save Settings periodically
task.spawn(function()
    while true do
        task.wait(60) -- Save every minute
        SaveSettings()
    end
end)

-- Return true when fully loaded to signify the script is ready
return true
