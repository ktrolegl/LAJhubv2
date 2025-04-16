-- LAJ Infinite Yield - Custom Admin Script
-- Based on popular Infinite Yield commands with LAJ HUB branding and customizations

-- Configuration
local version = "1.0.0"
local prefix = ";"
local lajColor = Color3.fromRGB(85, 170, 255) -- LAJ Blue color
local playerService = game:GetService("Players")
local localPlayer = playerService.LocalPlayer
local runService = game:GetService("RunService")
local teleportService = game:GetService("TeleportService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")

-- Command utility functions
local commands = {}
local aliases = {}
local autoCompleteList = {}

-- UI elements
local lajGui
local commandBar
local commandOutput
local playerList
local toggleButton
local screenGui

-- Main utility functions
local function createNotification(title, text, duration)
    duration = duration or 5
    
    -- Create notification UI
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 250, 0, 80)
    notification.Position = UDim2.new(0.85, 0, 0.8, 0)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.2
    notification.AnchorPoint = Vector2.new(1, 1)
    notification.Parent = screenGui
    
    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notification
    
    -- Create title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 24)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "   " .. title
    titleLabel.TextColor3 = lajColor
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification
    
    -- Create message
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -10, 1, -30)
    messageLabel.Position = UDim2.new(0, 10, 0, 25)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = text
    messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageLabel.TextSize = 14
    messageLabel.Font = Enum.Font.SourceSans
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = notification
    
    -- Add animation
    notification.Position = UDim2.new(1.1, 0, 0.8, 0)
    local tween = game:GetService("TweenService"):Create(
        notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.85, 0, 0.8, 0)}
    )
    tween:Play()
    
    -- Remove after duration
    spawn(function()
        wait(duration)
        local fadeOut = game:GetService("TweenService"):Create(
            notification,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = UDim2.new(1.1, 0, 0.8, 0)}
        )
        fadeOut:Play()
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

local function registerCommand(cmdName, func, description, aliases)
    commands[cmdName:lower()] = {func = func, desc = description or "No description provided"}
    autoCompleteList[#autoCompleteList + 1] = cmdName
    
    if aliases then
        for _, alias in pairs(aliases) do
            aliases[alias:lower()] = cmdName:lower()
            autoCompleteList[#autoCompleteList + 1] = alias
        end
    end
end

local function findPlayer(name)
    name = name:lower()
    
    -- Check for special targets
    if name == "me" then
        return {localPlayer}
    elseif name == "all" then
        return playerService:GetPlayers()
    elseif name == "others" then
        local plrs = {}
        for _, player in pairs(playerService:GetPlayers()) do
            if player ~= localPlayer then
                table.insert(plrs, player)
            end
        end
        return plrs
    end
    
    -- Search by display name or username
    local found = {}
    for _, player in pairs(playerService:GetPlayers()) do
        if player.Name:lower():sub(1, #name) == name or 
           (player.DisplayName and player.DisplayName:lower():sub(1, #name) == name) then
            table.insert(found, player)
        end
    end
    
    return found
end

local function executeCommand(cmdString)
    cmdString = cmdString:gsub("^%s+", ""):gsub("%s+$", "")
    
    if cmdString:sub(1, #prefix) ~= prefix then
        return
    end
    
    local withoutPrefix = cmdString:sub(#prefix + 1)
    local split = {}
    for part in withoutPrefix:gmatch("%S+") do
        table.insert(split, part)
    end
    
    local cmdName = split[1]
    if not cmdName then return end
    
    table.remove(split, 1)
    local args = split
    
    cmdName = cmdName:lower()
    
    -- Check for alias
    if aliases[cmdName] then
        cmdName = aliases[cmdName]
    end
    
    -- Execute the command
    if commands[cmdName] then
        local success, result = pcall(function()
            return commands[cmdName].func(args)
        end)
        
        if not success then
            createNotification("Command Error", "Error executing command: " .. result, 3)
        elseif result then
            createNotification("Command Result", result, 3)
        end
    else
        createNotification("Unknown Command", "Command not found: " .. cmdName, 3)
    end
end

-- Create user interface
local function createUI()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LAJInfiniteYield"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Main frame
    lajGui = Instance.new("Frame")
    lajGui.Name = "LAJAdminFrame"
    lajGui.Size = UDim2.new(0, 600, 0, 350)  -- Increased size for command buttons
    lajGui.Position = UDim2.new(0.5, -300, 0.5, -175)
    lajGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    lajGui.BorderSizePixel = 0
    lajGui.Visible = false
    lajGui.Parent = screenGui
    
    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = lajGui
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = lajColor
    titleBar.BorderSizePixel = 0
    titleBar.Parent = lajGui
    
    -- Make title bar draggable
    local dragging = false
    local dragStart
    local startPos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = lajGui.Position
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            lajGui.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Title bar corners
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 6)
    topCorner.Parent = titleBar
    
    -- Title text
    local titleText = Instance.new("TextLabel")
    titleText.Name = "Title"
    titleText.Size = UDim2.new(1, -10, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "LAJ Infinite Yield v" .. version
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.Font = Enum.Font.SourceSansBold
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 24
    closeButton.Parent = titleBar
    
    closeButton.MouseButton1Click:Connect(function()
        lajGui.Visible = false
    end)
    
    -- Command bar
    commandBar = Instance.new("TextBox")
    commandBar.Name = "CommandBar"
    commandBar.Size = UDim2.new(1, -20, 0, 30)
    commandBar.Position = UDim2.new(0, 10, 1, -40)
    commandBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    commandBar.BorderSizePixel = 0
    commandBar.PlaceholderText = "Enter command (prefix: " .. prefix .. ")"
    commandBar.Text = ""
    commandBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    commandBar.Font = Enum.Font.SourceSans
    commandBar.TextSize = 14
    commandBar.Parent = lajGui
    
    -- Command bar corners
    local cmdBarCorner = Instance.new("UICorner")
    cmdBarCorner.CornerRadius = UDim.new(0, 4)
    cmdBarCorner.Parent = commandBar
    
    -- Command output
    commandOutput = Instance.new("ScrollingFrame")
    commandOutput.Name = "CommandOutput"
    commandOutput.Size = UDim2.new(0.4, -15, 1, -80)
    commandOutput.Position = UDim2.new(0, 10, 0, 40)
    commandOutput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    commandOutput.BorderSizePixel = 0
    commandOutput.ScrollBarThickness = 6
    commandOutput.Parent = lajGui
    
    -- Command output corners
    local outputCorner = Instance.new("UICorner")
    outputCorner.CornerRadius = UDim.new(0, 4)
    outputCorner.Parent = commandOutput
    
    -- Command list (for console output)
    local commandList = Instance.new("Frame")
    commandList.Name = "CommandList"
    commandList.Size = UDim2.new(1, -10, 1, 0)
    commandList.BackgroundTransparency = 1
    commandList.Parent = commandOutput
    
    -- Command buttons container
    local commandButtonsContainer = Instance.new("ScrollingFrame")
    commandButtonsContainer.Name = "CommandButtonsContainer" 
    commandButtonsContainer.Size = UDim2.new(0.3, -10, 1, -80)
    commandButtonsContainer.Position = UDim2.new(0.4, 5, 0, 40)
    commandButtonsContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    commandButtonsContainer.BorderSizePixel = 0
    commandButtonsContainer.ScrollBarThickness = 6
    commandButtonsContainer.CanvasSize = UDim2.new(0, 0, 4, 0)  -- Will be adjusted based on content
    commandButtonsContainer.Parent = lajGui
    
    -- Command buttons container corners
    local cmdButtonsCorner = Instance.new("UICorner")
    cmdButtonsCorner.CornerRadius = UDim.new(0, 4)
    cmdButtonsCorner.Parent = commandButtonsContainer
    
    -- Command buttons title
    local commandButtonsTitle = Instance.new("TextLabel")
    commandButtonsTitle.Name = "Title"
    commandButtonsTitle.Size = UDim2.new(1, 0, 0, 25)
    commandButtonsTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    commandButtonsTitle.BorderSizePixel = 0
    commandButtonsTitle.Text = "Commands"
    commandButtonsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    commandButtonsTitle.Font = Enum.Font.SourceSansBold
    commandButtonsTitle.TextSize = 14
    commandButtonsTitle.Parent = commandButtonsContainer
    
    -- Command buttons title corners
    local cmdTitleCorner = Instance.new("UICorner")
    cmdTitleCorner.CornerRadius = UDim.new(0, 4)
    cmdTitleCorner.Parent = commandButtonsTitle
    
    -- Player list
    playerList = Instance.new("ScrollingFrame")
    playerList.Name = "PlayerList"
    playerList.Size = UDim2.new(0.3, -5, 1, -80)
    playerList.Position = UDim2.new(0.7, 0, 0, 40)
    playerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    playerList.BorderSizePixel = 0
    playerList.ScrollBarThickness = 6
    playerList.Parent = lajGui
    
    -- Player list corners
    local playerListCorner = Instance.new("UICorner")
    playerListCorner.CornerRadius = UDim.new(0, 4)
    playerListCorner.Parent = playerList
    
    -- Player list title
    local playerListTitle = Instance.new("TextLabel")
    playerListTitle.Name = "Title"
    playerListTitle.Size = UDim2.new(1, 0, 0, 25)
    playerListTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    playerListTitle.BorderSizePixel = 0
    playerListTitle.Text = "Players"
    playerListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerListTitle.Font = Enum.Font.SourceSansBold
    playerListTitle.TextSize = 14
    playerListTitle.Parent = playerList
    
    -- Player list title corners
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 4)
    titleCorner.Parent = playerListTitle
    
    -- Player list container
    local playerContainer = Instance.new("Frame")
    playerContainer.Name = "PlayerContainer"
    playerContainer.Size = UDim2.new(1, -10, 1, -35)
    playerContainer.Position = UDim2.new(0, 5, 0, 30)
    playerContainer.BackgroundTransparency = 1
    playerContainer.Parent = playerList
    
    -- Toggle button (minimized view)
    toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 40, 0, 40)
    toggleButton.Position = UDim2.new(0, 10, 0, 10)
    toggleButton.BackgroundColor3 = lajColor
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "LAJ"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.TextSize = 14
    toggleButton.Parent = screenGui
    
    -- Toggle button corners
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleButton
    
    toggleButton.MouseButton1Click:Connect(function()
        lajGui.Visible = not lajGui.Visible
    end)
    
    -- Handle command input
    commandBar.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            executeCommand(commandBar.Text)
            commandBar.Text = ""
        end
    end)
    
    -- Add player elements
    local function updatePlayerList()
        -- Clear existing items
        for _, child in pairs(playerContainer:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        -- Add players
        local players = playerService:GetPlayers()
        for i, player in pairs(players) do
            local playerFrame = Instance.new("Frame")
            playerFrame.Name = player.Name .. "Frame"
            playerFrame.Size = UDim2.new(1, 0, 0, 30)
            playerFrame.Position = UDim2.new(0, 0, 0, (i-1) * 35)
            playerFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            playerFrame.BorderSizePixel = 0
            playerFrame.Parent = playerContainer
            
            -- Player frame corners
            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 4)
            frameCorner.Parent = playerFrame
            
            -- Player name
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, -70, 1, 0)
            nameLabel.Position = UDim2.new(0, 10, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.Font = Enum.Font.SourceSans
            nameLabel.TextSize = 14
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = playerFrame
            
            -- Goto button
            local gotoButton = Instance.new("TextButton")
            gotoButton.Size = UDim2.new(0, 25, 0, 25)
            gotoButton.Position = UDim2.new(1, -60, 0.5, -12.5)
            gotoButton.BackgroundColor3 = Color3.fromRGB(60, 120, 190)
            gotoButton.BorderSizePixel = 0
            gotoButton.Text = "→"
            gotoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            gotoButton.Font = Enum.Font.SourceSansBold
            gotoButton.TextSize = 14
            gotoButton.Parent = playerFrame
            
            -- Goto button corners
            local gotoCorner = Instance.new("UICorner")
            gotoCorner.CornerRadius = UDim.new(0, 4)
            gotoCorner.Parent = gotoButton
            
            gotoButton.MouseButton1Click:Connect(function()
                executeCommand(prefix .. "goto " .. player.Name)
            end)
            
            -- Bring button
            local bringButton = Instance.new("TextButton")
            bringButton.Size = UDim2.new(0, 25, 0, 25)
            bringButton.Position = UDim2.new(1, -30, 0.5, -12.5)
            bringButton.BackgroundColor3 = Color3.fromRGB(190, 60, 60)
            bringButton.BorderSizePixel = 0
            bringButton.Text = "←"
            bringButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            bringButton.Font = Enum.Font.SourceSansBold
            bringButton.TextSize = 14
            bringButton.Parent = playerFrame
            
            -- Bring button corners
            local bringCorner = Instance.new("UICorner")
            bringCorner.CornerRadius = UDim.new(0, 4)
            bringCorner.Parent = bringButton
            
            bringButton.MouseButton1Click:Connect(function()
                executeCommand(prefix .. "bring " .. player.Name)
            end)
            
            -- Highlight if local player
            if player == localPlayer then
                playerFrame.BackgroundColor3 = Color3.fromRGB(60, 100, 150)
            end
        end
        
        playerContainer.Size = UDim2.new(1, -10, 0, #players * 35)
    end
    
    -- Update player list initially and when players join/leave
    updatePlayerList()
    playerService.PlayerAdded:Connect(updatePlayerList)
    playerService.PlayerRemoving:Connect(updatePlayerList)
    
    -- Output function for command responses
    local function addOutput(text, color)
        color = color or Color3.fromRGB(255, 255, 255)
        
        local outputLabel = Instance.new("TextLabel")
        outputLabel.Size = UDim2.new(1, 0, 0, 20)
        outputLabel.BackgroundTransparency = 1
        outputLabel.Text = text
        outputLabel.TextColor3 = color
        outputLabel.Font = Enum.Font.SourceSans
        outputLabel.TextSize = 14
        outputLabel.TextXAlignment = Enum.TextXAlignment.Left
        outputLabel.TextWrapped = true
        
        -- Calculate wrapped text height
        local textSize = game:GetService("TextService"):GetTextSize(
            text, 
            14, 
            Enum.Font.SourceSans, 
            Vector2.new(commandList.AbsoluteSize.X - 10, 9999)
        )
        outputLabel.Size = UDim2.new(1, 0, 0, textSize.Y + 5)
        
        -- Add to command list
        local yPos = 0
        for _, child in pairs(commandList:GetChildren()) do
            yPos = yPos + child.Size.Y.Offset
        end
        
        outputLabel.Position = UDim2.new(0, 5, 0, yPos + 5)
        outputLabel.Parent = commandList
        
        -- Update scrolling frame canvas size
        commandList.Size = UDim2.new(1, -10, 0, yPos + textSize.Y + 15)
        commandOutput.CanvasSize = UDim2.new(0, 0, 0, yPos + textSize.Y + 15)
        commandOutput.CanvasPosition = Vector2.new(0, commandOutput.CanvasSize.Y.Offset)
    end
    
    -- Add command buttons
    local function createCommandButton(text, command, position, color)
        color = color or Color3.fromRGB(60, 120, 190)
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.9, 0, 0, 30)
        button.Position = position
        button.BackgroundColor3 = color
        button.BorderSizePixel = 0
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 14
        button.Parent = commandButtonsContainer
        
        -- Button corners
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 4)
        buttonCorner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if command then
                executeCommand(command)
            else
                commandBar.Text = prefix .. text
                commandBar:CaptureFocus()
            end
        end)
        
        return button
    end
    
    -- Create command button categories and buttons
    local yOffset = 35  -- Start below the title
    
    -- Movement category
    local movementCategory = Instance.new("TextLabel")
    movementCategory.Size = UDim2.new(0.9, 0, 0, 25)
    movementCategory.Position = UDim2.new(0.05, 0, 0, yOffset)
    movementCategory.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    movementCategory.BorderSizePixel = 0
    movementCategory.Text = "   Movement"
    movementCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
    movementCategory.Font = Enum.Font.SourceSansBold
    movementCategory.TextSize = 14
    movementCategory.TextXAlignment = Enum.TextXAlignment.Left
    movementCategory.Parent = commandButtonsContainer
    
    -- Category corners
    local categoryCorner = Instance.new("UICorner")
    categoryCorner.CornerRadius = UDim.new(0, 4)
    categoryCorner.Parent = movementCategory
    
    yOffset = yOffset + 30
    
    -- Movement buttons
    createCommandButton("Speed", nil, UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 120, 190))
    yOffset = yOffset + 35
    createCommandButton("Jump", nil, UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 120, 190))
    yOffset = yOffset + 35
    createCommandButton("Fly", prefix .. "fly", UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 120, 190))
    yOffset = yOffset + 35
    createCommandButton("Noclip", prefix .. "noclip", UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 120, 190))
    yOffset = yOffset + 45
    
    -- Teleport category
    local teleportCategory = Instance.new("TextLabel")
    teleportCategory.Size = UDim2.new(0.9, 0, 0, 25)
    teleportCategory.Position = UDim2.new(0.05, 0, 0, yOffset)
    teleportCategory.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    teleportCategory.BorderSizePixel = 0
    teleportCategory.Text = "   Teleport"
    teleportCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportCategory.Font = Enum.Font.SourceSansBold
    teleportCategory.TextSize = 14
    teleportCategory.TextXAlignment = Enum.TextXAlignment.Left
    teleportCategory.Parent = commandButtonsContainer
    
    -- Category corners
    local tpCategoryCorner = Instance.new("UICorner")
    tpCategoryCorner.CornerRadius = UDim.new(0, 4)
    tpCategoryCorner.Parent = teleportCategory
    
    yOffset = yOffset + 30
    
    -- Teleport buttons
    createCommandButton("Goto", nil, UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(190, 60, 60))
    yOffset = yOffset + 35
    createCommandButton("Bring", nil, UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(190, 60, 60))
    yOffset = yOffset + 35
    createCommandButton("TP", nil, UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(190, 60, 60))
    yOffset = yOffset + 45
    
    -- Utility category
    local utilityCategory = Instance.new("TextLabel")
    utilityCategory.Size = UDim2.new(0.9, 0, 0, 25)
    utilityCategory.Position = UDim2.new(0.05, 0, 0, yOffset)
    utilityCategory.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    utilityCategory.BorderSizePixel = 0
    utilityCategory.Text = "   Utility"
    utilityCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
    utilityCategory.Font = Enum.Font.SourceSansBold
    utilityCategory.TextSize = 14
    utilityCategory.TextXAlignment = Enum.TextXAlignment.Left
    utilityCategory.Parent = commandButtonsContainer
    
    -- Category corners
    local utilityCategoryCorner = Instance.new("UICorner")
    utilityCategoryCorner.CornerRadius = UDim.new(0, 4)
    utilityCategoryCorner.Parent = utilityCategory
    
    yOffset = yOffset + 30
    
    -- Utility buttons
    createCommandButton("Respawn", prefix .. "respawn", UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 190, 60))
    yOffset = yOffset + 35
    createCommandButton("Refresh", prefix .. "refresh", UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 190, 60))
    yOffset = yOffset + 35
    createCommandButton("Position", prefix .. "pos", UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 190, 60))
    yOffset = yOffset + 35
    createCommandButton("Commands", prefix .. "cmds", UDim2.new(0.05, 0, 0, yOffset), Color3.fromRGB(60, 190, 60))
    yOffset = yOffset + 35
    
    -- Update canvas size based on content
    commandButtonsContainer.CanvasSize = UDim2.new(0, 0, 0, yOffset + 20)
    
    addOutput("LAJ Infinite Yield v" .. version .. " loaded!", lajColor)
    addOutput("Type " .. prefix .. "cmds for a list of commands.", Color3.fromRGB(200, 200, 200))
    addOutput("Use command buttons on the right for quick access.", Color3.fromRGB(200, 200, 200))
    
    return {
        addOutput = addOutput
    }
end

-- Initialize UI
local uiController = createUI()

-- Register commands
-- Movement commands
registerCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = speed
        return "Set speed to " .. speed
    else
        return "Character or Humanoid not found"
    end
end, "Changes your walkspeed (;speed [number])")

registerCommand("jump", function(args)
    local height = tonumber(args[1]) or 50
    
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpPower = height
        return "Set jump power to " .. height
    else
        return "Character or Humanoid not found"
    end
end, "Changes your jump power (;jump [number])")

registerCommand("fly", function(args)
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") then
        return "Character or Humanoid not found"
    end
    
    -- Variables
    local flySpeed = 50
    
    -- Check if speed was provided in arguments
    if args[1] and tonumber(args[1]) then
        flySpeed = tonumber(args[1])
        if flySpeed > 500 then flySpeed = 500 end -- Cap the speed for safety
    end
    
    local flying = true
    local keys = {w = false, a = false, s = false, d = false, space = false, q = false, e = false, shift = false}
    
    -- Setup
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart") 
    if not rootPart then return "HumanoidRootPart not found" end
    
    -- Disable jumping and falling
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    
    -- Create body velocity
    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyVel.Parent = rootPart
    
    -- Create body gyro
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.CFrame = rootPart.CFrame
    bodyGyro.Parent = rootPart
    
    -- Connect input handlers
    local connections = {}
    
    table.insert(connections, userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.W then
            keys.w = true
        elseif input.KeyCode == Enum.KeyCode.A then
            keys.a = true
        elseif input.KeyCode == Enum.KeyCode.S then
            keys.s = true
        elseif input.KeyCode == Enum.KeyCode.D then
            keys.d = true
        elseif input.KeyCode == Enum.KeyCode.Space then
            keys.space = true
        elseif input.KeyCode == Enum.KeyCode.Q then
            keys.q = true
        elseif input.KeyCode == Enum.KeyCode.E then
            keys.e = true -- Add barrel roll ability
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            keys.shift = true -- Add speed boost
        elseif input.KeyCode == Enum.KeyCode.F then
            -- Toggle flying on/off
            flying = not flying
            
            if not flying then
                for _, conn in pairs(connections) do
                    conn:Disconnect()
                end
                
                bodyVel:Destroy()
                bodyGyro:Destroy()
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                createNotification("Fly", "Flying disabled", 2)
            end
        elseif input.KeyCode == Enum.KeyCode.R then
            -- Speed adjustment
            flySpeed = flySpeed + 10
            if flySpeed > 500 then flySpeed = 500 end
            createNotification("Fly Speed", "Increased to " .. flySpeed, 1)
        elseif input.KeyCode == Enum.KeyCode.T then
            -- Speed adjustment
            flySpeed = flySpeed - 10
            if flySpeed < 10 then flySpeed = 10 end
            createNotification("Fly Speed", "Decreased to " .. flySpeed, 1)
        end
    end))
    
    table.insert(connections, userInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.W then
            keys.w = false
        elseif input.KeyCode == Enum.KeyCode.A then
            keys.a = false
        elseif input.KeyCode == Enum.KeyCode.S then
            keys.s = false
        elseif input.KeyCode == Enum.KeyCode.D then
            keys.d = false
        elseif input.KeyCode == Enum.KeyCode.Space then
            keys.space = false
        elseif input.KeyCode == Enum.KeyCode.Q then
            keys.q = false
        elseif input.KeyCode == Enum.KeyCode.E then
            keys.e = false
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            keys.shift = false
        end
    end))
    
    -- Variables for barrel roll
    local rolling = false
    local rollAngle = 0
    local rollDirection = 1
    
    -- Flying loop
    table.insert(connections, runService.RenderStepped:Connect(function()
        if not flying then return end
        
        local camera = workspace.CurrentCamera
        local lookVector = camera.CFrame.LookVector
        local rightVector = camera.CFrame.RightVector
        
        -- Update gyro with roll effect if active
        if keys.e and not rolling then
            rolling = true
            rollDirection = keys.a and -1 or 1 -- Roll direction based on A/D key
            spawn(function()
                for i = 1, 36 do -- Complete 360 degree roll in 36 steps
                    rollAngle = i * 10 * rollDirection
                    wait(0.01) -- 0.36 seconds for a full roll
                end
                rolling = false
                rollAngle = 0
            end)
        end
        
        -- Apply barrel roll effect to the gyro orientation
        local rollCFrame = CFrame.new(rootPart.Position, rootPart.Position + lookVector)
        if rolling then
            rollCFrame = rollCFrame * CFrame.Angles(0, 0, math.rad(rollAngle))
        end
        bodyGyro.CFrame = rollCFrame
        
        -- Calculate movement direction
        local moveDirection = Vector3.new(0, 0, 0)
        
        -- Forward/back
        if keys.w then
            moveDirection = moveDirection + lookVector
        end
        if keys.s then
            moveDirection = moveDirection - lookVector
        end
        
        -- Left/right
        if keys.a then
            moveDirection = moveDirection - rightVector
        end
        if keys.d then
            moveDirection = moveDirection + rightVector
        end
        
        -- Up/down
        if keys.space then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if keys.q then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        -- Normalize if needed
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end
        
        -- Apply velocity with boost if shift is pressed
        local currentSpeed = keys.shift and flySpeed * 2 or flySpeed
        bodyVel.Velocity = moveDirection * currentSpeed
    end))
    
    createNotification("Fly", "Enhanced flying enabled. Press F to toggle off/on.", 3)
    return "Enhanced flying enabled. Use WASD+Space+Q to move. Shift for boost, E for barrel roll, R/T to adjust speed. Press F to disable."
end, "Enables enhanced flying (;fly [speed])")

registerCommand("noclip", function()
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    -- Variables
    local noclipping = true
    
    -- Function to update noclip
    local function updateNoclip()
        if noclipping then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
    
    -- Connect to stepped event
    local connection = runService.Stepped:Connect(updateNoclip)
    
    -- Create toggle function
    local function toggleNoclip()
        noclipping = not noclipping
        
        if not noclipping then
            connection:Disconnect()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
            createNotification("Noclip", "Noclip disabled", 2)
        else
            connection = runService.Stepped:Connect(updateNoclip)
            createNotification("Noclip", "Noclip re-enabled", 2)
        end
    end
    
    -- Create keybind for toggle
    local noClipConnection
    noClipConnection = userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.V then
            toggleNoclip()
        end
    end)
    
    -- Handle character respawn
    local charConnection
    charConnection = localPlayer.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        if noclipping then
            connection:Disconnect()
            connection = runService.Stepped:Connect(updateNoclip)
        end
    end)
    
    createNotification("Noclip", "Noclip enabled. Press V to toggle off/on.", 3)
    return "Noclip enabled. Press V to toggle off/on."
end, "Allows walking through walls (;noclip)")

-- Teleport commands
registerCommand("goto", function(args)
    if #args < 1 then
        return "Missing player name. Usage: ;goto [player]"
    end
    
    local targetPlayers = findPlayer(args[1])
    if #targetPlayers == 0 then
        return "Player not found"
    end
    
    local targetPlayer = targetPlayers[1]
    local character = localPlayer.Character
    local targetCharacter = targetPlayer.Character
    
    if not character or not targetCharacter then
        return "Character not found"
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
    
    if not rootPart or not targetRootPart then
        return "HumanoidRootPart not found"
    end
    
    rootPart.CFrame = targetRootPart.CFrame
    return "Teleported to " .. targetPlayer.Name
end, "Teleport to a player (;goto [player])")

registerCommand("bring", function(args)
    if #args < 1 then
        return "Missing player name. Usage: ;bring [player]"
    end
    
    local targetPlayers = findPlayer(args[1])
    if #targetPlayers == 0 then
        return "Player not found"
    end
    
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return "HumanoidRootPart not found"
    end
    
    local broughtPlayers = {}
    for _, targetPlayer in pairs(targetPlayers) do
        if targetPlayer ~= localPlayer then
            local targetCharacter = targetPlayer.Character
            if targetCharacter then
                local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                if targetRootPart then
                    targetRootPart.CFrame = rootPart.CFrame
                    table.insert(broughtPlayers, targetPlayer.Name)
                end
            end
        end
    end
    
    if #broughtPlayers > 0 then
        return "Brought players: " .. table.concat(broughtPlayers, ", ")
    else
        return "No players were brought"
    end
end, "Bring a player to you (;bring [player])")

-- Utility commands
registerCommand("respawn", function()
    local character = localPlayer.Character
    if character then
        character:BreakJoints()
        return "Respawning..."
    else
        return "Character not found"
    end
end, "Respawns your character (;respawn)")

registerCommand("refresh", function()
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    local position = character:FindFirstChild("HumanoidRootPart").Position
    local oldCF = character:FindFirstChild("HumanoidRootPart").CFrame
    character:BreakJoints()
    
    local newCharacter
    local connection = localPlayer.CharacterAdded:Connect(function(char)
        newCharacter = char
    end)
    
    repeat wait() until newCharacter
    connection:Disconnect()
    
    local rootPart = newCharacter:WaitForChild("HumanoidRootPart")
    rootPart.CFrame = oldCF
    
    return "Character refreshed"
end, "Respawns and returns you to the same position (;refresh)")

registerCommand("tp", function(args)
    if #args < 3 then
        return "Missing coordinates. Usage: ;tp [x] [y] [z]"
    end
    
    local x = tonumber(args[1])
    local y = tonumber(args[2])
    local z = tonumber(args[3])
    
    if not x or not y or not z then
        return "Invalid coordinates"
    end
    
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return "HumanoidRootPart not found"
    end
    
    rootPart.CFrame = CFrame.new(x, y, z)
    return "Teleported to coordinates: " .. x .. ", " .. y .. ", " .. z
end, "Teleport to coordinates (;tp [x] [y] [z])")

registerCommand("cmds", function()
    local cmdList = "Available commands:\n"
    
    local sortedCommands = {}
    for cmd, info in pairs(commands) do
        table.insert(sortedCommands, {name = cmd, desc = info.desc})
    end
    
    table.sort(sortedCommands, function(a, b)
        return a.name < b.name
    end)
    
    for _, cmd in ipairs(sortedCommands) do
        cmdList = cmdList .. "\n" .. prefix .. cmd.name .. " - " .. cmd.desc
    end
    
    uiController.addOutput(cmdList, Color3.fromRGB(200, 200, 200))
    return "Command list shown in console"
end, "Shows available commands (;cmds)")

registerCommand("pos", function()
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return "HumanoidRootPart not found"
    end
    
    local position = rootPart.Position
    return "Current position: " .. math.floor(position.X+0.5) .. ", " .. math.floor(position.Y+0.5) .. ", " .. math.floor(position.Z+0.5)
end, "Shows your current position (;pos)")

-- Fun commands
registerCommand("twerk", function(args)
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then
        return "Humanoid or HumanoidRootPart not found"
    end
    
    -- Get duration from args or use default
    local duration = 10
    if args[1] and tonumber(args[1]) then
        duration = math.min(tonumber(args[1]), 30) -- Cap at 30 seconds
    end
    
    -- Variables for twerk animation
    local twerking = true
    local connection
    local startTime = tick()
    local twerkSpeed = 0.15 -- Time between twerk movements
    
    -- Preserve original CFrame and properties
    local originalHeight = humanoid.HipHeight
    local originalCFrame = rootPart.CFrame
    
    -- Twerk animation function
    local function doTwerk()
        if not character or not character:FindFirstChild("HumanoidRootPart") or not twerking then
            return
        end
        
        -- Lower upper body
        humanoid.HipHeight = originalHeight - 0.5
        wait(twerkSpeed)
        
        -- Raise back
        humanoid.HipHeight = originalHeight
        wait(twerkSpeed)
        
        -- Random rotation for extra effect
        rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(math.random(-5, 5)))
        
        -- Check if we should continue
        if tick() - startTime >= duration then
            twerking = false
            humanoid.HipHeight = originalHeight
            connection:Disconnect()
            createNotification("Twerk", "Twerk animation stopped", 2)
        end
    end
    
    -- Start the twerk loop
    connection = runService.Heartbeat:Connect(doTwerk)
    
    -- Add command to stop twerking early
    local function stopTwerking()
        if twerking then
            twerking = false
            humanoid.HipHeight = originalHeight
            if connection then connection:Disconnect() end
            createNotification("Twerk", "Twerk animation stopped", 2)
        end
    end
    
    -- Add keybind to stop twerking
    local stopConnection
    stopConnection = userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.X then
            stopTwerking()
            stopConnection:Disconnect()
        end
    end)
    
    -- Auto-disconnect after duration
    spawn(function()
        wait(duration)
        if stopConnection then stopConnection:Disconnect() end
    end)
    
    createNotification("Twerk", "Twerking for " .. duration .. " seconds. Press X to stop early.", 3)
    return "Started twerking for " .. duration .. " seconds. Press X to stop early."
end, "Makes your character twerk (;twerk [duration])")

registerCommand("bang", function(args)
    local character = localPlayer.Character
    if not character then
        return "Character not found"
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then
        return "Humanoid or HumanoidRootPart not found"
    end
    
    -- Check for target player
    local targetPlayer
    local targetRoot
    
    if args[1] then
        local players = findPlayer(args[1])
        if #players > 0 then
            targetPlayer = players[1]
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                targetRoot = targetPlayer.Character.HumanoidRootPart
            else
                return "Target player has no character or root part"
            end
        else
            return "Target player not found"
        end
    else
        return "Please specify a player to bang. Usage: ;bang [player]"
    end
    
    -- Variables for animation
    local banging = true
    local connection
    local bangTime = tick()
    local duration = 10 -- 10 seconds of banging
    local bangSpeed = 0.25
    
    -- Animation function
    local function doBang()
        if not character or not targetPlayer.Character or not banging then
            banging = false
            return
        end
        
        -- Position behind the target player
        local targetCFrame = targetRoot.CFrame
        local bangCFrame = targetCFrame * CFrame.new(0, 0, 1) -- Position behind
        
        -- Move forward and back rapidly
        rootPart.CFrame = bangCFrame * CFrame.new(0, 0, math.sin(tick() * 10) * 0.5)
        
        -- Check if we should continue
        if tick() - bangTime >= duration then
            banging = false
            connection:Disconnect()
            createNotification("Bang", "Bang animation stopped", 2)
        end
    end
    
    -- Start banging
    connection = runService.RenderStepped:Connect(doBang)
    
    -- Function to stop banging early
    local function stopBanging()
        if banging then
            banging = false
            if connection then connection:Disconnect() end
            createNotification("Bang", "Bang animation stopped", 2)
        end
    end
    
    -- Add keybind to stop banging
    local stopConnection
    stopConnection = userInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.X then
            stopBanging()
            stopConnection:Disconnect()
        end
    end)
    
    -- Auto-disconnect after duration
    spawn(function()
        wait(duration)
        if stopConnection then stopConnection:Disconnect() end
    end)
    
    createNotification("Bang", "Banging " .. targetPlayer.Name .. " for " .. duration .. " seconds. Press X to stop early.", 3)
    return "Started banging " .. targetPlayer.Name .. ". Press X to stop early."
end, "Performs a bang animation on a player (;bang [player])")

-- Execute commands with text box
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Semicolon then
        commandBar:CaptureFocus()
    end
end)

createNotification("LAJ Infinite Yield", "Loaded v" .. version .. "\nPress ; to open command bar", 5)
uiController.addOutput("Press " .. prefix .. " to open command bar", Color3.fromRGB(200, 200, 200))
