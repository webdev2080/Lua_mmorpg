DataStore = require(script.Parent.Data.DataStore)

----Remote Events
local checkCharacters = Instance.new("RemoteEvent", game.ReplicatedStorage)
checkCharacters.Name = "checkCharacters"

local createCharacter = Instance.new("RemoteEvent", game.ReplicatedStorage)
createCharacter.Name = "createCharacter"

local loadCharacter = Instance.new("RemoteEvent", game.ReplicatedStorage)
loadCharacter.Name = "loadCharacter"

local respawnCharacter = Instance.new("RemoteEvent", game.ReplicatedStorage)
respawnCharacter.Name = "respawnCharacter"

local getCharData = Instance.new("RemoteEvent", game.ReplicatedStorage)
getCharData.Name = "getCharData"

local itemHandler = Instance.new("RemoteEvent", game.ReplicatedStorage)
itemHandler.Name = "itemHandler"

--Remote Functions
local getClasses = Instance.new("RemoteFunction", game.ReplicatedStorage)
getClasses.Name = "getClasses"

--References
Item_Data = require(game.ServerStorage.Database.Item.Item_Manager)
Remotes = require(game.ServerScriptService.Remotes)
print("Main...Running...")


--Client > Server Invokes
checkCharacters.OnServerEvent:Connect(Remotes.checkChars)
createCharacter.OnServerEvent:Connect(Remotes.newChar)
loadCharacter.OnServerEvent:Connect(Remotes.loadChar)
respawnCharacter.OnServerEvent:Connect(Remotes.respawnChar)
itemHandler.OnServerEvent:Connect(Remotes.itemHandler)

--Client > Server > Client 
getClasses.OnServerInvoke = Remotes.getClasses



--Respawn Handler
game:GetService('Players').PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			player.CharacterAdded:Wait()
			Remotes:respawnChar(player)
		end)
	end)
end)






