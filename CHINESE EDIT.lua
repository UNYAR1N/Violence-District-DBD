loadstring(game:HttpGet("https://raw.githubusercontent.com/UNYAR1N/Violence-District-DBD/main/startdailog.lua"))()


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
local AUDIO_URL_LAU  = "https://raw.githubusercontent.com/UNYAR1N/DBD_DIA/main/kobe-bryant-laughing-made-with-Voicemod.mp3"

local FOLDER_PATH = "storage/DBD_DIA"
local FILE_BGS    = "bgs"
local FILE_MANS   = "mans"
local FILE_WCIS   = "wcis"
local FILE_LAU    = "Lau"

local TEAM_NAME      = "Killer"
local MAX_VOLUME     = 1.5
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
    ["107600098059627"] = true,
    ["95866729029878"] = true,
    ["111354281712103"] = true,
    ["71705121963639"] = true,
    ["79965656177566"] = true,
    ["136962284480779"] = true,
    ["132353867344883"] = true, 
    ["126751859125353"] = true  
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
local lauAssetUrl  = loadAsset(FILE_LAU, AUDIO_URL_LAU)

-- ============================================================
-- 3. Services & Variables
-- ============================================================
local Players    = game:GetService("Players")
local Teams      = game:GetService("Teams")
local RunService = game:GetService("RunService")
local player     = Players.LocalPlayer

local killerVisibleState = {} 
local nextWcisAllowed = 0     
local nextLauAllowed = 0

-- ตัวแปรสำหรับคิวเสียง (Lau กับ wcis เล่นทีละอัน ต้องจบก่อนค่อยเล่นอันต่อไป)
local isVoicePlaying = false   -- true = มี Lau หรือ wcis กำลังเล่นอยู่
local voiceQueue = {}          -- คิวรอเล่น เช่น {"wcis", "lau"}
local playNextVoice            -- ประกาศล่วงหน้า (forward declaration)

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
-- 5. ฟังก์ชันเล่นเสียง (mans / wcis / lau)
-- ============================================================
local function playMansSound()
    local myChar = player.Character
    if not myChar then return end
    local root = myChar:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local mansSound = Instance.new("Sound")
    mansSound.Name = "DBD_DIA_MansSound"
    mansSound.SoundId = mansAssetUrl
    mansSound.Volume = 1.5
    mansSound.PlaybackSpeed = 1.0 + math.random() * 0.4
    mansSound.RollOffMaxDistance = math.huge 
    mansSound.Parent = root
    mansSound:Play()

    mansSound.Ended:Connect(function() mansSound:Destroy() end)
    task.delay(10, function() if mansSound and mansSound.Parent then mansSound:Destroy() end end)
end

-- เล่นเสียง Lau/wcis จริง ๆ ทันที (เรียกจากระบบคิวเท่านั้น)
local function startVoice(kind)
    local myChar = player.Character
    local root = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local assetUrl = (kind == "lau") and lauAssetUrl or wcisAssetUrl

    -- ถ้าเล่นไม่ได้ (ไม่มีตัวละคร/ไม่มีไฟล์เสียง) ให้ข้ามไปอันถัดไปในคิว
    if not root or not assetUrl then
        isVoicePlaying = false
        playNextVoice()
        return
    end

    isVoicePlaying = true

    local voiceSound = Instance.new("Sound")
    voiceSound.Name = (kind == "lau") and "DBD_DIA_LauSound" or "DBD_DIA_WcisSound"
    voiceSound.SoundId = assetUrl
    voiceSound.Volume = 1.5
    voiceSound.Parent = root
    voiceSound:Play()

    local finished = false
    local function finishVoice()
        if finished then return end
        finished = true
        isVoicePlaying = false
        if voiceSound then voiceSound:Destroy() end
        playNextVoice() -- จบแล้วค่อยเล่นอันถัดไปในคิว
    end

    voiceSound.Ended:Connect(finishVoice)
    -- กันเหนียว: ถ้าเสียงโหลดไม่ขึ้น/ไม่ยิง Ended ให้ปลดล็อกหลังเวลาหนึ่ง
    task.delay(15, finishVoice)
end

playNextVoice = function()
    if isVoicePlaying then return end
    local nextKind = table.remove(voiceQueue, 1)
    if nextKind then
        startVoice(nextKind)
    end
end

-- ใส่เสียงเข้าคิว: ถ้าไม่มีอะไรเล่นอยู่จะเล่นทันที ถ้ามีจะรอให้จบก่อน
local function queueVoice(kind)
    -- กันคิวซ้ำชนิดเดียวกันซ้อนกัน
    for _, k in ipairs(voiceQueue) do
        if k == kind then return end
    end
    table.insert(voiceQueue, kind)
    playNextVoice()
end

local function playWcisSound()
    queueVoice("wcis")
end

local function playLauSound()
    queueVoice("lau")
end

-- ============================================================
-- 6. ฟังก์ชันดักจับแอนิเมชัน (เฉพาะ LocalPlayer เท่านั้น!)
-- ============================================================
local function hookLocalPlayerAnimations(char)
    local humanoid = char:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator", 5)
    if not animator then return end

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
-- 8. ระบบตรวจจับการเห็น/ลับตา Killer
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
                    
                    -- กรณีที่ 1: ลับตา (เมื่อกี้เห็น ตอนนี้ไม่เห็น)
                    if wasVisible and not isVisible then
                        if tick() >= nextWcisAllowed then
                            playWcisSound()
                            
                            local noti = NotificationLib.new()
							--[[
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
							]]
							local messages = {
    "慢了一步哦", -- ช้าไปก้าวนึงนะ
    "太慢了吧", -- ช้าเกินไปแล้วมั้ย
    "有本事就追上我啊", -- เก่งจริงก็ตามมาสิ
    "你是乌龟吗？", -- เป็นเต่าหรือไง?
    "看得见吗？", -- มองเห็นไหม?
    "过来这里！", -- มาที่นี่สิ!
    "差一点就中了", -- เกือบโดนแล้ว
    "我要说什么来着", -- เอ๊ะ จะพูดว่าอะไรนะ
    "你刚才打哪儿呢？", -- เมื่อกี้เธอตีตรงไหนน่ะ?
    "我在这儿呢", -- ฉันอยู่นี่ไง
    "看错方向了吧", -- มองผิดทางแล้วล่ะ
    "眼睛跟得上吗？", -- ตาของเธอตามทันไหม?
    "又扑空了吧", -- พลาดอีกแล้วล่ะ
    "这次也没打中", -- ครั้งนี้ก็ยังไม่โดน
    "你的准头真让人放心", -- ความแม่นของเธอนี่ทำเอาใครก็วางใจได้เลย
    "找得到我再说", -- หาเจอค่อยพูด
    "我藏好了哦", -- ฉันซ่อนตัวเรียบร้อยแล้วนะ
    "猜猜我在哪", -- เดาสิฉันอยู่ไหน
    "别东张西望了", -- อย่ามองซ้ายมองขวาไปแล้ว
    "你是在找我吗？", -- เธอกำลังหาฉันอยู่เหรอ?
    "我就在你身后……骗你的", -- ฉันอยู่ข้างหลังเธอ……ล้อเล่น
    "刚才那下挺吓人，可惜没中", -- เมื่อกี้ท่าทางน่ากลัวนะ เสียดายที่พลาด
    "差一点点，真的只差一点点", -- เกือบนะ จริง ๆ เกือบเดียวเท่านั้น
    "你的攻击挺有气势，就是打不中", -- การโจมตีของเธอมีพลังดีนะ แต่แค่ไม่โดน
    "瞄准的时候记得看前面", -- ตอนเล็งอย่าลืมมองข้างหน้า
    "我还没出力你就跟丢了", -- ฉันยังไม่ออกแรงเลย เธอตามหายไปแล้ว
    "这么容易就跟丢，真不习惯", -- ตามกันหายง่ายขนาดนี้ ไม่ชินเลยแฮะ
    "追不上就别勉强了", -- ตามไม่ทันก็อย่าฝืนเลย
    "我先走一步，你慢慢找", -- ฉันไปก่อนนะ เธอค่อย ๆ หาไป
    "别急，反正你也找不到", -- ไม่ต้องรีบ ยังไงก็หาไม่เจอ
    "你的眼神告诉我你迷路了", -- สายตาของเธอบอกว่าหลงทางแล้ว
    "看不见我了吧？", -- มองไม่เห็นฉันแล้วใช่ไหม?
    "我消失得还算及时吧？", -- ฉันหายตัวได้ทันเวลาพอดีเนอะ?
    "这一下算我让你的", -- ท่านี้ถือว่าฉันปล่อยให้เธอ
    "你是在打空气吗？", -- เธอกำลังตีอากาศอยู่เหรอ?
    "空气可不会喊疼", -- อากาศไม่ได้ร้องเจ็บนะ
    "墙都比你会挡", -- กำแพงยังหลบได้เก่งกว่าเธอเลย
    "你打墙的准头不错", -- ความแม่นในการตีกำแพงของเธอใช้ได้นะ
    "我躲得还行吧？", -- ฉันหลบได้พอใช้ไหม?
    "这都打不中，难怪你着急", -- แค่นี้ยังตีไม่โดน เลยไม่แปลกที่เธอจะร้อนใจ
    "别盯着我消失的地方看", -- อย่าจ้องที่ที่ฉันหายไปเลย
    "下一次记得快一点", -- ครั้งหน้าจำไว้ต้องเร็วกว่านี้
    "慢半拍可抓不到我", -- ช้ากว่าครึ่งจังหวะก็จับฉันไม่ได้หรอก
    "你追人的样子挺认真", -- ท่าทางที่เธอไล่คนนี่ตั้งใจดีนะ
    "认真归认真，还是追不上", -- ตั้งใจก็ตั้งใจเถอะ แต่ก็ยังตามไม่ทันอยู่ดี
    "我在这儿，刚才在那儿", -- ฉันอยู่นี่ เมื่อกี้อยู่นั่น
    "你看左边，我在右边", -- เธอมองซ้าย ฉันอยู่ขวา
    "你看右边，我又回来了", -- เธอมองขวา ฉันกลับมาแล้ว
    "别眨眼，眨眼我就没了", -- อย่ากะพริบตา กะพริบปุ๊บฉันหายปั๊บ
    "你眨眼的功夫我都换地方了", -- แค่เธอกะพริบตา ฉันก็ย้ายที่แล้ว
    "找累了就休息一下吧", -- หาเหนื่อยก็พักสักหน่อยสิ
    "我不介意等你一会儿", -- ฉันไม่รังเกียจรอเธอสักหน่อยหรอก
    "要不要我放慢一点？", -- ให้ฉันช้าลงหน่อยไหม?
    "放慢你也未必追得上", -- ถึงช้าลงเธอก็未必ตามทัน
    "这话我可没说过……大概", -- ประโยคนี้ฉันไม่ได้พูดนะ……มั้ง
    "我要说什么来着？算了，先躲", -- เอ๊ะ จะพูดว่าอะไรนะ? ช่างมันก่อน หลบก่อนดีกว่า
    "你刚才是不是看见我了？", -- เมื่อกี้เธอเห็นฉันใช่ไหม?
    "看见也没用，我已经走了", -- เห็นก็ไม่มีประโยชน์ ฉันไปแล้ว
    "下次早点出手", -- ครั้งหน้าออกมือเร็วหน่อย
    "出手晚了就只能打墙", -- ออกมือช้าก็ได้แต่ตีกำแพง
    "你的反应速度挺有进步空间", -- ความเร็วในการตอบสนองของเธอยังมีพื้นที่ให้พัฒนาเยอะนะ
    "进步空间大得能装下一座山", -- พื้นที่พัฒนานี่ใหญ่พอใส่ภูเขาได้เลย
    "别灰心，失败是成功之母", -- อย่าท้อ ความล้มเหลวเป็นมารดาของความสำเร็จ
    "追不上我别哭啊", -- ตามฉันไม่ทันก็อย่าร้องไห้นะ
    "哭也没用，我跑得快", -- ร้องไห้ก็ไม่ช่วยอะไร ฉันวิ่งเร็ว
    "你这速度，乌龟都替你着急", -- ความเร็วเธอขนาดนี้ เต่ายังร้อนใจแทน
    "乌龟刚才超车了哦", -- เมื่อกี้เต่าแซงไปแล้วนะ
    "我还没热身完呢", -- ฉันยังวอร์มไม่เสร็จเลย
    "热身完你可能更看不见我", -- วอร์มเสร็จเธออาจยิ่งมองไม่เห็นฉัน
    "你的攻击很努力，可惜方向不对", -- การโจมตีของเธอพยายามดีนะ เสียดายที่ทิศทางผิด
    "方向对了，时机又错了", -- ทิศทางถูกแล้ว แต่จังหวะผิดอีก
    "时机对了，人又不见了", -- จังหวะถูกแล้ว แต่คนหายไปอีก
    "别怀疑自己，你就是没打中", -- อย่าสงสัยตัวเองเลย เธอก็แค่ตีไม่โดน
    "我躲起来可不是怕你", -- ฉันหลบไม่ได้กลัวเธอนะ
    "只是怕你太尴尬", -- แค่กลัวเธอจะเก้อเกินไป
    "刚才那招挺帅，帅在没打中", -- ท่าเมื่อกี้เท่ดีนะ เท่ตรงที่ตีไม่โดนนี่แหละ
    "声势很大，效果很小", -- เสียงดังใหญ่โต แต่ผลลัพธ์น้อยนิด
    "你是在给我表演吗？", -- เธอกำลังแสดงให้ฉันดูอยู่เหรอ?
    "表演得不错，下次别打我了", -- แสดงได้ดีนะ ครั้งหน้าอย่าตีฉันก็พอ
    "我在这儿等你，你敢来吗？", -- ฉันรอเธออยู่นี่ กล้ามาไหมล่ะ?
    "不来也行，反正你找不到", -- ไม่มาก็ได้ ยังไงก็หาไม่เจอ
    "我数到三你就找不到我了", -- ฉันนับถึงสาม เธอจะหาฉันไม่เจอแล้ว
    "一、二……算了，我已经走了", -- หนึ่ง สอง……ช่างมัน ฉันไปแล้ว
    "你慢慢找，我先歇会儿", -- เธอค่อย ๆ หาไปนะ ฉันพักก่อน
    "找到我算你赢，找不到算我赢", -- หาเจอถือว่าเธอชนะ หาไม่เจอถือว่าฉันชนะ
    "这局我赢定了", -- ตานี้ฉันชนะแน่นอน
    "别看了，我换位置了", -- ไม่ต้องมองแล้ว ฉันเปลี่ยนที่แล้ว
    "你刚才那下差得不多", -- เมื่อกี้เธอพลาดไม่เยอะนะ
    "差得不多，也就是差了整个我", -- พลาดไม่เยอะ ก็แค่พลาดไปทั้งตัวฉันไง
    "你的准星是不是忘带了？", -- เธอลืมเอาความแม่นมาด้วยเหรอ?
    "准星没带也没关系，反正你也不用", -- ไม่ได้เอาความแม่นมาก็ไม่เป็นไร ยังไงเธอก็ไม่ได้ใช้
    "我躲得这么明显你都打不中？", -- ฉันหลบชัดขนาดนี้เธอยังตีไม่โดนอีกเหรอ?
    "看来我高估你了", -- ท่าทางฉันประเมินเธอสูงไป
    "不，是我低估了自己的速度", -- ไม่สิ ฉันประเมินความเร็วตัวเองต่ำไปต่างหาก
    "你追我，如果你追到我，我就让你继续追", -- เธอไล่ฉัน ถ้าเธอไล่ทัน ฉันจะให้เธอไล่ต่อ
    "别生气，生气也追不上", -- อย่าโกรธ โกรธก็ยังตามไม่ทันอยู่ดี
    "保持微笑，反正打不中", -- ยิ้มไว้เถอะ ยังไงก็ตีไม่โดน
    "你笑一个，我就多躲一会儿", -- เธอยิ้มหน่อยสิ ฉันจะหลบอีกสักพัก
    "你越认真，我越想跑", -- เธอยิ่งจริงจัง ฉันยิ่งอยากวิ่งหนี
    "这次算你运气不好", -- ครั้งนี้ถือว่าเธอโชคไม่ดี
    "下次运气也不会太好", -- ครั้งหน้าโชคก็คงไม่ดีเท่าไหร่
    "我在这儿留个影子给你打", -- ฉันทิ้งเงาไว้ให้เธอตีตรงนี้นะ
    "影子打中了也算你厉害", -- ตีโดนเงาก็ถือว่าเธอเก่ง
    "可惜影子也不会站着不动", -- เสียดายที่เงาก็ไม่ยืนนิ่งให้ตี
    "你的攻击落空了，声音还挺响", -- การโจมตีของเธอพลาดไป แต่เสียงดังใช้ได้เลย
    "响是响，就是没用", -- ดังก็ดัง แต่ไม่เกิดประโยชน์
    "别追了，前面没路……骗你的", -- อย่าตามแล้ว ข้างหน้าไม่มีทาง……ล้อเล่น
    "前面有路，但我不告诉你", -- ข้างหน้ามีทาง แต่ฉันไม่บอกเธอหรอก
    "你走那边，我走这边", -- เธอไปทางนั้น ฉันไปทางนี้
    "我们分头行动，你找我", -- เราแยกกันเดิน เธอหาฉัน
    "找得到我吗？找得到算我输", -- หาฉันเจอไหม? หาเจอถือว่าฉันแพ้
    "算了，我不赌，我直接走", -- ช่างมัน ฉันไม่เดิมพัน ฉันไปตรง ๆ เลยดีกว่า
    "你慢慢来，我不赶时间", -- เธอค่อย ๆ มาก็ได้ ฉันไม่รีบ
    "我赶时间，所以我先走了", -- ฉันรีบ เลยไปก่อนนะ
    "再见啦，不对，是再也见不到啦", -- ลาก่อนนะ เอ๊ะ ไม่สิ คือคงไม่ได้เจอกันอีกแล้ว
    "别想我，想我也打不中", -- อย่าคิดถึงฉัน คิดถึงก็ยังตีไม่โดน
    "我藏好了，开始找吧", -- ฉันซ่อนเรียบร้อยแล้ว เริ่มหาได้
    "找到之前不许生气哦", -- ก่อนจะหาเจอห้ามโกรธนะ
    "你刚才是不是差点就打中了？", -- เมื่อกี้เธอเกือบตีโดนใช่ไหม?
    "差点，真的只是差点", -- เกือบจริง ๆ เกือบแค่นั้นแหละ
    "下一次我会躲得更随便一点", -- ครั้งหน้าฉันจะหลบแบบชุ่ย ๆ กว่านี้หน่อย
    "随便躲你也打不中，那就没办法了", -- หลบชุ่ย ๆ เธอยังตีไม่โดน ก็ช่วยไม่ได้แล้ว
    "你的手速和眼速好像不太熟", -- ความเร็วมือกับความเร็วตาของเธอท่าทางจะไม่ค่อยรู้จักกัน
    "让它们先认识一下吧", -- ให้สองอย่างนั้นทำความรู้จักกันก่อนเถอะ
    "我在这儿呢，看哪儿呢？", -- ฉันอยู่นี่ไง มองไปไหนอยู่?
    "看错了吧，我在另一边", -- มองผิดแล้วล่ะ ฉันอยู่อีกฝั่ง
    "你转身的时候我就走了", -- ตอนเธอหันหลัง ฉันก็ไปแล้ว
    "别回头，回头也看不见我", -- อย่าหันกลับ หันกลับก็มองไม่เห็นฉัน
    "我消失得是不是很帅？", -- ฉันหายตัวได้เท่ไหม?
    "帅不帅不知道，反正你打不中", -- เท่ไม่เท่ไม่รู้ แต่ยังไงเธอก็ตีไม่โดน
    "你这招叫声东击西吗？", -- ท่านี้ของเธอเรียกว่าตีตะวันออกแต่ไปตะวันตกเหรอ?
    "西边没人，东边也没人", -- ฝั่งตะวันตกไม่มีใคร ฝั่งตะวันออกก็ไม่มีใคร
    "我建议你换个目标", -- ฉันแนะนำให้เธอเปลี่ยนเป้าหมาย
    "比如那面墙，它至少不会跑", -- เช่นกำแพงนั่นไง อย่างน้อยมันก็ไม่วิ่งหนี
    "你打墙的样子挺专注", -- ท่าทางที่เธอตีกำแพงนี่ตั้งใจดีนะ
    "专注是好事，可惜用错地方", -- ตั้งใจเป็นเรื่องดี เสียดายที่ใช้ผิดที่
    "我不动你都打不中", -- ฉันไม่ขยับเธอยังตีไม่โดน
    "我一动你就更没戏了", -- ฉันขยับที เธอยิ่งไม่มีหวังเลย
    "刚才那下我差点笑出声", -- เมื่อกี้ฉันเกือบหลุดหัวเราะออกมา
    "忍住了，给你留点面子", -- กลั้นไว้แล้ว ให้เธอมีหน้ามีตาหน่อย
    "下次不用留手，反正也打不中", -- ครั้งหน้าไม่ต้องออมมือก็ได้ ยังไงก็ตีไม่โดน
    "你尽力了，我看得出来", -- เธอพยายามเต็มที่แล้ว ฉันดูออก
    "看出来也没用，还是没中", -- ดูออกก็ไม่มีประโยชน์ ยังไงก็ไม่โดน
    "我躲得有点无聊了", -- ฉันหลบจนเริ่มเบื่อแล้วนะ
    "你能不能打准一点，让我认真一下", -- เธอตีให้แม่นหน่อยได้ไหม จะได้ทำให้ฉันจริงจังบ้าง
    "认真起来我怕你更受打击", -- ถ้าฉันจริงจัง ฉันกลัวเธอจะยิ่งชอกช้ำ
    "还是继续这样吧，挺好的", -- ปล่อยให้เป็นแบบนี้ต่อไปเถอะ ดีแล้ว
    "你追不上我的，接受现实吧", -- เธอตามฉันไม่ทันหรอก ยอมรับความจริงเถอะ
    "现实就是，我又不见了", -- ความจริงก็คือ ฉันหายไปอีกแล้ว
    "别找了，我已经在下一个地方了", -- อย่าหาแล้ว ฉันอยู่ที่ต่อไปแล้ว
    "你找到的只是我刚才站过的地方", -- ที่เธอหาเจอเป็นแค่ที่ที่ฉันเพิ่งยืนเมื่อกี้
    "那里现在只有空气", -- ตอนนี้ที่นั่นมีแค่อากาศ
    "跟空气聊聊天吧，我先走了", -- คุยกับอากาศไปก่อนนะ ฉันไปก่อน
    "你刚才是不是以为打中了？", -- เมื่อกี้เธอคิดว่าตีโดนใช่ไหม?
    "以为归以为，事实归事实", -- คิดก็ส่วนคิด ความจริงก็ส่วนความจริง
    "事实就是，我完好无损", -- ความจริงก็คือ ฉันยังสมบูรณ์ดี
    "你的攻击很精彩，下次记得打中", -- การโจมตีของเธอสุดยอดมาก ครั้งหน้าจำไว้ต้องตีให้โดน
    "不，下次也别打中", -- ไม่สิ ครั้งหน้าก็อย่าตีโดนแล้วกัน
    "我开玩笑的，你随意", -- ฉันล้อเล่น เธอตามสบาย
    "反正结果都一样", -- ยังไงผลลัพธ์ก็เหมือนเดิม
    "我又躲开了，气不气？", -- ฉันหลบได้อีกแล้ว โกรธไหมล่ะ?
    "别气，气坏了追得更慢", -- อย่าโกรธ โกรธมากเดี๋ยวตามได้ช้าลง
    "你慢一点没关系，我快一点就行", -- เธอช้าหน่อยไม่เป็นไร ฉันเร็วหน่อยก็พอ
    "我们各快各的，很公平", -- ต่างคนต่างเร็ว ยุติธรรมดี
    "你打你的，我躲我的", -- เธอตีของเธอ ฉันหลบของฉัน
    "互不干扰，多好", -- ไม่รบกวนกัน ดีจะตาย
    "可惜你总想干扰我", -- เสียดายที่เธอชอบมารบกวนฉัน
    "那就别怪我跑得快", -- งั้นก็อย่าโทษที่ฉันวิ่งเร็ว
    "我跑得快不是针对你", -- ฉันวิ่งเร็วไม่ได้เจาะจงเธอ
    "是对所有人都这么快", -- แต่กับทุกคนก็เร็วขนาดนี้
    "你不用自卑", -- เธอไม่ต้องน้อยใจ
    "你只是比较慢而已", -- เธอแค่ค่อนข้างช้าเท่านั้นเอง
    "慢也有慢的好处", -- ช้าก็มีข้อดีของมัน
    "比如能看清我怎么消失的", -- เช่น ได้เห็นชัด ๆ ว่าฉันหายตัวยังไง
    "看清了吗？没看清再来一次", -- เห็นชัดไหม? ไม่ชัดก็มาอีกครั้ง
    "再来一次结果也一样", -- มาอีกครั้งผลก็เหมือนเดิม
    "我都不好意思了", -- ฉันยังรู้สึกเกรงใจเลย
    "不好意思归不好意思，还是不让你打中", -- เกรงใจก็ส่วนเกรงใจ แต่ก็ยังไม่ให้เธอตีโดนอยู่ดี
    "你继续，我换地方了", -- เธอทำต่อเลย ฉันเปลี่ยนที่แล้ว
    "这次藏哪儿好呢？", -- ครั้งนี้ซ่อนไหนดีนะ?
    "算了，随便藏你都找不到", -- ช่างมัน ซ่อนยังไงเธอก็หาไม่เจอ
    "那我就不藏了，我直接跑", -- งั้นฉันไม่ซ่อนแล้ว ฉันวิ่งตรง ๆ เลย
    "你追吧，追到算你厉害", -- ไล่มาเลย ไล่ทันถือว่าเธอเก่ง
    "追不到也别难过", -- ไล่ไม่ทันก็อย่าเสียใจ
    "反正我也不会等你", -- ยังไงฉันก็ไม่รอเธอ
    "拜拜了您嘞", -- บายเลยนะคุณ
    "下次记得瞄准一点", -- ครั้งหน้าจำไว้เล็งให้ดีหน่อย
    "瞄准也没用，我会躲", -- เล็งก็ไม่มีประโยชน์ ฉันหลบ
    "不瞄准更没用", -- ไม่เล็งยิ่งไม่มีประโยชน์
    "你自己选一个吧", -- เธอเลือกเองสักอย่างเถอะ
    "我建议选放弃", -- ฉันแนะนำให้เลือกยอมแพ้
    "放弃也是一种智慧", -- การยอมแพ้ก็เป็นสติปัญญาอย่างหนึ่ง
    "开玩笑的，别当真", -- ล้อเล่น อย่าคิดจริงจัง
    "当真也没关系，反正打不中", -- คิดจริงจังก็ไม่เป็นไร ยังไงก็ตีไม่โดน
    "我走了，别送", -- ฉันไปแล้ว ไม่ต้องมาส่ง
    "送也送不到", -- มาส่งก็ส่งไม่ถึงหรอก
    "你就在原地慢慢找吧", -- เธอก็ค่อย ๆ หาอยู่กับที่ไปแล้วกัน
    "我先去安全的地方", -- ฉันไปที่ปลอดภัยก่อน
    "安全的地方就是你看不见的地方", -- ที่ปลอดภัยก็คือที่ที่เธอมองไม่เห็น
    "你看不见我，我就安全", -- เธอมองไม่เห็นฉัน ฉันก็ปลอดภัย
    "你看见我，我也能跑", -- เธอเห็นฉัน ฉันก็วิ่งหนีได้
    "所以结论是：你抓不到我", -- ดังนั้นสรุปคือ: เธอจับฉันไม่ได้
    "结论正确，奖励是没有奖励", -- สรุปถูกต้อง รางวัลคือไม่มีรางวัล
    "好了，不说了，再说就真被追上了", -- เอาล่ะ ไม่พูดแล้ว พูดต่อเดี๋ยวจะถูกตามทันจริง ๆ
    "追上也没用，我还会跑", -- ตามทันก็ไม่มีประโยชน์ ฉันก็ยังวิ่งต่อ
    "你加油，我先溜", -- เธอสู้ ๆ ฉันขอเผ่นก่อน
    "溜了溜了", -- เผ่นแล้วนะ เผ่นแล้ว
    "别追了，真的追不上", -- อย่าตามแล้ว ตามไม่ทันจริง ๆ
    "你追得越认真，我躲得越开心", -- เธอยิ่งไล่จริงจัง ฉันยิ่งหลบสนุก
    "开心归开心，还是得走", -- สนุกก็ส่วนสนุก แต่ก็ต้องไปอยู่ดี
    "下次见，如果你找得到的话", -- เจอกันครั้งหน้า ถ้าเธอหาเจอนะ
    "找得到再说吧", -- หาเจอก่อนค่อยว่ากัน
    "我在这儿……开玩笑的，我走了", -- ฉันอยู่นี่……ล้อเล่น ฉันไปแล้ว
    "你刚才是不是信了？", -- เมื่อกี้เธอเชื่อใช่ไหม?
    "信了就好，说明我演技不错", -- เชื่อก็ดีแล้ว แสดงว่าฉันแสดงเก่ง
    "下次演得更像一点", -- ครั้งหน้าจะแสดงให้เหมือนกว่านี้
    "演到你放弃为止", -- แสดงไปจนกว่าเธอจะยอมแพ้
    "你别放弃啊，我还没玩够", -- อย่ายอมแพ้นะ ฉันยังเล่นไม่พอเลย
    "玩够了我就走", -- เล่นพอแล้วฉันจะไป
    "现在还没玩够，所以继续", -- ตอนนี้ยังเล่นไม่พอ เลย продолжаем ต่อ
    "你继续追，我继续躲", -- เธอไล่ต่อ ฉันหลบต่อ
    "看谁先累", -- ดูสิใครจะเหนื่อยก่อน
    "我猜是你", -- ฉันเดาว่าเธอ
    "别不服，事实如此", -- อย่าไม่ยอมรับ ความจริงก็เป็นแบบนี้
    "服不服都追不上", -- ยอมหรือไม่ยอมก็ตามไม่ทัน
    "所以我先走了", -- งั้นฉันไปก่อนนะ
    "你慢慢来" -- เธอค่อย ๆ มา
}
                            local randomMsg = messages[math.random(#messages)]
                            noti:Send(randomMsg, 1.8)

                            nextWcisAllowed = tick() + math.random(8, 12)
                        end
                    end

                    -- กรณีที่ 2: เพิ่งเห็น (เมื่อกี้ไม่เห็น ตอนนี้เห็น)
                    if not wasVisible and isVisible then
                        if tick() >= nextLauAllowed then
                            playLauSound()
                            -- คูลดาวน์สั้นกว่าอันลับตาเล็กน้อย (5-8 วินาที)
                            nextLauAllowed = tick() + math.random(5, 8)
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
