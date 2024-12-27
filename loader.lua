-- The project is purely for experiments, this is the first version, it may have bugs :P

if game:GetService("CoreGui"):FindFirstChild("VisualBBGui") then
	warn("VisualBB Dublicate detected! Deleting...")
	game:GetService("CoreGui"):FindFirstChild("VisualBBGui"):Destroy()
end

VisualBBGui = Instance.new("ScreenGui")
BBframe = Instance.new("Frame")
BBTopBar = Instance.new("Frame")
BBNameProject = Instance.new("TextLabel")
CloseButton = Instance.new("TextButton")
BBFrame = Instance.new("Frame")

VisualBBGui.Name = "VisualBBGui"
VisualBBGui.Parent = game.CoreGui
VisualBBGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
game.CoreGui.VisualBBGui.Enabled = true

BBTopBar.Name = "BBTopBar"
BBTopBar.Parent = VisualBBGui
BBTopBar.AnchorPoint = Vector2.new(0.5, 0.5)
BBTopBar.Position = UDim2.new(0.5, 0, 0.1, 0)
BBTopBar.Size = UDim2.new(0, 600, 0, 40)
BBTopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BBTopBar.ZIndex = 2

BBNameProject.Parent = BBTopBar
BBNameProject.Name = "BBNameProject"
BBNameProject.Size = UDim2.new(1, -50, 1, 0)
BBNameProject.Position = UDim2.new(0, 10, -0.2, 0)
BBNameProject.BackgroundTransparency = 1
BBNameProject.Text = "VisualBB @blinnnn5 :3"
BBNameProject.TextColor3 = Color3.fromRGB(255, 255, 255)
BBNameProject.Font = Enum.Font.Ubuntu
BBNameProject.TextSize = 24
BBNameProject.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = BBTopBar
CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(0.970, 0, 0.38, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.TextSize = 35
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "×"

CloseButton.MouseButton1Click:Connect(function()
	VisualBBGui:Destroy()
end)

BBFrame.Name = "BBFrame"
BBFrame.Parent = BBTopBar
BBFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BBFrame.Position = UDim2.new(0.5, 0, 5.8, 0)
BBFrame.Size = UDim2.new(0, 600, 0, 400)
BBFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

color = Color3.fromRGB(255, 255, 255)

local function createColorPicker(parent, position, size, onColorChanged)
    local frame = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local colorDisplayFrame = Instance.new("Frame")
    local brightnessFrame = Instance.new("Frame")
    local brightnessGradient = Instance.new("UIGradient")
    local lightnessFrame = Instance.new("Frame")
    local lightnessGradient = Instance.new("UIGradient")

    local gradientColors = {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))
    }

    frame.Parent = parent
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    UIGradient.Parent = frame
    UIGradient.Color = ColorSequence.new(gradientColors)

    colorDisplayFrame.Parent = parent
    colorDisplayFrame.Size = UDim2.new(0, 50, 0, size.Y.Offset)
    colorDisplayFrame.Position = position + UDim2.new(0, -55, 0, 0)
    colorDisplayFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    brightnessFrame.Parent = parent
    brightnessFrame.Size = UDim2.new(0, size.X.Offset, 0, 20)
    brightnessFrame.Position = position + UDim2.new(0, 0, 0, size.Y.Offset + 5)
    brightnessFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    brightnessGradient.Parent = brightnessFrame
    brightnessGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })

    lightnessFrame.Parent = parent
    lightnessFrame.Size = UDim2.new(0, size.X.Offset, 0, 20)
    lightnessFrame.Position = position + UDim2.new(0, 0, 0, size.Y.Offset + 30)
    lightnessFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    lightnessGradient.Parent = lightnessFrame
    lightnessGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })

    local function interpolateColor(color1, color2, t)
        return Color3.fromRGB(
            math.floor(color1.R * 255 + (color2.R - color1.R) * t * 255),
            math.floor(color1.G * 255 + (color2.G - color1.G) * t * 255),
            math.floor(color1.B * 255 + (color2.B - color1.B) * t * 255)
        )
    end

    local function adjustBrightness(color, brightnessFactor)
        local r = math.clamp(color.R * brightnessFactor, 0, 1)
        local g = math.clamp(color.G * brightnessFactor, 0, 1)
        local b = math.clamp(color.B * brightnessFactor, 0, 1)
        return Color3.fromRGB(r * 255, g * 255, b * 255)
    end

    local function adjustLightness(color, lightnessFactor)
        local r = math.clamp(color.R + (1 - color.R) * lightnessFactor, 0, 1)
        local g = math.clamp(color.G + (1 - color.G) * lightnessFactor, 0, 1)
        local b = math.clamp(color.B + (1 - color.B) * lightnessFactor, 0, 1)
        return Color3.fromRGB(r * 255, g * 255, b * 255)
    end

    local selectedColor = Color3.fromRGB(255, 255, 255)
    local brightnessFactor = 1
    local lightnessFactor = 0
    local finalColor = selectedColor

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = (mouse.X - frame.AbsolutePosition.X) / frame.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)

            local keypoints = UIGradient.Color.Keypoints
            local startKeypoint, endKeypoint
            for i = 1, #keypoints - 1 do
                if relativeX >= keypoints[i].Time and relativeX <= keypoints[i + 1].Time then
                    startKeypoint = keypoints[i]
                    endKeypoint = keypoints[i + 1]
                    break
                end
            end

            local t = (relativeX - startKeypoint.Time) / (endKeypoint.Time - startKeypoint.Time)
            selectedColor = interpolateColor(startKeypoint.Value, endKeypoint.Value, t)

            finalColor = adjustBrightness(selectedColor, brightnessFactor)
            finalColor = adjustLightness(finalColor, lightnessFactor)

            colorDisplayFrame.BackgroundColor3 = finalColor

            lightnessGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, finalColor),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            })

            if onColorChanged then
                onColorChanged(finalColor)
            end
        end
    end)

    brightnessFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = (mouse.X - brightnessFrame.AbsolutePosition.X) / brightnessFrame.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)

            brightnessFactor = 1 - relativeX

            finalColor = adjustBrightness(selectedColor, brightnessFactor)
            finalColor = adjustLightness(finalColor, lightnessFactor)

            colorDisplayFrame.BackgroundColor3 = finalColor

            if onColorChanged then
                onColorChanged(finalColor)
            end
        end
    end)

    lightnessFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = (mouse.X - lightnessFrame.AbsolutePosition.X) / lightnessFrame.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)

            lightnessFactor = relativeX

            finalColor = adjustBrightness(selectedColor, brightnessFactor)
            finalColor = adjustLightness(finalColor, lightnessFactor)

            colorDisplayFrame.BackgroundColor3 = finalColor

            if onColorChanged then
                onColorChanged(finalColor)
            end
        end
    end)

    return finalColor
end


function setting(name, sizebackround, posbackround, sizetb)

	sizebackround = UDim2.new(0, 400, 0, 300)
	posbackround = UDim2.new(0.5, 0, 7, -40)
	sizetb = UDim2.new(0, 400, 0, 32)

	if VisualBBGui:FindFirstChild("settingTopBar") then VisualBBGui:FindFirstChild("settingTopBar"):Destroy() end

	local set = Instance.new("Frame")
	local tb = Instance.new("Frame")
	local title = Instance.new("TextLabel")
	local close = Instance.new("TextButton")

	set.Parent = VisualBBGui

	tb.Name = "settingTopBar"
	tb.Parent = VisualBBGui
	tb.AnchorPoint = Vector2.new(0.5, 0.5)
	tb.Position = UDim2.new(0.5, 0, 0.4, 0)
	tb.Size = sizetb
	tb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tb.ZIndex = 2
	
	set.Name = "settingFrame"
	set.Parent = tb
	set.AnchorPoint = Vector2.new(0.5, 0.5)
	set.Transparency = 0.3
	set.Position = posbackround
	set.Size = sizebackround
	set.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

	title.Parent = tb
	title.Name = "settingTitle"
	title.Size = UDim2.new(1, -50, 1, 0)
	title.Position = UDim2.new(0.1, -35, -0.11, 5)
	title.BackgroundTransparency = 1
	title.Text = tostring(name)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.Ubuntu
	title.TextSize = 24
	title.TextXAlignment = Enum.TextXAlignment.Left

	close.Name = "settingClose"
	close.Parent = tb
	close.AnchorPoint = Vector2.new(0.5, 0.5)
	close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	close.Position = UDim2.new(0.9, 25, 0.3, 5)
	close.Size = UDim2.new(0, 25, 0, 25)
	close.Font = Enum.Font.SourceSans
	close.TextSize = 35
	close.TextColor3 = Color3.fromRGB(255, 255, 255)
	close.Text = "×"

	close.MouseButton1Click:Connect(function()
		tb:Destroy()
	end)

	local UserInputService = game:GetService("UserInputService")
		
        local gui = tb

        local dragging
        local dragInput
        local dragStart
        local startPos

        local function update(input)
        	local delta = input.Position - dragStart
        	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        gui.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        		dragging = true
        		dragStart = input.Position
        		startPos = gui.Position
        		
        		input.Changed:Connect(function()
        			if input.UserInputState == Enum.UserInputState.End then
        				dragging = false
        			end
        		end)
        	end
        end)

        gui.InputChanged:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        		dragInput = input
        	end
        end)

        UserInputService.InputChanged:Connect(function(input)
        	if input == dragInput and dragging then
        		update(input)
        	end
        end)

		return tb
end

function createToggleButton(parent, buttonText, buttonSize, buttonPosition, onToggleFunction, a, b)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = buttonSize
    button.Position = buttonPosition
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 24

    local isOn = false

    local function updateButtonState()
        if isOn then
            button.Text = buttonText .. "[ON]"
            button.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
        else
            button.Text = buttonText .. "[OFF]"
            button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        end
    end

    updateButtonState()

	game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
		if isOn then
			a()
		end
	end)

    button.MouseButton1Click:Connect(function()
        isOn = not isOn
        updateButtonState()
        if onToggleFunction then
            onToggleFunction(isOn)
        end
    end)

	button.MouseButton2Click:Connect(function()
        b()
    end)

    return button
end

local trail
local trailColors = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)}

local function createTrail(color1, color2)
    local humanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    local att0 = Instance.new("Attachment", humanoidRootPart)
    local att1 = Instance.new("Attachment", humanoidRootPart)

    att0.Position = Vector3.new(0, humanoidRootPart.Size.Y / 1.5, 0)
    att1.Position = Vector3.new(0, -humanoidRootPart.Size.Y / 1.5, 0)

    trail = Instance.new("Trail", humanoidRootPart)
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    trail.Lifetime = 0.5
    trail.Color = ColorSequence.new(color1, color2)
    trail.Enabled = true
end

createToggleButton(BBTopBar, "Trails", UDim2.new(0, 200, 0, 30), UDim2.new(0, 10, 0, 40), function(isOn)
    if isOn then
        if not trail then
            createTrail(trailColors[1], trailColors[2])
        end
    else
        if trail then
            trail:Destroy()
            trail = nil
        end
    end
end, function() createTrail(trailColors[1], trailColors[2]) end, function()
    tb = setting("Trails settings")

    createColorPicker(tb, UDim2.new(0.5, -130, 0.5, 20), UDim2.new(0, 320, 0, 50), function(newColor)
        trailColors[1] = newColor
        if trail then
            trail.Color = ColorSequence.new(trailColors[1], trailColors[2])
        end
    end)

    createColorPicker(tb, UDim2.new(0.5, -130, 0.5, 150), UDim2.new(0, 320, 0, 50), function(newColor)
        trailColors[2] = newColor
        if trail then
            trail.Color = ColorSequence.new(trailColors[1], trailColors[2])
        end
    end)
end)


local chinahat
local chinahatcolor = Color3.fromRGB(255, 255, 255)

local function createHat(color)

	local head = game.Players.LocalPlayer.character:WaitForChild("Head")

    chinahat = game:GetService("InsertService"):CreateMeshPartAsync("rbxassetid://10791718641",0,0)
    chinahat.Size = Vector3.new(3, 0.8, 3)
	chinahat.Transparency = 0.6
	chinahat.Material = Enum.Material.Neon
	chinahat.Color = color
    chinahat.Anchored = false
    chinahat.CanCollide = false
    chinahat.Parent = game.Players.LocalPlayer.Character

    if head then
        chinahat.CFrame = head.CFrame * CFrame.new(0, 1.1, 0)

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = chinahat
        weld.Part1 = head
        weld.Parent = chinahat
    else
        warn("Голова персонажа не найдена!")
    end
end

createToggleButton(BBTopBar, "ChinaHat", UDim2.new(0, 200, 0, 30), UDim2.new(0, 10, 0, 80), function(isOn)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()


    if isOn then
        
		if not chinahat then
			createHat(chinahatcolor)
		end
    else
        if chinahat then
            chinahat:Destroy()
            chinahat = nil
        end
    end
end, function() createHat(chinahatcolor) end, function()

	tb = setting("ChinaHat settings")
    createColorPicker(tb, UDim2.new(0.5, -130, 0.5, 20), UDim2.new(0, 320, 0, 50), function(newColor)
        chinahatcolor = newColor
        if chinahat then
            chinahat.Color = chinahatcolor
        end
    end)
end)

local jumpingConnection
local jumpCircleScale = 2
local jumpCircleColor = Color3.fromRGB(255, 255, 255) 

local function JumpCircleCreate(a, b, c, d)

	local TS = game:GetService("TweenService")

	local jumpCircle
	local texture

    local humanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    jumpCircle = Instance.new("Part")
    jumpCircle.Size = Vector3.new(a, 0.2, b)
    jumpCircle.Position = humanoidRootPart.Position - Vector3.new(0, humanoidRootPart.Size.Y / 2 + 1.8, 0)
    jumpCircle.Anchored = true
    jumpCircle.CanCollide = false
    jumpCircle.Parent = workspace
	jumpCircle.Transparency = 1

	texture = Instance.new("Decal")
	texture.Color3 = d
	texture.Parent = jumpCircle
	texture.Face = Enum.NormalId.Top
	texture.Texture = "http://www.roblox.com/asset/?id=99917822851140"

	local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false) 
	local info2 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false) 
	local tween = TS:Create(texture, info, {Transparency = 1})
	local tween2 = TS:Create(jumpCircle, info, {Size = Vector3.new(a * c, 0.2, b * c)})

	tween:Play()
	tween2:Play()
	tween.Completed:Wait()
	jumpCircle:Destroy()

end

local function circlerespawn()

	local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	print(1)

	jumpingConnection = humanoid.Jumping:Connect(function(isJumping)
    	if isJumping then
        	JumpCircleCreate(3,3,jumpCircleScale, jumpCircleColor)
		end
	end)
end

createToggleButton(BBTopBar, "JumpCircle", UDim2.new(0, 200, 0, 30), UDim2.new(0, 10, 0, 120), function(isOn)

	local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

    if isOn then
		jumpingConnection = humanoid.Jumping:Connect(function(isJumping)

    		if isJumping then
            	JumpCircleCreate(3,3,jumpCircleScale, jumpCircleColor)
			end
		end)
    else
		if jumpingConnection then
            jumpingConnection:Disconnect()
            jumpingConnection = nil
        end
        

        if jumpCircle then
            jumpCircle:Destroy()
            jumpCircle = nil
        end
    end
end, function() circlerespawn() end, function()

	tb = setting("JumpCircle setting")

	createColorPicker(tb, UDim2.new(0.5, -130, 0.5, 20), UDim2.new(0, 320, 0, 50), function(newColor)
		jumpCircleColor = newColor
	end)

end)


local UserInputService = game:GetService("UserInputService")

        local gui = BBTopBar

        local dragging
        local dragInput
        local dragStart
        local startPos

        local function update(input)
        	local delta = input.Position - dragStart
        	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        gui.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        		dragging = true
        		dragStart = input.Position
        		startPos = gui.Position
        		
        		input.Changed:Connect(function()
        			if input.UserInputState == Enum.UserInputState.End then
        				dragging = false
        			end
        		end)
        	end
        end)

        gui.InputChanged:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        		dragInput = input
        	end
        end)

        UserInputService.InputChanged:Connect(function(input)
        	if input == dragInput and dragging then
        		update(input)
        	end
        end)
