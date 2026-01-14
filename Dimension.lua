if getgenv().Executed then
    return
end
getgenv().Executed = true

task.spawn(function()
local Players = game:GetService("Players")
local protectedPosition = Vector3.new(
	-697.584961,
	248.523666,
	751.720093
)
local closestPart = nil
local shortestDistance = math.huge
for _, obj in ipairs(workspace:GetDescendants()) do
	if obj:IsA("BasePart") then
		local distance = (obj.Position - protectedPosition).Magnitude
		if distance < shortestDistance then
			shortestDistance = distance
			closestPart = obj
		end
	end
end

if not closestPart then
	return
end

for _, obj in ipairs(workspace:GetDescendants()) do
	if obj:IsA("BasePart") then
		if obj == closestPart then
			continue
		end
		if Players:GetPlayerFromCharacter(obj.Parent) then
			continue
		end
		obj:Destroy()
	end
end
end)
task.wait(1)
-- Instances
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local BlueSkybox = Instance.new("Sky")
BlueSkybox.SkyboxBk = "rbxassetid://16269815885"
BlueSkybox.SkyboxDn = "rbxassetid://16269839652"
BlueSkybox.SkyboxFt = "rbxassetid://16269798011"
BlueSkybox.SkyboxLf = "rbxassetid://114269624906246"
BlueSkybox.SkyboxRt = "rbxassetid://16269814948"
BlueSkybox.SkyboxUp = "rbxassetid://16269829700"
BlueSkybox.SunTextureId = "rbxassetid://109499512560744"
BlueSkybox.MoonTextureId = "rbxassetid://109499512560744"
BlueSkybox.SunAngularSize = 150
BlueSkybox.MoonAngularSize = 150
BlueSkybox.Parent = Lighting
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
RunService.RenderStepped:Connect(function()
    Lighting.ClockTime = 14
end)
-- Functions
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local refPos = Vector3.new(-697.584961, 248.523666, 751.720093)
local targetPos = Vector3.new(-100000, 100000, -100000)
local nearest, dist = nil, math.huge
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("Part") then
        local d = (v.Position - refPos).Magnitude
        if d < dist then
            dist = d
            nearest = v
        end
    end
end
if nearest then
    nearest.Size = Vector3.new(2000, 1, 2000)
    nearest.Position = targetPos
    nearest.Orientation = Vector3.new(0, 0, 0)
    nearest.Anchored = true
    nearest.Transparency = 1
    nearest.CanCollide = true
    local function teleportPlayer()
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0))
        end
    end
    teleportPlayer()
    RunService.RenderStepped:Connect(function()
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local platformPos = nearest.Position
            local dx = math.abs(hrp.Position.X - platformPos.X)
            local dz = math.abs(hrp.Position.Z - platformPos.Z)
            local dy = hrp.Position.Y - platformPos.Y
            if dx > nearest.Size.X/2 or dz > nearest.Size.Z/2 or dy > 1000 or dy < -50 then
                teleportPlayer()
            end
        end
    end)
end
game:GetService("Players").LocalPlayer.PlayerGui.NoResetGUIHandler.TopCornerDetails.Clock:Destroy()
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://5799870105"
Sound.Volume = 1
Sound.Looped = true
Sound.Parent = workspace
Sound:Play()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local function shouldRemove(player)
	if player == LocalPlayer then
		return false
	end
	local success, isFriend = pcall(function()
		return LocalPlayer:IsFriendsWith(player.UserId)
	end)
	return not (success and isFriend)
end
local function removeCharacter(player)
	if shouldRemove(player) and player.Character then
		player.Character:Destroy()
	end
end
for _, player in ipairs(Players:GetPlayers()) do
	removeCharacter(player)
	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		removeCharacter(player)
	end)
end
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		removeCharacter(player)
	end)
end)
workspace.Vehicles:Destroy()
