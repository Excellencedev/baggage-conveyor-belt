-- SpawnerService.luau
-- Authoritatively handles bag creation on the server

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))
local BagFactory = require(Shared:WaitForChild("Modules"):WaitForChild("BagFactory"))

local SpawnerService = {}

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
end

function SpawnerService.SetInterval(newInterval: number)
	currentInterval = math.clamp(newInterval, Constants.MIN_SPAWN_INTERVAL, Constants.MAX_SPAWN_INTERVAL)
	print("Spawner Service: Interval updated to " .. currentInterval)
end

function SpawnerService.Init()
	task.spawn(function()
		while true do
			task.wait(currentInterval)
			spawnBag()
		end
	end)
	print("Spawner Service: Initialized and spawning bags every " .. currentInterval .. " seconds.")
end

return SpawnerService
