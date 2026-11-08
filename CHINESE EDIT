
-- [[ Notification Library - Exact Original Structure & Positioning ]]
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันหา Container ให้อยู่บนสุดเสมอ (รองรับ gethui และ CoreGui)
local function getParentContainer()
	if gethui then
		return gethui()
	end
	local success, result = pcall(function()
		return CoreGui
	end)
	if success and result then
		return result
	end
	return LocalPlayer:WaitForChild("PlayerGui")
end

local NotificationLib = {}
NotificationLib.__index = NotificationLib

function NotificationLib.new()
	local self = setmetatable({}, NotificationLib)
	return self
end

function NotificationLib:Send(textMessage, holdTime)
	holdTime = holdTime or 1.8 -- Default hold 1.8 วินาทีตามต้องการ

	-- สร้าง ScreenGui หลัก (DisplayOrder สูงสุด อยู่บนสุดทุก UI)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "noti"
	screenGui.DisplayOrder = 2147483647
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.ResetOnSpawn = false
	screenGui.Parent = getParentContainer()

	-- CanvasGroup เต็มจอ เพื่อทำ Animation Fade In / Fade Out ทั้งก้อนโดยไม่เพี้ยนสเกลเดิม
	local canvasGroup = Instance.new("CanvasGroup", screenGui)
	canvasGroup.Name = "FadeWrapper"
	canvasGroup.Size = UDim2.new(1, 0, 1, 0)
	canvasGroup.BackgroundTransparency = 1
	canvasGroup.GroupTransparency = 1 -- เริ่มต้นโปร่งใสสำหรับ Fade In

	-- ==========================================
	-- โครงสร้างองค์ประกอบเดิมของคุณเป๊ะๆ
	-- ==========================================

	-- 1. StarterGui.noti.tete (ImageLabel หลัก)
	local tete = Instance.new("ImageLabel", canvasGroup)
	tete.Name = "tete"
	tete.ZIndex = 4
	tete.BorderSizePixel = 0
	tete.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tete.Image = "rbxassetid://87671727851169"
	tete.Size = UDim2.new(0.70434, 0, 0.59265, 0)
	tete.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tete.BackgroundTransparency = 1
	tete.Position = UDim2.new(0.12559, 0, 0.37941, 0)

	-- StarterGui.noti.tete.UIAspectRatioConstraint
	local teteAspect = Instance.new("UIAspectRatioConstraint", tete)
	teteAspect.AspectRatio = 2.05955

	-- StarterGui.noti.tete.TextLabel
	local textLabel = Instance.new("TextLabel", tete)
	textLabel.Name = "TextLabel"
	textLabel.TextWrapped = true
	textLabel.BorderSizePixel = 0
	textLabel.TextSize = 14
	textLabel.TextScaled = true
	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.Size = UDim2.new(0.6253, 0, 0.37221, 0)
	textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.Text = textMessage or "你好"
	textLabel.Position = UDim2.new(0.32892, 0, 0.52605, 0)

	-- StarterGui.noti.tete.TextLabel.UIAspectRatioConstraint
	local textAspect = Instance.new("UIAspectRatioConstraint", textLabel)
	textAspect.AspectRatio = 3.46

	-- 2. StarterGui.noti.upf (ImageLabel รูปโปรไฟล์ - ลูกของ ScreenGui/Wrapper โดยตรงตามต้นฉบับ)
	local upf = Instance.new("ImageLabel", canvasGroup)
	upf.Name = "upf"
	upf.BorderSizePixel = 0
	upf.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	upf.Image = "rbxassetid://0"
	upf.Size = UDim2.new(0.34114, 0, 0.60147, 0)
	upf.BorderColor3 = Color3.fromRGB(0, 0, 0)
	upf.BackgroundTransparency = 1
	upf.Position = UDim2.new(0, 0, 0.39853, 0)

	-- StarterGui.noti.upf.UIAspectRatioConstraint
	local upfAspect = Instance.new("UIAspectRatioConstraint", upf)
	upfAspect.AspectRatio = 0.98289

	-- ==========================================
	-- Scripts เดิมของคุณ
	-- ==========================================

	-- ShakeScript (สำหรับ tete)
	local runConnection
	local clock = 0
	local MAX_ANGLE = 0.6 
	local SPEED = 12
	local baseRotation = tete.Rotation
	
	runConnection = RunService.Heartbeat:Connect(function(dt)
		if not tete or not tete.Parent then
			if runConnection then runConnection:Disconnect() end
			return
		end
		clock += dt
		local angle = math.sin(clock * SPEED) * MAX_ANGLE
		tete.Rotation = baseRotation + angle
	end)

	-- HeadshotScript (สำหรับ upf)
	task.spawn(function()
		if not LocalPlayer then return end
		local userId = LocalPlayer.UserId
		local thumbType = Enum.ThumbnailType.HeadShot
		local thumbSize = Enum.ThumbnailSize.Size420x420
		
		local success, content = pcall(function()
			return Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
		end)
		if success and content then
			upf.Image = content
		else
			task.spawn(function()
				local ok, retryContent = pcall(function()
					return Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
				end)
				if ok and retryContent then
					upf.Image = retryContent
				end
			end)
		end
	end)

	-- ==========================================
	-- Animation Fade In / Fade Out & Hold
	-- ==========================================
	
	-- Fade In (0.3 วินาที)
	TweenService:Create(canvasGroup, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()

	-- Hold & Fade Out
	task.spawn(function()
		task.wait(holdTime)
		
		local fadeOutTween = TweenService:Create(canvasGroup, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {GroupTransparency = 1})
		fadeOutTween:Play()
		
		fadeOutTween.Completed:Wait()
		if runConnection then
			runConnection:Disconnect()
		end
		screenGui:Destroy()
	end)
end

-- ==========================================
-- วิธีการใช้งาน
-- ==========================================


-- ============================================================
--  DBD_DIA - LocalPlayer Animations Only (FIXED)
-- ============================================================
local AUDIO_URL_BGS  = "https://raw.githubusercontent.com/UNYAR1N/DBD_DIA/main/bdbdiamusic.mp3"
local AUDIO_URL_MANS = "https://raw.githubusercontent.com/UNYAR1N/DBD_DIA/main/Kobe%20Bryant%20MAN%20Sound%20Effect.mp3"
local AUDIO_URL_WCIS = "https://raw.githubusercontent.com/UNYAR1N/DBD_DIA/main/Kobe%20Bryant%20What%20Can%20I%20Say%20Sound%20Effect.mp3"

local FOLDER_PATH = "storage/DBD_DIA"
local FILE_BGS    = "bgs"
local FILE_MANS   = "mans"
local FILE_WCIS   = "wcis"

local TEAM_NAME      = "Killer"
local MAX_VOLUME     = 2.5
local MUFFLED_VOLUME = 0.8
local PLAYBACK_SPEED = 1.25

-- ระยะใหม่ (Studs)
local ZONE_FULL_END      = 100
local ZONE_MUFFLE_START  = 200
local ZONE_MUFFLE_END    = 320
local ZONE_OFF           = 360

-- Equalizer (ทำเสียงใต้น้ำ)
local NORMAL_HIGH_GAIN   = 0
local MUFFLED_HIGH_GAIN  = -40

-- ความเร็ว Fade
local VOLUME_FADE = 6
local GAIN_LERP   = 4

-- ไอดีแอนิเมชัน (อัปเดตเพิ่มตัวใหม่แล้ว)
local TARGET_ANIM_IDS = {
    ["81486769001455"] = true,
    ["118019257172845"] = true,
    ["126081405469607"] = true,
    ["83873880822918"] = true,
    ["132353867344883"] = true, -- เพิ่มใหม่
    ["126751859125353"] = true  -- เพิ่มใหม่
}

-- ============================================================
-- 1. ล้างข้อมูลเก่าและเสียงที่ซ้อนกันอยู่
-- ============================================================
if _G.DBD_DIA_Running then
    if _G.DBD_DIA_Heartbeat then _G.DBD_DIA_Heartbeat:Disconnect() end
    if _G.DBD_DIA_AnimPlayed and typeof(_G.DBD_DIA_AnimPlayed) == "table" then
        for _, conn in ipairs(_G.DBD_DIA_AnimPlayed) do
            if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
        end
    end
end
_G.DBD_DIA_Running = true
_G.DBD_DIA_AnimPlayed = {}

-- ล้างเสียง BGS เก่าใน SoundService
local SoundService = game:GetService("SoundService")
for _, obj in ipairs(SoundService:GetChildren()) do
    if obj.Name == "DBD_DIA_BGS" or obj.Name == "DBD_DIA_Group" then
        obj:Destroy()
    end
end

-- ============================================================
-- 2. ตรวจสอบ Executor และ Pre-load Assets
-- ============================================================
local writefile      = writefile
local isfile         = isfile
local isfolder       = isfolder or function(p) return pcall(isfile, p) end
local makefolder     = makefolder
local getcustomasset = getcustomasset or getsynasset


if not isfolder(FOLDER_PATH) then makefolder(FOLDER_PATH) end

local function loadAsset(fileName, url)
    local path = FOLDER_PATH .. "/" .. fileName
    if isfile(path) then
    else
        local ok, data = pcall(function() return game:HttpGet(url) end)
        if ok and data and #data > 0 then
            writefile(path, data)
        else
            return nil
        end
    end
    local success, asset = pcall(function() return getcustomasset(path) end)
    if not success or not asset then return nil end
    return asset
end

local bgsAssetUrl  = loadAsset(FILE_BGS, AUDIO_URL_BGS)
local mansAssetUrl = loadAsset(FILE_MANS, AUDIO_URL_MANS)
local wcisAssetUrl = loadAsset(FILE_WCIS, AUDIO_URL_WCIS)


-- ============================================================
-- 3. Services & Variables
-- ============================================================
local Players    = game:GetService("Players")
local Teams      = game:GetService("Teams")
local RunService = game:GetService("RunService")
local player     = Players.LocalPlayer

local killerVisibleState = {} 
local nextWcisAllowed = 0     

-- ============================================================
-- 4. สร้างเพลง BGS (Singleton ใน SoundService)
-- ============================================================
local currentGroup = Instance.new("SoundGroup")
currentGroup.Name   = "DBD_DIA_Group"
currentGroup.Volume = 1
currentGroup.Parent = SoundService

local currentEqualizer = Instance.new("EqualizerSoundEffect")
currentEqualizer.Name       = "UnderwaterEQ"
currentEqualizer.HighGain   = NORMAL_HIGH_GAIN
currentEqualizer.Parent     = currentGroup

local currentSound = Instance.new("Sound")
currentSound.Name          = "DBD_DIA_BGS"
currentSound.SoundId       = bgsAssetUrl
currentSound.Looped        = true
currentSound.Volume        = 0
currentSound.PlaybackSpeed = PLAYBACK_SPEED
currentSound.SoundGroup    = currentGroup
currentSound.Parent        = SoundService

-- ============================================================
-- 5. ฟังก์ชันเล่นเสียง (mans / wcis)
-- ============================================================
local function playMansSound()
    local myChar = player.Character
    if not myChar then return end
    local root = myChar:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local mansSound = Instance.new("Sound")
    mansSound.Name = "DBD_DIA_MansSound"
    mansSound.SoundId = mansAssetUrl
    mansSound.Volume = 2.5
    mansSound.PlaybackSpeed = 1.0 + math.random() * 0.6
    mansSound.RollOffMaxDistance = math.huge 
    mansSound.Parent = root
    mansSound:Play()

    mansSound.Ended:Connect(function() mansSound:Destroy() end)
    task.delay(10, function() if mansSound and mansSound.Parent then mansSound:Destroy() end end)
end

local function playWcisSound()
    local myChar = player.Character
    if not myChar then return end
    local root = myChar:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local wcisSound = Instance.new("Sound")
    wcisSound.Name = "DBD_DIA_WcisSound"
    wcisSound.SoundId = wcisAssetUrl
    wcisSound.Volume = 2.5
    wcisSound.Parent = root
    wcisSound:Play()

    wcisSound.Ended:Connect(function() wcisSound:Destroy() end)
    task.delay(10, function() if wcisSound and wcisSound.Parent then wcisSound:Destroy() end end)
end

-- ============================================================
-- 6. ฟังก์ชันดักจับแอนิเมชัน (เฉพาะ LocalPlayer เท่านั้น!)
-- ============================================================
local function hookLocalPlayerAnimations(char)
    local humanoid = char:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator", 5)
    if not animator then return end

    -- ป้องกันไม่ให้ Hook ซ้ำซ้อน
    if animator:GetAttribute("DBD_DIA_Hooked") then return end
    animator:SetAttribute("DBD_DIA_Hooked", true)

    local conn = animator.AnimationPlayed:Connect(function(track)
        local animId = track.Animation and track.Animation.AnimationId or ""
        local numericId = string.match(animId, "%d+")
        
        if numericId and TARGET_ANIM_IDS[numericId] then
            playMansSound()
        end
    end)
    table.insert(_G.DBD_DIA_AnimPlayed, conn)
end

-- เรียกใช้งานแค่กับตัวละครของ LocalPlayer เท่านั้น!
if player.Character then
    hookLocalPlayerAnimations(player.Character)
end
player.CharacterAdded:Connect(hookLocalPlayerAnimations)

-- ============================================================
-- 7. คำนวณระยะ (BGS)
-- ============================================================
local function getNearestKillerDistanceFromCamera()
    local camera = workspace.CurrentCamera
    if not camera then return math.huge end
    local camPos = camera.CFrame.Position
    
    local killerTeam = Teams:FindFirstChild(TEAM_NAME)
    if not killerTeam then return math.huge end

    local nearest = math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Team == killerTeam then
            local char = plr.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local d = (camPos - root.Position).Magnitude
                    if d < nearest then nearest = d end
                end
            end
        end
    end
    return nearest
end

local function computeTargets(dist)
    if dist <= ZONE_FULL_END then
        return MAX_VOLUME, NORMAL_HIGH_GAIN
    elseif dist <= ZONE_MUFFLE_START then
        local t = (dist - ZONE_FULL_END) / (ZONE_MUFFLE_START - ZONE_FULL_END)
        return MAX_VOLUME + (MUFFLED_VOLUME - MAX_VOLUME) * t,
               NORMAL_HIGH_GAIN + (MUFFLED_HIGH_GAIN - NORMAL_HIGH_GAIN) * t
    elseif dist <= ZONE_MUFFLE_END then
        return MUFFLED_VOLUME, MUFFLED_HIGH_GAIN
    elseif dist <= ZONE_OFF then
        local t = (dist - ZONE_MUFFLE_END) / (ZONE_OFF - ZONE_MUFFLE_END)
        return MUFFLED_VOLUME * (1 - t), MUFFLED_HIGH_GAIN
    else
        return 0, MUFFLED_HIGH_GAIN
    end
end

-- ============================================================
-- 8. ระบบตรวจจับการลับตา Killer
-- ============================================================
local visCheckTimer = 0
local function checkKillerVisibility(dt)
    visCheckTimer += dt
    if visCheckTimer < 0.1 then return end
    visCheckTimer = 0

    local localChar = player.Character
    if not localChar then return end
    local myHead = localChar:FindFirstChild("Head")
    if not myHead then return end

    local killerTeam = Teams:FindFirstChild(TEAM_NAME)
    if not killerTeam then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Team == killerTeam then
            local killerChar = plr.Character
            if killerChar then
                local killerHead = killerChar:FindFirstChild("Head") or killerChar:FindFirstChild("HumanoidRootPart")
                
                if killerHead then
                    local rayOrigin = myHead.Position
                    local rayDirection = (killerHead.Position - rayOrigin)
                    
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                    raycastParams.FilterDescendantsInstances = {localChar}

                    local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                    
                    local isVisible = false
                    if rayResult then
                        if rayResult.Instance:IsDescendantOf(killerChar) then
                            isVisible = true
                        end
                    else
                        isVisible = true
                    end

                    local wasVisible = killerVisibleState[plr] or false
                    
                    if wasVisible and not isVisible then
                        if tick() >= nextWcisAllowed then
                            playWcisSound()
                            
                            
                            local noti = NotificationLib.new()

-- รวมประโยคภาษาจีนล้วนๆ
local messages = {
    "慢了一步哦",
    "太慢了吧",
    "有本事就追上我啊",
    "你是乌龟吗？",
    "看得见吗？",
    "过来这里！",
    "差一点就中了",
    "我要说什么来着"
}

-- สุ่มเลือกข้อความ 1 ประโยค
local randomMsg = messages[math.random(#messages)]

-- ส่งแจ้งเตือน
noti:Send(randomMsg, 1.8)

                            
                            nextWcisAllowed = tick() + math.random(8, 12)
                        end
                    end
                    killerVisibleState[plr] = isVisible
                end
            end
        end
    end
end

-- ============================================================
-- 9. Loop หลัก (Heartbeat)
-- ============================================================
_G.DBD_DIA_Heartbeat = RunService.Heartbeat:Connect(function(dt)
    checkKillerVisibility(dt)

    if not currentSound or not currentEqualizer then return end

    local dist = getNearestKillerDistanceFromCamera()
    local targetVol, targetHighGain = computeTargets(dist)

    local curVol = currentSound.Volume
    if curVol < targetVol then
        currentSound.Volume = math.min(curVol + VOLUME_FADE * dt, targetVol)
    elseif curVol > targetVol then
        currentSound.Volume = math.max(curVol - VOLUME_FADE * dt, targetVol)
    end

    local curGain = currentEqualizer.HighGain
    if math.abs(targetHighGain - curGain) > 0.5 then
        local t = math.min(dt * GAIN_LERP, 1)
        currentEqualizer.HighGain = curGain + (targetHighGain - curGain) * t
    else
        currentEqualizer.HighGain = targetHighGain
    end

    if targetVol > 0.01 then
        if not currentSound.IsPlaying then 
            currentSound:Play() 
        end
    else
        if currentSound.IsPlaying then 
            currentSound:Stop() 
        end
    end
end)
