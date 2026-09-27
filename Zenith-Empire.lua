-- ============================================================
-- ZENITH EMPIRE | By ALTRON
-- ============================================================

if _G.ZenithEmpireLoaded then warn("[Zenith Empire] Уже загружено") return end
_G.ZenithEmpireLoaded = true
_G.ZenithCfg = _G.ZenithCfg or {}

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local HttpService      = game:GetService("HttpService")
local CoreGui          = game:GetService("CoreGui")
local SoundService     = game:GetService("SoundService")
local VirtualUser      = game:GetService("VirtualUser")
local LocalPlayer      = Players.LocalPlayer
local Camera           = workspace.CurrentCamera

local Theme = {
    Bg=Color3.fromRGB(12,12,14), Bg2=Color3.fromRGB(18,18,21),
    Panel=Color3.fromRGB(22,22,26), Element=Color3.fromRGB(30,30,35),
    ElementHov=Color3.fromRGB(42,42,48), Stroke=Color3.fromRGB(60,60,68),
    StrokeHov=Color3.fromRGB(200,200,210), Accent=Color3.fromRGB(255,255,255),
    Accent2=Color3.fromRGB(210,210,220), Text=Color3.fromRGB(240,240,245),
    TextDim=Color3.fromRGB(170,170,180), TextMuted=Color3.fromRGB(110,110,120),
    Success=Color3.fromRGB(160,220,170), Danger=Color3.fromRGB(230,120,130),
}

local CFG = _G.ZenithCfg
CFG.UI = CFG.UI or {}
CFG.UI.Accent = CFG.UI.Accent or Color3.fromRGB(255,255,255)
CFG.UI.UIScale = CFG.UI.UIScale or 1
CFG.UI.Blur = CFG.UI.Blur ~= false
CFG.UI.Sounds = CFG.UI.Sounds ~= false
CFG.UI.ClickSound = CFG.UI.ClickSound or "rbxassetid://6895079853"
CFG.UI.NotifPos = CFG.UI.NotifPos or "BottomRight"
CFG.UI.AnimSpeed = CFG.UI.AnimSpeed or 0.28
CFG.UI.ActiveProfile = CFG.UI.ActiveProfile or ""
CFG.UI.Platform = CFG.UI.Platform or nil
CFG.UI.IsMobile = false

CFG.Master = CFG.Master ~= false
CFG.ToggleKey = CFG.ToggleKey or Enum.KeyCode.RightShift
CFG.PanicKey  = CFG.PanicKey  or Enum.KeyCode.End
CFG.Notifications = CFG.Notifications ~= false
CFG.NotifTime = CFG.NotifTime or 3
CFG.FPS = CFG.FPS ~= false
CFG.Ping = CFG.Ping ~= false
CFG.Memory = CFG.Memory or false
CFG.ActiveConfig = CFG.ActiveConfig or ""

CFG.World = CFG.World or {
    Fullbright=false, TimeOfDay=14, RemoveFog=false, RemoveGrass=false,
    Bloom=false, BloomIntensity=0.7,
    ColorCorrect=false, CCContrast=0.15, CCSaturation=0.15,
    NightVision=false, NightVisionIntensity=1,
}

CFG.ESP = CFG.ESP or {
    Box=false, BoxColor=Color3.fromRGB(255,255,255), BoxThick=1.5,
    Name=false, NameColor=Color3.fromRGB(255,255,255), NameSize=12,
    Health=false, HealthColor=Color3.fromRGB(160,220,170),
    Distance=false, DistanceColor=Color3.fromRGB(220,220,220),
    Tracer=false, TracerColor=Color3.fromRGB(255,255,255),
    HeadDot=false, HeadDotColor=Color3.fromRGB(255,255,255),
    Chams=false, ChamsColor=Color3.fromRGB(255,255,255), ChamsTransp=0.5,
    Outline=false, OutlineColor=Color3.fromRGB(255,255,255),
    Rainbow=false, TeamCheck=false, DistanceLimit=500,
}

CFG.Cheats = CFG.Cheats or {
    SpeedEnabled=false, WalkSpeed=16, SpeedKeybind=Enum.KeyCode.LeftShift, SpeedMode="Toggle",
    JumpEnabled=false, JumpPower=50, InfiniteJump=false, DoubleJump=false, DoubleJumpPower=75,
    FlyEnabled=false, FlySpeed=50, FlyMode="WASD", FlyKeybind=Enum.KeyCode.F, FlyVertical=true, FlySmooth=0.3, FlyNoClip=true,
    NoclipEnabled=false, NoclipKeybind=Enum.KeyCode.N, NoclipMode="Toggle",
    AntiFling=false, AntiFlingAggressive=false,
    AntiVoid=false, AntiVoidY=-50,
    BlinkEnabled=false, BlinkDistance=15, BlinkKeybind=Enum.KeyCode.Q, BlinkCooldown=0.5,
    TeleportEnabled=false, TeleportKeybind=Enum.KeyCode.T, TeleportToCursor=false,
    InfiniteYield=false, GodMode=false, AntiAFK=false, AntiKick=false, AntiStun=false, AntiSlow=false,
    AutoRespawn=false, RespawnDelay=0.1,
    HipHeightEnabled=false, HipHeight=2,
    GravityEnabled=false, Gravity=196.2,
    FreezePlayer=false, WalkOnWater=false, NoFallDamage=false,
    ServerHopKeybind=Enum.KeyCode.H,
    FlingEnabled=false, FlingTargetMode="Nearest", FlingKeybind=Enum.KeyCode.G,
}

CFG.Char = CFG.Char or {}
local function ensure(t, k, d)
    t[k] = t[k] or {}
    for a, b in pairs(d) do if t[k][a] == nil then t[k][a] = b end end
end
ensure(CFG.Char, "Halo",      {Enabled=false, Color=Color3.fromRGB(255,255,255), Size=1, Speed=1.5})
ensure(CFG.Char, "Aura",      {Enabled=false, Color=Color3.fromRGB(255,255,255), Size=1, Transp=0.7, Pulse=true})
ensure(CFG.Char, "Outline",   {Enabled=false, Color=Color3.fromRGB(255,255,255)})
ensure(CFG.Char, "Chams",     {Enabled=false, Color=Color3.fromRGB(255,255,255), Transp=0.5})
ensure(CFG.Char, "Trail",     {Enabled=false, Color=Color3.fromRGB(255,255,255), Life=0.6})
ensure(CFG.Char, "Glow",      {Enabled=false, Color=Color3.fromRGB(255,255,255), Bright=5, Range=16})
ensure(CFG.Char, "Orbs",      {Enabled=false, Color=Color3.fromRGB(255,255,255), Count=4, Size=0.6, Radius=4, Speed=2})
ensure(CFG.Char, "Ring",      {Enabled=false, Color=Color3.fromRGB(255,255,255), Size=6, Speed=1})
ensure(CFG.Char, "NeonBody",  {Enabled=false, Color=Color3.fromRGB(255,255,255)})
ensure(CFG.Char, "Particles", {Enabled=false, Color=Color3.fromRGB(255,255,255), Rate=30, Size=0.4})
ensure(CFG.Char, "Rainbow",   {Enabled=false, Speed=1})
ensure(CFG.Char, "FireAura",  {Enabled=false, Size=1, Rate=50})
ensure(CFG.Char, "IceAura",   {Enabled=false, Size=1})
ensure(CFG.Char, "Lightning", {Enabled=false, Color=Color3.fromRGB(180,220,255), Count=6})
ensure(CFG.Char, "Wings",     {Enabled=false, Color=Color3.fromRGB(255,255,255), Size=1})

if _G.ZenithEmpireGUI then pcall(function() _G.ZenithEmpireGUI:Destroy() end) end
if _G.ZenithEmpireNotifGui then pcall(function() _G.ZenithEmpireNotifGui:Destroy() end) end

local function Create(c, p, ch)
    local o = Instance.new(c)
    for k, v in pairs(p or {}) do if k ~= "Parent" then o[k] = v end end
    for _, x in ipairs(ch or {}) do x.Parent = o end
    if p and p.Parent then o.Parent = p.Parent end
    return o
end
local function Corner(p, r) return Create("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = p}) end
local function Stroke(p, c, t) return Create("UIStroke", {Color = c or Theme.Stroke, Thickness = t or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p}) end
local function Tween(o, t, p)
    local tw = TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), p)
    tw:Play(); return tw
end
local function SafeCall(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[Zenith Empire] " .. tostring(err)) end
end
local function PlaySound(id, vol)
    if not CFG.UI.Sounds then return end
    task.spawn(function()
        local s = Create("Sound", {SoundId=id, Volume=vol or 0.4, Parent=SoundService})
        s:Play(); task.wait(2)
        if s.Parent then s:Destroy() end
    end)
end
local function Click() PlaySound(CFG.UI.ClickSound, 0.3) end

function _G.ZenithAccent()
    return CFG.UI.Accent or Color3.fromRGB(255,255,255)
end

local CONFIG_FOLDER = "ZenithEmpire"
local CONFIG_INDEX = CONFIG_FOLDER .. "/index.json"
local MAX_SLOTS = 15

local function EnsureFolder()
    if not writefile then return false end
    pcall(function()
        if makefolder and not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
    end)
    return true
end

local function GetConfigList()
    if not readfile or not isfile then return {} end
    local list = {}
    pcall(function()
        if isfile(CONFIG_INDEX) then
            local data = HttpService:JSONDecode(readfile(CONFIG_INDEX))
            if type(data) == "table" then
                for _, name in ipairs(data) do table.insert(list, name) end
            end
        end
    end)
    return list
end

local function SaveConfigList(list)
    if not writefile then return end
    pcall(function() writefile(CONFIG_INDEX, HttpService:JSONEncode(list)) end)
end

local function SerializeTable(t, seen)
    seen = seen or {}
    if seen[t] then return nil end
    seen[t] = true
    local out = {}
    for k, v in pairs(t) do
        if type(v) == "number" or type(v) == "boolean" or type(v) == "string" then
            out[k] = v
        elseif type(v) == "table" then
            out[k] = SerializeTable(v, seen)
        elseif typeof(v) == "Color3" then
            out[k] = {__color = true, R = v.R, G = v.G, B = v.B}
        elseif typeof(v) == "EnumItem" then
            out[k] = {__enum = tostring(v.EnumType), Name = v.Name}
        end
    end
    return out
end

local function DeserializeTable(data, target)
    for k, v in pairs(data) do
        if type(v) == "table" then
            if v.__color then target[k] = Color3.new(v.R, v.G, v.B)
            elseif v.__enum then pcall(function() target[k] = Enum[v.__enum][v.Name] end)
            else
                if type(target[k]) ~= "table" then target[k] = {} end
                DeserializeTable(v, target[k])
            end
        else target[k] = v end
    end
end

local function SaveConfig(name)
    if not writefile then return false, "Executor не поддерживает writefile" end
    if not name or name == "" then return false, "Введите имя" end
    name = name:gsub("[^%w_%- ]", "")
    if name == "" then return false, "Неверное имя" end
    EnsureFolder()
    local data = SerializeTable(_G.ZenithCfg)
    local ok, err = pcall(function()
        writefile(CONFIG_FOLDER .. "/" .. name .. ".json", HttpService:JSONEncode(data))
    end)
    if not ok then return false, tostring(err) end
    local list = GetConfigList()
    local found = false
    for _, n in ipairs(list) do if n == name then found = true break end end
    if not found then
        if #list >= MAX_SLOTS then return false, "Лимит слотов: " .. MAX_SLOTS end
        table.insert(list, name); SaveConfigList(list)
    end
    CFG.ActiveConfig = name
    return true, "Сохранено: " .. name
end

local function LoadConfig(name)
    if not readfile or not isfile then return false, "Executor не поддерживает readfile" end
    local path = CONFIG_FOLDER .. "/" .. name .. ".json"
    if not isfile(path) then return false, "Файл не найден" end
    local ok, content = pcall(function() return readfile(path) end)
    if not ok or not content then return false, "Ошибка чтения" end
    local decodeOk, data = pcall(function() return HttpService:JSONDecode(content) end)
    if not decodeOk then return false, "Ошибка парсинга" end
    DeserializeTable(data, _G.ZenithCfg)
    CFG.ActiveConfig = name
    return true, "Загружено: " .. name
end

local function DeleteConfig(name)
    if not delfile then return false, "Нет delfile" end
    local path = CONFIG_FOLDER .. "/" .. name .. ".json"
    pcall(function() if isfile(path) then delfile(path) end end)
    local list = GetConfigList()
    local newList = {}
    for _, n in ipairs(list) do if n ~= name then table.insert(newList, n) end end
    SaveConfigList(newList)
    return true, "Удалено: " .. name
end

local function RenameConfig(old, new)
    if old == new then return false, "Одно и то же имя" end
    new = new:gsub("[^%w_%- ]", "")
    if new == "" then return false, "Неверное имя" end
    if not writefile or not isfile then return false, "Нет доступа" end
    local oldPath = CONFIG_FOLDER .. "/" .. old .. ".json"
    local newPath = CONFIG_FOLDER .. "/" .. new .. ".json"
    if isfile(newPath) then return false, "Имя занято" end
    local content = readfile(oldPath)
    writefile(newPath, content)
    delfile(oldPath)
    local list = GetConfigList()
    for i, n in ipairs(list) do if n == old then list[i] = new end end
    SaveConfigList(list)
    if CFG.ActiveConfig == old then CFG.ActiveConfig = new end
    return true, "Переименовано: " .. old .. " → " .. new
end

local gui = Create("ScreenGui", {
    Name="ZenithEmpire", ResetOnSpawn=false, IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=999,
    Parent=(gethui and gethui()) or CoreGui
})
_G.ZenithEmpireGUI = gui
local mainBlur = Create("BlurEffect", {Size=0, Parent=Lighting})

local notifGui = Create("ScreenGui", {
    Name="ZenithEmpireNotifs", ResetOnSpawn=false, IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=5,
    Parent=(gethui and gethui()) or CoreGui
})
_G.ZenithEmpireNotifGui = notifGui

local NotifHolder = Create("Frame", {
    Size=UDim2.new(0,260,0,400), Position=UDim2.new(1,-280,1,-420),
    BackgroundTransparency=1, Parent=notifGui
})
Create("UIListLayout", {
    Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder,
    VerticalAlignment=Enum.VerticalAlignment.Bottom, Parent=NotifHolder
})

local function Notify(text, color)
    if not CFG.Notifications then return end
    local f = Create("Frame", {
        Size=UDim2.new(1,0,0,32), BackgroundColor3=Theme.Bg2,
        BackgroundTransparency=1, LayoutOrder=-tick(), Parent=NotifHolder
    })
    Corner(f, 8)
    Stroke(f, color or Theme.Accent, 1)
    Create("Frame", {Size=UDim2.new(0,3,1,0), BackgroundColor3=color or Theme.Accent, BorderSizePixel=0, Parent=f})
    Create("TextLabel", {
        Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,12,0,0),
        BackgroundTransparency=1, Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=f
    })
    Tween(f, 0.25, {BackgroundTransparency=0.1})
    task.delay(CFG.NotifTime, function()
        Tween(f, 0.25, {BackgroundTransparency=1})
        for _, c in ipairs(f:GetDescendants()) do
            if c:IsA("TextLabel") then Tween(c, 0.2, {TextTransparency=1}) end
        end
        task.wait(0.3); f:Destroy()
    end)
end

local function DetectMobile()
    local ok, result = pcall(function()
        return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    end)
    return ok and result
end

local PlatformSelected = false
local PlatformGui = Create("ScreenGui", {
    Name="ZenithEmpirePlatform",
    ResetOnSpawn=false, IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=1000,
    Parent=(gethui and gethui()) or CoreGui
})

local PFrame = Create("Frame", {
    Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(8,8,10),
    BorderSizePixel=0, Parent=PlatformGui
})

local PCenter = Create("Frame", {
    Size=UDim2.new(0,520,0,340), Position=UDim2.new(0.5,0,0.5,0),
    AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=Theme.Bg2,
    BorderSizePixel=0, Parent=PFrame
})
Corner(PCenter, 16)
Stroke(PCenter, Theme.StrokeHov, 1.5)

Create("TextLabel", {
    Size=UDim2.new(1,0,0,36), Position=UDim2.new(0,0,0,32),
    BackgroundTransparency=1, Text="ZENITH EMPIRE",
    TextColor3=Theme.Text, Font=Enum.Font.GothamBlack, TextSize=28,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=PCenter
})
Create("TextLabel", {
    Size=UDim2.new(1,0,0,20), Position=UDim2.new(0,0,0,74),
    BackgroundTransparency=1, Text="Выберите платформу",
    TextColor3=Theme.TextDim, Font=Enum.Font.Gotham, TextSize=14,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=PCenter
})
Create("TextLabel", {
    Size=UDim2.new(1,0,0,16), Position=UDim2.new(0,0,0,98),
    BackgroundTransparency=1, Text="Можно изменить позже в настройках",
    TextColor3=Theme.TextMuted, Font=Enum.Font.Gotham, TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=PCenter
})

local buttonRow = Create("Frame", {
    Size=UDim2.new(0,460,0,140), Position=UDim2.new(0.5,0,0,130),
    AnchorPoint=Vector2.new(0.5,0), BackgroundTransparency=1, Parent=PCenter
})
Create("UIListLayout", {
    FillDirection=Enum.FillDirection.Horizontal,
    HorizontalAlignment=Enum.HorizontalAlignment.Center,
    VerticalAlignment=Enum.VerticalAlignment.Center,
    Padding=UDim.new(0,20), Parent=buttonRow
})

local PCButton = Create("TextButton", {
    Size=UDim2.new(0,220,0,140),
    BackgroundColor3=Theme.Element, Text="", AutoButtonColor=false, Parent=buttonRow
})
Corner(PCButton, 12)
local PCStroke = Stroke(PCButton, Theme.Stroke, 1.2)

Create("TextLabel", {
    Size=UDim2.new(1,0,0,40), Position=UDim2.new(0,0,0,20),
    BackgroundTransparency=1, Text="ПК", TextColor3=Theme.Text,
    Font=Enum.Font.GothamBlack, TextSize=32, Parent=PCButton
})
Create("TextLabel", {
    Size=UDim2.new(1,-10,0,20), Position=UDim2.new(0,5,0,64),
    BackgroundTransparency=1, Text="Клавиатура, мышь",
    TextColor3=Theme.TextDim, Font=Enum.Font.Gotham, TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=PCButton
})
Create("TextLabel", {
    Size=UDim2.new(1,-10,0,16), Position=UDim2.new(0,5,0,88),
    BackgroundTransparency=1, Text="RightShift · keybinds",
    TextColor3=Theme.TextMuted, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=PCButton
})

local MobileButton = Create("TextButton", {
    Size=UDim2.new(0,220,0,140),
    BackgroundColor3=Theme.Element, Text="", AutoButtonColor=false, Parent=buttonRow
})
Corner(MobileButton, 12)
local MobileStroke = Stroke(MobileButton, Theme.Stroke, 1.2)

Create("TextLabel", {
    Size=UDim2.new(1,0,0,40), Position=UDim2.new(0,0,0,20),
    BackgroundTransparency=1, Text="ТЕЛЕФОН", TextColor3=Theme.Text,
    Font=Enum.Font.GothamBlack, TextSize=24, Parent=MobileButton
})
Create("TextLabel", {
    Size=UDim2.new(1,-10,0,20), Position=UDim2.new(0,5,0,64),
    BackgroundTransparency=1, Text="Тачскрин",
    TextColor3=Theme.TextDim, Font=Enum.Font.Gotham, TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=MobileButton
})
Create("TextLabel", {
    Size=UDim2.new(1,-10,0,16), Position=UDim2.new(0,5,0,88),
    BackgroundTransparency=1, Text="Кнопки на экране",
    TextColor3=Theme.TextMuted, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=MobileButton
})

PCButton.MouseEnter:Connect(function()
    Tween(PCButton, 0.15, {BackgroundColor3=Theme.ElementHov})
    Tween(PCStroke, 0.15, {Color=Theme.StrokeHov})
end)
PCButton.MouseLeave:Connect(function()
    Tween(PCButton, 0.15, {BackgroundColor3=Theme.Element})
    Tween(PCStroke, 0.15, {Color=Theme.Stroke})
end)
MobileButton.MouseEnter:Connect(function()
    Tween(MobileButton, 0.15, {BackgroundColor3=Theme.ElementHov})
    Tween(MobileStroke, 0.15, {Color=Theme.StrokeHov})
end)
MobileButton.MouseLeave:Connect(function()
    Tween(MobileButton, 0.15, {BackgroundColor3=Theme.Element})
    Tween(MobileStroke, 0.15, {Color=Theme.Stroke})
end)

local autoDetected = DetectMobile()
Create("TextLabel", {
    Size=UDim2.new(1,-20,0,20), Position=UDim2.new(0,10,1,-46),
    BackgroundTransparency=1,
    Text=autoDetected and "Обнаружен тачскрин — рекомендуется ТЕЛЕФОН" or "Обнаружена клавиатура — рекомендуется ПК",
    TextColor3=Theme.Success, Font=Enum.Font.GothamMedium, TextSize=12,
    TextXAlignment=Enum.TextXAlignment.Center, Parent=PCenter
})

if autoDetected then
    Tween(MobileStroke, 0.3, {Color=Theme.Success, Thickness=2})
else
    Tween(PCStroke, 0.3, {Color=Theme.Success, Thickness=2})
end

local function FinalizePlatform(platform)
    if PlatformSelected then return end
    PlatformSelected = true
    CFG.UI.Platform = platform
    CFG.UI.IsMobile = (platform == "Mobile")
    PlaySound(CFG.UI.ClickSound, 0.3)
    Tween(PFrame, 0.4, {BackgroundTransparency=1})
    for _, c in ipairs(PCenter:GetDescendants()) do
        if c:IsA("TextLabel") then Tween(c, 0.3, {TextTransparency=1})
        elseif c:IsA("TextButton") then Tween(c, 0.3, {BackgroundTransparency=1}) end
    end
    Tween(PCenter, 0.4, {BackgroundTransparency=1})
    task.delay(0.5, function()
        PlatformGui:Destroy()
        if _G.ZenithEmpireOnPlatformChosen then _G.ZenithEmpireOnPlatformChosen(platform) end
    end)
end

PCButton.MouseButton1Click:Connect(function() FinalizePlatform("PC") end)
MobileButton.MouseButton1Click:Connect(function() FinalizePlatform("Mobile") end)
PCButton.TouchTap:Connect(function() FinalizePlatform("PC") end)
MobileButton.TouchTap:Connect(function() FinalizePlatform("Mobile") end)
-- LOADING
local loadingFrame = Create("Frame", {
    Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(8,8,10),
    BorderSizePixel=0, ZIndex=9999, Visible=false, Parent=gui
})
local lt = Create("TextLabel", {
    Size=UDim2.new(1,0,0,60), Position=UDim2.new(0,0,0.42,-60),
    BackgroundTransparency=1, Text="ZENITH EMPIRE", TextColor3=Color3.fromRGB(255,255,255),
    Font=Enum.Font.GothamBlack, TextSize=52, ZIndex=10000, Parent=loadingFrame
})
Create("UIGradient", {
    Color=ColorSequence.new(Color3.fromRGB(255,255,255), Color3.fromRGB(120,120,130)),
    Parent=lt
})
Create("TextLabel", {
    Size=UDim2.new(1,0,0,20), Position=UDim2.new(0,0,0.42,0),
    BackgroundTransparency=1, Text="By ALTRON", TextColor3=Theme.TextDim,
    Font=Enum.Font.Gotham, TextSize=12, ZIndex=10000, Parent=loadingFrame
})
local lbBg = Create("Frame", {
    Size=UDim2.new(0,340,0,4), Position=UDim2.new(0.5,-170,0.42,40),
    BackgroundColor3=Color3.fromRGB(40,40,45), BorderSizePixel=0,
    ZIndex=10000, Parent=loadingFrame
})
Corner(lbBg, 2)
local lbF = Create("Frame", {
    Size=UDim2.new(0,0,1,0), BackgroundColor3=Theme.Accent,
    BorderSizePixel=0, ZIndex=10001, Parent=lbBg
})
Corner(lbF, 2)

-- MAIN
local WIN_W, WIN_H = 700, 430
local NAV_W = 155
local TOP_H = 44

local MainGroup = Create("CanvasGroup", {
    Name="MainGroup", Size=UDim2.new(0,WIN_W,0,WIN_H),
    Position=UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H/2),
    BackgroundTransparency=1, BorderSizePixel=0,
    Visible=false, GroupTransparency=1, ZIndex=50, Parent=gui
})

local Main = Create("Frame", {
    Name="Main", Size=UDim2.new(1,0,1,0),
    BackgroundColor3=Theme.Bg, BackgroundTransparency=0,
    BorderSizePixel=0, ZIndex=50, Parent=MainGroup
})
Corner(Main, 12)
Stroke(Main, Theme.Stroke, 1.2)
Create("UIGradient", {Color=ColorSequence.new(Theme.Bg2, Theme.Bg), Rotation=90, Parent=Main})

local PreviewGroup
do
    local dragging, start, sp
    local bar = Create("Frame", {Size=UDim2.new(1,0,0,TOP_H), BackgroundTransparency=1, ZIndex=51, Parent=Main})
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging=true; start=i.Position; sp=MainGroup.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - start
            MainGroup.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
            if PreviewGroup then
                PreviewGroup.Position = UDim2.new(
                    MainGroup.Position.X.Scale,
                    MainGroup.Position.X.Offset + MainGroup.AbsoluteSize.X + 20,
                    MainGroup.Position.Y.Scale,
                    MainGroup.Position.Y.Offset
                )
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging=false end
    end)
end

local logo = Create("Frame", {
    Size=UDim2.new(0,32,0,32), Position=UDim2.new(0,14,0,6),
    BackgroundColor3=Theme.Accent, BorderSizePixel=0, ZIndex=51, Parent=Main
})
Corner(logo, 9)
Create("TextLabel", {
    Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
    Text="Z", TextColor3=Theme.Bg, Font=Enum.Font.GothamBlack,
    TextSize=18, ZIndex=52, Parent=logo
})
Create("TextLabel", {
    Size=UDim2.new(0,200,0,20), Position=UDim2.new(0,54,0,8),
    BackgroundTransparency=1, Text="ZENITH EMPIRE", TextColor3=Theme.Text,
    Font=Enum.Font.GothamBold, TextSize=15,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=51, Parent=Main
})
Create("TextLabel", {
    Size=UDim2.new(0,200,0,12), Position=UDim2.new(0,54,0,25),
    BackgroundTransparency=1, Text="By ALTRON", TextColor3=Theme.TextMuted,
    Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=51, Parent=Main
})

local closeBtn = Create("TextButton", {
    Size=UDim2.new(0,26,0,26), Position=UDim2.new(1,-38,0,10),
    BackgroundColor3=Theme.Element, Text="x", TextColor3=Theme.TextDim,
    Font=Enum.Font.GothamBold, TextSize=12,
    AutoButtonColor=false, ZIndex=51, Parent=Main
})
Corner(closeBtn, 7)
closeBtn.MouseEnter:Connect(function() Tween(closeBtn, 0.15, {BackgroundColor3=Theme.Danger, TextColor3=Color3.fromRGB(255,255,255)}) end)
closeBtn.MouseLeave:Connect(function() Tween(closeBtn, 0.15, {BackgroundColor3=Theme.Element, TextColor3=Theme.TextDim}) end)
closeBtn.MouseButton1Click:Connect(function() Click(); _G.ZenithEmpireSetMenuOpen(false) end)

-- Mobile menu button
local mobileMenuBtn = Create("TextButton", {
    Name="MobileMenuBtn",
    Size=UDim2.new(0,50,0,50), Position=UDim2.new(0,20,0.5,-25),
    BackgroundColor3=Theme.Bg2, Text="Z", TextColor3=Theme.Accent,
    Font=Enum.Font.GothamBlack, TextSize=22,
    AutoButtonColor=false, Visible=false, ZIndex=500, Parent=gui
})
Corner(mobileMenuBtn, 25)
Stroke(mobileMenuBtn, Theme.Accent, 1.5)
mobileMenuBtn.MouseButton1Click:Connect(function()
    Click()
    _G.ZenithEmpireSetMenuOpen(not menuOpen)
end)
mobileMenuBtn.TouchTap:Connect(function()
    Click()
    _G.ZenithEmpireSetMenuOpen(not menuOpen)
end)

local Nav = Create("Frame", {
    Size=UDim2.new(0,NAV_W,1,-TOP_H-16), Position=UDim2.new(0,12,0,TOP_H+6),
    BackgroundColor3=Theme.Panel, BackgroundTransparency=0.25,
    BorderSizePixel=0, ZIndex=51, Parent=Main
})
Corner(Nav, 10)
Stroke(Nav, Theme.Stroke, 1)

local NavScroll = Create("ScrollingFrame", {
    Size=UDim2.new(1,-8,1,-16), Position=UDim2.new(0,4,0,8),
    BackgroundTransparency=1, BorderSizePixel=0,
    ScrollBarThickness=2, ScrollBarImageColor3=Theme.Accent,
    CanvasSize=UDim2.new(0,0,0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    ScrollingDirection=Enum.ScrollingDirection.Y,
    ZIndex=52, Parent=Nav
})
local NavHolder = Create("Frame", {
    Size=UDim2.new(1,0,1,0),
    BackgroundTransparency=1, ZIndex=52, Parent=NavScroll
})
Create("UIListLayout", {Padding=UDim.new(0,3), SortOrder=Enum.SortOrder.LayoutOrder, Parent=NavHolder})

local Content = Create("Frame", {
    Size=UDim2.new(1,-NAV_W-24,1,-TOP_H-16), Position=UDim2.new(0,NAV_W+18,0,TOP_H+6),
    BackgroundTransparency=1, ClipsDescendants=true, ZIndex=51, Parent=Main
})

local PageTitle = Create("TextLabel", {
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1,
    Text="Главная", TextColor3=Theme.Text,
    Font=Enum.Font.GothamBold, TextSize=18,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=52, Parent=Content
})
Create("Frame", {
    Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,0,30),
    BackgroundColor3=Theme.Stroke, BorderSizePixel=0, ZIndex=52, Parent=Content
})

local Scroll = Create("ScrollingFrame", {
    Size=UDim2.new(1,0,1,-40), Position=UDim2.new(0,0,0,38),
    BackgroundTransparency=1, BorderSizePixel=0,
    ScrollBarThickness=3, ScrollBarImageColor3=Theme.Accent,
    CanvasSize=UDim2.new(0,0,0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    ScrollingDirection=Enum.ScrollingDirection.Y,
    ZIndex=52, Parent=Content
})
Create("UIListLayout", {Padding=UDim.new(0,5), SortOrder=Enum.SortOrder.LayoutOrder, Parent=Scroll})

Create("TextLabel", {
    Size=UDim2.new(0,200,0,16), Position=UDim2.new(1,-214,1,-22),
    BackgroundTransparency=1, Text="@"..LocalPlayer.Name,
    TextColor3=Theme.TextMuted, Font=Enum.Font.GothamMedium,
    TextSize=11, TextXAlignment=Enum.TextXAlignment.Right,
    ZIndex=51, Parent=Main
})

-- PREVIEW
PreviewGroup = Create("CanvasGroup", {
    Name="PreviewGroup", Size=UDim2.new(0,220,0,WIN_H),
    Position=UDim2.new(0.5,WIN_W/2+10,0.5,-WIN_H/2),
    BackgroundTransparency=1, BorderSizePixel=0,
    Visible=false, GroupTransparency=1, ZIndex=50, Parent=gui
})
local Preview = Create("Frame", {
    Name="Preview", Size=UDim2.new(1,0,1,0),
    BackgroundColor3=Theme.Bg, BorderSizePixel=0, ZIndex=50, Parent=PreviewGroup
})
Corner(Preview, 12)
Stroke(Preview, Theme.Stroke, 1.2)
Create("UIGradient", {Color=ColorSequence.new(Theme.Bg2, Theme.Bg), Rotation=90, Parent=Preview})
Create("TextLabel", {
    Size=UDim2.new(1,0,0,20), Position=UDim2.new(0,0,0,12),
    BackgroundTransparency=1, Text="PREVIEW", TextColor3=Theme.TextDim,
    Font=Enum.Font.GothamBold, TextSize=10, ZIndex=51, Parent=Preview
})
local refreshBtn = Create("TextButton", {
    Size=UDim2.new(0,60,0,18), Position=UDim2.new(1,-70,0,14),
    BackgroundColor3=Theme.Element, Text="Refresh", TextColor3=Theme.TextDim,
    Font=Enum.Font.GothamMedium, TextSize=10,
    AutoButtonColor=false, ZIndex=52, Parent=Preview
})
Corner(refreshBtn, 5)
refreshBtn.MouseEnter:Connect(function() Tween(refreshBtn, 0.12, {BackgroundColor3=Theme.ElementHov, TextColor3=Theme.Text}) end)
refreshBtn.MouseLeave:Connect(function() Tween(refreshBtn, 0.12, {BackgroundColor3=Theme.Element, TextColor3=Theme.TextDim}) end)
local Viewport = Create("ViewportFrame", {
    Size=UDim2.new(1,-20,1,-50), Position=UDim2.new(0,10,0,36),
    BackgroundColor3=Color3.fromRGB(10,10,12), BackgroundTransparency=0.1,
    BorderSizePixel=0, ZIndex=51, Parent=Preview
})
Corner(Viewport, 10)
Stroke(Viewport, Theme.Stroke, 1)

-- PALETTE
local Palette = Create("Frame", {
    Size=UDim2.new(0,240,0,240), Position=UDim2.new(0.5,-120,0.5,-120),
    BackgroundColor3=Theme.Bg2, BorderSizePixel=0,
    Visible=false, ZIndex=200, Parent=gui
})
Corner(Palette, 12)
Stroke(Palette, Theme.StrokeHov, 1.5)
Create("TextLabel", {
    Size=UDim2.new(1,-40,0,24), Position=UDim2.new(0,14,0,8),
    BackgroundTransparency=1, Text="COLOR", TextColor3=Theme.Text,
    Font=Enum.Font.GothamBold, TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=201, Parent=Palette
})
local palClose = Create("TextButton", {
    Size=UDim2.new(0,22,0,22), Position=UDim2.new(1,-30,0,10),
    BackgroundColor3=Theme.Element, Text="x", TextColor3=Theme.TextDim,
    Font=Enum.Font.GothamBold, TextSize=11,
    AutoButtonColor=false, ZIndex=201, Parent=Palette
})
Corner(palClose, 6)
palClose.MouseButton1Click:Connect(function() Palette.Visible=false end)

local swatchColors = {
    Color3.fromRGB(255,255,255), Color3.fromRGB(220,220,220), Color3.fromRGB(180,180,180),
    Color3.fromRGB(130,130,130), Color3.fromRGB(80,80,80),    Color3.fromRGB(30,30,30),
    Color3.fromRGB(255,80,80),   Color3.fromRGB(255,160,80),  Color3.fromRGB(255,220,80),
    Color3.fromRGB(180,255,100), Color3.fromRGB(120,240,160), Color3.fromRGB(80,220,220),
    Color3.fromRGB(80,160,255),  Color3.fromRGB(120,100,255), Color3.fromRGB(180,80,255),
    Color3.fromRGB(255,80,200),  Color3.fromRGB(255,120,160), Color3.fromRGB(140,70,40),
    Color3.fromRGB(100,60,40),   Color3.fromRGB(60,40,30),
}
local pickRow = Create("Frame", {
    Size=UDim2.new(1,-20,0,90), Position=UDim2.new(0,10,0,36),
    BackgroundTransparency=1, ZIndex=201, Parent=Palette
})
Create("UIGridLayout", {CellSize=UDim2.new(0,28,0,28), CellPadding=UDim2.new(0,6,0,6), Parent=pickRow})
local palCallback
for _, col in ipairs(swatchColors) do
    local sw = Create("TextButton", {BackgroundColor3=col, Text="", AutoButtonColor=false, ZIndex=202, Parent=pickRow})
    Corner(sw, 6); Stroke(sw, Theme.Stroke, 1)
    sw.MouseButton1Click:Connect(function()
        Click()
        if palCallback then palCallback(col) end
        Palette.Visible=false
    end)
    sw.TouchTap:Connect(function()
        Click()
        if palCallback then palCallback(col) end
        Palette.Visible=false
    end)
end

local hueBar = Create("Frame", {
    Size=UDim2.new(1,-20,0,12), Position=UDim2.new(0,10,0,138),
    BackgroundColor3=Color3.fromRGB(60,60,60), BorderSizePixel=0, ZIndex=201, Parent=Palette
})
Corner(hueBar, 6)
Create("UIGradient", {
    Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255,255,0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0,255,0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0,0,255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255,0,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0)),
    }, Parent=hueBar
})
local satBar = Create("Frame", {
    Size=UDim2.new(1,-20,0,12), Position=UDim2.new(0,10,0,158),
    BackgroundColor3=Color3.fromRGB(60,60,60), BorderSizePixel=0, ZIndex=201, Parent=Palette
})
Corner(satBar, 6)
local hueHandle = Create("Frame", {
    Size=UDim2.new(0,8,0,16), Position=UDim2.new(0,-4,0.5,-8),
    BackgroundColor3=Color3.fromRGB(255,255,255), BorderSizePixel=0, ZIndex=202, Parent=hueBar
})
Corner(hueHandle, 3)
local satHandle = Create("Frame", {
    Size=UDim2.new(0,8,0,16), Position=UDim2.new(1,-4,0.5,-8),
    BackgroundColor3=Color3.fromRGB(255,255,255), BorderSizePixel=0, ZIndex=202, Parent=satBar
})
Corner(satHandle, 3)

local hueVal, satVal = 0, 1
local function dragBar(bar, cb)
    local dragging = false
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging=true; cb(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then cb(i) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging=false end
    end)
end
dragBar(hueBar, function(i)
    local p = math.clamp((i.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
    hueVal = p
    hueHandle.Position = UDim2.new(p, -4, 0.5, -8)
    if palCallback then palCallback(Color3.fromHSV(hueVal, satVal, 1)) end
end)
dragBar(satBar, function(i)
    local p = math.clamp((i.Position.X - satBar.AbsolutePosition.X) / satBar.AbsoluteSize.X, 0, 1)
    satVal = p
    satHandle.Position = UDim2.new(p, -4, 0.5, -8)
    if palCallback then palCallback(Color3.fromHSV(hueVal, satVal, 1)) end
end)

local function OpenPalette(initial, cb)
    palCallback = cb
    if initial then
        local h, s = Color3.toHSV(initial)
        hueVal, satVal = h, s
        hueHandle.Position = UDim2.new(h, -4, 0.5, -8)
        satHandle.Position = UDim2.new(s, -4, 0.5, -8)
    end
    Palette.Visible = true
end

-- WIDGETS
local toggleRefs = {}
local sliderRefs = {}

local function SectionLabel(text)
    Create("TextLabel", {
        Size=UDim2.new(1,-4,0,18), BackgroundTransparency=1,
        Text=text, TextColor3=Theme.TextMuted,
        Font=Enum.Font.GothamBold, TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=Scroll
    })
end

local function Toggle(text, default, callback)
    local state = default or false
    local btn = Create("TextButton", {
        Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element,
        Text="", AutoButtonColor=false, Parent=Scroll
    })
    Corner(btn, 8)
    local str = Stroke(btn, Theme.Stroke, 1)
    Create("TextLabel", {
        Size=UDim2.new(1,-60,1,0), Position=UDim2.new(0,14,0,0),
        BackgroundTransparency=1, Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=btn
    })
    local track = Create("Frame", {
        Size=UDim2.new(0,32,0,16), Position=UDim2.new(1,-46,0.5,-8),
        BackgroundColor3=state and _G.ZenithAccent() or Color3.fromRGB(60,60,68),
        BorderSizePixel=0, Parent=btn
    })
    Corner(track, 8)
    local ball = Create("Frame", {
        Size=UDim2.new(0,12,0,12),
        Position=state and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6),
        BackgroundColor3=state and Theme.Bg or Color3.fromRGB(200,200,210),
        BorderSizePixel=0, Parent=track
    })
    Corner(ball, 6)
    btn.MouseEnter:Connect(function()
        Tween(btn, 0.12, {BackgroundColor3=Theme.ElementHov})
        Tween(str, 0.12, {Color=Theme.StrokeHov})
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, 0.12, {BackgroundColor3=Theme.Element})
        Tween(str, 0.12, {Color=Theme.Stroke})
    end)
    local function set(v, silent)
        state = v
        local accent = _G.ZenithAccent()
        Tween(track, 0.18, {BackgroundColor3=v and accent or Color3.fromRGB(60,60,68)})
        Tween(ball, 0.18, {
            Position=v and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6),
            BackgroundColor3=v and Theme.Bg or Color3.fromRGB(200,200,210)
        })
        if not silent then SafeCall(callback, v) end
    end
    local function refresh()
        local accent = _G.ZenithAccent()
        track.BackgroundColor3 = state and accent or Color3.fromRGB(60,60,68)
    end
    table.insert(toggleRefs, {track=track, refresh=refresh})
    btn.MouseButton1Click:Connect(function() set(not state); Click() end)
    btn.TouchTap:Connect(function() set(not state); Click() end)
    return {set=set, get=function() return state end}
end

local function Slider(text, min, max, default, callback)
    local val = default or min
    local frame = Create("Frame", {
        Size=UDim2.new(1,-8,0,46), BackgroundColor3=Theme.Element, Parent=Scroll
    })
    Corner(frame, 8)
    Stroke(frame, Theme.Stroke, 1)
    Create("TextLabel", {
        Size=UDim2.new(1,-100,0,18), Position=UDim2.new(0,14,0,5),
        BackgroundTransparency=1, Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=frame
    })
    local valueLbl = Create("TextLabel", {
        Size=UDim2.new(0,70,0,18), Position=UDim2.new(1,-80,0,5),
        BackgroundTransparency=1, Text=tostring(val),
        TextColor3=Theme.Accent2,
        Font=Enum.Font.GothamMedium, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Right, Parent=frame
    })
    local track = Create("Frame", {
        Size=UDim2.new(1,-28,0,8), Position=UDim2.new(0,14,1,-18),
        BackgroundColor3=Color3.fromRGB(50,50,58),
        BorderSizePixel=0, Parent=frame
    })
    Corner(track, 4)
    local fill = Create("Frame", {
        Size=UDim2.new((val-min)/(max-min), 0, 1, 0),
        BackgroundColor3=_G.ZenithAccent(), BorderSizePixel=0, Parent=track
    })
    Corner(fill, 4)
    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        val = min + (max - min) * pos
        if max - min >= 100 then val = math.floor(val) end
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valueLbl.Text = tostring(math.floor(val * 100) / 100)
        SafeCall(callback, val)
    end
    local function refresh()
        fill.BackgroundColor3 = _G.ZenithAccent()
    end
    table.insert(sliderRefs, {fill=fill, refresh=refresh})
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging=true; update(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging=false end
    end)
    return {set=function(v)
        val = v
        local pos = (v - min) / (max - min)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valueLbl.Text = tostring(math.floor(v * 100) / 100)
    end}
end

local function Button(text, callback)
    local btn = Create("TextButton", {
        Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element,
        Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=13,
        AutoButtonColor=false, Parent=Scroll
    })
    Corner(btn, 8)
    local s = Stroke(btn, Theme.Stroke, 1)
    btn.MouseEnter:Connect(function()
        Tween(btn, 0.12, {BackgroundColor3=Theme.ElementHov})
        Tween(s, 0.12, {Color=Theme.StrokeHov})
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, 0.12, {BackgroundColor3=Theme.Element})
        Tween(s, 0.12, {Color=Theme.Stroke})
    end)
    btn.MouseButton1Click:Connect(function() Click(); SafeCall(callback) end)
    btn.TouchTap:Connect(function() Click(); SafeCall(callback) end)
    return btn
end

local function Keybind(text, defaultKey, callback)
    if CFG.UI.IsMobile then
        local state = false
        local btn = Create("TextButton", {
            Size=UDim2.new(1,-8,0,40), BackgroundColor3=Theme.Element,
            Text=text .. ": OFF", TextColor3=Theme.Text,
            Font=Enum.Font.GothamBold, TextSize=13,
            AutoButtonColor=false, Parent=Scroll
        })
        Corner(btn, 8)
        Stroke(btn, Theme.Stroke, 1)
        local function flip()
            state = not state
            btn.Text = text .. ": " .. (state and "ON" or "OFF")
            btn.BackgroundColor3 = state and _G.ZenithAccent() or Theme.Element
            btn.TextColor3 = state and Theme.Bg or Theme.Text
            Click()
            SafeCall(callback, state)
        end
        btn.MouseButton1Click:Connect(flip)
        btn.TouchTap:Connect(flip)
        return function() return state end
    end

    local currentKey = defaultKey
    local btn = Create("TextButton", {
        Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element,
        Text="", AutoButtonColor=false, Parent=Scroll
    })
    Corner(btn, 8)
    Stroke(btn, Theme.Stroke, 1)
    Create("TextLabel", {
        Size=UDim2.new(1,-100,1,0), Position=UDim2.new(0,14,0,0),
        BackgroundTransparency=1, Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=btn
    })
    local valLbl = Create("TextLabel", {
        Size=UDim2.new(0,80,1,0), Position=UDim2.new(1,-90,0,0),
        BackgroundTransparency=1, Text=currentKey and currentKey.Name or "None",
        TextColor3=Theme.Accent2,
        Font=Enum.Font.GothamMedium, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Right, Parent=btn
    })
    local listening = false
    btn.MouseButton1Click:Connect(function() listening=true; valLbl.Text="..." end)
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not listening then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentKey = input.KeyCode
            valLbl.Text = currentKey.Name
            listening = false
            SafeCall(callback, currentKey)
        end
    end)
    return function() return currentKey end
end

local function ColorPicker(text, defaultColor, callback)
    local btn = Create("TextButton", {
        Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element,
        Text="", AutoButtonColor=false, Parent=Scroll
    })
    Corner(btn, 8)
    Stroke(btn, Theme.Stroke, 1)
    Create("TextLabel", {
        Size=UDim2.new(1,-70,1,0), Position=UDim2.new(0,14,0,0),
        BackgroundTransparency=1, Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=btn
    })
    local sw = Create("Frame", {
        Size=UDim2.new(0,24,0,24), Position=UDim2.new(1,-38,0.5,-12),
        BackgroundColor3=defaultColor or Color3.fromRGB(255,255,255),
        BorderSizePixel=0, Parent=btn
    })
    Corner(sw, 6)
    Stroke(sw, Theme.Stroke, 1)
    btn.MouseEnter:Connect(function() Tween(btn, 0.12, {BackgroundColor3=Theme.ElementHov}) end)
    btn.MouseLeave:Connect(function() Tween(btn, 0.12, {BackgroundColor3=Theme.Element}) end)
    local function open()
        Click()
        OpenPalette(sw.BackgroundColor3, function(c)
            sw.BackgroundColor3 = c
            SafeCall(callback, c)
        end)
    end
    btn.MouseButton1Click:Connect(open)
    btn.TouchTap:Connect(open)
    return {set=function(c) sw.BackgroundColor3=c end}
end

local function Dropdown(text, options, default, callback)
    local current = default or options[1]
    local btn = Create("TextButton", {
        Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element,
        Text="", AutoButtonColor=false, Parent=Scroll
    })
    Corner(btn, 8)
    Stroke(btn, Theme.Stroke, 1)
    Create("TextLabel", {
        Size=UDim2.new(1,-100,1,0), Position=UDim2.new(0,14,0,0),
        BackgroundTransparency=1, Text=text, TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=btn
    })
    local valLbl = Create("TextLabel", {
        Size=UDim2.new(0,80,1,0), Position=UDim2.new(1,-90,0,0),
        BackgroundTransparency=1, Text=tostring(current),
        TextColor3=Theme.Accent2,
        Font=Enum.Font.GothamMedium, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Right, Parent=btn
    })

    local list = Create("Frame", {
        Size=UDim2.new(1,0,0,0), Position=UDim2.new(0,0,1,4),
        BackgroundColor3=Theme.Bg2, BorderSizePixel=0,
        Visible=false, ZIndex=300, Parent=btn
    })
    Corner(list, 8)
    Stroke(list, Theme.StrokeHov, 1)
    Create("UIListLayout", {Padding=UDim.new(0,2), Parent=list})

    local isOpen = false
    for i, opt in ipairs(options) do
        local optBtn = Create("TextButton", {
            Size=UDim2.new(1,-8,0,28), BackgroundColor3=Theme.Element,
            Text=tostring(opt), TextColor3=Theme.Text,
            Font=Enum.Font.GothamMedium, TextSize=12,
            AutoButtonColor=false, LayoutOrder=i, Parent=list
        })
        Corner(optBtn, 6)
        optBtn.MouseEnter:Connect(function() Tween(optBtn, 0.1, {BackgroundColor3=Theme.ElementHov}) end)
        optBtn.MouseLeave:Connect(function() Tween(optBtn, 0.1, {BackgroundColor3=Theme.Element}) end)
        local function pick()
            current = opt
            valLbl.Text = tostring(opt)
            isOpen = false
            Tween(list, 0.15, {Size=UDim2.new(1,0,0,0)})
            task.delay(0.15, function() list.Visible = false end)
            Click()
            SafeCall(callback, opt)
        end
        optBtn.MouseButton1Click:Connect(pick)
        optBtn.TouchTap:Connect(pick)
    end

    local function toggle()
        isOpen = not isOpen
        if isOpen then
            local h = #options * 30 + 6
            list.Visible = true
            Tween(list, 0.15, {Size=UDim2.new(1,0,0,h)})
        else
            Tween(list, 0.15, {Size=UDim2.new(1,0,0,0)})
            task.delay(0.15, function() list.Visible = false end)
        end
        Click()
    end
    btn.MouseButton1Click:Connect(toggle)
    btn.TouchTap:Connect(toggle)

    return {set=function(v) current = v; valLbl.Text = tostring(v) end}
end
-- PREVIEW BUILD
local previewModel, previewAngle = nil, 0
local previewAura, previewHalo, previewChamsHL, previewOutlineHL, previewRing, previewParticles
local previewOrbs = {}

local function ClearPreviewVisuals()
    for _, ref in ipairs({previewAura, previewHalo, previewChamsHL, previewOutlineHL, previewRing, previewParticles}) do
        if ref then ref:Destroy() end
    end
    previewAura, previewHalo, previewChamsHL, previewOutlineHL, previewRing, previewParticles = nil,nil,nil,nil,nil,nil
    for _, o in ipairs(previewOrbs) do if o.Parent then o:Destroy() end end
    previewOrbs = {}
end

local function BuildPreview()
    ClearPreviewVisuals()
    if previewModel then previewModel:Destroy(); previewModel = nil end
    local char = LocalPlayer.Character
    if not char then
        task.spawn(function()
            local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            c:WaitForChild("Humanoid", 5); task.wait(0.5)
            BuildPreview()
        end)
        return
    end
    char:WaitForChild("HumanoidRootPart", 5)
    previewModel = Create("Model", {Name="ZenithPreview"})
    local hrp = char:FindFirstChild("HumanoidRootPart")
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local clone = part:Clone()
            clone.Anchored = true; clone.CanCollide = false
            clone.CanQuery = false; clone.CanTouch = false
            for _, child in ipairs(clone:GetDescendants()) do
                if child:IsA("Script") or child:IsA("LocalScript")
                   or child:IsA("Sound") or child:IsA("Motor6D")
                   or child:IsA("Weld") or child:IsA("JointInstance")
                   or child:IsA("ParticleEmitter") or child:IsA("Trail")
                   or child:IsA("Beam") or child:IsA("Fire")
                   or child:IsA("Smoke") or child:IsA("Sparkles") then
                    pcall(function() child:Destroy() end)
                end
            end
            if hrp then clone.CFrame = hrp.CFrame:ToObjectSpace(part.CFrame) end
            clone.Parent = previewModel
        end
    end
    for _, acc in ipairs(char:GetChildren()) do
        if acc:IsA("Accessory") then
            local clone = acc:Clone()
            for _, d in ipairs(clone:GetDescendants()) do
                if d:IsA("BasePart") then
                    d.Anchored = true; d.CanCollide = false; d.CanQuery = false
                    if hrp then d.CFrame = hrp.CFrame:ToObjectSpace(d.CFrame) end
                end
                if d:IsA("Script") or d:IsA("LocalScript") then pcall(function() d:Destroy() end) end
            end
            clone.Parent = previewModel
        end
    end
    for _, clothing in ipairs(char:GetChildren()) do
        if clothing:IsA("Shirt") or clothing:IsA("Pants") or clothing:IsA("ShirtGraphic") then
            clothing:Clone().Parent = previewModel
        end
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        for _, item in ipairs(hum:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                local clone = item:Clone()
                if clone:IsA("Accessory") then
                    for _, d in ipairs(clone:GetDescendants()) do
                        if d:IsA("BasePart") then
                            d.Anchored = true; d.CanCollide = false
                            if hrp then d.CFrame = hrp.CFrame:ToObjectSpace(d.CFrame) end
                        end
                    end
                end
                clone.Parent = previewModel
            end
        end
    end
    local bc = hum and hum:FindFirstChild("BodyColors")
    if bc then bc:Clone().Parent = previewModel end
    if #previewModel:GetChildren() == 0 then task.wait(0.5); BuildPreview() return end
    Viewport.CurrentCamera = Create("Camera", {Parent=Viewport})
    local cam = Viewport.CurrentCamera
    cam.FieldOfView = 45
    cam.CFrame = CFrame.new(Vector3.new(0, 2, 12), Vector3.new(0, 0, 0))
    previewModel.Parent = Viewport
    Create("PointLight", {Brightness=3, Range=30, Color=Color3.fromRGB(255,255,255), Parent=cam})
    Create("PointLight", {Brightness=1.5, Range=25, Color=Color3.fromRGB(200,200,220), Parent=cam})
end

local function WatchCharacter(char)
    if not char then return end
    char.ChildAdded:Connect(function(child)
        if child:IsA("Accessory") or child:IsA("Shirt") or child:IsA("Pants") or child:IsA("ShirtGraphic") then
            task.wait(0.3); BuildPreview()
        end
    end)
    char.ChildRemoved:Connect(function(child)
        if child:IsA("Accessory") or child:IsA("Shirt") or child:IsA("Pants") or child:IsA("ShirtGraphic") then
            task.wait(0.3); BuildPreview()
        end
    end)
end
if LocalPlayer.Character then WatchCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(c) task.wait(1); WatchCharacter(c); BuildPreview() end)
refreshBtn.MouseButton1Click:Connect(function() Click(); BuildPreview(); Notify("Превью обновлено", Theme.Success) end)

-- PAGES
local pages = {}
local navButtons = {}
local currentPage

local function ClearScroll()
    for _, c in ipairs(Scroll:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end
end

local function AddNavButton(name)
    local btn = Create("TextButton", {
        Size=UDim2.new(1,0,0,30), BackgroundColor3=Theme.Panel,
        BackgroundTransparency=1, Text="", AutoButtonColor=false, Parent=NavHolder
    })
    Corner(btn, 8)
    local accent = Create("Frame", {
        Size=UDim2.new(0,3,0.5,0), Position=UDim2.new(0,0,0.25,0),
        BackgroundColor3=_G.ZenithAccent(), BorderSizePixel=0,
        BackgroundTransparency=1, Parent=btn
    })
    Corner(accent, 2)
    local label = Create("TextLabel", {
        Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,14,0,0),
        BackgroundTransparency=1, Text=name, TextColor3=Theme.TextDim,
        Font=Enum.Font.GothamMedium, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=btn
    })
    btn.MouseEnter:Connect(function()
        if currentPage ~= name then
            Tween(btn, 0.15, {BackgroundColor3=Theme.Element, BackgroundTransparency=0.4})
        end
    end)
    btn.MouseLeave:Connect(function()
        if currentPage ~= name then Tween(btn, 0.15, {BackgroundTransparency=1}) end
    end)
    local function switch()
        if currentPage == name then return end
        Click()
        currentPage = name
        PageTitle.Text = name
        for n, b in pairs(navButtons) do
            local active = (n == name)
            Tween(b.btn, 0.15, {
                BackgroundColor3=active and Theme.Element or Theme.Panel,
                BackgroundTransparency=active and 0 or 1
            })
            Tween(b.accent, 0.15, {BackgroundTransparency=active and 0 or 1})
            Tween(b.label, 0.15, {TextColor3=active and Theme.Text or Theme.TextDim})
        end
        ClearScroll()
        if pages[name] then pages[name]() end
    end
    btn.MouseButton1Click:Connect(switch)
    btn.TouchTap:Connect(switch)
    navButtons[name] = {btn=btn, accent=accent, label=label}
end

-- ГЛАВНАЯ
pages["Главная"] = function()
    SectionLabel("ОБЩЕЕ")
    Toggle("Master Switch", CFG.Master, function(v)
        CFG.Master = v
        if not v then
            -- Выключаем ВСЁ при снятии Master
            for name, cfg in pairs(CFG.Char) do
                if type(cfg) == "table" and cfg.Enabled ~= nil then cfg.Enabled = false end
            end
            for _, k in ipairs({"Box","Name","Health","Distance","Tracer","HeadDot","Chams","Outline","Rainbow"}) do
                CFG.ESP[k] = false
            end
            for k, _ in pairs(CFG.Cheats) do
                if type(CFG.Cheats[k]) == "boolean" and k:find("Enabled") then
                    CFG.Cheats[k] = false
                end
            end
            if CFG.Cheats then
                CFG.Cheats.AntiFling = false
                CFG.Cheats.AntiVoid = false
                CFG.Cheats.InfiniteJump = false
                CFG.Cheats.DoubleJump = false
                CFG.Cheats.GodMode = false
                CFG.Cheats.AntiAFK = false
                CFG.Cheats.AntiSlow = false
                CFG.Cheats.AntiStun = false
                CFG.Cheats.NoFallDamage = false
                CFG.Cheats.FreezePlayer = false
                CFG.Cheats.WalkOnWater = false
                CFG.Cheats.AutoRespawn = false
                CFG.Cheats.InfiniteYield = false
            end
            Notify("Master OFF — всё выключено", Theme.Danger)
        else
            Notify("Master ON", Theme.Success)
        end
    end)
    SectionLabel("ФИЛЬТРЫ")
    Toggle("Team Check", CFG.ESP.TeamCheck, function(v) CFG.ESP.TeamCheck = v end)
    SectionLabel("БЫСТРОЕ")
    Button("Включить все визуалы", function()
        for _, n in ipairs({"Halo","Aura","Outline","Chams","Trail","Glow","Orbs","Ring","Particles","FireAura","IceAura","Lightning","Wings"}) do
            CFG.Char[n].Enabled = true
        end
        CFG.ESP.Box = true; CFG.ESP.Name = true
        Notify("Всё включено", Theme.Success)
    end)
    Button("Выключить всё", function()
        for _, n in ipairs({"Halo","Aura","Outline","Chams","Trail","Glow","Orbs","Ring","Particles","FireAura","IceAura","Lightning","Wings"}) do
            CFG.Char[n].Enabled = false
        end
        for _, n in ipairs({"Box","Name","Health","Distance","Tracer","HeadDot","Chams","Outline"}) do
            CFG.ESP[n] = false
        end
        Notify("Всё выключено", Theme.Danger)
    end)
end

-- ЧИТЫ
pages["Читы"] = function()
    local CC = CFG.Cheats

    SectionLabel("СКОРОСТЬ")
    Toggle("Speed Enabled", CC.SpeedEnabled, function(v)
        CC.SpeedEnabled = v
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v and CC.WalkSpeed or 16 end
    end)
    Slider("Walk Speed", 16, 500, CC.WalkSpeed, function(v)
        CC.WalkSpeed = v
        if CC.SpeedEnabled then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end)
    Dropdown("Speed Mode", {"Toggle", "Hold"}, CC.SpeedMode, function(v) CC.SpeedMode = v end)
    Keybind("Speed Keybind", CC.SpeedKeybind, function(k) CC.SpeedKeybind = k end)

    SectionLabel("ПРЫЖОК")
    Toggle("Jump Enabled", CC.JumpEnabled, function(v)
        CC.JumpEnabled = v
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = v and CC.JumpPower or 50
        end
    end)
    Slider("Jump Power", 50, 500, CC.JumpPower, function(v)
        CC.JumpPower = v
        if CC.JumpEnabled then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.UseJumpPower = true; hum.JumpPower = v end
        end
    end)
    Toggle("Infinite Jump", CC.InfiniteJump, function(v) CC.InfiniteJump = v end)
    Toggle("Double Jump", CC.DoubleJump, function(v) CC.DoubleJump = v end)
    Slider("Double Jump Power", 50, 300, CC.DoubleJumpPower, function(v) CC.DoubleJumpPower = v end)

    SectionLabel("ПОЛЁТ")
    Toggle("Fly Enabled", CC.FlyEnabled, function(v) CC.FlyEnabled = v end)
    Slider("Fly Speed", 10, 500, CC.FlySpeed, function(v) CC.FlySpeed = v end)
    Dropdown("Fly Mode", {"WASD", "Camera", "Both"}, CC.FlyMode, function(v) CC.FlyMode = v end)
    Keybind("Fly Keybind", CC.FlyKeybind, function(k) CC.FlyKeybind = k end)
    Toggle("Fly Vertical (Space/Ctrl)", CC.FlyVertical, function(v) CC.FlyVertical = v end)
    Slider("Fly Smoothness", 0.05, 1, CC.FlySmooth, function(v) CC.FlySmooth = v end)
    Toggle("Fly NoClip", CC.FlyNoClip, function(v) CC.FlyNoClip = v end)

    SectionLabel("NOCLIP")
    Toggle("Noclip Enabled", CC.NoclipEnabled, function(v) CC.NoclipEnabled = v end)
    Dropdown("Noclip Mode", {"Toggle", "Hold"}, CC.NoclipMode, function(v) CC.NoclipMode = v end)
    Keybind("Noclip Keybind", CC.NoclipKeybind, function(k) CC.NoclipKeybind = k end)

    SectionLabel("АНТИ-ФЛИНГ")
    Toggle("Anti-Fling", CC.AntiFling, function(v) CC.AntiFling = v end)
    Toggle("Anti-Fling Aggressive", CC.AntiFlingAggressive, function(v) CC.AntiFlingAggressive = v end)

    SectionLabel("FLING (швырять игроков)")
    Toggle("Fling Enabled", CC.FlingEnabled, function(v)
        CC.FlingEnabled = v
        if v then Notify("Fling ON — жми " .. (CC.FlingKeybind and CC.FlingKeybind.Name or "G"), Theme.Success) end
    end)
    Dropdown("Fling Target", {"Nearest", "All", "Selected"}, CC.FlingTargetMode, function(v) CC.FlingTargetMode = v end)
    Keybind("Fling Keybind", CC.FlingKeybind, function(k) CC.FlingKeybind = k end)

    SectionLabel("АНТИ-ВОИД")
    Toggle("Anti-Void", CC.AntiVoid, function(v) CC.AntiVoid = v end)
    Slider("Anti-Void Y", -500, 50, CC.AntiVoidY, function(v) CC.AntiVoidY = v end)

    SectionLabel("БЛИНК")
    Toggle("Blink Enabled", CC.BlinkEnabled, function(v) CC.BlinkEnabled = v end)
    Slider("Blink Distance", 5, 100, CC.BlinkDistance, function(v) CC.BlinkDistance = v end)
    Keybind("Blink Keybind", CC.BlinkKeybind, function(k) CC.BlinkKeybind = k end)
    Slider("Blink Cooldown (сек)", 0, 3, CC.BlinkCooldown, function(v) CC.BlinkCooldown = v end)

    SectionLabel("ТЕЛЕПОРТ")
    Toggle("Teleport Enabled", CC.TeleportEnabled, function(v) CC.TeleportEnabled = v end)
    Keybind("Teleport Keybind", CC.TeleportKeybind, function(k) CC.TeleportKeybind = k end)
    Toggle("Teleport to Cursor", CC.TeleportToCursor, function(v) CC.TeleportToCursor = v end)

    SectionLabel("INFINITE YIELD")
    Toggle("Infinite Yield", CC.InfiniteYield, function(v)
        CC.InfiniteYield = v
        if v and loadstring then
            pcall(function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
            end)
        end
    end)

    SectionLabel("GODMODE")
    Toggle("God Mode", CC.GodMode, function(v)
        CC.GodMode = v
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.MaxHealth = v and math.huge or 100 end
    end)

    SectionLabel("ЗАЩИТА")
    Toggle("Anti-AFK", CC.AntiAFK, function(v) CC.AntiAFK = v end)
    Toggle("Anti-Kick", CC.AntiKick, function(v) CC.AntiKick = v end)
    Toggle("Anti-Stun", CC.AntiStun, function(v) CC.AntiStun = v end)
    Toggle("Anti-Slow", CC.AntiSlow, function(v) CC.AntiSlow = v end)
    Toggle("No Fall Damage", CC.NoFallDamage, function(v) CC.NoFallDamage = v end)

    SectionLabel("АВТО-РЕСПАВН")
    Toggle("Auto Respawn", CC.AutoRespawn, function(v) CC.AutoRespawn = v end)
    Slider("Respawn Delay", 0.1, 5, CC.RespawnDelay, function(v) CC.RespawnDelay = v end)

    SectionLabel("HIP HEIGHT")
    Toggle("Hip Height Enabled", CC.HipHeightEnabled, function(v)
        CC.HipHeightEnabled = v
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = v and CC.HipHeight or 2 end
    end)
    Slider("Hip Height", -5, 20, CC.HipHeight, function(v)
        CC.HipHeight = v
        if CC.HipHeightEnabled then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.HipHeight = v end
        end
    end)

    SectionLabel("ГРАВИТАЦИЯ")
    Toggle("Gravity Enabled", CC.GravityEnabled, function(v)
        CC.GravityEnabled = v
        workspace.Gravity = v and CC.Gravity or 196.2
    end)
    Slider("Gravity", 0, 500, CC.Gravity, function(v)
        CC.Gravity = v
        if CC.GravityEnabled then workspace.Gravity = v end
    end)

    SectionLabel("FREEZE")
    Toggle("Freeze Player (локально)", CC.FreezePlayer, function(v)
        CC.FreezePlayer = v
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if v then
                local anchor = Create("Part", {
                    Name="ZenithFreeze", Size=Vector3.new(1,1,1), Transparency=1,
                    CanCollide=false, Anchored=true, CanQuery=false,
                    CFrame=hrp.CFrame, Parent=workspace
                })
                Create("WeldConstraint", {Part0=hrp, Part1=anchor, Parent=hrp})
            else
                local anchor = workspace:FindFirstChild("ZenithFreeze")
                if anchor then anchor:Destroy() end
            end
        end
    end)

    SectionLabel("WALK ON WATER")
    Toggle("Walk On Water", CC.WalkOnWater, function(v) CC.WalkOnWater = v end)

    SectionLabel("SERVER")
    Keybind("Server Hop Keybind", CC.ServerHopKeybind, function(k) CC.ServerHopKeybind = k end)
    Button("Скопировать Job ID", function()
        if setclipboard then
            setclipboard(game.JobId)
            Notify("Job ID скопирован", Theme.Success)
        end
    end)
end

-- МИР
pages["Мир"] = function()
    SectionLabel("ОСВЕЩЕНИЕ")
    Toggle("Fullbright", CFG.World.Fullbright, function(v)
        CFG.World.Fullbright = v
        if v then
            Lighting.Brightness = 3
            Lighting.Ambient = Color3.fromRGB(200,200,200)
            Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)
        else
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(70,70,70)
            Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        end
    end)
    Slider("Time of Day", 0, 24, CFG.World.TimeOfDay, function(v) CFG.World.TimeOfDay = v; Lighting.ClockTime = v end)
    SectionLabel("ТУМАН")
    Toggle("Remove Fog", CFG.World.RemoveFog, function(v)
        CFG.World.RemoveFog = v
        Lighting.FogEnd = v and 100000 or 500
    end)
    SectionLabel("ЭФФЕКТЫ")
    Toggle("Remove Grass", CFG.World.RemoveGrass, function(v)
        CFG.World.RemoveGrass = v
        if v then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Material == Enum.Material.Grass then
                    obj.Material = Enum.Material.SmoothPlastic
                end
            end
        end
    end)
    Toggle("Bloom", CFG.World.Bloom, function(v)
        CFG.World.Bloom = v
        local e = Lighting:FindFirstChild("ZenithBloom")
        if v and not e then
            Create("BloomEffect", {Name="ZenithBloom", Intensity=CFG.World.BloomIntensity, Size=24, Threshold=1, Parent=Lighting})
        elseif not v and e then e:Destroy() end
    end)
    Slider("Bloom Intensity", 0, 3, CFG.World.BloomIntensity, function(v)
        CFG.World.BloomIntensity = v
        local e = Lighting:FindFirstChild("ZenithBloom")
        if e then e.Intensity = v end
    end)
    Toggle("Color Correction", CFG.World.ColorCorrect, function(v)
        CFG.World.ColorCorrect = v
        local e = Lighting:FindFirstChild("ZenithCC")
        if v and not e then
            Create("ColorCorrectionEffect", {Name="ZenithCC", Brightness=0, Contrast=CFG.World.CCContrast, Saturation=CFG.World.CCSaturation, Parent=Lighting})
        elseif not v and e then e:Destroy() end
    end)
    Slider("Contrast", -1, 1, CFG.World.CCContrast, function(v)
        CFG.World.CCContrast = v
        local e = Lighting:FindFirstChild("ZenithCC")
        if e then e.Contrast = v end
    end)
    Slider("Saturation", -1, 1, CFG.World.CCSaturation, function(v)
        CFG.World.CCSaturation = v
        local e = Lighting:FindFirstChild("ZenithCC")
        if e then e.Saturation = v end
    end)
    SectionLabel("НОЧНОЕ ЗРЕНИЕ")
    Toggle("Night Vision", CFG.World.NightVision, function(v)
        CFG.World.NightVision = v
        local e = Lighting:FindFirstChild("ZenithNV")
        if v and not e then
            Create("ColorCorrectionEffect", {Name="ZenithNV", Brightness=0.15*CFG.World.NightVisionIntensity, Contrast=0.1, Saturation=-0.5, TintColor=Color3.fromRGB(140,255,140), Parent=Lighting})
        elseif not v and e then e:Destroy() end
    end)
    Slider("NV Intensity", 0.1, 3, CFG.World.NightVisionIntensity, function(v)
        CFG.World.NightVisionIntensity = v
        local e = Lighting:FindFirstChild("ZenithNV")
        if e then e.Brightness = 0.15 * v end
    end)
end

-- ПЕРСОНАЖ
pages["Персонаж"] = function()
    SectionLabel("HALO")
    Toggle("Halo Enabled", CFG.Char.Halo.Enabled, function(v) CFG.Char.Halo.Enabled = v end)
    ColorPicker("Halo Color", CFG.Char.Halo.Color, function(c) CFG.Char.Halo.Color = c end)
    Slider("Halo Size", 0.3, 3, CFG.Char.Halo.Size, function(v) CFG.Char.Halo.Size = v end)
    Slider("Halo Speed", 0.1, 5, CFG.Char.Halo.Speed, function(v) CFG.Char.Halo.Speed = v end)

    SectionLabel("AURA")
    Toggle("Aura Enabled", CFG.Char.Aura.Enabled, function(v) CFG.Char.Aura.Enabled = v end)
    ColorPicker("Aura Color", CFG.Char.Aura.Color, function(c) CFG.Char.Aura.Color = c end)
    Slider("Aura Size", 0.5, 3, CFG.Char.Aura.Size, function(v) CFG.Char.Aura.Size = v end)
    Slider("Aura Transparency", 0, 1, CFG.Char.Aura.Transp, function(v) CFG.Char.Aura.Transp = v end)

    SectionLabel("FIRE AURA")
    Toggle("Fire Aura", CFG.Char.FireAura.Enabled, function(v) CFG.Char.FireAura.Enabled = v end)
    Slider("Fire Size", 0.5, 3, CFG.Char.FireAura.Size, function(v) CFG.Char.FireAura.Size = v end)
    Slider("Fire Rate", 10, 200, CFG.Char.FireAura.Rate, function(v) CFG.Char.FireAura.Rate = v end)

    SectionLabel("ICE AURA")
    Toggle("Ice Aura", CFG.Char.IceAura.Enabled, function(v) CFG.Char.IceAura.Enabled = v end)
    Slider("Ice Size", 0.5, 3, CFG.Char.IceAura.Size, function(v) CFG.Char.IceAura.Size = v end)

    SectionLabel("LIGHTNING")
    Toggle("Lightning", CFG.Char.Lightning.Enabled, function(v) CFG.Char.Lightning.Enabled = v end)
    ColorPicker("Lightning Color", CFG.Char.Lightning.Color, function(c) CFG.Char.Lightning.Color = c end)
    Slider("Bolt Count", 2, 20, CFG.Char.Lightning.Count, function(v) CFG.Char.Lightning.Count = v end)

    SectionLabel("WINGS")
    Toggle("Wings", CFG.Char.Wings.Enabled, function(v) CFG.Char.Wings.Enabled = v end)
    ColorPicker("Wings Color", CFG.Char.Wings.Color, function(c) CFG.Char.Wings.Color = c end)
    Slider("Wings Size", 0.5, 3, CFG.Char.Wings.Size, function(v) CFG.Char.Wings.Size = v end)

    SectionLabel("OUTLINE")
    Toggle("Outline Enabled", CFG.Char.Outline.Enabled, function(v) CFG.Char.Outline.Enabled = v end)
    ColorPicker("Outline Color", CFG.Char.Outline.Color, function(c) CFG.Char.Outline.Color = c end)

    SectionLabel("CHAMS")
    Toggle("Chams Enabled", CFG.Char.Chams.Enabled, function(v) CFG.Char.Chams.Enabled = v end)
    ColorPicker("Chams Color", CFG.Char.Chams.Color, function(c) CFG.Char.Chams.Color = c end)
    Slider("Chams Transp", 0, 1, CFG.Char.Chams.Transp, function(v) CFG.Char.Chams.Transp = v end)

    SectionLabel("TRAIL")
    Toggle("Trail Enabled", CFG.Char.Trail.Enabled, function(v) CFG.Char.Trail.Enabled = v end)
    ColorPicker("Trail Color", CFG.Char.Trail.Color, function(c) CFG.Char.Trail.Color = c end)
    Slider("Trail Life", 0.1, 3, CFG.Char.Trail.Life, function(v) CFG.Char.Trail.Life = v end)

    SectionLabel("GLOW")
    Toggle("Glow Enabled", CFG.Char.Glow.Enabled, function(v) CFG.Char.Glow.Enabled = v end)
    ColorPicker("Glow Color", CFG.Char.Glow.Color, function(c) CFG.Char.Glow.Color = c end)
    Slider("Glow Brightness", 0, 10, CFG.Char.Glow.Bright, function(v) CFG.Char.Glow.Bright = v end)
    Slider("Glow Range", 1, 30, CFG.Char.Glow.Range, function(v) CFG.Char.Glow.Range = v end)

    SectionLabel("ORBS")
    Toggle("Orbs Enabled", CFG.Char.Orbs.Enabled, function(v) CFG.Char.Orbs.Enabled = v end)
    ColorPicker("Orbs Color", CFG.Char.Orbs.Color, function(c) CFG.Char.Orbs.Color = c end)
    Slider("Orbs Count", 1, 12, CFG.Char.Orbs.Count, function(v) CFG.Char.Orbs.Count = v end)
    Slider("Orbs Size", 0.2, 2, CFG.Char.Orbs.Size, function(v) CFG.Char.Orbs.Size = v end)
    Slider("Orbs Radius", 1, 10, CFG.Char.Orbs.Radius, function(v) CFG.Char.Orbs.Radius = v end)
    Slider("Orbs Speed", 0.5, 10, CFG.Char.Orbs.Speed, function(v) CFG.Char.Orbs.Speed = v end)

    SectionLabel("RING")
    Toggle("Ring Enabled", CFG.Char.Ring.Enabled, function(v) CFG.Char.Ring.Enabled = v end)
    ColorPicker("Ring Color", CFG.Char.Ring.Color, function(c) CFG.Char.Ring.Color = c end)
    Slider("Ring Size", 2, 15, CFG.Char.Ring.Size, function(v) CFG.Char.Ring.Size = v end)
    Slider("Ring Speed", 0.1, 5, CFG.Char.Ring.Speed, function(v) CFG.Char.Ring.Speed = v end)

    SectionLabel("NEON BODY")
    Toggle("NeonBody", CFG.Char.NeonBody.Enabled, function(v) CFG.Char.NeonBody.Enabled = v end)
    ColorPicker("NeonBody Color", CFG.Char.NeonBody.Color, function(c) CFG.Char.NeonBody.Color = c end)

    SectionLabel("PARTICLES")
    Toggle("Particles", CFG.Char.Particles.Enabled, function(v) CFG.Char.Particles.Enabled = v end)
    ColorPicker("Particles Color", CFG.Char.Particles.Color, function(c) CFG.Char.Particles.Color = c end)
    Slider("Particles Rate", 5, 100, CFG.Char.Particles.Rate, function(v) CFG.Char.Particles.Rate = v end)
    Slider("Particles Size", 0.1, 2, CFG.Char.Particles.Size, function(v) CFG.Char.Particles.Size = v end)

    SectionLabel("РАДУГА")
    Toggle("Rainbow Mode", CFG.Char.Rainbow.Enabled, function(v) CFG.Char.Rainbow.Enabled = v end)
    Slider("Rainbow Speed", 0.1, 5, CFG.Char.Rainbow.Speed, function(v) CFG.Char.Rainbow.Speed = v end)
end

-- ESP
pages["ESP"] = function()
    SectionLabel("BOX")
    Toggle("Box Enabled", CFG.ESP.Box, function(v) CFG.ESP.Box = v end)
    ColorPicker("Box Color", CFG.ESP.BoxColor, function(c) CFG.ESP.BoxColor = c end)
    Slider("Box Thickness", 0.5, 4, CFG.ESP.BoxThick, function(v) CFG.ESP.BoxThick = v end)

    SectionLabel("NAME")
    Toggle("Name Enabled", CFG.ESP.Name, function(v) CFG.ESP.Name = v end)
    ColorPicker("Name Color", CFG.ESP.NameColor, function(c) CFG.ESP.NameColor = c end)
    Slider("Name Size", 8, 20, CFG.ESP.NameSize, function(v) CFG.ESP.NameSize = v end)

    SectionLabel("HEALTH")
    Toggle("Health Enabled", CFG.ESP.Health, function(v) CFG.ESP.Health = v end)
    ColorPicker("Health Color", CFG.ESP.HealthColor, function(c) CFG.ESP.HealthColor = c end)

    SectionLabel("DISTANCE")
    Toggle("Distance Enabled", CFG.ESP.Distance, function(v) CFG.ESP.Distance = v end)
    ColorPicker("Distance Color", CFG.ESP.DistanceColor, function(c) CFG.ESP.DistanceColor = c end)

    SectionLabel("TRACER")
    Toggle("Tracer Enabled", CFG.ESP.Tracer, function(v) CFG.ESP.Tracer = v end)
    ColorPicker("Tracer Color", CFG.ESP.TracerColor, function(c) CFG.ESP.TracerColor = c end)

    SectionLabel("HEAD DOT")
    Toggle("HeadDot", CFG.ESP.HeadDot, function(v) CFG.ESP.HeadDot = v end)
    ColorPicker("HeadDot Color", CFG.ESP.HeadDotColor, function(c) CFG.ESP.HeadDotColor = c end)

    SectionLabel("CHAMS ESP")
    Toggle("Chams ESP", CFG.ESP.Chams, function(v) CFG.ESP.Chams = v end)
    ColorPicker("Chams Color", CFG.ESP.ChamsColor, function(c) CFG.ESP.ChamsColor = c end)
    Slider("Chams Transp", 0, 1, CFG.ESP.ChamsTransp, function(v) CFG.ESP.ChamsTransp = v end)

    SectionLabel("OUTLINE ESP")
    Toggle("Outline ESP", CFG.ESP.Outline, function(v) CFG.ESP.Outline = v end)
    ColorPicker("Outline Color", CFG.ESP.OutlineColor, function(c) CFG.ESP.OutlineColor = c end)

    SectionLabel("ФИЛЬТРЫ")
    Toggle("Team Check", CFG.ESP.TeamCheck, function(v) CFG.ESP.TeamCheck = v end)
    Toggle("Rainbow ESP", CFG.ESP.Rainbow, function(v) CFG.ESP.Rainbow = v end)
    Slider("Distance Limit", 50, 2000, CFG.ESP.DistanceLimit, function(v) CFG.ESP.DistanceLimit = v end)
end
-- ЗВУКИ
pages["Звуки"] = function()
    SectionLabel("ОСНОВНЫЕ")
    Toggle("Enable Sounds", CFG.UI.Sounds, function(v) CFG.UI.Sounds = v end)
    Button("Test Click", function() PlaySound(CFG.UI.ClickSound, 0.4) end)
    SectionLabel("БИБЛИОТЕКА")
    local sounds = {
        {"Click 1", "rbxassetid://6895079853"},
        {"Click 2", "rbxassetid://6042053626"},
        {"Click 3", "rbxassetid://876939830"},
        {"Click 4", "rbxassetid://131961136"},
    }
    for _, s in ipairs(sounds) do
        Button("Play: " .. s[1], function() PlaySound(s[2], 0.4) end)
        Button("Set as Click: " .. s[1], function()
            CFG.UI.ClickSound = s[2]
            Notify("Click звук: " .. s[1], Theme.Success)
        end)
    end
end

-- УВЕДОМЛЕНИЯ
pages["Уведомления"] = function()
    SectionLabel("ОСНОВНЫЕ")
    Toggle("Enable Notifications", CFG.Notifications, function(v) CFG.Notifications = v end)
    Slider("Duration (сек)", 1, 10, CFG.NotifTime, function(v) CFG.NotifTime = v end)
    SectionLabel("ПОЗИЦИЯ")
    Button("Bottom Right", function()
        CFG.UI.NotifPos = "BottomRight"
        NotifHolder.Position = UDim2.new(1, -280, 1, -420)
        Notify("Позиция: BR", Theme.Success)
    end)
    Button("Bottom Left", function()
        CFG.UI.NotifPos = "BottomLeft"
        NotifHolder.Position = UDim2.new(0, 20, 1, -420)
        Notify("Позиция: BL", Theme.Success)
    end)
    Button("Top Right", function()
        CFG.UI.NotifPos = "TopRight"
        NotifHolder.Position = UDim2.new(1, -280, 0, 20)
        Notify("Позиция: TR", Theme.Success)
    end)
    Button("Top Left", function()
        CFG.UI.NotifPos = "TopLeft"
        NotifHolder.Position = UDim2.new(0, 20, 0, 20)
        Notify("Позиция: TL", Theme.Success)
    end)
    SectionLabel("ТЕСТ")
    Button("Test Notification", function() Notify("Это тест!", Theme.Accent) end)
    Button("Test Success", function() Notify("Успешно выполнено", Theme.Success) end)
    Button("Test Error", function() Notify("Ошибка!", Theme.Danger) end)
end

-- АНИМАЦИИ
pages["Анимации"] = function()
    SectionLabel("СКОРОСТЬ UI")
    Slider("Anim Speed", 0.1, 1, CFG.UI.AnimSpeed, function(v) CFG.UI.AnimSpeed = v end)
    SectionLabel("ЭФФЕКТЫ")
    Toggle("Blur Background", CFG.UI.Blur, function(v)
        CFG.UI.Blur = v
        if v and menuOpen then Tween(mainBlur, 0.3, {Size=14})
        elseif not v then Tween(mainBlur, 0.3, {Size=0}) end
    end)
    SectionLabel("РЕСЕТ")
    Button("Reset Animations", function()
        CFG.UI.AnimSpeed = 0.28
        CFG.UI.Blur = true
        Notify("Анимации сброшены", Theme.Success)
    end)
end

-- HOTKEYS
pages["Hotkeys"] = function()
    SectionLabel("МЕНЮ")
    Keybind("Toggle Menu", CFG.ToggleKey, function(k) CFG.ToggleKey = k end)
    Keybind("Panic Key", CFG.PanicKey, function(k) CFG.PanicKey = k end)
    SectionLabel("ИНФО")
    Button("Текущие клавиши", function()
        Notify("Menu: " .. (CFG.ToggleKey and CFG.ToggleKey.Name or "?"), Theme.Accent)
        Notify("Panic: " .. (CFG.PanicKey and CFG.PanicKey.Name or "?"), Theme.Accent)
    end)
end

-- ПРОФИЛИ
pages["Профили"] = function()
    SectionLabel("ПРЕСЕТЫ")
    local presets = {
        "Combat", "Chill", "Streamer", "Tryhard", "Casual",
        "Stealth", "Cinematic", "Minimal", "Maximal", "Stealth PvP"
    }
    for _, preset in ipairs(presets) do
        local row = Create("Frame", {
            Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element, Parent=Scroll
        })
        Corner(row, 8)
        Stroke(row, Theme.Stroke, 1)
        Create("TextLabel", {
            Size=UDim2.new(0.5,-10,1,0), Position=UDim2.new(0,10,0,0),
            BackgroundTransparency=1, Text=preset, TextColor3=Theme.Text,
            Font=Enum.Font.GothamMedium, TextSize=13,
            TextXAlignment=Enum.TextXAlignment.Left, Parent=row
        })
        local saveBtn = Create("TextButton", {
            Size=UDim2.new(0,60,1,-8), Position=UDim2.new(1,-130,0,4),
            BackgroundColor3=_G.ZenithAccent(), Text="Save",
            TextColor3=Theme.Bg, Font=Enum.Font.GothamMedium, TextSize=11,
            AutoButtonColor=false, Parent=row
        })
        Corner(saveBtn, 5)
        saveBtn.MouseButton1Click:Connect(function()
            Click()
            local ok, msg = SaveConfig(preset)
            Notify(msg, ok and Theme.Success or Theme.Danger)
        end)
        local loadBtn = Create("TextButton", {
            Size=UDim2.new(0,60,1,-8), Position=UDim2.new(1,-65,0,4),
            BackgroundColor3=Theme.ElementHov, Text="Load",
            TextColor3=Theme.Text, Font=Enum.Font.GothamMedium, TextSize=11,
            AutoButtonColor=false, Parent=row
        })
        Corner(loadBtn, 5)
        loadBtn.MouseButton1Click:Connect(function()
            Click()
            local ok, msg = LoadConfig(preset)
            Notify(msg, ok and Theme.Success or Theme.Danger)
        end)
    end
end

-- КОНФИГИ
pages["Конфиги"] = function()
    SectionLabel("УПРАВЛЕНИЕ")
    local nameRow = Create("Frame", {
        Size=UDim2.new(1,-8,0,32), BackgroundColor3=Theme.Element, Parent=Scroll
    })
    Corner(nameRow, 8)
    Stroke(nameRow, Theme.Stroke, 1)
    local nameBox = Create("TextBox", {
        Size=UDim2.new(1,-10,1,-8), Position=UDim2.new(0,5,0,4),
        BackgroundColor3=Color3.fromRGB(20,20,24),
        PlaceholderText="Введите имя конфига...",
        Text="",
        TextColor3=Theme.Text,
        Font=Enum.Font.GothamMedium, TextSize=12,
        ClearTextOnFocus=false, Parent=nameRow
    })
    Corner(nameBox, 5)
    Stroke(nameBox, Theme.Stroke, 1)

    Button("Save as new config", function()
        if nameBox.Text == "" then Notify("Введите имя", Theme.Danger); return end
        local ok, msg = SaveConfig(nameBox.Text)
        Notify(msg, ok and Theme.Success or Theme.Danger)
        if currentPage == "Конфиги" then ClearScroll(); pages["Конфиги"]() end
    end)
    Button("Reload list", function()
        ClearScroll(); pages["Конфиги"]()
        Notify("Список обновлён", Theme.Success)
    end)

    SectionLabel("СЛОТЫ (" .. MAX_SLOTS .. " макс.)")
    local list = GetConfigList()

    if #list == 0 then
        local emptyLabel = Create("TextLabel", {
            Size=UDim2.new(1,-8,0,60), BackgroundColor3=Theme.Element,
            Text="Пока нет сохранённых конфигов\nСохрани первый через кнопку выше",
            TextColor3=Theme.TextMuted,
            Font=Enum.Font.GothamMedium, TextSize=12,
            TextWrapped=true, Parent=Scroll
        })
        Corner(emptyLabel, 8)
        Stroke(emptyLabel, Theme.Stroke, 1)
        return
    end

    for idx, cfgName in ipairs(list) do
        local card = Create("Frame", {
            Size=UDim2.new(1,-8,0,80), BackgroundColor3=Theme.Element, Parent=Scroll
        })
        Corner(card, 8)
        Stroke(card, Theme.Stroke, 1)
        local active = (CFG.ActiveConfig == cfgName)
        Create("TextLabel", {
            Size=UDim2.new(1,-20,0,20), Position=UDim2.new(0,12,0,6),
            BackgroundTransparency=1,
            Text=(active and "[ACTIVE] " or "[" .. idx .. "] ") .. cfgName,
            TextColor3=active and _G.ZenithAccent() or Theme.Text,
            Font=Enum.Font.GothamBold, TextSize=13,
            TextXAlignment=Enum.TextXAlignment.Left, Parent=card
        })

        local function makeBtn(txt, xPos, bg, txtCol, cb)
            local b = Create("TextButton", {
                Size=UDim2.new(0,60,0,22), Position=UDim2.new(1, xPos, 0, 50),
                BackgroundColor3=bg, Text=txt,
                TextColor3=txtCol, Font=Enum.Font.GothamMedium, TextSize=10,
                AutoButtonColor=false, Parent=card
            })
            Corner(b, 5)
            b.MouseButton1Click:Connect(function() Click(); cb() end)
            return b
        end

        makeBtn("Save", -256, _G.ZenithAccent(), Theme.Bg, function()
            local ok, msg = SaveConfig(cfgName)
            Notify(msg, ok and Theme.Success or Theme.Danger)
        end)
        makeBtn("Load", -192, Theme.ElementHov, Theme.Text, function()
            local ok, msg = LoadConfig(cfgName)
            Notify(msg, ok and Theme.Success or Theme.Danger)
            ClearScroll(); pages["Конфиги"]()
        end)
        makeBtn("Rename", -128, Theme.ElementHov, Theme.Text, function()
            local newName = cfgName .. "_copy"
            local ok, msg = RenameConfig(cfgName, newName)
            Notify(msg, ok and Theme.Success or Theme.Danger)
            ClearScroll(); pages["Конфиги"]()
        end)
        makeBtn("Delete", -64, Theme.Danger, Color3.fromRGB(255,255,255), function()
            local ok, msg = DeleteConfig(cfgName)
            Notify(msg, ok and Theme.Success or Theme.Danger)
            ClearScroll(); pages["Конфиги"]()
        end)
    end
end

-- НАСТРОЙКИ
pages["Настройки"] = function()
    SectionLabel("ОБЩЕЕ")
    Toggle("Notifications", CFG.Notifications, function(v) CFG.Notifications = v end)
    Slider("Notification Time", 1, 10, CFG.NotifTime, function(v) CFG.NotifTime = v end)
    Toggle("FPS Counter", CFG.FPS, function(v) CFG.FPS = v end)
    Toggle("Ping Display", CFG.Ping, function(v) CFG.Ping = v end)
    Toggle("Memory Usage", CFG.Memory, function(v) CFG.Memory = v end)
    SectionLabel("ПЛАТФОРМА")
    Button("Перезапустить выбор платформы", function()
        CFG.UI.Platform = nil
        CFG.UI.IsMobile = false
        Notify("Платформа сброшена. Перезапусти скрипт.", Theme.Success)
    end)
end

-- НАСТРОЙКИ МЕНЮ
pages["Настройки меню"] = function()
    SectionLabel("ВНЕШНИЙ ВИД")
    ColorPicker("Accent Color", CFG.UI.Accent, function(c)
        CFG.UI.Accent = c
        for _, ref in ipairs(toggleRefs) do
            if ref.refresh then ref.refresh() end
        end
        for _, ref in ipairs(sliderRefs) do
            if ref.refresh then ref.refresh() end
        end
        for _, b in pairs(navButtons) do
            b.accent.BackgroundColor3 = _G.ZenithAccent()
        end
    end)
    Toggle("Blur Background", CFG.UI.Blur, function(v)
        CFG.UI.Blur = v
        if v and menuOpen then Tween(mainBlur, 0.3, {Size=14})
        elseif not v then Tween(mainBlur, 0.3, {Size=0}) end
    end)
    SectionLabel("КЛАВИШИ")
    Keybind("UI Toggle Key", CFG.ToggleKey, function(k) CFG.ToggleKey = k end)
    Keybind("Panic Key", CFG.PanicKey, function(k) CFG.PanicKey = k end)
    SectionLabel("СБРОС")
    Button("Reset All Settings", function()
        _G.ZenithCfg = {}
        Notify("Настройки сброшены (перезапусти скрипт)", Theme.Danger)
    end)
end

-- Регистрация вкладок
AddNavButton("Главная")
AddNavButton("Читы")
AddNavButton("Мир")
AddNavButton("Персонаж")
AddNavButton("ESP")
AddNavButton("Звуки")
AddNavButton("Уведомления")
AddNavButton("Анимации")
AddNavButton("Hotkeys")
AddNavButton("Профили")
AddNavButton("Конфиги")
AddNavButton("Настройки")
AddNavButton("Настройки меню")

currentPage = "Главная"
PageTitle.Text = "Главная"
pages["Главная"]()
for n, b in pairs(navButtons) do
    local active = (n == "Главная")
    b.btn.BackgroundColor3 = active and Theme.Element or Theme.Panel
    b.btn.BackgroundTransparency = active and 0 or 1
    b.accent.BackgroundTransparency = active and 0 or 1
    b.label.TextColor3 = active and Theme.Text or Theme.TextDim
end

-- MENU OPEN/CLOSE
menuOpen = false
_G.ZenithMenuOpen = function() return menuOpen end

function _G.ZenithEmpireSetMenuOpen(v)
    if menuOpen == v then return end
    menuOpen = v
    if v then
        MainGroup.Visible = true
        PreviewGroup.Visible = true
        MainGroup.GroupTransparency = 1
        PreviewGroup.GroupTransparency = 1
        Tween(MainGroup, CFG.UI.AnimSpeed, {GroupTransparency=0})
        Tween(PreviewGroup, CFG.UI.AnimSpeed, {GroupTransparency=0})
        if CFG.UI.Blur then Tween(mainBlur, 0.3, {Size=14}) end
    else
        Tween(MainGroup, CFG.UI.AnimSpeed*0.8, {GroupTransparency=1})
        Tween(PreviewGroup, CFG.UI.AnimSpeed*0.8, {GroupTransparency=1})
        if CFG.UI.Blur then Tween(mainBlur, 0.3, {Size=0}) end
        task.delay(CFG.UI.AnimSpeed*0.9, function()
            if not menuOpen then
                MainGroup.Visible = false
                PreviewGroup.Visible = false
            end
        end)
    end
end

_G.ZenithEmpireOnPlatformChosen = function(platform)
    if platform == "Mobile" then
        WIN_W, WIN_H = 380, 620
        NAV_W = 110
        TOP_H = 40
        MainGroup.Size = UDim2.new(0, WIN_W, 0, WIN_H)
        MainGroup.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
        Nav.Size = UDim2.new(0, NAV_W, 1, -TOP_H - 16)
        Content.Size = UDim2.new(1, -NAV_W - 24, 1, -TOP_H - 16)
        Content.Position = UDim2.new(0, NAV_W + 18, 0, TOP_H + 6)
        PreviewGroup.Visible = false
        PreviewGroup.Size = UDim2.new(0, 0, 0, 0)
        mobileMenuBtn.Visible = true
    else
        mobileMenuBtn.Visible = false
    end
    task.wait(0.4)
    _G.ZenithEmpireSetMenuOpen(true)
    task.wait(0.6)
    if platform == "Mobile" then
        Notify("Тапни Z-кнопку слева, чтобы открыть меню", Theme.Accent2)
    else
        Notify("RightShift - открыть меню", Theme.Accent2)
    end
end

local panicState = false
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CFG.ToggleKey then
        _G.ZenithEmpireSetMenuOpen(not menuOpen)
    elseif input.KeyCode == CFG.PanicKey then
        if not panicState then
            panicState = true
            _G.ZenithEmpireSetMenuOpen(false)
            for name, cfg in pairs(CFG.Char) do
                if type(cfg) == "table" and cfg.Enabled ~= nil then cfg.Enabled = false end
            end
            for _, k in ipairs({"Box","Name","Health","Distance","Tracer","HeadDot","Chams","Outline","Rainbow"}) do
                CFG.ESP[k] = false
            end
            for k, _ in pairs(CFG.Cheats) do
                if type(CFG.Cheats[k]) == "boolean" then CFG.Cheats[k] = false end
            end
            Notify("PANIC", Theme.Danger)
        else
            panicState = false
            CFG.Master = true
            Notify("Восстановлено", Theme.Success)
        end
    end
end)

-- ЧИТЫ ОБРАБОТКА
local CC = CFG.Cheats
local blinkLastUse = 0

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CC.SpeedKeybind and CC.SpeedEnabled and CC.SpeedMode == "Hold" then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = CC.WalkSpeed end
    elseif input.KeyCode == CC.BlinkKeybind and CC.BlinkEnabled then
        local now = tick()
        if now - blinkLastUse >= CC.BlinkCooldown then
            blinkLastUse = now
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -CC.BlinkDistance) end
        end
    elseif input.KeyCode == CC.TeleportKeybind and CC.TeleportEnabled then
        if CC.TeleportToCursor then
            local mouse = LocalPlayer:GetMouse()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and mouse.Hit then hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)) end
        end
    elseif input.KeyCode == CC.FlingKeybind and CC.FlingEnabled then
        local function flingPlayer(plr)
            local myChar = LocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local targetChar = plr.Character
            local tHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
            if not myHrp or not tHrp then return end
            local origSize = myHrp.Size
            myHrp.Size = Vector3.new(0.05, 0.05, 0.05)
            myHrp.CanCollide = false
            myHrp.Massless = false
            myHrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 100, 100)
            myHrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 0)
            local spin = Instance.new("BodyAngularVelocity")
            spin.AngularVelocity = Vector3.new(0, 100000, 0)
            spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            spin.Parent = myHrp
            task.delay(0.5, function()
                if spin and spin.Parent then spin:Destroy() end
                if myHrp and myHrp.Parent then
                    myHrp.Size = origSize
                    myHrp.CustomPhysicalProperties = nil
                end
            end)
        end
        if CC.FlingTargetMode == "Nearest" then
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then
                local closest, bestDist = nil, math.huge
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local d = (hrp.Position - myHrp.Position).Magnitude
                            if d < bestDist then bestDist = d; closest = plr end
                        end
                    end
                end
                if closest then
                    flingPlayer(closest)
                    Notify("Fling: " .. closest.Name, Theme.Success)
                end
            end
        elseif CC.FlingTargetMode == "All" then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then flingPlayer(plr) end
            end
            Notify("Fling ALL", Theme.Success)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == CC.SpeedKeybind and CC.SpeedEnabled and CC.SpeedMode == "Hold" then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end)

-- MAIN CHEAT LOOP
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not char or not hum then task.wait(0.1); continue end

        if CFG.Master then
            if CC.SpeedEnabled and CC.SpeedMode == "Toggle" then
                if hum.WalkSpeed ~= CC.WalkSpeed then hum.WalkSpeed = CC.WalkSpeed end
            end
            if CC.JumpEnabled then
                hum.UseJumpPower = true
                if hum.JumpPower ~= CC.JumpPower then hum.JumpPower = CC.JumpPower end
            end
            if CC.InfiniteJump then
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
            if CC.NoclipEnabled and CC.NoclipMode == "Toggle" then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
                end
            end
            if CC.FlyEnabled and hrp then
                local bv = hrp:FindFirstChild("ZenithFlyBV")
                local bg = hrp:FindFirstChild("ZenithFlyBG")
                if not bv then bv = Create("BodyVelocity", {Name="ZenithFlyBV", MaxForce=Vector3.new(1e5,1e5,1e5), Velocity=Vector3.zero, P=1250, Parent=hrp}) end
                if not bg then bg = Create("BodyGyro", {Name="ZenithFlyBG", MaxTorque=Vector3.new(1e5,1e5,1e5), P=3000, D=50, CFrame=hrp.CFrame, Parent=hrp}) end
                local move = Vector3.zero
                if CC.FlyMode == "WASD" or CC.FlyMode == "Both" then
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
                end
                if CC.FlyVertical then
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
                end
                if move.Magnitude > 0 then bv.Velocity = move.Unit * CC.FlySpeed else bv.Velocity = Vector3.zero end
                bg.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
                if CC.FlyNoClip then
                    for _, p in ipairs(char:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
            else
                if hrp then
                    local bv = hrp:FindFirstChild("ZenithFlyBV"); if bv then bv:Destroy() end
                    local bg = hrp:FindFirstChild("ZenithFlyBG"); if bg then bg:Destroy() end
                end
            end
            if CC.AntiFling and hrp then
                for _, v in ipairs(hrp:GetChildren()) do
                    if v:IsA("BodyAngularVelocity") or v:IsA("BodyVelocity") then
                        if v.Name ~= "ZenithFlyBV" then v:Destroy() end
                    end
                    if CC.AntiFlingAggressive and (v:IsA("BodyThrust") or v:IsA("BodyPosition")) then v:Destroy() end
                end
            end
            if CC.AntiVoid and hrp and hrp.Position.Y < CC.AntiVoidY then
                hrp.CFrame = CFrame.new(hrp.Position.X, 20, hrp.Position.Z)
                hrp.Velocity = Vector3.zero
            end
            if CC.AntiAFK then
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            end
            if CC.AntiSlow and hum and hum.WalkSpeed < 10 then hum.WalkSpeed = CC.WalkSpeed end
            if CC.AntiStun and hum and hum.PlatformStand then hum.PlatformStand = false end
            if CC.AutoRespawn and hum and hum.Health <= 0 then
                task.wait(CC.RespawnDelay)
                LocalPlayer:LoadCharacter()
            end
            if CC.GodMode and hum then
                hum.MaxHealth = math.huge
                if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
            end
            if CC.HipHeightEnabled and hum then hum.HipHeight = CC.HipHeight end
            if CC.GravityEnabled then workspace.Gravity = CC.Gravity end
            if CC.NoFallDamage and hum then hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and CFG.Cheats.SpeedEnabled then hum.WalkSpeed = CFG.Cheats.WalkSpeed end
    if hum and CFG.Cheats.JumpEnabled then
        hum.UseJumpPower = true
        hum.JumpPower = CFG.Cheats.JumpPower
    end
    if CFG.Cheats.NoclipEnabled then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- CHARACTER VISUALS
local charFolder = Create("Folder", {Name="ZenithEmpire_Char", Parent=workspace})
local function GetChar() return LocalPlayer.Character end
local function RainbowColor() return Color3.fromHSV((tick() * CFG.Char.Rainbow.Speed % 10) / 10, 1, 1) end
local function GetColor(cfg)
    if CFG.Char.Rainbow.Enabled then return RainbowColor() end
    return cfg.Color
end

-- HALO — тонкий круг (плоский диск-кольцо) через Cylinder + вырез
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        if not char then continue end
        local head = char:FindFirstChild("Head")
        local haloContainer = charFolder:FindFirstChild("HaloContainer")
        if CFG.Char.Halo.Enabled and CFG.Master and head then
            if not haloContainer then
                haloContainer = Create("Folder", {Name="HaloContainer", Parent=charFolder})
                -- 4 полоски, собранные в круг (ромбовидное кольцо)
                for i = 1, 4 do
                    local seg = Create("Part", {
                        Name="HaloSeg"..i,
                        Size=Vector3.new(0.15, 0.15, 2),
                        Transparency=0,
                        CanCollide=false, Anchored=true, CanQuery=false,
                        Massless=true, Material=Enum.Material.Neon,
                        Color=CFG.Char.Halo.Color,
                        Parent=haloContainer
                    })
                end
            end
            local segs = haloContainer:GetChildren()
            local s = CFG.Char.Halo.Size
            local diameter = 3 * s
            local angle = (tick() * 80 * CFG.Char.Halo.Speed) % 360
            local headCF = head.CFrame * CFrame.new(0, 1.8 * s, 0) * CFrame.Angles(0, math.rad(angle), 0)
            for i, seg in ipairs(segs) do
                if seg:IsA("BasePart") then
                    seg.Size = Vector3.new(0.15, 0.15, diameter * 0.9)
                    seg.Color = GetColor(CFG.Char.Halo)
                    seg.CFrame = headCF * CFrame.Angles(0, math.rad((i - 1) * 45), 0) * CFrame.new(0, 0, diameter * 0.5)
                end
            end
        elseif haloContainer then
            haloContainer:Destroy()
        end
    end
end)

-- AURA
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local aura = charFolder:FindFirstChild("Aura")
        if CFG.Char.Aura.Enabled and CFG.Master and root then
            if not aura then
                aura = Create("Part", {
                    Name="Aura", Shape=Enum.PartType.Ball, Size=Vector3.new(5,5,5),
                    Transparency=CFG.Char.Aura.Transp, CanCollide=false,
                    Anchored=true, CanQuery=false, Material=Enum.Material.ForceField,
                    Color=CFG.Char.Aura.Color, Parent=charFolder
                })
            end
            aura.Transparency = CFG.Char.Aura.Transp
            local bs = 5 * CFG.Char.Aura.Size
            if CFG.Char.Aura.Pulse then bs = bs + math.sin(tick()*3)*0.4 end
            aura.Size = Vector3.new(bs,bs,bs)
            aura.CFrame = CFrame.new(root.Position)
            aura.Color = GetColor(CFG.Char.Aura)
        elseif aura then aura:Destroy() end
    end
end)

-- FIRE AURA
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local f = charFolder:FindFirstChild("FireAura")
        if CFG.Char.FireAura.Enabled and CFG.Master and root then
            if not f then
                f = Create("Part", {
                    Name="FireAura", Shape=Enum.PartType.Ball, Size=Vector3.new(5,5,5),
                    Transparency=0.75, CanCollide=false, Anchored=true, CanQuery=false,
                    Material=Enum.Material.ForceField, Color=Color3.fromRGB(255,120,40),
                    Parent=charFolder
                })
                Create("ParticleEmitter", {
                    Rate=CFG.Char.FireAura.Rate, Lifetime=NumberRange.new(0.4,0.9),
                    Speed=NumberRange.new(2,5), SpreadAngle=Vector2.new(180,180),
                    Size=NumberSequence.new(0.6),
                    Color=ColorSequence.new(Color3.fromRGB(255,200,50), Color3.fromRGB(255,60,0)),
                    LightEmission=1,
                    Texture="rbxasset://textures/particles/fire_main.dds",
                    Parent=f
                })
            end
            local s = 5 * CFG.Char.FireAura.Size + math.sin(tick()*4)*0.5
            f.Size = Vector3.new(s,s,s)
            f.CFrame = CFrame.new(root.Position)
            local pe = f:FindFirstChildOfClass("ParticleEmitter")
            if pe then pe.Rate = CFG.Char.FireAura.Rate end
        elseif f then f:Destroy() end
    end
end)

-- ICE AURA
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local f = charFolder:FindFirstChild("IceAura")
        if CFG.Char.IceAura.Enabled and CFG.Master and root then
            if not f then
                f = Create("Part", {
                    Name="IceAura", Shape=Enum.PartType.Ball, Size=Vector3.new(5,5,5),
                    Transparency=0.7, CanCollide=false, Anchored=true, CanQuery=false,
                    Material=Enum.Material.ForceField, Color=Color3.fromRGB(180,230,255),
                    Parent=charFolder
                })
                Create("ParticleEmitter", {
                    Rate=40, Lifetime=NumberRange.new(0.8,1.5), Speed=NumberRange.new(1,3),
                    SpreadAngle=Vector2.new(180,180), Size=NumberSequence.new(0.4),
                    Texture="rbxasset://textures/particles/sparkles_main.dds", Parent=f
                })
            end
            local s = 5 * CFG.Char.IceAura.Size + math.sin(tick()*2)*0.4
            f.Size = Vector3.new(s,s,s)
            f.CFrame = CFrame.new(root.Position)
        elseif f then f:Destroy() end
    end
end)

-- LIGHTNING
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local folder = charFolder:FindFirstChild("Lightning")
        if CFG.Char.Lightning.Enabled and CFG.Master and root then
            if not folder then folder = Create("Folder", {Name="Lightning", Parent=charFolder}) end
            task.wait(0.15)
            for _, c in ipairs(folder:GetChildren()) do c:Destroy() end
            for i = 1, CFG.Char.Lightning.Count do
                local a = math.random() * math.pi * 2
                local r = 2 + math.random() * 2
                local offset = Vector3.new(math.cos(a)*r, math.random(-2,3), math.sin(a)*r)
                local bolt = Create("Part", {
                    Size=Vector3.new(0.1, 1 + math.random()*1.5, 0.1),
                    Material=Enum.Material.Neon, Color=CFG.Char.Lightning.Color,
                    CanCollide=false, Anchored=true, CanQuery=false,
                    CFrame=CFrame.new(root.Position + offset) * CFrame.Angles(
                        math.rad(math.random(-30,30)), math.rad(math.random(0,360)), math.rad(math.random(-30,30))
                    ), Parent=folder
                })
                task.delay(0.1, function() if bolt.Parent then bolt:Destroy() end end)
            end
        elseif folder then folder:Destroy() end
    end
end)

-- WINGS
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local folder = charFolder:FindFirstChild("Wings")
        if CFG.Char.Wings.Enabled and CFG.Master and root then
            if not folder then
                folder = Create("Folder", {Name="Wings", Parent=charFolder})
                for side = -1, 1, 2 do
                    local wingModel = Create("Model", {Name = side == -1 and "WingL" or "WingR", Parent = folder})
                    for i = 1, 5 do
                        Create("Part", {
                            Name = "F"..i, Size = Vector3.new(0.15, 0.8 + i*0.1, 0.4 + i*0.15),
                            Material = Enum.Material.Neon, Color = CFG.Char.Wings.Color,
                            Transparency = 0.05, CanCollide = false, Anchored = true,
                            CanQuery = false, Parent = wingModel
                        })
                    end
                end
            end
            local rootCF = root.CFrame
            for _, wingModel in ipairs(folder:GetChildren()) do
                local side = wingModel.Name == "WingL" and -1 or 1
                for i, part in ipairs(wingModel:GetChildren()) do
                    if part:IsA("BasePart") then
                        local baseOffset = Vector3.new(side * (0.8 + i * 0.3), 0.5 + i * 0.4, 0.2 + i * 0.1)
                        part.Size = Vector3.new(0.15, 0.6 + i*0.15, 0.4 + i*0.2) * CFG.Char.Wings.Size
                        local flap = math.sin(tick() * 3 + i * 0.5) * 0.15
                        part.CFrame = rootCF * CFrame.new(baseOffset) * CFrame.Angles(math.rad(side * (10 + i*5 + flap*100)), 0, 0)
                        part.Color = GetColor(CFG.Char.Wings)
                    end
                end
            end
        elseif folder then folder:Destroy() end
    end
end)

-- OUTLINE
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local hl = charFolder:FindFirstChild("OutlineHL")
        if CFG.Char.Outline.Enabled and CFG.Master and char then
            if not hl then
                hl = Create("Highlight", {Name="OutlineHL", FillTransparency=1, OutlineTransparency=0, OutlineColor=CFG.Char.Outline.Color, DepthMode=Enum.HighlightDepthMode.AlwaysOnTop, Parent=charFolder})
            end
            hl.Adornee = char
            hl.OutlineColor = GetColor(CFG.Char.Outline)
        elseif hl then hl:Destroy() end
    end
end)

-- CHAMS
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local hl = charFolder:FindFirstChild("ChamsHL")
        if CFG.Char.Chams.Enabled and CFG.Master and char then
            if not hl then
                hl = Create("Highlight", {Name="ChamsHL", OutlineTransparency=1, FillTransparency=CFG.Char.Chams.Transp, FillColor=CFG.Char.Chams.Color, DepthMode=Enum.HighlightDepthMode.AlwaysOnTop, Parent=charFolder})
            end
            hl.Adornee = char
            hl.FillColor = GetColor(CFG.Char.Chams)
            hl.FillTransparency = CFG.Char.Chams.Transp
        elseif hl then hl:Destroy() end
    end
end)

-- TRAIL
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local trail = root and root:FindFirstChild("ZenithTrail")
        if CFG.Char.Trail.Enabled and CFG.Master and root then
            if not trail then
                local a0 = Create("Attachment", {Name="ZA0", Parent=root}); a0.Position = Vector3.new(0, 0.5, 0)
                local a1 = Create("Attachment", {Name="ZA1", Parent=root}); a1.Position = Vector3.new(0, -0.5, 0)
                trail = Create("Trail", {Name="ZenithTrail", Attachment0=a0, Attachment1=a1, Lifetime=CFG.Char.Trail.Life, Color=ColorSequence.new(CFG.Char.Trail.Color), Parent=root})
            end
            trail.Lifetime = CFG.Char.Trail.Life
            trail.Color = ColorSequence.new(GetColor(CFG.Char.Trail))
        elseif trail then trail:Destroy() end
    end
end)

-- GLOW
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local glow = root and root:FindFirstChild("ZenithGlow")
        if CFG.Char.Glow.Enabled and CFG.Master and root then
            if not glow then
                glow = Create("PointLight", {Name="ZenithGlow", Brightness=CFG.Char.Glow.Bright, Range=CFG.Char.Glow.Range, Color=CFG.Char.Glow.Color, Parent=root})
            end
            glow.Brightness = CFG.Char.Glow.Bright
            glow.Range = CFG.Char.Glow.Range
            glow.Color = GetColor(CFG.Char.Glow)
        elseif glow then glow:Destroy() end
    end
end)

-- ORBS
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local folder = charFolder:FindFirstChild("Orbs")
        if CFG.Char.Orbs.Enabled and CFG.Master and root then
            if not folder then folder = Create("Folder", {Name="Orbs", Parent=charFolder}) end
            local count = CFG.Char.Orbs.Count
            local kids = folder:GetChildren()
            while #kids < count do
                Create("Part", {Name="Orb"..(#kids+1), Shape=Enum.PartType.Ball, Size=Vector3.new(0.6,0.6,0.6), Material=Enum.Material.Neon, CanCollide=false, Anchored=true, CanQuery=false, Parent=folder})
                kids = folder:GetChildren()
            end
            while #kids > count do kids[#kids]:Destroy(); kids = folder:GetChildren() end
            local t = tick() * CFG.Char.Orbs.Speed
            local s = CFG.Char.Orbs.Size
            local r = CFG.Char.Orbs.Radius
            for i, orb in ipairs(folder:GetChildren()) do
                local a = t + (i * math.pi * 2 / #folder:GetChildren())
                local off = Vector3.new(math.cos(a)*r, 1.5 + math.sin(t+i)*0.5, math.sin(a)*r)
                orb.Size = Vector3.new(s,s,s)
                orb.CFrame = CFrame.new(root.Position + off)
                orb.Color = GetColor(CFG.Char.Orbs)
            end
        elseif folder then folder:Destroy() end
    end
end)

-- RING
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local ring = charFolder:FindFirstChild("Ring")
        if CFG.Char.Ring.Enabled and CFG.Master and root then
            if not ring then
                ring = Create("Part", {Name="Ring", Shape=Enum.PartType.Cylinder, Size=Vector3.new(0.2,6,6), Transparency=0.2, CanCollide=false, Anchored=true, CanQuery=false, Material=Enum.Material.Neon, Color=CFG.Char.Ring.Color, Parent=charFolder})
            end
            local s = CFG.Char.Ring.Size
            ring.Size = Vector3.new(0.2, s, s)
            local angle = (tick() * 60 * CFG.Char.Ring.Speed) % 360
            ring.CFrame = CFrame.new(root.Position - Vector3.new(0,2.9,0)) * CFrame.Angles(0, math.rad(angle), math.rad(90))
            ring.Color = GetColor(CFG.Char.Ring)
        elseif ring then ring:Destroy() end
    end
end)

-- NEON BODY
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        if CFG.Char.NeonBody.Enabled and CFG.Master and char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Material = Enum.Material.Neon
                    part.Color = GetColor(CFG.Char.NeonBody)
                end
            end
        end
    end
end)

-- PARTICLES
task.spawn(function()
    while gui.Parent do
        RunService.Heartbeat:Wait()
        local char = GetChar()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local p = root and root:FindFirstChild("ZenithParticles")
        if CFG.Char.Particles.Enabled and CFG.Master and root then
            if not p then
                p = Create("ParticleEmitter", {Name="ZenithParticles", Rate=CFG.Char.Particles.Rate, Lifetime=NumberRange.new(0.5,1.2), Speed=NumberRange.new(2,4), SpreadAngle=Vector2.new(180,180), Size=NumberSequence.new(CFG.Char.Particles.Size), Texture="rbxasset://textures/particles/sparkles_main.dds", Parent=root})
            end
            p.Rate = CFG.Char.Particles.Rate
            p.Color = ColorSequence.new(GetColor(CFG.Char.Particles))
        elseif p then p:Destroy() end
    end
end)

-- ESP
local espFolder = Create("Folder", {Name="Zenith_EspFolder", Parent=gui})
local function IsTeammate(plr)
    if not CFG.ESP.TeamCheck then return false end
    return plr.Team == LocalPlayer.Team and plr.Team ~= nil
end

local function CreateESPGui(plr)
    local box = Create("Frame", {Name=plr.Name, BackgroundTransparency=1, BorderSizePixel=0, Visible=false, Parent=espFolder})
    Stroke(box, CFG.ESP.BoxColor, CFG.ESP.BoxThick)
    Create("TextLabel", {Name="NameTag", Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,-16), BackgroundTransparency=1, Text=plr.Name, TextColor3=CFG.ESP.NameColor, Font=Enum.Font.GothamBold, TextSize=CFG.ESP.NameSize, TextStrokeTransparency=0.3, Parent=box})
    local hb = Create("Frame", {Name="HealthBg", Size=UDim2.new(0,3,1,0), Position=UDim2.new(0,-6,0,0), BackgroundColor3=Color3.fromRGB(30,30,35), BorderSizePixel=0, Parent=box})
    Create("Frame", {Name="Health", Size=UDim2.new(1,0,1,0), BackgroundColor3=CFG.ESP.HealthColor, BorderSizePixel=0, Parent=hb})
    Create("TextLabel", {Name="DistTag", Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,1,2), BackgroundTransparency=1, Text="", TextColor3=CFG.ESP.DistanceColor, Font=Enum.Font.Gotham, TextSize=11, TextStrokeTransparency=0.3, Parent=box})
    Create("Frame", {Name="HeadDot", Size=UDim2.new(0,6,0,6), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=CFG.ESP.HeadDotColor, BorderSizePixel=0, Parent=box})
    return box
end

local tracerGui = Create("Frame", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Parent=espFolder})
local espData = {}
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then espData[plr] = CreateESPGui(plr) end
end
Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then espData[plr] = CreateESPGui(plr) end
end)
Players.PlayerRemoving:Connect(function(plr)
    if espData[plr] then espData[plr]:Destroy(); espData[plr] = nil end
end)

local espHighlights = {}
local function UpdateESPHighlight(plr)
    if CFG.ESP.Chams or CFG.ESP.Outline then
        if not espHighlights[plr] then
            espHighlights[plr] = Create("Highlight", {FillTransparency=CFG.ESP.Chams and CFG.ESP.ChamsTransp or 1, OutlineTransparency=CFG.ESP.Outline and 0 or 1, FillColor=CFG.ESP.ChamsColor, OutlineColor=CFG.ESP.OutlineColor, DepthMode=Enum.HighlightDepthMode.AlwaysOnTop, Parent=espFolder})
        end
        espHighlights[plr].Adornee = plr.Character
        espHighlights[plr].FillTransparency = CFG.ESP.Chams and CFG.ESP.ChamsTransp or 1
        espHighlights[plr].OutlineTransparency = CFG.ESP.Outline and 0 or 1
        if CFG.ESP.Rainbow then
            local c = RainbowColor()
            espHighlights[plr].FillColor = c
            espHighlights[plr].OutlineColor = c
        else
            espHighlights[plr].FillColor = CFG.ESP.ChamsColor
            espHighlights[plr].OutlineColor = CFG.ESP.OutlineColor
        end
    elseif espHighlights[plr] then
        espHighlights[plr]:Destroy()
        espHighlights[plr] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not CFG.Master then
        for _, box in pairs(espData) do box.Visible = false end
        return
    end
    local myPos = Camera.CFrame.Position
    for plr, box in pairs(espData) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local show = (CFG.ESP.Box or CFG.ESP.Name or CFG.ESP.Health or CFG.ESP.Distance or CFG.ESP.Tracer or CFG.ESP.HeadDot) and hrp and head and hum and hum.Health > 0 and not IsTeammate(plr)
        if show then
            local dist = (hrp.Position - myPos).Magnitude
            if dist <= CFG.ESP.DistanceLimit then
                local sp = Camera:WorldToViewportPoint(hrp.Position)
                local spHead = Camera:WorldToViewportPoint(head.Position)
                local h = math.abs(spHead.Y - sp.Y) * 1.6
                local w = h * 0.65
                box.Visible = CFG.ESP.Box
                box.Position = UDim2.new(0, sp.X - w/2, 0, sp.Y - h/2)
                box.Size = UDim2.new(0, w, 0, h)
                local s = box:FindFirstChildOfClass("UIStroke")
                if s then
                    s.Color = CFG.ESP.Rainbow and RainbowColor() or CFG.ESP.BoxColor
                    s.Thickness = CFG.ESP.BoxThick
                    s.Transparency = CFG.ESP.Box and 0 or 1
                end
                local nt = box:FindFirstChild("NameTag")
                nt.Visible = CFG.ESP.Name
                nt.TextColor3 = CFG.ESP.Rainbow and RainbowColor() or CFG.ESP.NameColor
                nt.TextSize = CFG.ESP.NameSize
                local hbb = box:FindFirstChild("HealthBg")
                hbb.Visible = CFG.ESP.Health
                if CFG.ESP.Health then
                    hbb:FindFirstChild("Health").Size = UDim2.new(1, 0, hum.Health / hum.MaxHealth, 0)
                    hbb:FindFirstChild("Health").BackgroundColor3 = CFG.ESP.Rainbow and RainbowColor() or CFG.ESP.HealthColor
                end
                local dt = box:FindFirstChild("DistTag")
                dt.Visible = CFG.ESP.Distance
                if CFG.ESP.Distance then
                    dt.Text = string.format("[%d]", dist)
                    dt.TextColor3 = CFG.ESP.Rainbow and RainbowColor() or CFG.ESP.DistanceColor
                end
                local hd = box:FindFirstChild("HeadDot")
                hd.Visible = CFG.ESP.HeadDot
                if CFG.ESP.HeadDot then
                    hd.Position = UDim2.new(0.5, 0, (spHead.Y - (sp.Y - h/2)) / h, 0)
                    hd.BackgroundColor3 = CFG.ESP.Rainbow and RainbowColor() or CFG.ESP.HeadDotColor
                end
            else box.Visible = false end
        else box.Visible = false end
        UpdateESPHighlight(plr)
    end

    for _, f in ipairs(tracerGui:GetChildren()) do
        if f:IsA("Frame") then f:Destroy() end
    end
    if CFG.ESP.Tracer then
        for plr in pairs(espData) do
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and not IsTeammate(plr) then
                local sp = Camera.ViewportSize
                local target = Camera:WorldToViewportPoint(hrp.Position)
                local from = Vector2.new(sp.X/2, sp.Y)
                local to = Vector2.new(target.X, target.Y)
                local delta = to - from
                local len = delta.Magnitude
                local ang = math.deg(math.atan2(delta.Y, delta.X))
                Create("Frame", {BackgroundColor3=CFG.ESP.Rainbow and RainbowColor() or CFG.ESP.TracerColor, BorderSizePixel=0, Size=UDim2.new(0, len, 0, 1), Position=UDim2.new(0, from.X, 0, from.Y), Rotation=ang, Parent=tracerGui})
            end
        end
    end
end)

-- FPS/PING
local perfLabel = Create("TextLabel", {Size=UDim2.new(0,250,0,18), Position=UDim2.new(0,12,0,12), BackgroundTransparency=1, Text="", TextColor3=Theme.TextDim, Font=Enum.Font.GothamMedium, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left, TextStrokeTransparency=0.6, Parent=gui})
local fpsCount, fpsTime, fpsValue = 0, 0, 0
RunService.RenderStepped:Connect(function(dt)
    fpsCount = fpsCount + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then fpsValue = fpsCount; fpsCount = 0; fpsTime = 0 end
end)
task.spawn(function()
    while gui.Parent do
        local parts = {}
        if CFG.FPS then table.insert(parts, "FPS: " .. fpsValue) end
        if CFG.Ping then
            local ping = "?"
            pcall(function() ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms" end)
            table.insert(parts, "PING: " .. ping)
        end
        if CFG.Memory then table.insert(parts, "MEM: " .. math.floor(collectgarbage("count") / 1024) .. "MB") end
        perfLabel.Text = table.concat(parts, "  |  ")
        task.wait(0.5)
    end
end)

-- STARTUP
task.spawn(function()
    loadingFrame.Visible = true
    for i = 0, 100, 3 do
        Tween(lbF, 0.05, {Size=UDim2.new(i/100, 0, 1, 0)})
        task.wait(0.015)
    end
    task.wait(0.3)
    Tween(loadingFrame, 0.5, {BackgroundTransparency=1})
    for _, c in ipairs(loadingFrame:GetDescendants()) do
        if c:IsA("TextLabel") then Tween(c, 0.4, {TextTransparency=1}) end
        if c:IsA("Frame") then Tween(c, 0.4, {BackgroundTransparency=1}) end
    end
    task.wait(0.6)
    loadingFrame:Destroy()
    if CFG.ActiveConfig ~= "" and isfile and isfile(CONFIG_FOLDER .. "/" .. CFG.ActiveConfig .. ".json") then
        pcall(function() LoadConfig(CFG.ActiveConfig) end)
    end
end)

task.spawn(function()
    while not CFG.UI.Platform do task.wait(0.1) end
    task.wait(0.5)
    if not CFG.UI.IsMobile then
        BuildPreview()
    end
end)
