--[[

Made by Supadownload for group 825742
Do not edit. Do not copy. Do not distribute.

--]]

local EquipRFunction = game:GetService("ReplicatedStorage"):WaitForChild("EquipRFunction")
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

repeat wait() until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") and game:GetService("Players").LocalPlayer.Character.Parent ~= nil

local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()

local Humanoid = Character:FindFirstChildOfClass("Humanoid")

local idle = Handle:WaitForChild("HoldAnim")
local use = Handle:WaitForChild("ShieldEquip")

local Animator = Humanoid:WaitForChild("Animator")
local IdleAnimation = Animator:LoadAnimation(idle)
local UseAnimation = Animator:LoadAnimation(use)

local Equipped = false
local Activated = false

--Tool.ShieldColor.BrickColor = game.Players.LocalPlayer.TeamColor

function onClick()
	if Equipped == false or Activated == true then return end
		Activated = true
	Handle.Sound:Play()
	--animation
	UseAnimation:Play()
	wait(UseAnimation.Length)
	--animation
	local activationCheck = EquipRFunction:InvokeServer(Tool)
	if activationCheck == 1 then
		onUnEquip()
		Tool:Destroy()
	else
		warn("The equip tool ".. Tool.Name.. " has encountered an error. Do you already have a shield equipped? EQSys Code: ".. activationCheck)
	end
	Activated = false
end

function onEquip()
	Equipped = true
	IdleAnimation:Play()
end

function onUnEquip()
	Equipped = false
	IdleAnimation:Stop()
	UseAnimation:Stop()
end

Tool.Activated:Connect(onClick)
Tool.Equipped:Connect(onEquip)
Tool.Unequipped:Connect(onUnEquip)
