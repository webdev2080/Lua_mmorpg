local player = game.Players.LocalPlayer
local getCharData = game.ReplicatedStorage:FindFirstChild("getCharData")

local UI = script.Parent

local function updateUI(data)
	
	--Character Menu
	UI.Character.info.Text = "Level "..data.level.." "..data.class
	UI.Character.Center.Damage.value.Text = data.damage
	UI.Character.Center.Defense.value.Text = data.defense
	UI.Character.Center.Energy.value.Text = data.energy.." / "..data.maxEnergy
	UI.Character.Center.Health.value.Text = data.health.." / "..data.maxHealth
	
	--Viewport
	--print("Resetting Viewport")
	UI.Character.CharView.ViewportHandler.Disabled = true
	wait(0.5)
	UI.Character.CharView.ViewportHandler.Disabled = false
	
	--Health Bar / Energy Bar
	local energyP = (data.maxEnergy / data.energy) * 100
	local healthP = (data.maxHealth / data.health) * 100
	UI.EnergyBar.currentEnergy.energyInfo.Text = data.energy.."  ["..energyP.."%]"
	UI.EnergyBar.currentEnergy.dropshadow.Text = data.energy.."  ["..energyP.."%]"
	UI.HealthBar.currentHealth.healthInfo.Text = data.health.."  ["..healthP.."%]"
	UI.HealthBar.currentHealth.dropshadow.Text = data.health.."  ["..healthP.."%]"
end


getCharData.OnClientEvent:Connect(function(data) updateUI(data)end)
