-- BagFactory.luau
-- Responsible for creating and configuring bag instances

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))

local BagFactory = {}

function BagFactory.CreateBag(): BasePart
	local newBag = Instance.new("Part")
	newBag.Name = "Bag_" .. HttpService:GenerateGUID(false)
	
	-- Physical properties
	newBag.Size = Vector3.new(2, 2, 2)
	newBag.Anchored = true
	newBag.CanCollide = true
	newBag.Transparency = 0 -- FULLY VISIBLE
	
	-- Visual identifiers for debugging
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Adornee = newBag
	selectionBox.LineThickness = 0.05
	selectionBox.Color3 = Color3.fromRGB(255, 255, 0) -- Bright Yellow outline
	selectionBox.Parent = newBag

	-- Random Material & Color
	local materials = Constants.BAG_MATERIALS
	newBag.Material = materials[math.random(1, #materials)]
	
	local colors = Constants.BAG_COLORS
	newBag.Color = colors[math.random(1, #colors)]
	
	-- Add Mesh (but we keep the part visible)
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.FileMesh
	mesh.MeshId = Constants.BAG_ASSET_ID
	mesh.Scale = Vector3.new(1.5, 1.5, 1.5)
	mesh.Parent = newBag
	
	return newBag
end

return BagFactory
