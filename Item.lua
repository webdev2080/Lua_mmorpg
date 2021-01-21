local GenerateID = require(game.ServerScriptService.Utility.Generate_ID)
Item = {}

Item.__index = Item

function Item.new(id, name, itemType, tier, model)
	local newItem = {}
	setmetatable(newItem, Item)
	
	newItem.Id = GenerateID:generate()
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

function Item:AddItem(location)
	local newItem = Instance.new("Folder", location)
	newItem.Name = self.Name .. self.Id
	
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
end

return Item
