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
		
		if obj:IsDescendantOf(workspace.WorkspaceCom["001_TrafficCones"]) then
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
do
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function isFriend(player)
	if player == LocalPlayer then
		return true
	end

	local ok, result = pcall(function()
		return LocalPlayer:IsFriendsWith(player.UserId)
	end)

	return ok and result
end

local function wipeCharacter(player)
	if isFriend(player) then
		return
	end
	if player.Character then
		player.Character:BreakJoints()
		player.Character:Destroy()
	end
end

local function wipeAnyCharacterModel(model)
	if not model:IsA("Model") then
		return
	end

	local player = Players:GetPlayerFromCharacter(model)
	if not player then
		return
	end

	if isFriend(player) then
		return
	end

	model:BreakJoints()
	model:Destroy()
end

for _, player in ipairs(Players:GetPlayers()) do
	wipeCharacter(player)
	player.CharacterAdded:Connect(function(char)
		task.wait()
		wipeCharacter(player)
	end)
end
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait()
		wipeCharacter(player)
	end)
end)
workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("Model") then
		wipeAnyCharacterModel(obj)
	end
end)
end
workspace.Vehicles:Destroy()
RunService.RenderStepped:Connect(function()
workspace.FallenPartsDestroyHeight = 0/0
end)
game:GetService("Players").LocalPlayer.PlayerScripts.BulletVisualizerScript.Disabled = true
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local function IsFromPlayer(obj)
	local model = obj:FindFirstAncestorOfClass("Model")
	if not model then return false end
	return Players:GetPlayerFromCharacter(model) ~= nil
end
local function CheckAndDestroy(obj)
	if not obj:IsA("BasePart") then return end
	if obj.Anchored then return end
	if not obj.CanCollide then return end
	if IsFromPlayer(obj) then return end
	obj:Destroy()
end
for _, obj in ipairs(Workspace:GetDescendants()) do
	CheckAndDestroy(obj)
end
Workspace.DescendantAdded:Connect(function(obj)
	task.wait()
	CheckAndDestroy(obj)
end)
do
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Folder = workspace:WaitForChild("WorkspaceCom"):WaitForChild("001_TrafficCones")
local function isFriend(playerName)
	local targetPlayer = Players:FindFirstChild(playerName)
	if not targetPlayer then
		return false
	end
	local success, result = pcall(function()
		return LocalPlayer:IsFriendsWith(targetPlayer.UserId)
	end)
	return success and result
end
local function handleModel(model)
	if not model:IsA("Model") then
		return
	end
	local name = model.Name
	if not name:sub(1, 4) == "Prop" then
		return
	end
	local playerName = name:sub(5)
	if playerName == "" then
		return
	end
	if not isFriend(playerName) then
		model:Destroy()
	end
end
for _, obj in ipairs(Folder:GetChildren()) do
	handleModel(obj)
end
Folder.ChildAdded:Connect(function(obj)
	task.wait(0.1)
	handleModel(obj)
end)
end
workspace["001_Lots"]:Destroy()
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local localPlayer = Players.LocalPlayer
TextChatService.OnIncomingMessage = function(message)
	if not message.TextSource then
		return
	end
	local speaker = Players:GetPlayerByUserId(message.TextSource.UserId)
	if not speaker then
		return
	end
	if speaker == localPlayer then
		return
	end
	if localPlayer:IsFriendsWith(speaker.UserId) then
		return
	end
	local props = Instance.new("TextChatMessageProperties")
	props.Text = ""
	props.PrefixText = ""
	props.BackgroundTransparency = 1
	props.TextTransparency = 1
	props.PrefixTextTransparency = 1
	return props
end
workspace.Baseplate:Destroy()
