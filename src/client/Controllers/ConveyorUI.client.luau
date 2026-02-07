-- ConveyorUI.client.luau
-- Creates and manages the control panel for the assigned player

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Constants = require(Shared:WaitForChild("Constants"))
local Events = Shared:WaitForChild("Events")

local SetIntervalEvent = Events:WaitForChild("SetInterval")
local AssignControllerEvent = Events:WaitForChild("AssignController")

local screenGui = nil

local function createUI()
	if screenGui then screenGui:Destroy() end
	
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ConveyorControlUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Main Frame (Clean, Dark Theme)
	local frame = Instance.new("Frame")
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 200, 0, 150)
	frame.Position = UDim2.new(0, 20, 0.5, -75)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true -- Convenient for the user
	frame.Parent = screenGui
	
	-- Rounded Corners
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame
	
	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 40)
	title.BackgroundTransparency = 1
	title.Text = "Conveyor Control"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 18
	title.Font = Enum.Font.GothamBold
	title.Parent = frame
	
	-- Input Label
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.Position = UDim2.new(0, 0, 0, 40)
	label.BackgroundTransparency = 1
	label.Text = "Spawn Interval (sec):"
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.TextSize = 12
	label.Font = Enum.Font.Gotham
	label.Parent = frame
	
	-- TextBox (Input)
	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(0.8, 0, 0, 30)
	textBox.Position = UDim2.new(0.1, 0, 0, 65)
	textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	textBox.BorderSizePixel = 0
	textBox.Text = tostring(Constants.DEFAULT_SPAWN_INTERVAL)
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.PlaceholderText = "1.0"
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 14
	textBox.Parent = frame
	
	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 4)
	boxCorner.Parent = textBox
	
	-- Update Button
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.8, 0, 0, 30)
	button.Position = UDim2.new(0.1, 0, 0, 105)
	button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
	button.BorderSizePixel = 0
	button.Text = "Update Interval"
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 14
	button.Parent = frame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = button
	
	-- Task 6.2: Input Validation & Remote Trigger
	button.MouseButton1Click:Connect(function()
		local text = textBox.Text
		local val = tonumber(text)
		
		if val then
			-- Clamp locally for immediate feedback (matching server constants)
			val = math.clamp(val, Constants.MIN_SPAWN_INTERVAL, Constants.MAX_SPAWN_INTERVAL)
			textBox.Text = tostring(val)
			
			button.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Success flash
			SetIntervalEvent:FireServer(val)
			task.wait(0.5)
			button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
		else
			textBox.Text = "INVALID"
			button.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Error flash
			task.wait(1)
			textBox.Text = tostring(Constants.DEFAULT_SPAWN_INTERVAL)
			button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
		end
	end)
end

-- Task 6.3: Assignment Listener
AssignControllerEvent.OnClientEvent:Connect(function(isController)
	if isController then
		createUI()
		print("UI: You have been assigned control of the conveyor.")
	else
		if screenGui then screenGui:Destroy() end
		print("UI: You do not have conveyor control.")
	end
end)
