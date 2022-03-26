--[[

Made by Supadownload for group 825742
Do not edit. Do not copy. Do not distribute.

--]]


local EquipRFunction = game:GetService("ReplicatedStorage"):WaitForChild("EquipRFunction")
local Equips = require(script.Equips)
local Players = game:GetService("Players")

local playerTable = {}

local function AddToTable(plr)
	table.insert(playerTable, plr)
end

local function RemoveFromTable(plr)
	local plrIndex = table.find(playerTable, plr)
	if plrIndex then
		table.remove(playerTable, plrIndex)
	end
end

local function EquipFunction(player, info)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			if table.find(playerTable, player) then
				return false
			else
				humanoid.Died:Connect(function()
					RemoveFromTable(player)
				end)
				AddToTable(player)
				humanoid.MaxHealth = humanoid.MaxHealth + (Equips.GetHealth(info))
				print(player, "used an equip item: ",info)
				return true
			end
		end
	end
	return false
end

Players.PlayerRemoving:Connect(function(player)
	RemoveFromTable(player)
end)

EquipRFunction.OnServerInvoke = EquipFunction
