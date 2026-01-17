local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoid()
	local char = getCharacter()
	return char:WaitForChild("Humanoid")
end

local function resetCamera()
	local humanoid = getHumanoid()

	local oldCamera = workspace.CurrentCamera
	if oldCamera then
		oldCamera:Destroy()
	end

	local newCamera = Instance.new("Camera")
	newCamera.Name = "PlayerCamera"
	newCamera.CameraType = Enum.CameraType.Custom
	newCamera.CameraSubject = humanoid
	newCamera.FieldOfView = 70
	newCamera.Parent = workspace

	workspace.CurrentCamera = newCamera
end

local function isViewingOtherPlayer()
	local cam = workspace.CurrentCamera
	if not cam then
		return true
	end

	local humanoid = getHumanoid()

	if cam.CameraSubject ~= humanoid then
		if cam.CameraSubject and cam.CameraSubject:IsA("Humanoid") then
			return true
		end

		if cam.CameraSubject and cam.CameraSubject:IsA("BasePart") then
			if not cam.CameraSubject:IsDescendantOf(player.Character) then
				return true
			end
		end
	end

	if cam.CameraType ~= Enum.CameraType.Custom then
		return true
	end

	return false
end

RunService.RenderStepped:Connect(function()
	if isViewingOtherPlayer() then
		resetCamera()
	end
end)

player.CharacterAdded:Connect(function()
	task.wait(0.1)
	resetCamera()
end)

resetCamera()
