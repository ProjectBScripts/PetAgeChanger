-- LocalScript (StarterPlayerScripts or StarterGui)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ProjectBPetAgeChanger"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 140)
frame.Position = UDim2.new(0.5, -150, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true
frame.Name = "PetAgeFrame"
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "Pet Age Changer"
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 5)

-- Close Button
local closeButton = Instance.new("TextButton", frame)
closeButton.Text = "X"
closeButton.Font = Enum.Font.FredokaOne
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(1, -34, 0, 6)
Instance.new("UICorner", closeButton)

closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- Equipped Pet Label
local petInfo = Instance.new("TextLabel", frame)
petInfo.Text = "Equipped Pet: [None]"
petInfo.Font = Enum.Font.FredokaOne
petInfo.TextSize = 16
petInfo.TextColor3 = Color3.fromRGB(255, 255, 160)
petInfo.BackgroundTransparency = 1
petInfo.Position = UDim2.new(0, 12, 0, 40)
petInfo.Size = UDim2.new(1, -24, 0, 24)
petInfo.TextXAlignment = Enum.TextXAlignment.Left

-- Button
local button = Instance.new("TextButton", frame)
button.Text = "Set Age to 50"
button.Font = Enum.Font.FredokaOne
button.TextSize = 16
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Size = UDim2.new(0, 220, 0, 36)
button.Position = UDim2.new(0.5, -110, 1, -58)
Instance.new("UICorner", button)

-- Gradient Effect on Button
local grad = Instance.new("UIGradient", button)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255))
}
grad.Rotation = 90

-- Footer Label
local footer = Instance.new("TextLabel", frame)
footer.Text = "Made by ProjectB"
footer.Font = Enum.Font.FredokaOne
footer.TextSize = 13
footer.TextColor3 = Color3.fromRGB(180, 180, 180)
footer.BackgroundTransparency = 1
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)

-- Function to find equipped pet tool
local function getEquippedPetTool()
	character = player.Character or player.CharacterAdded:Wait()
	for _, child in pairs(character:GetChildren()) do
		if child:IsA("Tool") and child.Name:find("Age") then
			return child
		end
	end
	return nil
end

-- Update GUI with equipped pet
local function updateGUI()
	local pet = getEquippedPetTool()
	if pet then
		petInfo.Text = "Equipped Pet: " .. pet.Name
	else
		petInfo.Text = "Equipped Pet: [None]"
	end
end

-- On button click, wait 10s then change name visually
button.MouseButton1Click:Connect(function()
	local tool = getEquippedPetTool()
	if tool then
		for i = 10, 1, -1 do
			button.Text = "Changing Age in " .. i .. "..."
			task.wait(1)
		end
		local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		tool.Name = newName
		petInfo.Text = "Equipped Pet: " .. tool.Name
		button.Text = "Set Age to 50"
	else
		button.Text = "No Pet Equipped!"
		wait(2)
		button.Text = "Set Age to 50"
	end
end)

-- Auto refresh pet name every second
task.spawn(function()
	while true do
		updateGUI()
		task.wait(1)
	end
end)
