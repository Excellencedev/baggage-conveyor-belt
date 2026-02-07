-- Shared configuration for the Baggage Conveyor Belt system

local Constants = {}

-- Conveyor Mechanics
Constants.CONVEYOR_LENGTH = 100 -- Studs
Constants.CONVEYOR_SPEED = 5    -- Studs per second
Constants.DESPAWN_DISTANCE = Constants.CONVEYOR_LENGTH + 5

-- Coordinate Points
Constants.SPAWN_POSITION = Vector3.new(0, 2.5, 0) -- Slightly above the belt start
Constants.DESPAWN_POSITION = Vector3.new(0, 2.5, Constants.CONVEYOR_LENGTH)

-- Spawning
Constants.DEFAULT_SPAWN_INTERVAL = 1.0 -- Seconds
Constants.MIN_SPAWN_INTERVAL = 0.1
Constants.MAX_SPAWN_INTERVAL = 10.0

-- Assets
Constants.BAG_ASSET_ID = "rbxassetid://129544287"

-- Bag Visuals
Constants.BAG_MATERIALS = {
    Enum.Material.Plastic,
    Enum.Material.Neon,
    Enum.Material.SmoothPlastic,
    Enum.Material.Metal,
    Enum.Material.Wood,
}

Constants.BAG_COLORS = {
    Color3.fromHSV(0, 1, 1), -- Red
    Color3.fromHSV(0.16, 1, 1), -- Yellow
    Color3.fromHSV(0.33, 1, 1), -- Green
    Color3.fromHSV(0.5, 1, 1), -- Cyan
    Color3.fromHSV(0.66, 1, 1), -- Blue
    Color3.fromHSV(0.83, 1, 1), -- Magenta
}

-- Events
Constants.EVENT_SET_INTERVAL = "SetInterval"
Constants.EVENT_BAG_CLICKED = "BagClicked"
Constants.EVENT_ASSIGN_CONTROLLER = "AssignController"

return Constants
