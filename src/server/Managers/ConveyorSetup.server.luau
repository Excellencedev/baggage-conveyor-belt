-- Generates the physical Conveyor Belt model in Workspace

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Shared.Constants)

local function createConveyor()
	if Workspace:FindFirstChild("ConveyorSystem") then
		warn("ConveyorSystem already exists. Skipping generation.")
		return
	end

	local conveyorFolder = Instance.new("Folder")
	conveyorFolder.Name = "ConveyorSystem"
	conveyorFolder.Parent = Workspace

	-- Main Belt
	local belt = Instance.new("Part")
	belt.Name = "Belt"
	belt.Anchored = true
	belt.CanCollide = true
	-- Length based on constants, Width 8, Height 1
	belt.Size = Vector3.new(8, 1, Constants.CONVEYOR_LENGTH) 
	-- Center it so it starts near 0,0,0 or looks nice
	-- If Length is 100, center is at 50 to make it range from 0 to 100?
	-- Let's make the StartPoint at 0,0,0.
	-- So center is at (0, 0.5, Length/2)
	belt.Position = Vector3.new(0, 0.5, Constants.CONVEYOR_LENGTH / 2)
	belt.Material = Enum.Material.DiamondPlate
	belt.Color = Color3.fromRGB(50, 50, 50)
	belt.Parent = conveyorFolder

	-- Visual Start Point
	local startPoint = Instance.new("Part")
	startPoint.Name = "StartPoint"
	startPoint.Anchored = true
	startPoint.CanCollide = false
	startPoint.Size = Vector3.new(8, 0.2, 2)
	startPoint.Position = Vector3.new(0, 1.1, 0) -- Slightly above belt at Z=0
	startPoint.Color = Color3.fromRGB(0, 255, 0)
	startPoint.Material = Enum.Material.Neon
	startPoint.Parent = conveyorFolder

	-- Visual End Point
	local endPoint = Instance.new("Part")
	endPoint.Name = "EndPoint"
	endPoint.Anchored = true
	endPoint.CanCollide = false
	endPoint.Size = Vector3.new(8, 0.2, 2)
	endPoint.Position = Vector3.new(0, 1.1, Constants.CONVEYOR_LENGTH) -- At Z=100
	endPoint.Color = Color3.fromRGB(255, 0, 0)
	endPoint.Material = Enum.Material.Neon
	endPoint.Parent = conveyorFolder

	print("ConveyorSystem generated successfully.")
end

createConveyor()
