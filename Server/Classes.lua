local GearHandlerSkin = require(game.ReplicatedStorage.GearHandlerSkin)
local Item_Manager = require(game.ServerStorage.Database.Item.Item_Manager)

local colorTable = {
	Fighter = "Crimson",
	Paladin = "Pastel Blue",
	Mage = "Lilac",
	Archer = "Moss",
}

local classes = {	--Classes for game (Will add more later
	"Mage",
	"Paladin",
	"Fighter",
	"Archer"
}

local PlayerSlots = {
	"Char1",
	"Char2",
	"Char3",
	"Char4",
	"Char5",
	"Char6",
}

local RemoteHandler = {}

--Remote Functions


function RemoteHandler:getCharData(player) --Sends player CharData
	local currChar = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId).Settings.currentChar.Value	--current char
	local playerData = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId)[currChar].CharData
	local getCharDataRemote = game.ReplicatedStorage:FindFirstChild("getCharData")
	local data = {
		class = playerData.class.Value,
		level = playerData.level.Value,
		experience = playerData.experience.Value,
		maxExperience = playerData.maxExperience.Value,
		damage = playerData.damage.Value,
		defense = playerData.defense.Value,
		health = playerData.health.Value,
		maxHealth = playerData.maxHealth.Value,
		energy = playerData.energy.Value,
		maxEnergy = playerData.maxEnergy.Value,
	}	
	--print(data)
	getCharDataRemote:FireClient(player, data)
	
end

function RemoteHandler:getClasses()	--Latest Classes in game
	return classes
end

function RemoteHandler:checkChars(player) --Updates the players character selection GUI with active characters
	local playerData = game.ServerStorage.PlayerData:WaitForChild(player.Name..player.UserId)
	local chars = playerData:GetChildren()
	for i = 1, #chars do -- Loop through character data
		if string.sub(chars[i].Name, 0,4) == "Char" then --If its a character save slot
			if chars[i].CharData.class.Value == "none" then 
			else --If its not an empty class
				local slot = player.PlayerGui.UI.CharacterSelect.holder:FindFirstChild(chars[i].Name)
				slot.Text = "Lvl. "..chars[i].CharData.level.Value.." "..chars[i].CharData.class.Value --Change gui values
			end
		end
		
	end
end

function RemoteHandler:itemHandler(player,slot,item,location,operation) --player, char slot, item name, location to put item, operation type
	if (operation == "equip") then
		local gear = Item_Manager:getGear()
		if (gear[item]) then
			print(player)
			gear[item]:EquipItem(player, "RightHand")
		end
	end
end

function RemoteHandler:setCurrentChar(player,char) --Sets current char, NEEDS CHECKS TODO
	local playerData = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId)
	playerData.Settings.currentChar.Value = char
end

function RemoteHandler:resetCurrentChar(player)
	local playerData = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId)
	playerData.Settings.currentChar.Value = "none"
end

function RemoteHandler:newChar(player, class, slot) --Creates new character
	if (table.find(classes,class)) then	--Check class is valid
		if (table.find(PlayerSlots,slot)) then --check char is valid
			--print("REMOTE: CREATING CHARACTER")
			local playerData = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId)
			if playerData:FindFirstChild(slot).CharData.class.Value == "none" then	--make sure its an empty class
				playerData:FindFirstChild(slot).CharData.class.Value = class		--Set class
				playerData:FindFirstChild(slot).CharData.level.Value = 1			--Set level to 1
				GearHandlerSkin:addSkin(player.Character,	colorTable[class])
				RemoteHandler:setCurrentChar(player,slot)							--Set current character
				RemoteHandler:getCharData(player)
			end
		else
			warn("Invalid Class, Possible Error or Exploit")
		end
	else
		warn("Invalid Class, Possible Error or Exploit")
	end
end

function RemoteHandler:loadChar(player, slot)	--Loads saved character
	--print("REMOTE: LOADING CHARACTER")
	local playerData = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId)
	if (table.find(PlayerSlots, slot)) then
		if playerData:FindFirstChild(slot).CharData.class.Value ~= "none" and playerData.Settings.currentChar.Value ~= slot then	--Make sure its not empty, and theyre not currently using that class
			RemoteHandler:setCurrentChar(player, slot) -- Set to current char
			GearHandlerSkin:addSkin(player.Character, colorTable[playerData:FindFirstChild(slot).CharData.class.Value]) --Set player color accordingly
			RemoteHandler:getCharData(player)
			--TODO Load Player Inventory
			--TODO Load Player Equipment
			--TODO Load Player Skills
		end
	end
end

function RemoteHandler:respawnChar(player)
	local playerData = game.ServerStorage.PlayerData:FindFirstChild(player.Name..player.UserId)
	local slot = playerData.Settings.currentChar.Value
	if (table.find(PlayerSlots, slot)) then
		if playerData:FindFirstChild(slot).CharData.class.Value ~= "none" then	--Make sure its not empty an empty class
			GearHandlerSkin:addSkin(player.Character, colorTable[playerData:FindFirstChild(slot).CharData.class.Value]) --Set player color accordingly
			RemoteHandler:getCharData(player)
			
			--TODO Load Player equipped items to them
		end
	end
end

return RemoteHandler
