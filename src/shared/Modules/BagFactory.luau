-- Responsible for creating and configuring bag instances

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))
local Assets = Shared:WaitForChild("Assets")

local BagFactory = {}

function BagFactory.CreateBag(): MeshPart
	local baseBag = Assets:WaitForChild("Bag")
	local newBag = baseBag:Clone()
	
	-- Unique ID for the bag
	newBag.Name = "Bag_" .. HttpService:GenerateGUID(false)
	
	-- Random Material
	local materials = Constants.BAG_MATERIALS
	newBag.Material = materials[math.random(1, #materials)]
	
	-- Random Color
	local colors = Constants.BAG_COLORS
	newBag.Color = colors[math.random(1, #colors)]
	
	-- Ensure it's ready for placement
	newBag.Anchored = true
	newBag.CanCollide = true
	
	return newBag
end

return BagFactory
