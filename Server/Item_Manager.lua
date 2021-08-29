local Item_Data = {}

local Weapons = require(script.Parent.Item.Weapons)
local Armor = require(script.Parent.Item.Armor)
local ItemModels = game.ServerStorage.Database.Item_Models

--ID Decoding
-- 1000 Weapons
-- 2000 Armor
-- 3000 Effect Items (Potions, Scrolls)
-- 4000 Material

--[WEAPON] id, name, itemType, tier, model, attack, enhancement
--[ARMOR] id, name, itemType, tier, model, defense, enhancement
Gear = {
	BasicSword = Weapons.new(1000, "Basic Sword", "1H Sword", 1, ItemModels["Weapons"].BasicSword, 10, 0),
	BackSword = Armor.new(2000, "Back Sword", "Chest", 1, ItemModels["Armor"].BackSword, 20, 0)
	--BasicChest = Armor.new(2000, "Basic Chestplate", "Chest", 1, ItemModels.BasicChest, 20, 0)
}

function Item_Data:getGear()
	return Gear
end


--wait(10)
--print("Creating Sword")
--BasicSword:AddItem(game.ServerStorage.PlayerData:FindFirstChild("Logicarbon").Char1.Inventory_Items)
--BasicSword:EquipItem("Logicarbon", "RightHand")
--BasicChest:AddItem(game.ServerStorage.PlayerData:FindFirstChild("Player2-2").Char1.Inventory_Items)
--print('Done')


return Item_Data
