-- Main.server.luau
-- Initializes all server-side services

local Server = script.Parent
local Services = Server.Services

local ConveyorService = require(Services.ConveyorService)
local SpawnerService = require(Services.SpawnerService)
local InteractionService = require(Services.InteractionService)

-- Initialize services
ConveyorService.Init()
SpawnerService.Init()
InteractionService.Init()

print("Server: All services initialized.")
