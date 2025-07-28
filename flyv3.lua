-- Tram Cute Fly v13 - Phiên bản bay mượt như cũ
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local flying = false
local speed = 50

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying then
            local Char = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Char:WaitForChild("HumanoidRootPart")

            RS:BindToRenderStep("TramCuteFly", Enum.RenderPriority.Character.Value, function()
                local cam = workspace.CurrentCamera
                local moveDirection = Vector3.new()

                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection += cam.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection -= cam.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection -= cam.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection += cam.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection += Vector3.new(0, 1, 0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                    moveDirection -= Vector3.new(0, 1, 0)
                end

                if moveDirection.Magnitude > 0 then
                    HRP.Velocity = moveDirection.Unit * speed
                else
                    HRP.Velocity = Vector3.zero
                end
            end)
        else
            RS:UnbindFromRenderStep("TramCuteFly")
        end
    end
end)
