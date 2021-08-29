local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local character = player.Character
if not character or not character.Parent then
	character = player.CharacterAdded:wait()
end
local humanoid = character:WaitForChild("Humanoid")

local camera = workspace.CurrentCamera
local intro = true -- Move to player data for "starting" 
local cloneLocation = workspace.SpawnPart
local tempClone = nil
local classes = nil
local currentSelection = ""

--References
local GearHandlerSkin = require(game.ReplicatedStorage.GearHandlerSkin)
local Tweener = require(game.ReplicatedStorage.GUITweens)
local ReplicatedStorage = game.ReplicatedStorage

--Remotes for loading/creating/respawning chars
local newChar = ReplicatedStorage:FindFirstChild("createCharacter")
local loadChar = ReplicatedStorage:FindFirstChild("loadCharacter")
local respawnChar = ReplicatedStorage:FindFirstChild("respawnCharacter")

--Selection Ability for characters
local Chars = script.Parent.CharacterSelect.holder:GetChildren()
local Classes = script.Parent.CharacterSelect.classes:GetChildren()

--Get Classes
local classesRemote = ReplicatedStorage:WaitForChild("getClasses")

function getClassData()
	--print("GET CLASS DATA : RUNNING")
	classes = classesRemote:InvokeServer()	--get latest classes from remote func
end

function getSavedData()
	local checkChars = ReplicatedStorage:FindFirstChild("checkCharacters")
	checkChars:FireServer(player)
end

function preventReset()
	coroutine.wrap(function()
		local timeout = 1
		local t = tick()
		while not pcall(game.StarterGui.SetCore, game.StarterGui, "ResetButtonCallback", false) and tick()-t<timeout do
			wait()
		end
	end)()
end

function lookAtPlayer(fakePlayer) --Cam in front of player
	local Camera = workspace.CurrentCamera
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.CameraSubject = fakePlayer.Humanoid
	Camera.CFrame = CFrame.new((fakePlayer.HumanoidRootPart.CFrame * CFrame.new(-2, 0, -8)).Position, fakePlayer.Head.Position) * CFrame.fromEulerAnglesXYZ(0,0,0)  
end

function CamToPlayer()
	--camera.CameraSubject = character.Humanoid
	camera.CameraType = "Custom"
	camera.CameraSubject = player.Character.Humanoid
	camera.CFrame = character.Head.CFrame
end

function animateClone(fakePlayer) --Animates
	--local Anim = game.ReplicatedStorage.Animate:Clone()
	local Anim = fakePlayer.Animate
	Anim.Parent = fakePlayer
	local anim = fakePlayer.Humanoid:LoadAnimation(Anim.idle.Animation1)
	anim:Play()
end


function clonePlayer()	--Clones Player
	character.Archivable = true
	local newClone = ReplicatedStorage.tempCloneChar:Clone()
	newClone.Parent = workspace
	newClone.Humanoid.WalkSpeed = 0
	newClone.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	newClone.HumanoidRootPart.CFrame = cloneLocation.CFrame
	tempClone = newClone
end

--Start Beginning Loop of Character Setup
preventReset()
clonePlayer()	-- Begin Clone
lookAtPlayer(tempClone) --Cam set
GearHandlerSkin:addSkin(tempClone, "White") --add skin / color (Accepts Brick Color Names)
animateClone(tempClone) --Animate the Clone
--------------------Setup Complete

script.Parent.CharacterSelect.Visible = true
script.Parent.CharacterSelect.classes.Visible = false
script.Parent.CharacterSelect.holder.Visible = true


--Manage Items (Move in future out of this script) Remove equipitem call in start game
local itemHandler = ReplicatedStorage:FindFirstChild("itemHandler")
--TEST TODO1

function blackout()
	script.Parent.black.Visible = true
	script.Parent.black.BackgroundTransparency = 1
	local Info = TweenInfo.new(1)
	local Tween = game:GetService("TweenService"):Create(script.Parent.black,Info,{BackgroundTransparency=0})
	Tween:Play()
end

function viewMainUI()
	local t = script.Parent
	t.EnergyBar.Visible = true
	t.HealthBar.Visible = true
	t.MenuItems.Visible = true
	t.expBar.Visible = true
	t.hotBar.Visible = true
end

function resetUI()
	script.Parent.CharacterSelect.Visible = true
	script.Parent.CharacterSelect.classes.Visible = false
	script.Parent.CharacterSelect.holder.Visible = true
	for i = 1, #Chars do
		if Chars[i]:IsA("TextButton") then
			Chars[i].Selected = false
			Chars[i].Visible = true
		end
	end
end

function hideMainUI()
	local t = script.Parent
	t.EnergyBar.Visible = false
	t.HealthBar.Visible = false
	t.MenuItems.Visible = false
	t.expBar.Visible = false
	t.hotBar.Visible = false
end

function Startgame(val,slot) --Val is only used for class name for new char, slot is char1-2-3 etc
	--Check if its a new char, or load previous
	if (table.find(classes, val)) then
		newChar:FireServer(player,val,slot)
	else
		loadChar:FireServer(player, slot)
	end

	script.Parent.CharacterSelect.Visible = false
	blackout()
	intro = false
	wait(1)
	CamToPlayer()
	tempClone:Remove()
	viewMainUI()
	wait(5)
	script.Parent.black.Visible = false
	player.Character.Humanoid.WalkSpeed = 18
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	itemHandler:FireServer(player,"Char1","BasicSword","RightHand","equip")----------------------------------------------------------------------REMOVE FOR TEST
	itemHandler:FireServer(player,"Char1","BackSword","Chest","equip")	
end

function checkSlot(button) --Handles if they selected a new char, or a saved one
	if (button.Text == "New Character") then --If its a new char
		for i = 1, #Chars do
			if (Chars[i]:IsA("TextButton"))then
				Chars[i].Visible = false
				wait(0.05)
			end
		end
		
		script.Parent.CharacterSelect.classes.Visible = true
		
		for x = 1, #Classes do
			if (Classes[x]:IsA("TextButton")) then
				Classes[x].Selected = false
				Classes[x].MouseButton1Click:Connect(function() Classes[x].Selected = true Startgame(Classes[x].Name,button.Name) end)
			end
		end
		
	else --Saved slot selected
		script.Parent.CharacterSelect.Play.Visible = true
		script.Parent.CharacterSelect.Play.MouseButton1Click:Connect(function() Startgame("saved", currentSelection) end)
	end
end

function selectChar()
	getClassData()
	getSavedData()
	player.Character.Humanoid.WalkSpeed = 0
	for i = 1, #Chars do
		if (Chars[i]:IsA("TextButton")) then
			Chars[i].MouseButton1Click:Connect(function()
				for x = 1, #Chars do
					if (Chars[x]:IsA("TextButton")) then
						Chars[x].Selected = false
					end
				end
				Chars[i].Selected = true
				currentSelection = Chars[i].Name
				checkSlot(Chars[i])
			end)
		end
	end
end

function changeCharacter()
	intro = true
	script.Parent.Help.Visible = false
	blackout()
	wait(1.1)
	hideMainUI()
	resetUI()
	preventReset()
	clonePlayer()	-- Begin Clone
	GearHandlerSkin:addSkin(tempClone, "White") --add skin / color (Accepts Brick Color Names)
	animateClone(tempClone) --Animate the Clone
	wait(2)
	script.Parent.black.Visible = false
	lookAtPlayer(tempClone) --Cam set
	selectChar()
end

script.Parent.Help.Holder.holder.changeCharacter.Select.MouseButton1Click:Connect(function()changeCharacter()end)

selectChar()










