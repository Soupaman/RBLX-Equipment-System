--will be editing this in the future --Supa

local Equips = {}

Equips["Basic Shield"] = {
	Health = 60
}

Equips["XuRal"] = {
	Health = 400
}

function Equips.GetHealth(EquipName)
	return Equips[EquipName].Health
end

return Equips
