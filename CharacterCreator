--This script will remove the old roblox body, (make it transparent) and build
-- a custom body for the player (colors will vary between class type selected at login)
game.Players.PlayerAdded:connect(function(player) 
player.CharacterAdded:connect(function(character)
player.CharacterAppearanceLoaded:Connect(function(character)
	

local p = player
local c = character
local humanoid = character:WaitForChild("Humanoid")
humanoid:RemoveAccessories()

local BodyParts = c:GetChildren();
for i = 1, #BodyParts do 
	if (BodyParts[i]:IsA("MeshPart") or BodyParts[i]:IsA("Part")) then 
		BodyParts[i].Transparency = 1
		if (BodyParts[i].Name == "Head") then
			local headParts = BodyParts[i]:GetChildren()
			for x = 1, #headParts do
				if headParts[x]:IsA("Decal") then
					headParts[x]:Destroy()
				end
			end 
		end
		
	end
end


local colors = {"Mid gray","Really black","White","Light yellow","Pastel Blue","Bright red"}
newColor =  BrickColor.new(math.random(1,#colors))
NewChar = game:GetService("ReplicatedStorage"):FindFirstChild("Character")

--Nearby Detection Part

--Chest 
local function CreateTorso()
	local newTorso = NewChar:WaitForChild("Chest"):clone()
	newTorso.Parent = character
	local torsoParts = newTorso:GetChildren()
	for i = 1, #torsoParts do
		if torsoParts[i]:IsA("Part") then
			local W = Instance.new("Weld")
			W.Part0 = newTorso.ChestPart
			W.Part1 = torsoParts[i]
			local CJ = CFrame.new(newTorso.ChestPart.Position)
			local C0 = newTorso.ChestPart.CFrame:inverse() * CJ
			local C1 = torsoParts[i].CFrame:inverse() * CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = newTorso.ChestPart
		end
		local Y = Instance.new("Weld")
		Y.Part0 = character.UpperTorso
		Y.Part1 = newTorso.ChestPart
		Y.C0 = CFrame.new(0, 0, 0)
		Y.Parent = Y.Part0
	end
	
	local parts = newTorso:GetChildren()
		for i = 1, #parts do
			if parts[i]:IsA("Part") then
				parts[i].Anchored = false
			end
		end
	newTorso.ChestPart.BrickColor = newColor
end
local function CreateLeftLeg()
	local newPart = NewChar:WaitForChild("LeftLeg"):clone()
	newPart.Parent = character
	mainPart = newPart:FindFirstChild("LeftLegPart")
	local newParts = newPart:GetChildren()
	for i = 1, #newParts do
		if newParts[i]:IsA("Part") then
			local W = Instance.new("Weld")
			W.Part0 = mainPart
			W.Part1 = newParts[i]
			local CJ = CFrame.new(mainPart.Position)
			local C0 = mainPart.CFrame:inverse() * CJ
			local C1 = newParts[i].CFrame:inverse() * CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = mainPart
		end
		local Y = Instance.new("Weld")
		Y.Part0 = character:FindFirstChild("LeftLowerLeg")
		Y.Part1 = mainPart
		Y.C0 = CFrame.new(-0.8, -0.5, 0)
		Y.Parent = Y.Part0
	end
	
	local parts = newPart:GetChildren()
		for i = 1, #parts do
			if parts[i]:IsA("Part") then
				parts[i].Anchored = false
			end
		end
	mainPart.BrickColor = newColor
end
local function CreateLeftArm()
	local newPart = NewChar:WaitForChild("LeftArm"):clone()
	newPart.Parent = character
	mainPart = newPart:FindFirstChild("LeftArmPart")
	local newParts = newPart:GetChildren()
	for i = 1, #newParts do
		if newParts[i]:IsA("Part") then
			local W = Instance.new("Weld")
			W.Part0 = mainPart
			W.Part1 = newParts[i]
			local CJ = CFrame.new(mainPart.Position)
			local C0 = mainPart.CFrame:inverse() * CJ
			local C1 = newParts[i].CFrame:inverse() * CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = mainPart
		end
		local Y = Instance.new("Weld")
		Y.Part0 = character:FindFirstChild("LeftHand")
		Y.Part1 = mainPart
		Y.C0 = CFrame.new(-1, 0.5, 0)
		Y.Parent = Y.Part0
	end
	
	local parts = newPart:GetChildren()
		for i = 1, #parts do
			if parts[i]:IsA("Part") then
				parts[i].Anchored = false
			end
		end
	mainPart.BrickColor = newColor
end
local function CreateRightLeg()
	local newPart = NewChar:WaitForChild("RightLeg"):clone()
	newPart.Parent = character
	mainPart = newPart:FindFirstChild("RightLegPart")
	local newParts = newPart:GetChildren()
	for i = 1, #newParts do
		if newParts[i]:IsA("Part") then
			local W = Instance.new("Weld")
			W.Part0 = mainPart
			W.Part1 = newParts[i]
			local CJ = CFrame.new(mainPart.Position)
			local C0 = mainPart.CFrame:inverse() * CJ
			local C1 = newParts[i].CFrame:inverse() * CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = mainPart
		end
		local Y = Instance.new("Weld")
		Y.Part0 = character:FindFirstChild("RightLowerLeg")
		Y.Part1 = mainPart
		Y.C0 = CFrame.new(0.8, -0.5, 0)
		Y.Parent = Y.Part0
	end
	
	local parts = newPart:GetChildren()
		for i = 1, #parts do
			if parts[i]:IsA("Part") then
				parts[i].Anchored = false
			end
		end
	mainPart.BrickColor = newColor
end
local function CreateRightArm()
	local newPart = NewChar:WaitForChild("RightArm"):clone()
	newPart.Parent = character
	mainPart = newPart:FindFirstChild("RightArmPart")
	local newParts = newPart:GetChildren()
	for i = 1, #newParts do
		if newParts[i]:IsA("Part") then
			local W = Instance.new("Weld")
			W.Part0 = mainPart
			W.Part1 = newParts[i]
			local CJ = CFrame.new(mainPart.Position)
			local C0 = mainPart.CFrame:inverse() * CJ
			local C1 = newParts[i].CFrame:inverse() * CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = mainPart
		end
		local Y = Instance.new("Weld")
		Y.Part0 = character:FindFirstChild("RightHand")
		Y.Part1 = mainPart
		Y.C0 = CFrame.new(1, 0.5, 0)
		Y.Parent = Y.Part0
	end
	
	local parts = newPart:GetChildren()
		for i = 1, #parts do
			if parts[i]:IsA("Part") then
				parts[i].Anchored = false
			end
		end
	mainPart.BrickColor = newColor
end

CreateTorso()
CreateLeftLeg()
CreateLeftArm()
CreateRightLeg()
CreateRightArm()



end)
end)
end)


