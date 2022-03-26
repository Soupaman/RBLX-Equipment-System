--[[

Made by Supadownload for group 825742
Do not copy. Do not distrubute.

--]]



local EquipRFunction = game:GetService("ReplicatedStorage"):WaitForChild("EquipRFunction")
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

if not game.Players.LocalPlayer:HasAppearanceLoaded() then
	game.Players.LocalPlayer.CharacterAppearanceLoaded:Wait()
end

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
	local activationCheck = EquipRFunction:InvokeServer(Tool.Name)
	if activationCheck == true then
		local Weld = Instance.new("Weld")
		local Model = Instance.new("Model")
		Model.Parent = Character
		Model.Name = "Shield"
		Weld.Parent = Handle
		Weld.Part0 = Handle
		Weld.Part1 = Character["Left Arm"]
		Weld.C0 = CFrame.Angles(0,math.rad(-90),0) * CFrame.new(.59,-.15,0)
		for _,v in pairs(Tool:GetChildren()) do
			if v:IsA("BasePart") then
				v.Parent = Model
			end
		end
		Tool:Destroy()
	else
		Activated = false
		error("The equip tool ".. Tool.Name.. "has encountered an error. Do you already have a shield equipped?")
	end
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
