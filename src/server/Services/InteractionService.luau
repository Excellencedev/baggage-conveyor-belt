-- Handles server-side interactions with bags

local Workspace = game:GetService("Workspace")

local InteractionService = {}

local function onBagClicked(player: Player, bag: BasePart)
	print("SERVER: Player " .. player.Name .. " clicked bag ID: " .. bag.Name)
end

function InteractionService.Init()
	local bagsFolder = Workspace:WaitForChild("Bags")
	
	-- Listen for new bags being added
	bagsFolder.ChildAdded:Connect(function(child)
		if child:IsA("BasePart") then
			local clickDetector = child:WaitForChild("ClickDetector", 5)
			if clickDetector then
				clickDetector.MouseClick:Connect(function(player)
					onBagClicked(player, child)
				end)
			end
		end
	end)
	
	-- Connect existing bags if any
	for _, child in bagsFolder:GetChildren() do
		if child:IsA("BasePart") then
			local clickDetector = child:FindFirstChild("ClickDetector")
			if clickDetector then
				clickDetector.MouseClick:Connect(function(player)
					onBagClicked(player, child)
				end)
			end
		end
	end
	
	print("Interaction Service: Server side initialized.")
end

return InteractionService
