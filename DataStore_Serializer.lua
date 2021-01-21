--Takes the players data and creates it into the DataStore
local ServerStorage = game:GetService("ServerStorage")
local Serialize = {}


function Serialize:CreateData(player, folder, data)
	data = data or {}

	for index, val in pairs(folder:GetChildren()) do
		if (val.ClassName == 'Folder') then
			data[val.Name] = Serialize:CreateData(player, val)
		elseif (val.ClassName == 'IntValue' or val.ClassName == 'NumberValue' or val.ClassName == 'StringValue' or val.ClassName == 'BoolValue') then
			data[val.Name] = val.Value
		end
	end

	return data
end

function Serialize:SerializeData(player)
	local PlayerFolder

	local Data = ServerStorage:WaitForChild("PlayerData")
	local folders = Data:GetChildren()

	for index, val in pairs(folders) do
		if (val.Name == (player.Name..player.UserId)) == true then
			return Serialize:CreateData(player, val)
		else
			print("No Player Data Folder")
		end
	end

end

return Serialize

