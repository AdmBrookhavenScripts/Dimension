if getgenv().Executed then
    return
end
getgenv().Executed = true
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local holder = Instance.new("Frame")
holder.Size = UDim2.new(0,260,0,40)
holder.Position = UDim2.new(0,20,1,-60)
holder.BackgroundTransparency = 1
holder.Parent = gui

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1,0,0,18)
text.Position = UDim2.new(0,0,0,5)
text.BackgroundTransparency = 1
text.Text = "Fazendo download dos assets"
text.TextColor3 = Color3.fromRGB(255,255,255)
text.TextSize = 14
text.Font = Enum.Font.Gotham
text.TextXAlignment = Enum.TextXAlignment.Left
text.Parent = holder

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1,0,0,6)
barBg.Position = UDim2.new(0,0,1,-6)
barBg.BackgroundTransparency = 1
barBg.Parent = holder

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(80,255,220)
bar.Parent = barBg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = bar

local folder = "CustomSkybox"
if not isfolder(folder) then
    makefolder(folder)
end

local SkyboxFiles = {
    Up    = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Up.png",
    Down  = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Down.png",
    Front = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Front.png",
    Back  = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Back.png",
    Left  = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Left.png",
    Right = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Right.png",
    ["1000350673"] = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/1000350673.png",
    ["Mp3.mp3"]    = "https://raw.githubusercontent.com/AdmBrookhavenScripts/Skybox/main/Mp3.mp3",
}

local total = 0
for _ in pairs(SkyboxFiles) do
    total += 1
end

local done = 0

for name, url in pairs(SkyboxFiles) do
    local fileName = name

    if not fileName:match("%.") then
        fileName = fileName .. ".png"
    end

    local path = folder .. "/" .. fileName
    if not isfile(path) then
        writefile(path, game:HttpGet(url))
    end
    done += 1
    bar.Size = UDim2.new(done / total, 0, 1, 0)
end

gui:Destroy()

local function waitFile(path, timeout)
    local t = os.clock()
    while not isfile(path) do
        if os.clock() - t > (timeout or 5) then
            return false
        end
        task.wait()
    end
    return true
end

waitFile(folder.."/Up.png")
waitFile(folder.."/Down.png")
waitFile(folder.."/Front.png")
waitFile(folder.."/Back.png")
waitFile(folder.."/Left.png")
waitFile(folder.."/Right.png")

local BlueSkybox = Instance.new("Sky")
BlueSkybox.SkyboxUp = getcustomasset(folder .. "/Up.png")
BlueSkybox.SkyboxDn = getcustomasset(folder .. "/Down.png")
BlueSkybox.SkyboxFt = getcustomasset(folder .. "/Front.png")
BlueSkybox.SkyboxBk = getcustomasset(folder .. "/Back.png")
BlueSkybox.SkyboxLf = getcustomasset(folder .. "/Left.png")
BlueSkybox.SkyboxRt = getcustomasset(folder .. "/Right.png")
BlueSkybox.SunTextureId = getcustomasset(folder .. "/1000350673.png")
BlueSkybox.MoonTextureId = getcustomasset(folder .. "/1000350673.png")
BlueSkybox.SunAngularSize = 150
BlueSkybox.MoonAngularSize = 150
BlueSkybox.Parent = Lighting
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
Lighting.TimeOfDay = "14:00:00"
Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
	Lighting.ClockTime = 14
end)
RunService.RenderStepped:Connect(function()
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        local ok, isFriend = pcall(function()
            return LocalPlayer:IsFriendsWith(player.UserId)
        end)
        if not ok or not isFriend then
            player.Character:Destroy()
        end
    end
end
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        local ok, isFriend = pcall(function()
            return LocalPlayer:IsFriendsWith(player.UserId)
        end)
        if not ok or not isFriend then
            player:Destroy()
        end
    end
end
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
    nearest.Size = Vector3.new(20000, 1, 20000)
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
    task.spawn(function()
    do
    task.wait(5)
    local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 0, 70)
text.Position = UDim2.new(0.5, 0, 0.5, 0)
text.AnchorPoint = Vector2.new(0.5, 0.5)
text.BackgroundTransparency = 1
text.Text = "- Non-existent Dimension -"
text.TextColor3 = Color3.new(1, 1, 1)
text.TextTransparency = 1
text.TextStrokeTransparency = 1
text.Font = Enum.Font.SciFi
text.TextSize = 40
text.TextXAlignment = Enum.TextXAlignment.Center
text.TextYAlignment = Enum.TextYAlignment.Center
text.Parent = gui

local fadeIn = TweenService:Create(
	text,
	TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{TextTransparency = 0, TextStrokeTransparency = 0.3}
)

local fadeOut = TweenService:Create(
	text,
	TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	{TextTransparency = 1, TextStrokeTransparency = 1}
)

fadeIn:Play()
fadeIn.Completed:Wait()

task.wait(3)

fadeOut:Play()
fadeOut.Completed:Wait()

gui:Destroy()
end
end)
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
local Sound1 = Instance.new("Sound")
Sound1.SoundId = getcustomasset(folder .. "/Mp3.mp3")
Sound1.Volume = 1
Sound1.Looped = true
Sound1.Parent = workspace
Sound1:Play()
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
    if not targetPlayer then return false end
    local ok, result = pcall(function()
        return LocalPlayer:IsFriendsWith(targetPlayer.UserId)
    end)
    return ok and result
end

local function handleModel(model)
    if not model:IsA("Model") then return end
    local name = model.Name
    if name:sub(1, 4) ~= "Prop" then return end
    local playerName = name:sub(5)
    if playerName == "" then return end
    if playerName == LocalPlayer.Name then return end
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

do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    TextChatService.OnIncomingMessage = function(message)
	if not message.TextSource then
		return
	end
	if message.TextSource.UserId == localPlayer.UserId then
		return
	end
	if not localPlayer:IsFriendsWith(message.TextSource.UserId) then
		local props = Instance.new("TextChatMessageProperties")
		props.Text = ""
		props.PrefixText = ""
		props.BackgroundTransparency = 1
		props.TextTransparency = 1
		props.PrefixTextTransparency = 1
		return props
	end
  end
end
localPlayer.CharacterAdded:Connect(onCharacterAdded)
if localPlayer.Character then
    onCharacterAdded(localPlayer.Character)
  end
end
workspace.Baseplate:Destroy()
local function getCharacterFromInstance(inst)
	while inst do
		if inst:IsA("Model") then
			local plr = Players:GetPlayerFromCharacter(inst)
			if plr then
				return inst
			end
		end
		inst = inst.Parent
	end
	return nil
end
local function isInsideNoMotorModel(sound)
	local parent = sound.Parent
	while parent do
		if parent:IsA("Model") and parent.Name == "NoMotorVehicleModel" then
			return true
		end
		parent = parent.Parent
	end
	return false
end
local function isFromTool(sound)
	local parent = sound.Parent
	while parent do
		if parent:IsA("Tool") then
			return true
		end
		parent = parent.Parent
	end
	return false
end
local function isFromMap(sound)
	local parent = sound.Parent
	while parent do
		if parent:IsA("BasePart") or parent:IsA("Model") then
			return true
		end
		parent = parent.Parent
	end
	return false
end
local function shouldMute(sound)
	local character = getCharacterFromInstance(sound)
	if character then
		if isInsideNoMotorModel(sound) then
			return true
		end
		return false
	end
	if isFromTool(sound) then
		return true
	end
	if isFromMap(sound) then
		return true
	end
	return false
end
local function muteSound(sound)
	if not sound:IsA("Sound") then return end
	if not shouldMute(sound) then return end
	sound.Volume = 0
	sound.Looped = false
	sound:GetPropertyChangedSignal("Volume"):Connect(function()
		if sound.Volume ~= 0 then
			sound.Volume = 0
		end
	end)
	sound:GetPropertyChangedSignal("Playing"):Connect(function()
		if sound.Playing then
			sound:Stop()
		end
	end)
end
for _, obj in ipairs(game:GetDescendants()) do
	if obj:IsA("Sound") then
		muteSound(obj)
	end
end
game.DescendantAdded:Connect(function(obj)
	if obj:IsA("Sound") then
		task.wait()
		muteSound(obj)
	end
end)
