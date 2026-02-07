-- Handles the movement of bags along the conveyor belt

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Shared.Constants)

-- Reference to the bags folder
local bagsFolder = Workspace:FindFirstChild("Bags")
if not bagsFolder then
	bagsFolder = Instance.new("Folder")
	bagsFolder.Name = "Bags"
	bagsFolder.Parent = Workspace
end

-- Movement Loop
local function onHeartbeat(dt: number)
	local bags = bagsFolder:GetChildren()
	
	for _, bag in bags do
		if bag:IsA("BasePart") and bag.Anchored then
			-- Pure CFrame movement forward along Z axis
			-- We multiply by dt to ensure frame-rate independence
			bag.CFrame = bag.CFrame * CFrame.new(0, 0, Constants.CONVEYOR_SPEED * dt)
		end
	end
end

RunService.Heartbeat:Connect(onHeartbeat)

print("Conveyor Service: Movement logic initialized.")
