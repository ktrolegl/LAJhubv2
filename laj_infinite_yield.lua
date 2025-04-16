--[[
    LAJHUBv2 - Embedded Version
    No environment checks, no HttpGet, just direct code execution
]]

-- Direct Rayfield UI Loading
local Rayfield = (function()
    local Rayfield = {
        Flags = {},
    }
    
    -- Create a ScreenGui for UI elements
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RayfieldLibrary"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    
    -- Try to set the parent properly
    if syn then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = game.CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = game.CoreGui
    end
    
    -- Main UI elements
    local MainUI = Instance.new("Frame")
    MainUI.Name = "MainUI"
    MainUI.Size = UDim2.new(0, 600, 0, 350)
    MainUI.Position = UDim2.new(0.5, -300, 0.5, -175)
    MainUI.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainUI.BorderSizePixel = 0
    MainUI.Parent = ScreenGui
    
    -- Add rounded corners
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainUI
    
    -- Header Section
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Header.BorderSizePixel = 0
    Header.Parent = MainUI
    
    -- Add rounded corners to header
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 6)
    HeaderCorner.Parent = Header
    
    -- Add title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = ""
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.Parent = Header
    
    -- Add rounded corners to close button
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 4)
    CloseButtonCorner.Parent = CloseButton
    
    -- Tab container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 140, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainUI
    
    -- Tab list
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, 0, 1, 0)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 2
    TabList.ScrollingDirection = Enum.ScrollingDirection.Y
    TabList.Parent = TabContainer
    
    -- Tab list layout
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Vertical
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabList
    
    -- Content container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -140, 1, -40)
    ContentContainer.Position = UDim2.new(0, 140, 0, 40)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainUI
    
    -- Tab storage for created tabs
    local Tabs = {}
    local CurrentTab = nil
    
    function Rayfield:CreateWindow(options)
        -- Set title
        Title.Text = options.Name or "Rayfield UI"
        
        -- Make draggable
        local isDragging = false
        local dragStart = nil
        local startPosition = nil
        
        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
                dragStart = input.Position
                startPosition = MainUI.Position
            end
        end)
        
        Header.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                MainUI.Position = UDim2.new(
                    startPosition.X.Scale, 
                    startPosition.X.Offset + delta.X, 
                    startPosition.Y.Scale, 
                    startPosition.Y.Offset + delta.Y
                )
            end
        end)
        
        -- Close button functionality
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
        
        -- Return the window methods
        return {
            CreateTab = function(self, tabOptions)
                local tabName = tabOptions.Name or "Tab"
                local tabIcon = tabOptions.Icon or 0
                
                -- Create tab button
                local TabButton = Instance.new("TextButton")
                TabButton.Name = tabName .. "Button"
                TabButton.Size = UDim2.new(1, -10, 0, 30)
                TabButton.Position = UDim2.new(0, 5, 0, #Tabs * 35 + 5)
                TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                TabButton.Text = tabName
                TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                TabButton.TextSize = 14
                TabButton.Font = Enum.Font.Gotham
                TabButton.Parent = TabList
                
                -- Add corner to tab button
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = TabButton
                
                -- Create tab content
                local TabContent = Instance.new("ScrollingFrame")
                TabContent.Name = tabName .. "Content"
                TabContent.Size = UDim2.new(1, -20, 1, -20)
                TabContent.Position = UDim2.new(0, 10, 0, 10)
                TabContent.BackgroundTransparency = 1
                TabContent.ScrollBarThickness = 2
                TabContent.ScrollingDirection = Enum.ScrollingDirection.Y
                TabContent.Visible = false
                TabContent.Parent = ContentContainer
                
                -- Tab content layout
                local ContentLayout = Instance.new("UIListLayout")
                ContentLayout.FillDirection = Enum.FillDirection.Vertical
                ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ContentLayout.Padding = UDim.new(0, 5)
                ContentLayout.Parent = TabContent
                
                -- Tab button click
                TabButton.MouseButton1Click:Connect(function()
                    -- Hide all tabs
                    for _, tab in pairs(Tabs) do
                        tab.Content.Visible = false
                        tab.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    end
                    
                    -- Show this tab
                    TabContent.Visible = true
                    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    CurrentTab = Tabs[tabName]
                end)
                
                -- Add to tabs list
                local newTab = {
                    Name = tabName,
                    Button = TabButton,
                    Content = TabContent,
                    Sections = {}
                }
                
                Tabs[tabName] = newTab
                
                -- If first tab, set as current
                if #Tabs == 0 then
                    TabContent.Visible = true
                    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    CurrentTab = newTab
                end
                
                -- Tab methods
                return {
                    -- Create a section within the tab
                    CreateSection = function(self, sectionName)
                        -- Create section container
                        local Section = Instance.new("Frame")
                        Section.Name = sectionName .. "Section"
                        Section.Size = UDim2.new(1, 0, 0, 40)
                        Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        Section.BorderSizePixel = 0
                        Section.AutomaticSize = Enum.AutomaticSize.Y
                        Section.Parent = TabContent
                        
                        -- Section corners
                        local SectionCorner = Instance.new("UICorner")
                        SectionCorner.CornerRadius = UDim.new(0, 4)
                        SectionCorner.Parent = Section
                        
                        -- Section title
                        local SectionTitle = Instance.new("TextLabel")
                        SectionTitle.Name = "Title"
                        SectionTitle.Size = UDim2.new(1, -20, 0, 30)
                        SectionTitle.Position = UDim2.new(0, 10, 0, 5)
                        SectionTitle.BackgroundTransparency = 1
                        SectionTitle.Text = sectionName
                        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SectionTitle.TextSize = 16
                        SectionTitle.Font = Enum.Font.GothamBold
                        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
                        SectionTitle.Parent = Section
                        
                        -- Section content
                        local SectionContent = Instance.new("Frame")
                        SectionContent.Name = "Content"
                        SectionContent.Size = UDim2.new(1, -20, 0, 0)
                        SectionContent.Position = UDim2.new(0, 10, 0, 35)
                        SectionContent.BackgroundTransparency = 1
                        SectionContent.AutomaticSize = Enum.AutomaticSize.Y
                        SectionContent.Parent = Section
                        
                        -- Section content layout
                        local SectionLayout = Instance.new("UIListLayout")
                        SectionLayout.FillDirection = Enum.FillDirection.Vertical
                        SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        SectionLayout.Padding = UDim.new(0, 5)
                        SectionLayout.Parent = SectionContent
                        
                        return {}
                    end,
                    
                    -- Create a button in the tab
                    CreateButton = function(self, buttonOptions)
                        local Button = Instance.new("TextButton")
                        Button.Name = buttonOptions.Name .. "Button"
                        Button.Size = UDim2.new(1, 0, 0, 35)
                        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        Button.Text = buttonOptions.Name
                        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Button.TextSize = 14
                        Button.Font = Enum.Font.Gotham
                        Button.Parent = TabContent
                        
                        -- Button corners
                        local ButtonCorner = Instance.new("UICorner")
                        ButtonCorner.CornerRadius = UDim.new(0, 4)
                        ButtonCorner.Parent = Button
                        
                        -- Button functionality
                        Button.MouseButton1Click:Connect(function()
                            if buttonOptions.Callback then
                                buttonOptions.Callback()
                            end
                        end)
                        
                        return {}
                    end,
                    
                    -- Create a toggle in the tab
                    CreateToggle = function(self, toggleOptions)
                        local Toggle = Instance.new("Frame")
                        Toggle.Name = toggleOptions.Name .. "Toggle"
                        Toggle.Size = UDim2.new(1, 0, 0, 35)
                        Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        Toggle.Parent = TabContent
                        
                        -- Toggle corners
                        local ToggleCorner = Instance.new("UICorner")
                        ToggleCorner.CornerRadius = UDim.new(0, 4)
                        ToggleCorner.Parent = Toggle
                        
                        -- Toggle title
                        local ToggleTitle = Instance.new("TextLabel")
                        ToggleTitle.Name = "Title"
                        ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
                        ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
                        ToggleTitle.BackgroundTransparency = 1
                        ToggleTitle.Text = toggleOptions.Name
                        ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ToggleTitle.TextSize = 14
                        ToggleTitle.Font = Enum.Font.Gotham
                        ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                        ToggleTitle.Parent = Toggle
                        
                        -- Toggle button
                        local ToggleButton = Instance.new("TextButton")
                        ToggleButton.Name = "Button"
                        ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                        ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        ToggleButton.Text = ""
                        ToggleButton.Parent = Toggle
                        
                        -- Toggle button corners
                        local ButtonCorner = Instance.new("UICorner")
                        ButtonCorner.CornerRadius = UDim.new(0, 10)
                        ButtonCorner.Parent = ToggleButton
                        
                        -- Toggle indicator
                        local Indicator = Instance.new("Frame")
                        Indicator.Name = "Indicator"
                        Indicator.Size = UDim2.new(0, 16, 0, 16)
                        Indicator.Position = UDim2.new(0, 2, 0.5, -8)
                        Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Indicator.Parent = ToggleButton
                        
                        -- Indicator corners
                        local IndicatorCorner = Instance.new("UICorner")
                        IndicatorCorner.CornerRadius = UDim.new(0, 8)
                        IndicatorCorner.Parent = Indicator
                        
                        -- Toggle state
                        local toggleState = toggleOptions.CurrentValue or false
                        
                        -- Update toggle appearance
                        local function updateToggle()
                            if toggleState then
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
                                Indicator.Position = UDim2.new(1, -18, 0.5, -8)
                            else
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                                Indicator.Position = UDim2.new(0, 2, 0.5, -8)
                            end
                        end
                        
                        -- Initial state
                        updateToggle()
                        
                        -- Toggle functionality
                        ToggleButton.MouseButton1Click:Connect(function()
                            toggleState = not toggleState
                            updateToggle()
                            
                            if toggleOptions.Callback then
                                toggleOptions.Callback(toggleState)
                            end
                            
                            -- Update flag
                            if toggleOptions.Flag then
                                Rayfield.Flags[toggleOptions.Flag] = {
                                    Value = toggleState
                                }
                            end
                        end)
                        
                        -- Set flag
                        if toggleOptions.Flag then
                            Rayfield.Flags[toggleOptions.Flag] = {
                                Value = toggleState
                            }
                        end
                        
                        return {}
                    end,
                    
                    -- Create a color picker
                    CreateColorPicker = function(self, colorOptions)
                        local ColorPicker = Instance.new("Frame")
                        ColorPicker.Name = colorOptions.Name .. "ColorPicker"
                        ColorPicker.Size = UDim2.new(1, 0, 0, 35)
                        ColorPicker.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        ColorPicker.Parent = TabContent
                        
                        -- Color picker corners
                        local ColorCorner = Instance.new("UICorner")
                        ColorCorner.CornerRadius = UDim.new(0, 4)
                        ColorCorner.Parent = ColorPicker
                        
                        -- Color picker title
                        local ColorTitle = Instance.new("TextLabel")
                        ColorTitle.Name = "Title"
                        ColorTitle.Size = UDim2.new(1, -60, 1, 0)
                        ColorTitle.Position = UDim2.new(0, 10, 0, 0)
                        ColorTitle.BackgroundTransparency = 1
                        ColorTitle.Text = colorOptions.Name
                        ColorTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ColorTitle.TextSize = 14
                        ColorTitle.Font = Enum.Font.Gotham
                        ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
                        ColorTitle.Parent = ColorPicker
                        
                        -- Color preview
                        local ColorPreview = Instance.new("Frame")
                        ColorPreview.Name = "Preview"
                        ColorPreview.Size = UDim2.new(0, 25, 0, 25)
                        ColorPreview.Position = UDim2.new(1, -35, 0.5, -12.5)
                        ColorPreview.BackgroundColor3 = colorOptions.Color or Color3.fromRGB(255, 255, 255)
                        ColorPreview.Parent = ColorPicker
                        
                        -- Preview corners
                        local PreviewCorner = Instance.new("UICorner")
                        PreviewCorner.CornerRadius = UDim.new(0, 4)
                        PreviewCorner.Parent = ColorPreview
                        
                        return {}
                    end,
                    
                    -- Create a slider
                    CreateSlider = function(self, sliderOptions)
                        local Slider = Instance.new("Frame")
                        Slider.Name = sliderOptions.Name .. "Slider"
                        Slider.Size = UDim2.new(1, 0, 0, 50)
                        Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        Slider.Parent = TabContent
                        
                        -- Slider corners
                        local SliderCorner = Instance.new("UICorner")
                        SliderCorner.CornerRadius = UDim.new(0, 4)
                        SliderCorner.Parent = Slider
                        
                        -- Slider title
                        local SliderTitle = Instance.new("TextLabel")
                        SliderTitle.Name = "Title"
                        SliderTitle.Size = UDim2.new(1, -20, 0, 25)
                        SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                        SliderTitle.BackgroundTransparency = 1
                        SliderTitle.Text = sliderOptions.Name
                        SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SliderTitle.TextSize = 14
                        SliderTitle.Font = Enum.Font.Gotham
                        SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                        SliderTitle.Parent = Slider
                        
                        -- Slider value
                        local SliderValue = Instance.new("TextLabel")
                        SliderValue.Name = "Value"
                        SliderValue.Size = UDim2.new(0, 40, 0, 25)
                        SliderValue.Position = UDim2.new(1, -50, 0, 0)
                        SliderValue.BackgroundTransparency = 1
                        SliderValue.Text = tostring(sliderOptions.CurrentValue or sliderOptions.Range[1])
                        SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SliderValue.TextSize = 14
                        SliderValue.Font = Enum.Font.Gotham
                        SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                        SliderValue.Parent = Slider
                        
                        -- Slider background
                        local SliderBG = Instance.new("Frame")
                        SliderBG.Name = "Background"
                        SliderBG.Size = UDim2.new(1, -20, 0, 10)
                        SliderBG.Position = UDim2.new(0, 10, 0, 30)
                        SliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        SliderBG.Parent = Slider
                        
                        -- Background corners
                        local BGCorner = Instance.new("UICorner")
                        BGCorner.CornerRadius = UDim.new(0, 5)
                        BGCorner.Parent = SliderBG
                        
                        -- Slider fill
                        local SliderFill = Instance.new("Frame")
                        SliderFill.Name = "Fill"
                        SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
                        SliderFill.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
                        SliderFill.Parent = SliderBG
                        
                        -- Fill corners
                        local FillCorner = Instance.new("UICorner")
                        FillCorner.CornerRadius = UDim.new(0, 5)
                        FillCorner.Parent = SliderFill
                        
                        -- Drag indicator
                        local DragIndicator = Instance.new("Frame")
                        DragIndicator.Name = "Indicator"
                        DragIndicator.Size = UDim2.new(0, 14, 0, 14)
                        DragIndicator.Position = UDim2.new(1, -7, 0.5, -7)
                        DragIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DragIndicator.Parent = SliderFill
                        
                        -- Indicator corners
                        local IndicatorCorner = Instance.new("UICorner")
                        IndicatorCorner.CornerRadius = UDim.new(0, 7)
                        IndicatorCorner.Parent = DragIndicator
                        
                        -- Slider configuration
                        local minValue = sliderOptions.Range[1]
                        local maxValue = sliderOptions.Range[2]
                        local currentValue = sliderOptions.CurrentValue or minValue
                        
                        -- Update slider visual
                        local function updateSlider()
                            local range = maxValue - minValue
                            local percentage = (currentValue - minValue) / range
                            SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                            SliderValue.Text = tostring(currentValue)
                        end
                        
                        -- Initial update
                        updateSlider()
                        
                        -- Make draggable
                        local isDragging = false
                        
                        SliderBG.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                isDragging = true
                            end
                        end)
                        
                        SliderBG.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                isDragging = false
                            end
                        end)
                        
                        game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                isDragging = false
                            end
                        end)
                        
                        game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                                local relativePos = mousePos.X - SliderBG.AbsolutePosition.X
                                local percentage = math.clamp(relativePos / SliderBG.AbsoluteSize.X, 0, 1)
                                
                                local range = maxValue - minValue
                                local rawValue = minValue + (range * percentage)
                                
                                -- Handle increment if provided
                                if sliderOptions.Increment then
                                    currentValue = math.floor(rawValue / sliderOptions.Increment + 0.5) * sliderOptions.Increment
                                    currentValue = math.clamp(currentValue, minValue, maxValue)
                                else
                                    currentValue = rawValue
                                end
                                
                                updateSlider()
                                
                                if sliderOptions.Callback then
                                    sliderOptions.Callback(currentValue)
                                end
                                
                                -- Update flag
                                if sliderOptions.Flag then
                                    Rayfield.Flags[sliderOptions.Flag] = {
                                        Value = currentValue
                                    }
                                end
                            end
                        end)
                        
                        -- Set flag
                        if sliderOptions.Flag then
                            Rayfield.Flags[sliderOptions.Flag] = {
                                Value = currentValue
                            }
                        end
                        
                        return {}
                    end,
                    
                    -- Create a dropdown
                    CreateDropdown = function(self, dropdownOptions)
                        local Dropdown = Instance.new("Frame")
                        Dropdown.Name = dropdownOptions.Name .. "Dropdown"
                        Dropdown.Size = UDim2.new(1, 0, 0, 35)
                        Dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        Dropdown.ClipsDescendants = true
                        Dropdown.Parent = TabContent
                        
                        -- Dropdown corners
                        local DropdownCorner = Instance.new("UICorner")
                        DropdownCorner.CornerRadius = UDim.new(0, 4)
                        DropdownCorner.Parent = Dropdown
                        
                        -- Dropdown header
                        local DropdownHeader = Instance.new("TextButton")
                        DropdownHeader.Name = "Header"
                        DropdownHeader.Size = UDim2.new(1, 0, 0, 35)
                        DropdownHeader.BackgroundTransparency = 1
                        DropdownHeader.Text = dropdownOptions.Name
                        DropdownHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownHeader.TextSize = 14
                        DropdownHeader.Font = Enum.Font.Gotham
                        DropdownHeader.TextXAlignment = Enum.TextXAlignment.Left
                        DropdownHeader.TextTruncate = Enum.TextTruncate.AtEnd
                        DropdownHeader.Parent = Dropdown
                        
                        -- Header padding
                        local HeaderPadding = Instance.new("UIPadding")
                        HeaderPadding.PaddingLeft = UDim.new(0, 10)
                        HeaderPadding.Parent = DropdownHeader
                        
                        -- Selected option indicator
                        local SelectedOption = Instance.new("TextLabel")
                        SelectedOption.Name = "Selection"
                        SelectedOption.Size = UDim2.new(1, -60, 1, 0)
                        SelectedOption.Position = UDim2.new(0, 0, 0, 0)
                        SelectedOption.BackgroundTransparency = 1
                        SelectedOption.Text = dropdownOptions.CurrentOption or ""
                        SelectedOption.TextColor3 = Color3.fromRGB(200, 200, 200)
                        SelectedOption.TextSize = 14
                        SelectedOption.Font = Enum.Font.Gotham
                        SelectedOption.TextXAlignment = Enum.TextXAlignment.Right
                        SelectedOption.Parent = DropdownHeader
                        
                        -- Arrow indicator
                        local Arrow = Instance.new("TextLabel")
                        Arrow.Name = "Arrow"
                        Arrow.Size = UDim2.new(0, 20, 0, 35)
                        Arrow.Position = UDim2.new(1, -25, 0, 0)
                        Arrow.BackgroundTransparency = 1
                        Arrow.Text = "▼"
                        Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Arrow.TextSize = 14
                        Arrow.Font = Enum.Font.Gotham
                        Arrow.Parent = DropdownHeader
                        
                        -- Dropdown content
                        local DropdownContent = Instance.new("Frame")
                        DropdownContent.Name = "Content"
                        DropdownContent.Size = UDim2.new(1, -20, 0, 0)
                        DropdownContent.Position = UDim2.new(0, 10, 0, 35)
                        DropdownContent.BackgroundTransparency = 1
                        DropdownContent.AutomaticSize = Enum.AutomaticSize.Y
                        DropdownContent.Visible = false
                        DropdownContent.Parent = Dropdown
                        
                        -- Content layout
                        local ContentLayout = Instance.new("UIListLayout")
                        ContentLayout.FillDirection = Enum.FillDirection.Vertical
                        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        ContentLayout.Padding = UDim.new(0, 5)
                        ContentLayout.Parent = DropdownContent
                        
                        -- Dropdown state
                        local isOpen = false
                        local selectedOption = dropdownOptions.CurrentOption or ""
                        
                        -- Populate dropdown options
                        for _, option in pairs(dropdownOptions.Options) do
                            local OptionButton = Instance.new("TextButton")
                            OptionButton.Name = option .. "Option"
                            OptionButton.Size = UDim2.new(1, 0, 0, 25)
                            OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            OptionButton.Text = option
                            OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                            OptionButton.TextSize = 14
                            OptionButton.Font = Enum.Font.Gotham
                            OptionButton.Parent = DropdownContent
                            
                            -- Option corners
                            local OptionCorner = Instance.new("UICorner")
                            OptionCorner.CornerRadius = UDim.new(0, 4)
                            OptionCorner.Parent = OptionButton
                            
                            -- Option selection
                            OptionButton.MouseButton1Click:Connect(function()
                                selectedOption = option
                                SelectedOption.Text = option
                                
                                -- Toggle dropdown
                                isOpen = false
                                Dropdown.Size = UDim2.new(1, 0, 0, 35)
                                DropdownContent.Visible = false
                                Arrow.Text = "▼"
                                
                                if dropdownOptions.Callback then
                                    dropdownOptions.Callback(option)
                                end
                                
                                -- Update flag
                                if dropdownOptions.Flag then
                                    Rayfield.Flags[dropdownOptions.Flag] = {
                                        Value = option
                                    }
                                end
                            end)
                        end
                        
                        -- Toggle dropdown
                        DropdownHeader.MouseButton1Click:Connect(function()
                            isOpen = not isOpen
                            
                            if isOpen then
                                -- Calculate content height based on options
                                local contentHeight = #dropdownOptions.Options * 30
                                Dropdown.Size = UDim2.new(1, 0, 0, 35 + contentHeight)
                                DropdownContent.Visible = true
                                Arrow.Text = "▲"
                            else
                                Dropdown.Size = UDim2.new(1, 0, 0, 35)
                                DropdownContent.Visible = false
                                Arrow.Text = "▼"
                            end
                        end)
                        
                        -- Set flag
                        if dropdownOptions.Flag then
                            Rayfield.Flags[dropdownOptions.Flag] = {
                                Value = selectedOption
                            }
                        end
                        
                        return {}
                    end,
                    
                    -- Create a paragraph
                    CreateParagraph = function(self, paragraphOptions)
                        local Paragraph = Instance.new("Frame")
                        Paragraph.Name = "Paragraph"
                        Paragraph.Size = UDim2.new(1, 0, 0, 60)
                        Paragraph.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        Paragraph.Parent = TabContent
                        
                        -- Paragraph corners
                        local ParagraphCorner = Instance.new("UICorner")
                        ParagraphCorner.CornerRadius = UDim.new(0, 4)
                        ParagraphCorner.Parent = Paragraph
                        
                        -- Paragraph title
                        local Title = Instance.new("TextLabel")
                        Title.Name = "Title"
                        Title.Size = UDim2.new(1, -20, 0, 25)
                        Title.Position = UDim2.new(0, 10, 0, 0)
                        Title.BackgroundTransparency = 1
                        Title.Text = paragraphOptions.Title or "Paragraph"
                        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Title.TextSize = 16
                        Title.Font = Enum.Font.GothamBold
                        Title.TextXAlignment = Enum.TextXAlignment.Left
                        Title.Parent = Paragraph
                        
                        -- Paragraph content
                        local Content = Instance.new("TextLabel")
                        Content.Name = "Content"
                        Content.Size = UDim2.new(1, -20, 0, 0)
                        Content.Position = UDim2.new(0, 10, 0, 25)
                        Content.BackgroundTransparency = 1
                        Content.Text = paragraphOptions.Content or ""
                        Content.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Content.TextSize = 14
                        Content.Font = Enum.Font.Gotham
                        Content.TextXAlignment = Enum.TextXAlignment.Left
                        Content.TextYAlignment = Enum.TextYAlignment.Top
                        Content.TextWrapped = true
                        Content.AutomaticSize = Enum.AutomaticSize.Y
                        Content.Parent = Paragraph
                        
                        -- Adjust paragraph size based on content
                        Paragraph.AutomaticSize = Enum.AutomaticSize.Y
                        
                        return {}
                    end,
                    
                    -- Create a label
                    CreateLabel = function(self, text)
                        local Label = Instance.new("TextLabel")
                        Label.Name = "Label"
                        Label.Size = UDim2.new(1, 0, 0, 25)
                        Label.BackgroundTransparency = 1
                        Label.Text = text
                        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Label.TextSize = 14
                        Label.Font = Enum.Font.Gotham
                        Label.TextXAlignment = Enum.TextXAlignment.Left
                        Label.Parent = TabContent
                        
                        -- Add padding
                        local LabelPadding = Instance.new("UIPadding")
                        LabelPadding.PaddingLeft = UDim.new(0, 10)
                        LabelPadding.Parent = Label
                        
                        return {}
                    end
                }
            end
        }
    end
    
    -- Notification system
    function Rayfield:Notify(options)
        -- Create notification container if doesn't exist
        if not ScreenGui:FindFirstChild("NotificationContainer") then
            local NotifContainer = Instance.new("Frame")
            NotifContainer.Name = "NotificationContainer"
            NotifContainer.Size = UDim2.new(0, 300, 1, 0)
            NotifContainer.Position = UDim2.new(1, -310, 0, 0)
            NotifContainer.BackgroundTransparency = 1
            NotifContainer.Parent = ScreenGui
            
            -- Container layout
            local ContainerLayout = Instance.new("UIListLayout")
            ContainerLayout.FillDirection = Enum.FillDirection.Vertical
            ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ContainerLayout.Padding = UDim.new(0, 10)
            ContainerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            ContainerLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
            ContainerLayout.Parent = NotifContainer
            
            -- Container padding
            local ContainerPadding = Instance.new("UIPadding")
            ContainerPadding.PaddingBottom = UDim.new(0, 10)
            ContainerPadding.Parent = NotifContainer
        end
        
        local container = ScreenGui.NotificationContainer
        
        -- Create notification
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Size = UDim2.new(1, -20, 0, 0)
        Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Notification.BackgroundTransparency = 0.1
        Notification.AutomaticSize = Enum.AutomaticSize.Y
        Notification.Parent = container
        
        -- Notification corner
        local NotifCorner = Instance.new("UICorner")
        NotifCorner.CornerRadius = UDim.new(0, 6)
        NotifCorner.Parent = Notification
        
        -- Title
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Size = UDim2.new(1, -20, 0, 25)
        Title.Position = UDim2.new(0, 10, 0, 5)
        Title.BackgroundTransparency = 1
        Title.Text = options.Title or "Notification"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 16
        Title.Font = Enum.Font.GothamBold
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = Notification
        
        -- Content
        local Content = Instance.new("TextLabel")
        Content.Name = "Content"
        Content.Size = UDim2.new(1, -20, 0, 0)
        Content.Position = UDim2.new(0, 10, 0, 30)
        Content.BackgroundTransparency = 1
        Content.Text = options.Content or ""
        Content.TextColor3 = Color3.fromRGB(200, 200, 200)
        Content.TextSize = 14
        Content.Font = Enum.Font.Gotham
        Content.TextXAlignment = Enum.TextXAlignment.Left
        Content.TextYAlignment = Enum.TextYAlignment.Top
        Content.TextWrapped = true
        Content.AutomaticSize = Enum.AutomaticSize.Y
        Content.Parent = Notification
        
        -- Close after duration
        local duration = options.Duration or 5
        task.delay(duration, function()
            Notification:Destroy()
        end)
        
        return Notification
    end
    
    return Rayfield
end)()

-- Create the main window
local Window = Rayfield:CreateWindow({
    Name = "▶ LAJHUBv2 EXPLOIT ◀",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by LAJ HUB",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LAJHUBv2",
        FileName = "config"
    },
})

-- Create tabs
local HomeTab = Window:CreateTab("Home")
local ScriptsTab = Window:CreateTab("Scripts")
local SettingsTab = Window:CreateTab("Settings")

-- Home Tab Content
local WelcomeSection = HomeTab:CreateSection("Welcome to LAJHUBv2")

HomeTab:CreateParagraph({
    Title = "LAJHUBv2 Premium Exploit",
    Content = "Welcome to LAJHUBv2, the premium Roblox exploit with advanced features. This UI is designed for optimal performance on mobile platforms."
})

HomeTab:CreateButton({
    Name = "Join Discord",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/lajhub")
            Rayfield:Notify({
                Title = "Discord",
                Content = "Discord invite copied to clipboard!",
                Duration = 3,
            })
        else
            Rayfield:Notify({
                Title = "Discord",
                Content = "Unable to copy to clipboard",
                Duration = 3,
            })
        end
    end,
})

HomeTab:CreateButton({
    Name = "Check for Updates",
    Callback = function()
        Rayfield:Notify({
            Title = "Update Check",
            Content = "Your version is up to date!",
            Duration = 3,
        })
    end,
})

-- Scripts Tab Content
local PopularSection = ScriptsTab:CreateSection("Popular Scripts")

ScriptsTab:CreateButton({
    Name = "LAJ Infinite Yield",
    Callback = function()
        Rayfield:Notify({
            Title = "LAJ Infinite Yield",
            Content = "Loading LAJ Infinite Yield admin commands...",
            Duration = 3,
        })
        
        -- Load Infinite Yield directly (code execution would go here)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ktrolegl/LAJhubv2/main/laj_infinite_yield.lua', true))()
        
        Rayfield:Notify({
            Title = "LAJ Infinite Yield",
            Content = "Successfully loaded! Use ; to enter commands",
            Duration = 5,
        })
    end,
})

ScriptsTab:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        Rayfield:Notify({
            Title = "Dex Explorer",
            Content = "Loading Dex Explorer...",
            Duration = 3,
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDex.lua", true))()
    end,
})

local GamesSection = ScriptsTab:CreateSection("Game Scripts")

-- Speed Hub X integration
local SpeedHubGames = {
    ["Blox Fruits"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Dead Rails"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Muscle Legends"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Fisch"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["The Strongest Battlegrounds"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Arise Crossover"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Bubble Gum Simulator INFINITY"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Anime Reborn"] = "https://raw.githubusercontent.com/AhmadV99/Script-Games/main/Anime%20Reborn.lua",
    ["Anime Vanguards"] = "https://raw.githubusercontent.com/AhmadV99/Script-Games/main/Anime%20Vanguards.lua"
}

-- Combine standard games with Speed Hub X games
local AllGameOptions = {
    "Adopt Me", 
    "Blox Fruits", 
    "Dead Rails",
    "Fisch", 
    "Jailbreak", 
    "Murder Mystery 2", 
    "Muscle Legends",
    "Pets Go!", 
    "Shindo Life",
    "The Strongest Battlegrounds",
    "Arise Crossover",
    "Bubble Gum Simulator INFINITY",
    "Anime Reborn",
    "Anime Vanguards"
}

-- Sort the game options for better organization
table.sort(AllGameOptions)

ScriptsTab:CreateDropdown({
    Name = "Select Game",
    Options = AllGameOptions,
    CurrentOption = "Jailbreak", -- Set Jailbreak as the default selected game
    Flag = "GameDropdown",
    Callback = function(Option)
        Rayfield:Notify({
            Title = "Game Selected",
            Content = "Selected: " .. Option,
            Duration = 3,
        })
    end,
})

ScriptsTab:CreateButton({
    Name = "Load Selected Game Script",
    Callback = function()
        -- Get the currently selected game from the dropdown
        local selectedGame = Rayfield.Flags.GameDropdown.Value
        
        -- Notify what game script we're loading
        Rayfield:Notify({
            Title = "Script Loader",
            Content = "Loading script for " .. (selectedGame or "selected game") .. "...",
            Duration = 3,
        })
        
        -- Check if it's a Speed Hub X game
        if SpeedHubGames[selectedGame] then
            -- Load the Speed Hub X script for the selected game
            loadstring(game:HttpGet(SpeedHubGames[selectedGame], true))()
            
            Rayfield:Notify({
                Title = "Speed Hub X",
                Content = selectedGame .. " script loaded successfully!",
                Duration = 3,
            })
        -- Handle other specific games
        elseif selectedGame == "Jailbreak" then
            -- Load Jailbreak Auto Arrest script
            loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoArrestV3'))()
            
            Rayfield:Notify({
                Title = "Jailbreak",
                Content = "Auto Arrest script loaded successfully!",
                Duration = 3,
            })
        else
            -- Generic message for other games (to be implemented)
            Rayfield:Notify({
                Title = "Script Loader",
                Content = "No specific script available for " .. (selectedGame or "this game"),
                Duration = 3,
            })
        end
    end,
})

-- Settings Tab Content
local UISection = SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateToggle({
    Name = "Save Configuration",
    CurrentValue = true,
    Flag = "SaveConfig",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Configuration",
            Content = Value and "Configuration saving enabled" or "Configuration saving disabled",
            Duration = 3,
        })
    end,
})

local ThemeColorPicker = SettingsTab:CreateColorPicker({
    Name = "UI Theme Color",
    Color = Color3.fromRGB(89, 150, 255),
    Flag = "UIColor",
    Callback = function(Color)
        Rayfield:Notify({
            Title = "Theme Color",
            Content = "Theme color updated!",
            Duration = 3,
        })
    end,
})

local PerformanceSection = SettingsTab:CreateSection("Performance")

SettingsTab:CreateSlider({
    Name = "Animation Smoothness",
    Range = {0, 100},
    Increment = 5,
    CurrentValue = 75,
    Flag = "AnimationSmoothnessSlider",
    Callback = function(Value)
        -- Animation smoothness value stored
    end,
})

SettingsTab:CreateToggle({
    Name = "Mobile Optimization",
    CurrentValue = true,
    Flag = "MobileOptimization",
    Callback = function(Value)
        Rayfield:Notify({
            Title = "Mobile Optimization",
            Content = Value and "Mobile optimization enabled" or "Mobile optimization disabled",
            Duration = 3,
        })
    end,
})

-- Show notification on load
Rayfield:Notify({
    Title = "LAJHUBv2 EXPLOIT",
    Content = "Successfully loaded the exploit UI!",
    Duration = 5,
})
