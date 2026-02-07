-- Handles the movement of bags along the conveyor belt

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Constants = require(ReplicatedStorage.Shared.Constants)

-- Reference to the bags folder
local bagsFolder = Workspace:FindFirstChild("Bags")
if not bagsFolder then
	bagsFolder = Instance.new("Folder")
	bagsFolder.Name = "Bags"
	bagsFolder.Parent = Workspace
end

-- Function to handle bag destruction with animation (Task 5.2 & 5.3)
local function despawnBag(bag: BasePart)
	if bag:GetAttribute("IsDespawning") then return end
	bag:SetAttribute("IsDespawning", true)
	
	local mesh = bag:FindFirstChildOfClass("SpecialMesh")
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	
	-- Creative Despawn Animation: Shrink and Spin
	local goal = {
		Transparency = 1,
		CFrame = bag.CFrame * CFrame.Angles(0, math.rad(360), 0)
	}
	
	if mesh then
		TweenService:Create(mesh, tweenInfo, {Scale = Vector3.new(0, 0, 0)}):Play()
	else
		goal.Size = Vector3.new(0.1, 0.1, 0.1)
	end
	
	local tween = TweenService:Create(bag, tweenInfo, goal)
	tween:Play()
	
	tween.Completed:Connect(function()
		bag:Destroy()
	end)
end

-- Movement Loop
local function onHeartbeat(dt: number)
	local bags = bagsFolder:GetChildren()
	
	for _, bag in bags do
		if bag:IsA("BasePart") and bag.Anchored and not bag:GetAttribute("IsDespawning") then
			-- Pure CFrame movement forward along Z axis
			bag.CFrame = bag.CFrame * CFrame.new(0, 0, Constants.CONVEYOR_SPEED * dt)
			
			-- Check if reached end of conveyor (Task 5.1)
			if bag.Position.Z >= Constants.DESPAWN_POSITION.Z then
				despawnBag(bag)
			end
		end
	end
end

RunService.Heartbeat:Connect(onHeartbeat)

print("Conveyor Service: Movement logic initialized.")
