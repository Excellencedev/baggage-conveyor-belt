-- SpawnerService.server.luau
-- Authoritatively handles bag creation on the server

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))
local BagFactory = require(Shared:WaitForChild("Modules"):WaitForChild("BagFactory"))

-- State
local currentInterval = Constants.DEFAULT_SPAWN_INTERVAL

-- Reference to the bags folder
local bagsFolder = Workspace:FindFirstChild("Bags")
if not bagsFolder then
	bagsFolder = Instance.new("Folder")
	bagsFolder.Name = "Bags"
	bagsFolder.Parent = Workspace
end

-- Function to spawn a single bag
local function spawnBag()
	local newBag = BagFactory.CreateBag()
	
	-- Ensure correct position and parenting
	newBag.CFrame = CFrame.new(Constants.SPAWN_POSITION)
	newBag.Parent = bagsFolder
	
	print("Bag successfully added to Workspace.Bags at " .. tostring(newBag.Position))
end

-- Spawning Loop
task.spawn(function()
	while true do
		task.wait(currentInterval)
		spawnBag()
	end
end)

-- API
local SpawnerService = {}
function SpawnerService.SetInterval(newInterval: number)
	currentInterval = math.clamp(newInterval, Constants.MIN_SPAWN_INTERVAL, Constants.MAX_SPAWN_INTERVAL)
end

_G.SpawnerService = SpawnerService

print("Spawner Service: Initialized and spawning bags.")

return SpawnerService
