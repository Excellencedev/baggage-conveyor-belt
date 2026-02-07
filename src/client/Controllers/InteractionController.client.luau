-- InteractionController.client.luau
-- Handles client-side interactions with bags

local Workspace = game:GetService("Workspace")

local bagsFolder = Workspace:WaitForChild("Bags")

local function onBagClicked(bag: BasePart)
	print("CLIENT: Clicked bag ID: " .. bag.Name)
end

local function setupBag(bag: BasePart)
	local clickDetector = bag:WaitForChild("ClickDetector", 5)
	if clickDetector then
		clickDetector.MouseClick:Connect(function()
			onBagClicked(bag)
		end)
	end
end

-- Listen for new bags
bagsFolder.ChildAdded:Connect(function(child)
	if child:IsA("BasePart") then
		setupBag(child)
	end
end)

-- Setup existing bags
for _, child in bagsFolder:GetChildren() do
	if child:IsA("BasePart") then
		setupBag(child)
	end
end

print("Interaction Controller: Client side initialized.")
