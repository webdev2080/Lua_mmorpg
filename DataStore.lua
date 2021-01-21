local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

DataStore = {}

local Constants = require(script.Parent.Parent.Constants)
local Data_Template = require(script.Parent.Data_Template)

local DataStore = game:GetService("DataStoreService")
local GameData = DataStore:GetDataStore(Constants.GameDataStores.Dev)

local DeSerialize = require(script.Parent.DeSerialize)
local Serialize = require(script.Parent.Serialize)

--Functions
function removePlayerData(playerID)
	pcall(function()
		GameData:RemoveAsync(playerID)
	end)
end

function RemoveData(player)
	local GameData = ServerStorage:FindFirstChild("PlayerData"):GetChildren()
	for index, val in pairs(GameData) do
		if (val.Name == (player.Name..player.UserId)) then
			val:Remove()
			print("Removed "..player.Name.."'s Data From Server")
		else
			print("No Data to remove")
		end
	end

end

--Events 

game.Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " (" .. player.UserId .. ")" .. " joined the game...")

	local retrieved

	local didSucceed, errorMessage = pcall(function()
		retrieved = GameData:GetAsync(player.UserId)
	end)

	if didSucceed then
		if retrieved ~= nil then
			print("Data retrieved for " .. player.Name .. ": ")
			--Create saved player data into ServerStorage
			DeSerialize:CreateData(player, retrieved)
		else
			print("No data found...")
			local playerData = DeSerialize:CreateData(player, Data_Template)
		end
	else
		warn(errorMessage)
	end	
end)


game.Players.PlayerRemoving:Connect(function(player)
	print(player.Name .. " (" .. player.UserId .. ")" .. " left the game...")
	
	
	
	local didSucceed, errorMessage = pcall(function()
		local PlayerData = Serialize:SerializeData(player)
		GameData:SetAsync(player.UserId, PlayerData)
	end)
	print("Saving data...")
	if didSucceed then
		print(player.Name .. " data saved successfully!")
		RemoveData(player)
	else
		print("There was an issue saving " .. player.Name .. "'s data!")
		warn(errorMessage)
	end
end)

----For Non_Dev Servers
--game:BindToClose(function()
--	for _, client in ipairs(game.Players:GetPlayers()) do
--		coroutine.wrap(SaveData(client))
--	end
--end)

return DataStore
