Item = require(script.Parent)

Armor = {}
Armor.__index = Armor
setmetatable(Armor,Item)

function Armor.new(id, name, itemType, tier, model, defense, enhancement)
	local newArmor = Item.new(id, name, itemType, tier, model)
	setmetatable(newArmor, Item)
	
	newArmor.Defense = defense
	newArmor.Enhancement = enhancement
	
	return newArmor
end

return Armor
