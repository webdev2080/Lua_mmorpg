Item = require(script.Parent)

Weapons = {}
Weapons.__index = Weapons
setmetatable(Weapons,Item)

function Weapons.new(id, name, itemType, tier, model, attack, enhancement)
	local newWeapons = Item.new(id, name, itemType, tier, model)
	setmetatable(newWeapons, Item)

	newWeapons.Attack = attack
	newWeapons.Enhancement = enhancement

	return newWeapons
end

return Weapons
