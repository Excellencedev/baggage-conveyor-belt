-- Handles the movement of bags along the conveyor belt

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))

local ConveyorService = {}

-- Reference to the bags folder
local bagsFolder = Workspace:FindFirstChild("Bags")
if not bagsFolder then
	bagsFolder = Instance.new("Folder")
	bagsFolder.Name = "Bags"
	bagsFolder.Parent = Workspace
end

-- Movement Loop
local function onHeartbeat(dt: number)
	local bags = bagsFolder:GetChildren()
	
	for _, bag in bags do
		if bag:IsA("BasePart") and bag.Anchored and not bag:GetAttribute("IsDespawning") then
			-- Pure CFrame movement forward along Z axis
			bag.CFrame = bag.CFrame * CFrame.new(0, 0, Constants.CONVEYOR_SPEED * dt)
			
			-- Check if reached end of conveyor
			if bag.Position.Z >= Constants.DESPAWN_POSITION.Z then
				-- We might need a reference to the despawn logic or handle it here
				-- For simplicity, let's keep the despawn logic internal or in a shared module
				-- If we want to keep it simple, we can just destroy or handle animation here
				-- I previously had it in the .server.luau
				
				-- Let's re-implement the despawn animation here or in a separate handler
				if not bag:GetAttribute("IsDespawning") then
					bag:SetAttribute("IsDespawning", true)
					task.spawn(function()
						-- Local tween for despawn
						local ts = game:GetService("TweenService")
						local ti = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In)
						local mesh = bag:FindFirstChildOfClass("SpecialMesh")
						
						if mesh then
							ts:Create(mesh, ti, {Scale = Vector3.new(0, 0, 0)}):Play()
						end
						
						local t = ts:Create(bag, ti, {
							Transparency = 1,
							CFrame = bag.CFrame * CFrame.Angles(0, math.rad(360), 0)
						})
						t:Play()
						t.Completed:Connect(function()
							bag:Destroy()
						end)
					end)
				end
			end
		end
	end
end

function ConveyorService.Init()
	RunService.Heartbeat:Connect(onHeartbeat)
	print("Conveyor Service: Heartbeat loop started.")
end

return ConveyorService
