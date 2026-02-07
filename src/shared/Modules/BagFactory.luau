-- BagFactory.luau
-- Responsible for creating and configuring bag instances

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))

local BagFactory = {}
local rng = Random.new()

function BagFactory.CreateBag(): BasePart
	-- We use a standard Part as the base to GUARANTEE visibility.
	local newBag = Instance.new("Part")
	newBag.Name = "Bag_" .. HttpService:GenerateGUID(false)
	
	-- Physics & Properties
	newBag.Size = Vector3.new(2, 1.2, 3) -- More bag-shaped (Length, Height, Depth)
	newBag.Anchored = true
	newBag.CanCollide = true
	newBag.Transparency = 0 
	newBag.TopSurface = Enum.SurfaceType.Smooth
	newBag.BottomSurface = Enum.SurfaceType.Smooth
	
	-- Click detector for interaction (Task 7.1)
	local clickDetector = Instance.new("ClickDetector")
	clickDetector.Parent = newBag

	-- Random Material & Color
	local materials = Constants.BAG_MATERIALS
	local randomMaterial = materials[rng:NextInteger(1, #materials)]
	newBag.Material = randomMaterial
	
	local colors = Constants.BAG_COLORS
	local randomColor = colors[rng:NextInteger(1, #colors)]
	newBag.Color = randomColor
	
	-- Fallback/Visual: The Part itself is the Bag
	newBag.Color = randomColor
	newBag.Material = randomMaterial
	
	-- Add Mesh as a separate child so it doesn't overwrite the Part's rendering (Task Sync)
	local meshPart = Instance.new("Part")
	meshPart.Name = "MeshVisual"
	meshPart.Transparency = 1 -- Hide the part, show the mesh
	meshPart.CanCollide = false
	meshPart.Anchored = false -- We will weld it
	meshPart.Size = Vector3.new(0.1, 0.1, 0.1)
	meshPart.Parent = newBag
	
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.FileMesh
	mesh.MeshId = Constants.BAG_ASSET_ID
	mesh.TextureId = "" 
	mesh.Scale = Vector3.new(1.5, 1.5, 1.5)
	mesh.VertexColor = Vector3.new(randomColor.R, randomColor.G, randomColor.B)
	mesh.Parent = meshPart
	
	-- Weld mesh to bag
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = newBag
	weld.Part1 = meshPart
	weld.Parent = newBag
	
	return newBag
end

return BagFactory
