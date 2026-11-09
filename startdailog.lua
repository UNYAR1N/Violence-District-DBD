--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

-- Instances: 29 | Scripts: 1 | Modules: 0 | Tags: 0
if getgenv and getgenv().DBD_EDIT_NOTIFY then
	pcall(function() getgenv().DBD_EDIT_NOTIFY:Destroy() end)
end

-- === parent resolution: hui > protected CoreGui > PlayerGui ===
local PARENT
if gethui then
	local ok, hui = pcall(gethui)
	if ok and hui then PARENT = hui end
end
if not PARENT then
	local ok, cg = pcall(function() return game:GetService("CoreGui") end)
	PARENT = (ok and cg) or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local G2L = {}

-- StarterGui.popup
G2L["1"] = Instance.new("ScreenGui")
G2L["1"]["Name"] = "popup"
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
G2L["1"]["IgnoreGuiInset"] = true
G2L["1"]["ResetOnSpawn"] = false
G2L["1"]["DisplayOrder"] = 2147483647          -- int32 max, above every other ScreenGui

if syn and syn.protect_gui then
	pcall(syn.protect_gui, G2L["1"])            -- hide from CoreGui enumeration
end
G2L["1"].Parent = PARENT

if getgenv then getgenv().DBD_EDIT_NOTIFY = G2L["1"] end

-- StarterGui.popup.Frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["Size"] = UDim2.new(0.44022, 0, 0.43529, 0);
G2L["2"]["Position"] = UDim2.new(0.28004, 0, 0.28235, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["BackgroundTransparency"] = 0.15;


-- StarterGui.popup.Frame.UICorner
G2L["3"] = Instance.new("UICorner", G2L["2"]);
G2L["3"]["CornerRadius"] = UDim.new(0.02027, 0);


-- StarterGui.popup.Frame.UIGradient
G2L["4"] = Instance.new("UIGradient", G2L["2"]);
G2L["4"]["Rotation"] = -121;
G2L["4"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(45, 45, 45))};


-- StarterGui.popup.Frame.TextLabel
G2L["5"] = Instance.new("TextLabel", G2L["2"]);
G2L["5"]["TextWrapped"] = true;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["TextSize"] = 14;
G2L["5"]["TextScaled"] = true;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5"]["TextColor3"] = Color3.fromRGB(118, 28, 245);
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["Size"] = UDim2.new(0.30754, 0, 0.07432, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Text"] = [[DIALEV - DBD EDIT]];
G2L["5"]["Position"] = UDim2.new(0.03095, 0, 0.03041, 0);


-- StarterGui.popup.Frame.TextLabel.UIAspectRatioConstraint
G2L["6"] = Instance.new("UIAspectRatioConstraint", G2L["5"]);
G2L["6"]["AspectRatio"] = 7.22727;


-- StarterGui.popup.Frame.TextLabel
G2L["7"] = Instance.new("TextLabel", G2L["2"]);
G2L["7"]["TextWrapped"] = true;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextSize"] = 14;
G2L["7"]["TextScaled"] = true;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7"]["TextColor3"] = Color3.fromRGB(227, 221, 245);
G2L["7"]["BackgroundTransparency"] = 1;
G2L["7"]["Size"] = UDim2.new(0.91489, 0, 0.15203, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Text"] = [[This Scropt Work At In Game And Thank For Useing this script (v0.2.0) (use this script for every update! XD) thank you so much enjoyyyyyyyy. RESPECT POOKIES]];
G2L["7"]["Position"] = UDim2.new(0.04255, 0, 0.19932, 0);


-- StarterGui.popup.Frame.TextLabel.UIAspectRatioConstraint
G2L["8"] = Instance.new("UIAspectRatioConstraint", G2L["7"]);
G2L["8"]["AspectRatio"] = 10.51111;


-- StarterGui.popup.Frame.Frame
G2L["9"] = Instance.new("Frame", G2L["2"]);
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["Size"] = UDim2.new(0.96712, 0, 0.00676, 0);
G2L["9"]["Position"] = UDim2.new(0.01741, 0, 0.13514, 0);
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.popup.Frame.Frame.UIGradient
G2L["a"] = Instance.new("UIGradient", G2L["9"]);
G2L["a"]["Rotation"] = -121;
G2L["a"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(134, 104, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(30, 30, 30))};


-- StarterGui.popup.Frame.Frame.UIAspectRatioConstraint
G2L["b"] = Instance.new("UIAspectRatioConstraint", G2L["9"]);
G2L["b"]["AspectRatio"] = 250;


-- StarterGui.popup.Frame.Frame
G2L["c"] = Instance.new("Frame", G2L["2"]);
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["Size"] = UDim2.new(0.96712, 0, 0.00676, 0);
G2L["c"]["Position"] = UDim2.new(0.01741, 0, 0.78041, 0);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.popup.Frame.Frame.UIGradient
G2L["d"] = Instance.new("UIGradient", G2L["c"]);
G2L["d"]["Rotation"] = 81;
G2L["d"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(134, 104, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(30, 30, 30))};


-- StarterGui.popup.Frame.Frame.UIAspectRatioConstraint
G2L["e"] = Instance.new("UIAspectRatioConstraint", G2L["c"]);
G2L["e"]["AspectRatio"] = 250;


-- StarterGui.popup.Frame.Frame
G2L["f"] = Instance.new("Frame", G2L["2"]);
G2L["f"]["BorderSizePixel"] = 0;
G2L["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f"]["Size"] = UDim2.new(0.40812, 0, 0.16892, 0);
G2L["f"]["Position"] = UDim2.new(0.5764, 0, 0.80743, 0);
G2L["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.popup.Frame.Frame.UICorner
G2L["10"] = Instance.new("UICorner", G2L["f"]);
G2L["10"]["CornerRadius"] = UDim.new(0.16, 0);


-- StarterGui.popup.Frame.Frame.UIGradient
G2L["11"] = Instance.new("UIGradient", G2L["f"]);
G2L["11"]["Rotation"] = 85;
G2L["11"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(47, 72, 54)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(30, 30, 30))};


-- StarterGui.popup.Frame.Frame.UIStroke
G2L["12"] = Instance.new("UIStroke", G2L["f"]);
G2L["12"]["Transparency"] = 0.68;
G2L["12"]["Thickness"] = 0.02;
G2L["12"]["StrokeSizingMode"] = Enum.StrokeSizingMode.ScaledSize;
G2L["12"]["Color"] = Color3.fromRGB(0, 255, 116);


-- StarterGui.popup.Frame.Frame.TextButton
G2L["13"] = Instance.new("TextButton", G2L["f"]);
G2L["13"]["TextWrapped"] = true;
G2L["13"]["RichText"] = true;
G2L["13"]["BorderSizePixel"] = 0;
G2L["13"]["TextSize"] = 21;
G2L["13"]["TextScaled"] = true;
G2L["13"]["TextColor3"] = Color3.fromRGB(182, 255, 171);
G2L["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/Jura.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["13"]["BackgroundTransparency"] = 1;
G2L["13"]["Size"] = UDim2.new(0.99526, 0, 1, 0);
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13"]["Text"] = [[OK POOKIE]];


-- StarterGui.popup.Frame.Frame.TextButton.UIPadding
G2L["14"] = Instance.new("UIPadding", G2L["13"]);
G2L["14"]["PaddingTop"] = UDim.new(0.292, 0);
G2L["14"]["PaddingBottom"] = UDim.new(0.292, 0);


-- StarterGui.popup.Frame.Frame.TextButton.UIAspectRatioConstraint
G2L["15"] = Instance.new("UIAspectRatioConstraint", G2L["13"]);
G2L["15"]["AspectRatio"] = 4.2;


-- StarterGui.popup.Frame.Frame.UIAspectRatioConstraint
G2L["16"] = Instance.new("UIAspectRatioConstraint", G2L["f"]);
G2L["16"]["AspectRatio"] = 4.22;


-- StarterGui.popup.Frame.UIStroke
G2L["17"] = Instance.new("UIStroke", G2L["2"]);
G2L["17"]["Transparency"] = 0.13;
G2L["17"]["Thickness"] = 0.00845;
G2L["17"]["StrokeSizingMode"] = Enum.StrokeSizingMode.ScaledSize;
G2L["17"]["Color"] = Color3.fromRGB(141, 58, 255);


-- StarterGui.popup.Frame.UIShadow
G2L["18"] = Instance.new("UIShadow", G2L["2"]);



-- StarterGui.popup.Frame.darker
G2L["19"] = Instance.new("UIShadow", G2L["2"]);



-- StarterGui.popup.Frame.sprite
G2L["1a"] = Instance.new("ImageLabel", G2L["2"]);
G2L["1a"]["BorderSizePixel"] = 0;
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["Image"] = [[rbxassetid://83202525487199]];
G2L["1a"]["Size"] = UDim2.new(0.24371, 0, 0.42905, 0);
G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a"]["BackgroundTransparency"] = 1;
G2L["1a"]["Name"] = [[sprite]];
G2L["1a"]["Position"] = UDim2.new(0.73888, 0, 0.35135, 0);


-- StarterGui.popup.Frame.sprite.UIAspectRatioConstraint
G2L["1b"] = Instance.new("UIAspectRatioConstraint", G2L["1a"]);
G2L["1b"]["AspectRatio"] = 0.99213;


-- StarterGui.popup.Frame.UIAspectRatioConstraint
G2L["1c"] = Instance.new("UIAspectRatioConstraint", G2L["2"]);
G2L["1c"]["AspectRatio"] = 1.74662;


-- StarterGui.popup.PopupAnimation
G2L["1d"] = Instance.new("LocalScript", G2L["1"]);
G2L["1d"]["Name"] = [[PopupAnimation]];


-- StarterGui.popup.PopupAnimation
local function C_1d()
local script = G2L["1d"];
	--[[
		Popup Animation (แบบเรียบง่าย)
		- Animate IN  ตอน popup ถูกสร้าง
		- Animate OUT เมื่อกด OK แล้วทำลาย popup
		- Spritesheet 5x5 = 25 ช่อง (ใช้จริง 21 เฟรม) เล่นวน loop
		  ใช้วิธีเลื่อน sheet ทั้งใบในกรอบ clip จึงตรงเฟรมเสมอไม่ต้องรู้ขนาดพิกเซล
	]]
	
	local TweenService = game:GetService("TweenService")
	
	local gui = script.Parent
	local frame = gui:WaitForChild("Frame")
	
	-- ================= Spritesheet 5x5 (21 เฟรม) loop =================
	local COLS, ROWS, TOTAL_FRAMES = 5, 5, 21
	local FPS = 60
	
	local sprite = frame:FindFirstChild("sprite")
	if sprite then
		-- กรอบ clip ขนาด 1 ช่อง แล้วเลื่อน sheet ทั้งใบเพื่อแสดงทีละช่อง
		local clip = Instance.new("Frame")
		clip.Name = "spriteClip"
		clip.BackgroundTransparency = 1
		clip.BorderSizePixel = 0
		clip.ClipsDescendants = true
		clip.Position = sprite.Position
		clip.Size = sprite.Size
		clip.Parent = frame
	
		sprite.Parent = clip
		sprite.AnchorPoint = Vector2.zero
		sprite.Position = UDim2.fromOffset(0, 0)
		sprite.Size = UDim2.fromScale(COLS, ROWS) -- sheet ทั้งใบ = 5x5 ของกรอบ clip
		sprite.ScaleType = Enum.ScaleType.Stretch
	
		local index = 1
		local function setFrame(i)
			local col = (i - 1) % COLS
			local row = math.floor((i - 1) / COLS)
			sprite.Position = UDim2.fromScale(-col, -row)
		end
	
		setFrame(1)
		task.spawn(function()
			-- รอภาพโหลดจริงก่อนค่อยเล่น
			local t0 = os.clock()
			while not sprite.IsLoaded and os.clock() - t0 < 5 do
				task.wait(0.1)
			end
			if not sprite.IsLoaded then
				warn("[Popup] sprite โหลดไม่สำเร็จ: " .. tostring(sprite.Image))
				return
			end
			-- เล่นวน loop จนกว่า popup จะถูกทำลาย
			while gui.Parent do
				task.wait(1 / FPS)
				index += 1
				if index > TOTAL_FRAMES then index = 1 end
				setFrame(index)
			end
		end)
	end
	
	-- ================= เก็บค่าต้นฉบับของ frame =================
	local origPos = frame.Position
	local origSize = frame.Size
	
	local function scaled(s)
		return UDim2.new(origSize.X.Scale * s, origSize.X.Offset * s, origSize.Y.Scale * s, origSize.Y.Offset * s)
	end
	
	local function centered(size)
		return origPos + UDim2.fromOffset(
			(origSize.X.Offset - size.X.Offset) / 2,
			(origSize.Y.Offset - size.Y.Offset) / 2
		)
	end
	
	-- ================= element ทั้งหมด (สำหรับ fade) =================
	local fades = {}
	for _, el in frame:GetDescendants() do
		if el:IsA("TextLabel") or el:IsA("TextButton") then
			table.insert(fades, { obj = el, prop = "TextTransparency" })
		elseif el:IsA("ImageLabel") then
			table.insert(fades, { obj = el, prop = "ImageTransparency" })
		elseif el:IsA("Frame") and el.BackgroundTransparency < 1 then
			table.insert(fades, { obj = el, prop = "BackgroundTransparency" })
		end
	end
	
	local function setFade(alpha)
		for _, f in fades do
			f.obj[f.prop] = alpha
		end
	end
	
	-- ================= Animate IN =================
	local small = scaled(0.8)
	frame.Size = small
	frame.Position = centered(small)
	frame.BackgroundTransparency = 1
	setFade(1)
	
	local infoIn = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	TweenService:Create(frame, infoIn, {
		Size = origSize,
		Position = origPos,
		BackgroundTransparency = 0.15,
	}):Play()
	for _, f in fades do
		TweenService:Create(f.obj, infoIn, { [f.prop] = 0 }):Play()
	end
	
	-- ================= Animate OUT (กด OK แล้วทำลาย) =================
	local okButton = frame:FindFirstChildWhichIsA("TextButton", true)
	local closing = false
	
	if okButton then
		okButton.MouseButton1Click:Connect(function()
			if closing then return end
			closing = true
	
			local infoOut = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
			TweenService:Create(frame, infoOut, {
				Size = small,
				Position = centered(small),
				BackgroundTransparency = 1,
			}):Play()
			for _, f in fades do
				TweenService:Create(f.obj, infoOut, { [f.prop] = 1 }):Play()
			end
	
			task.wait(0.3)
			gui:Destroy()
		end)
	end
	
end;
task.spawn(C_1d);

return G2L["1"], require;
