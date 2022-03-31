--[[

Made by Supadownload for group 825742
Do not edit. Do not copy. Do not distribute.

--]]


local EquipRFunction = game:GetService("ReplicatedStorage"):WaitForChild("EquipRFunction")
local EquipModelsStorage = game:GetService("ServerStorage").SupaWSystemSStorage.Equipables
local Players = game:GetService("Players")
local Equips = require(script.Equips)

local WeldCopy = Instance.new("WeldConstraint")
local ModelCopy = Instance.new("Model")

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
	if not info then
		warn(player.Name .. " tried using an equipment item without permission.")
		return 3
	end
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			if table.find(playerTable, player) then
				return 2
			else
				player.CharacterRemoving:Connect(function()
					RemoveFromTable(player)
				end)
				AddToTable(player)
				humanoid.MaxHealth = 100 + (Equips.GetHealth(info.Name))
				local EquipModel = EquipModelsStorage[info.Name]
				print(EquipModel)
				if EquipModel then
					EquipModel = EquipModel:Clone()

					local Weld = Instance.new("WeldConstraint")
					local ModelHolder = Instance.new("Model")
					ModelHolder.Parent = character
					
					EquipModel.Handle.CFrame = character["Left Arm"].CFrame * CFrame.Angles(0,math.rad(90),0) * CFrame.new(0,.15,-0.59)
					Weld.Part0 = character["Left Arm"]
					Weld.Part1 = EquipModel.Handle
					Weld.Parent = Weld.Part0
					for _,v in pairs(EquipModel:GetChildren()) do
						if v:IsA("BasePart") then
							v.Parent = ModelHolder
						end
					end
					EquipModel:Destroy()
					
					ModelHolder.Parent = character
				end
				
				print(player, "used an equip item: ",info.Name)
				return 1
			end
		end
	end
	return 2
end

Players.PlayerRemoving:Connect(function(player)
	RemoveFromTable(player)
end)

EquipRFunction.OnServerInvoke = EquipFunction
