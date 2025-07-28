-- 🌸 Tram Cute Fly v3 - Speed 100 + Nút bay lên/xuống + Kéo được (Mobile)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- GUI setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TramCuteFlyFull"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 120, 0, 50)
frame.Position = UDim2.new(0.5, -60, 0.85, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
frame.Active = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1, 0, 1, 0)
btn.Position = UDim2.new(0, 0, 0, 0)
btn.BackgroundColor3 = Color3.fromRGB(255, 160, 200)
btn.Text = "🌸 Fly 🌸"
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 20
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

-- Nút bay lên
local up = Instance.new("TextButton", gui)
up.Size = UDim2.new(0, 50, 0, 50)
up.Position = UDim2.new(1, -60, 0.6, 0)
up.Text = "⬆"
up.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
up.TextColor3 = Color3.fromRGB(255,255,255)
up.Font = Enum.Font.GothamBold
up.TextSize = 25
Instance.new("UICorner", up).CornerRadius = UDim.new(0, 12)

-- Nút bay xuống
local down = Instance.new("TextButton", gui)
down.Size = UDim2.new(0, 50, 0, 50)
down.Position = UDim2.new(1, -60, 0.7, 0)
down.Text = "⬇"
down.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
down.TextColor3 = Color3.fromRGB(255,255,255)
down.Font = Enum.Font.GothamBold
down.TextSize = 25
Instance.new("UICorner", down).CornerRadius = UDim.new(0, 12)

-- Bay logic
local flying = false
local speed = 100
local bp = nil
local vertical = 0 -- Lên/xuống

btn.MouseButton1Click:Connect(function()
	flying = not flying
	btn.Text = flying and "❌ Unfly" or "🌸 Fly 🌸"

	if flying then
		bp = Instance.new("BodyPosition")
		bp.Name = "TramCuteFloat"
		bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bp.P = 10000
		bp.Position = hrp.Position
		bp.Parent = hrp
	else
		if hrp:FindFirstChild("TramCuteFloat") then
			hrp.TramCuteFloat:Destroy()
		end
	end
end)

-- Bay chính
RunService.Heartbeat:Connect(function()
	if flying and bp and humanoid then
		local dir = humanoid.MoveDirection
		local move = Vector3.new(0, vertical, 0)
		if dir.Magnitude > 0 then
			move = move + dir.Unit * speed
		end
		bp.Position = hrp.Position + move
	end
end)

-- Xử lý lên/xuống
up.MouseButton1Down:Connect(function()
	vertical = speed
end)
up.MouseButton1Up:Connect(function()
	vertical = 0
end)
down.MouseButton1Down:Connect(function()
	vertical = -speed
end)
down.MouseButton1Up:Connect(function()
	vertical = 0
end)

-- Kéo GUI bằng cảm ứng
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
frame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
