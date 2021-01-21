local player = game.Players.LocalPlayer

local UserInputService = game:GetService("UserInputService")
-- Shift keys
local shiftKeyL = Enum.KeyCode.LeftShift
local shiftKeyR = Enum.KeyCode.RightShift
local backwardsKey = Enum.KeyCode.S

-- Return whether left or right shift keys are down
local function IsShiftKeyDown()
	return UserInputService:IsKeyDown(shiftKeyL) or UserInputService:IsKeyDown(shiftKeyR)
end

local function IsWalkingBackwards()
	return UserInputService:IsKeyDown(backwardsKey)
end

-- Handle user input began differently depending on whether a shift key is pressed
local function Input(input, gameProcessedEvent)
	if not IsWalkingBackwards() then
		-- Normal input
		game:GetService("RunService"):BindToRenderStep("ForceShiftlock", Enum.RenderPriority.Camera.Value + 1, function()
			UserSettings():GetService("UserGameSettings").RotationType = Enum.RotationType.MovementRelative
		end)
	else
		-- Shift input
		while IsWalkingBackwards() do
			wait()
			print("Backwards Walking!")
			game:GetService("RunService"):BindToRenderStep("ForceShiftlock", Enum.RenderPriority.Camera.Value + 1, function()
			UserSettings():GetService("UserGameSettings").RotationType = Enum.RotationType.CameraRelative
			end)
		end
	end
end

UserInputService.InputBegan:Connect(Input)


	
