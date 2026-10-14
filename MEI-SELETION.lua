--==================================================
-- SCRIPT SELECTION
-- tap a card to load it
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--==================================================
-- YOUR SCRIPTS  ← edit this list
--==================================================
-- name = shown on card
-- url  = raw lua link
--==================================================

local Scripts = {
	{
		name = "MEDUSZA (Alkedion)",
		url  = "loadstring(game:HttpGet("https://raw.githubusercontent.com/xianpoliser-droid/Tuff-MDSZ/main/obfuscated_script-1791446093392.lua.txt"))()",
	},
	{
		name = "MIRANDA (STEALANEGG)",
		url  = "loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/kaitunmirage.lua"))()",
	},
	{
		name = "BIG-FROOT (KEY REQUIRED)",
		url  = "loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()",
	},
	{
		name = "ourboros",
		url  = "loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()",
	},
	{
		name = "Clover",
		url  = "loadstring(game:HttpGet("https://cloverhub.app/clover.lua"))()",
	},
    {
        name = "pulse"
        url  = "loadstring(game:HttpGet("https://raw.githubusercontent.com/PulseZax/Loader/main/.lua"))()".
  },
  {
        name = "MEIHUB (ALDEKION)
		url  = "loadstring(game:HttpGet("https://raw.githubusercontent.com/delarocaaxel3-debug/MEI-HUB-SCRIPT/refs/heads/main/MEIHUBSCRIPT.lua"))()"

--==================================================
-- helpers
--==================================================

local ACCENT = Color3.fromRGB(170, 80, 255)
local BG     = Color3.fromRGB(20, 15, 30)
local PANEL  = Color3.fromRGB(35, 25, 50)
local TEXT   = Color3.new(1, 1, 1)

local function New(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do o[k] = v end
	if parent then o.Parent = parent end
	return o
end

local function Round(o, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = o
end

local function Stroke(o, color, t)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = t or 1
	s.Parent = o
end

local function Tween(o, props, dur)
	TweenService:Create(o, TweenInfo.new(dur or 0.2), props):Play()
end

--==================================================
-- clean old
--==================================================

local old = PlayerGui:FindFirstChild("ScriptSelection")
if old then old:Destroy() end

--==================================================
-- notify
--==================================================

local notifGui = New("ScreenGui", {
	Name = "ScriptSelection_Notify",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
}, PlayerGui)

local function notify(text, color)
	color = color or ACCENT
	local lbl = New("TextLabel", {
		Size = UDim2.fromOffset(240, 36),
		Position = UDim2.new(1, -260, 0, 20),
		BackgroundColor3 = Color3.fromRGB(18, 18, 24),
		BackgroundTransparency = 0.1,
		TextColor3 = color,
		Text = text,
		TextScaled = true,
		Font = Enum.Font.Gotham,
		BorderSizePixel = 0,
	}, notifGui)
	Round(lbl, 8)
	Stroke(lbl, color, 1)
	task.delay(2.5, function()
		Tween(lbl, {BackgroundTransparency = 1, TextTransparency = 1}, 0.3)
		task.wait(0.35)
		lbl:Destroy()
	end)
end

--==================================================
-- loader
--==================================================

local function loadScript(entry)
	notify("loading " .. entry.name)
	task.spawn(function()
		local ok, src = pcall(function() return game:HttpGet(entry.url) end)
		if not ok or not src or #src < 10 then
			notify("fetch failed: " .. entry.name, Color3.fromRGB(220, 100, 100))
			return
		end
		local fn, err = loadstring(src)
		if not fn then
			notify("compile error: " .. tostring(err):sub(1, 40), Color3.fromRGB(220, 100, 100))
			return
		end
		local ok2, err2 = pcall(fn)
		if not ok2 then
			notify("runtime: " .. tostring(err2):sub(1, 40), Color3.fromRGB(220, 100, 100))
			return
		end
		notify(entry.name .. " loaded", Color3.fromRGB(120, 220, 140))
	end)
end

--==================================================
-- main gui
--==================================================

local gui = New("ScreenGui", {
	Name = "ScriptSelection",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
}, PlayerGui)

local main = New("Frame", {
	Size = UDim2.fromOffset(340, 460),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = BG,
	ClipsDescendants = true,
}, gui)
Round(main, 14)
Stroke(main, ACCENT, 1.2)

-- header
local header = New("Frame", {
	Size = UDim2.new(1, 0, 0, 56),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
}, main)
Round(header, 14)

New("Frame", {
	Size = UDim2.new(1, 0, 0, 20),
	Position = UDim2.new(0, 0, 1, -20),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
}, header)

New("TextLabel", {
	Position = UDim2.fromOffset(16, 14),
	Size = UDim2.new(1, -60, 0, 28),
	BackgroundTransparency = 1,
	Text = "Script Selection",
	TextColor3 = TEXT,
	TextSize = 17,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local closeBtn = New("TextButton", {
	Size = UDim2.fromOffset(28, 28),
	Position = UDim2.new(1, -38, 0.5, -14),
	BackgroundColor3 = Color3.fromRGB(60, 30, 40),
	Text = "X",
	TextColor3 = TEXT,
	TextSize = 13,
	Font = Enum.Font.GothamBold,
	BorderSizePixel = 0,
}, header)
Round(closeBtn, 8)
closeBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- drag
do
	local dragging, dragStart, startPos = false, nil, nil
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

-- body
local body = New("ScrollingFrame", {
	Position = UDim2.fromOffset(0, 56),
	Size = UDim2.new(1, 0, 1, -56),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = ACCENT,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, main)

New("UIPadding", {
	PaddingTop = UDim.new(0, 12),
	PaddingBottom = UDim.new(0, 15),
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12),
}, body)

New("UIListLayout", {
	Padding = UDim.new(0, 10),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, body)

--==================================================
-- cards
--==================================================

for _, entry in ipairs(Scripts) do
	local card = New("TextButton", {
		Size = UDim2.new(1, -8, 0, 54),
		BackgroundColor3 = PANEL,
		Text = "",
		AutoButtonColor = false,
		BorderSizePixel = 0,
	}, body)
	Round(card, 10)
	local cs = Stroke(card, Color3.fromRGB(70, 50, 100), 1)

	New("TextLabel", {
		Position = UDim2.fromOffset(16, 0),
		Size = UDim2.new(1, -110, 1, 0),
		BackgroundTransparency = 1,
		Text = entry.name,
		TextColor3 = TEXT,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, card)

	local load = New("TextButton", {
		Position = UDim2.new(1, -78, 0.5, -15),
		Size = UDim2.fromOffset(66, 30),
		BackgroundColor3 = ACCENT,
		Text = "LOAD",
		TextColor3 = TEXT,
		TextSize = 11,
		Font = Enum.Font.GothamBold,
		BorderSizePixel = 0,
	}, card)
	Round(load, 8)

	card.MouseEnter:Connect(function()
		if UIS.MouseEnabled then
			Tween(card, {BackgroundColor3 = Color3.fromRGB(48, 35, 68)}, 0.15)
			cs.Color = ACCENT
		end
	end)
	card.MouseLeave:Connect(function()
		Tween(card, {BackgroundColor3 = PANEL}, 0.15)
		cs.Color = Color3.fromRGB(70, 50, 100)
	end)

	card.MouseButton1Click:Connect(function() loadScript(entry) end)
	load.MouseButton1Click:Connect(function() loadScript(entry) end)
end

--==================================================
-- floating reopen button
--==================================================

local floatGui = New("ScreenGui", {
	Name = "ScriptSelection_Float",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
}, PlayerGui)

local floatBtn = New("TextButton", {
	Size = UDim2.fromOffset(50, 50),
	Position = UDim2.fromOffset(20, 300),
	BackgroundColor3 = BG,
	Text = "S",
	TextColor3 = ACCENT,
	TextSize = 22,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false,
	BorderSizePixel = 0,
}, floatGui)
Round(floatBtn, 25)
Stroke(floatBtn, ACCENT, 1.5)

do
	local dragging, moved = false, false
	local dragStart, startPos
	floatBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; moved = false
			dragStart = input.Position
			startPos = floatBtn.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					if not moved then gui.Enabled = not gui.Enabled end
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			if math.abs(d.X) > 5 or math.abs(d.Y) > 5 then moved = true end
			floatBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

print("Script Selection loaded — " .. #Scripts .. " entries")
