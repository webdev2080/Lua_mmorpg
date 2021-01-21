local ServerStorage = game:GetService("ServerStorage")

local DeSerialize = {}
--Take the data from datastore, create it in server storage folder
function DeSerialize:Decode(player, Data, Parent) 
	for index, val in pairs(Data) do
		if (type(val) == "table") then
			local folder = Instance.new("Folder", Parent)
			folder.Name = tostring(index)
			DeSerialize:Decode(player, val, folder)
		else
			if (type(val) == "number") then
				local number = Instance.new("NumberValue", Parent)
				number.Name = tostring(index)
				number.Value = val
			elseif(type(val) == "string") then
				local newString = Instance.new("StringValue", Parent)
				newString.Name = tostring(index)
				newString.Value = val
			else
				print(val)
			end
		end
	end
end
--Create players folder in server storage folder
function DeSerialize:CreateData(player, Data)
	if (ServerStorage:FindFirstChild("PlayerData")) then
		local PlayerData = Instance.new("Folder", ServerStorage.PlayerData)
		PlayerData.Name = (player.Name .. tostring(player.UserId))
		DeSerialize:Decode(player, Data, PlayerData)
		--end
	end

end

return DeSerialize
