-- Tram Cute Fly v13
local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")
local flying = false
local speed = 2

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		flying = not flying
		Char = Player.Character
		HRP = Char:WaitForChild("HumanoidRootPart")
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if flying then
		local moveDirection = Vector3.new(0, 0, 0)
		if UIS:IsKeyDown(Enum.KeyCode.W) then
			moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.LookVector)
		end
		if UIS:IsKeyDown(Enum.KeyCode.S) then
			moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.LookVector)
		end
		if UIS:IsKeyDown(Enum.KeyCode.A) then
			moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.RightVector)
		end
		if UIS:IsKeyDown(Enum.KeyCode.D) then
			moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.RightVector)
		end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			moveDirection = moveDirection + Vector3.new(0, 1, 0)
		end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
			moveDirection = moveDirection - Vector3.new(0, 1, 0)
		end
		HRP.Velocity = moveDirection.Unit * speed
	end
end)