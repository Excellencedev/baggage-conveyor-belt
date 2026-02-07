-- UIController.server.luau
-- Manages UI ownership and permission for the conveyor control panel

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Events = Shared:WaitForChild("Events")
local SpawnerService = require(game:GetService("ServerScriptService").Server.Services.SpawnerService)

local SetIntervalEvent = Events:WaitForChild("SetInterval")
local AssignControllerEvent = Events:WaitForChild("AssignController")

-- State
local currentController: Player? = nil

local function assignNewController()
	local allPlayers = Players:GetPlayers()
	if #allPlayers > 0 then
		currentController = allPlayers[1] -- Assign first available
		if currentController then
			AssignControllerEvent:FireClient(currentController, true)
			print("UI Controller: Assigned control to " .. currentController.Name)
		end
	else
		currentController = nil
	end
end

-- Listen for players joining
Players.PlayerAdded:Connect(function(player)
	if not currentController then
		currentController = player
		AssignControllerEvent:FireClient(player, true)
		print("UI Controller: Assigned control to first player: " .. player.Name)
	else
		-- Ensure non-controllers know they aren't the one
		AssignControllerEvent:FireClient(player, false)
	end
end)

-- Listen for players leaving
Players.PlayerRemoving:Connect(function(player)
	if player == currentController then
		currentController = nil
		print("UI Controller: Controller left, re-assigning...")
		task.wait(1) -- Small delay to ensure player list is updated
		assignNewController()
	end
end)

-- Handle SetInterval requests
SetIntervalEvent.OnServerEvent:Connect(function(player, newInterval)
	-- Security Check: Only the controller can change settings
	if player ~= currentController then
		warn("UI Controller: Unauthorized attempt to set interval by " .. player.Name)
		return
	end
	
	if typeof(newInterval) ~= "number" then
		warn("UI Controller: Invalid interval type from " .. player.Name)
		return
	end
	
	-- Update the SpawnerService
	SpawnerService.SetInterval(newInterval)
end)

print("UI Controller: Server logic initialized.")
