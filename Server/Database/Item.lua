local GenerateID = require(game.ServerScriptService.Utility.Generate_ID)
Item = {}

Item.__index = Item

function Item.new(id, name, itemType, tier, model)
	local newItem = {}
	setmetatable(newItem, Item)
	
	newItem.Id = 0
	newItem.Name = name
	newItem.Type = itemType
	newItem.Tier = tier
	newItem.Model = model
	
	return newItem	
end

function Item:getData()
	for index, val in pairs (self) do
		print(index, val)
	end
end

local function AttachItem(Model, Accessory)-- Character & Item 
	Accessory.Parent = Model
	local HandleAttachment = Accessory.Handle:FindFirstChildOfClass("Attachment") -- Find accessory attachment
	local CharacterAttachment do -- Find character attachment
		for i, v in ipairs(Model:GetDescendants()) do
			--print(i.." "..v.Name)
			if v.Name == HandleAttachment.Name and not v:FindFirstAncestorOfClass("Accessory") then
				CharacterAttachment = v
				break
			end
		end
	end

	--| Destroy any previous welds.
	for _, v in ipairs(Model:GetDescendants()) do
		if v.ClassName == "Weld" and v.Name == "AccessoryWeld" then
			v:Destroy()
		end
	end
	
	--| Replace the weld with a Motor6D instead.
	local AttachmentWeld = Instance.new("Motor6D")
	AttachmentWeld.Part0 = CharacterAttachment.Parent
	AttachmentWeld.Part1 = HandleAttachment.Parent
	AttachmentWeld.C0 = CharacterAttachment.CFrame
	AttachmentWeld.C1 = HandleAttachment.CFrame
	AttachmentWeld.Name = Accessory.Name
	AttachmentWeld.Parent = Accessory
end

function Item:EquipItem(player, location)	--Location on body for equipping		--TODO
	print("Equipping item")
	local item = self.Model:Clone()
	AttachItem(player.Character, item)		
end

function Item:AddItem(location)	--Add to folder location in playerdata (inventory / equipment etc)
	local newItem = Instance.new("Folder", location)
	local newID = GenerateID.generate()
	newItem.Name = self.Name .. newID
	
	for index, val in pairs(self) do
		if (index ~= "Name") then
			if (typeof(val) == "string") then
				local newString = Instance.new("StringValue", newItem)
				newString.Value = val
				newString.Name = index	
			elseif (typeof(val) == "number") then
				local newNumber = Instance.new("NumberValue", newItem)
				newNumber.Name = index
				newNumber.Value = val
			elseif (typeof(val) == "boolean") then
				local newBoolean = Instance.new("BoolValue", newItem)
				newBoolean.Name = index
				newBoolean.Value = val
			end
		end
	end
	newItem.Id.Value = newID
end

return Item
