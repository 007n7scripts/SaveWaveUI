local SaveWaveUVL = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Configurable KeySystem (true = aktif, false = mati)
local KeySystem = true
local KeyList = {"universal2026", "savewavevip", "allgamepro", "yokgacor"}

-- Bilingual Support
local Language = "ID" -- "ID" atau "EN"
local L = {
    ID = {
        Title = "SAVEWAVE UNIVERSAL",
        Subtitle = "Support Semua Game - 2026",
        Close = "✕",
        Minimize = "−",
        Loaded = "SaveWave Universal Loaded!",
        Welcome = "UI siap dipake di game apapun bro!",
        KeyTitle = "AKSES PREMIUM",
        KeyDesc = "Masukkan key untuk buka fitur lengkap.",
        KeyPlaceholder = "Ketik key di sini...",
        Unlock = "BUKA",
        Invalid = "Key Salah!",
        Granted = "Akses Diterima!",
        TabMain = "Utama",
        TabTools = "Alat",
        TabVisual = "Visual",
        TabSettings = "Pengaturan",
        ToggleOn = "NYALA",
        ToggleOff = "MATI"
    },
    EN = {
        Title = "SAVEWAVE UNIVERSAL",
        Subtitle = "All Game Support - 2026",
        Close = "✕",
        Minimize = "−",
        Loaded = "SaveWave Universal Loaded!",
        Welcome = "UI ready for any game!",
        KeyTitle = "PREMIUM ACCESS",
        KeyDesc = "Enter your key to unlock full features.",
        KeyPlaceholder = "Type key here...",
        Unlock = "UNLOCK",
        Invalid = "Invalid Key!",
        Granted = "Access Granted!",
        TabMain = "Main",
        TabTools = "Tools",
        TabVisual = "Visual",
        TabSettings = "Settings",
        ToggleOn = "ON",
        ToggleOff = "OFF"
    }
}
local Text = L[Language] or L.ID

-- Themes
local Themes = {
    NeonBlue = {Bg = Color3.fromRGB(5, 15, 45), Accent = Color3.fromRGB(0, 240, 255), TextC = Color3.new(1,1,1), Sec = Color3.fromRGB(15, 40, 100)},
    Dark = {Bg = Color3.fromRGB(10, 10, 28), Accent = Color3.fromRGB(100, 150, 255), TextC = Color3.new(1,1,1), Sec = Color3.fromRGB(25, 25, 55)},
    PurpleWave = {Bg = Color3.fromRGB(20, 8, 40), Accent = Color3.fromRGB(200, 80, 255), TextC = Color3.new(1,1,1), Sec = Color3.fromRGB(45, 20, 110)}
}
local Theme = Themes.NeonBlue

-- KeySystem Screen
if KeySystem then
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "SaveWaveKey"
    KeyGui.Parent = PlayerGui

    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(0, 500, 0, 350)
    KeyFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    KeyFrame.BackgroundColor3 = Theme.Bg
    KeyFrame.Parent = KeyGui

    local KCorner = Instance.new("UICorner", KeyFrame)
    KCorner.CornerRadius = UDim.new(0, 20)

    local KGlow = Instance.new("ImageLabel")
    KGlow.Parent = KeyFrame
    KGlow.BackgroundTransparency = 1
    KGlow.Position = UDim2.new(0, -60, 0, -60)
    KGlow.Size = UDim2.new(1, 120, 1, 120)
    KGlow.Image = "rbxassetid://4996891970"
    KGlow.ImageColor3 = Theme.Accent
    KGlow.ImageTransparency = 0.4

    local KTitle = Instance.new("TextLabel")
    KTitle.Parent = KeyFrame
    KTitle.Text = Text.KeyTitle
    KTitle.Position = UDim2.new(0, 0, 0, 40)
    KTitle.Size = UDim2.new(1, 0, 0, 60)
    KTitle.BackgroundTransparency = 1
    KTitle.TextColor3 = Theme.TextC
    KTitle.Font = Enum.Font.GothamBlack
    KTitle.TextSize = 32

    local KDesc = Instance.new("TextLabel")
    KDesc.Parent = KeyFrame
    KDesc.Text = Text.KeyDesc
    KDesc.Position = UDim2.new(0, 40, 0, 110)
    KDesc.Size = UDim2.new(1, -80, 0, 50)
    KDesc.BackgroundTransparency = 1
    KDesc.TextColor3 = Theme.Accent
    KDesc.TextSize = 18
    KDesc.TextWrapped = true

    local KeyInput = Instance.new("TextBox")
    KeyInput.Parent = KeyFrame
    KeyInput.PlaceholderText = Text.KeyPlaceholder
    KeyInput.Position = UDim2.new(0, 60, 0.5, -30)
    KeyInput.Size = UDim2.new(1, -120, 0, 70)
    KeyInput.BackgroundColor3 = Theme.Sec
    KeyInput.TextColor3 = Theme.TextC
    KeyInput.TextSize = 20
    local InC = Instance.new("UICorner", KeyInput)

    local UnlockBtn = Instance.new("TextButton")
    UnlockBtn.Parent = KeyFrame
    UnlockBtn.Text = Text.Unlock
    UnlockBtn.Position = UDim2.new(0.5, -100, 1, -90)
    UnlockBtn.Size = UDim2.new(0, 200, 0, 60)
    UnlockBtn.BackgroundColor3 = Theme.Accent
    UnlockBtn.TextColor3 = Color3.new(0,0,0)
    UnlockBtn.TextSize = 24
    local UB = Instance.new("UICorner", UnlockBtn)

    local Status = Instance.new("TextLabel")
    Status.Parent = KeyFrame
    Status.Position = UDim2.new(0, 0, 1, -150)
    Status.Size = UDim2.new(1, 0, 0, 40)
    Status.BackgroundTransparency = 1
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    Status.TextSize = 18

    UnlockBtn.MouseButton1Click:Connect(function()
        local entered = KeyInput.Text:gsub("%s+", "")
        local valid = false
        for _, k in pairs(KeyList) do
            if entered == k then valid = true break end
        end
        if valid then
            Status.Text = Text.Granted
            Status.TextColor3 = Color3.fromRGB(100, 255, 150)
            task.wait(1.5)
            KeyGui:Destroy()
            SaveWaveUVL:BuildUI()
        else
            Status.Text = Text.Invalid
        end
    end)
else
    SaveWaveUVL:BuildUI()
end

-- Main UI Build
function SaveWaveUVL:BuildUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SaveWaveUniversal"
    ScreenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 800, 0, 600)
    MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
    MainFrame.BackgroundColor3 = Theme.Bg
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Parent = ScreenGui

    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 20)

    local Glow = Instance.new("ImageLabel")
    Glow.Parent = MainFrame
    Glow.BackgroundTransparency = 1
    Glow.Position = UDim2.new(0, -50, 0, -50)
    Glow.Size = UDim2.new(1, 100, 1, 100)
    Glow.Image = "rbxassetid://4996891970"
    Glow.ImageColor3 = Theme.Accent
    Glow.ImageTransparency = 0.4

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Text = Text.Title
    Title.Position = UDim2.new(0, 30, 0, 20)
    Title.Size = UDim2.new(0, 500, 0, 50)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Theme.TextC
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 32
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Sub = Instance.new("TextLabel")
    Sub.Parent = MainFrame
    Sub.Text = Text.Subtitle
    Sub.Position = UDim2.new(0, 30, 0, 70)
    Sub.Size = UDim2.new(0, 500, 0, 30)
    Sub.BackgroundTransparency = 1
    Sub.TextColor3 = Theme.Accent
    Sub.TextSize = 18
    Sub.TextXAlignment = Enum.TextXAlignment.Left

    -- Close & Minimize
    local Close = Instance.new("TextButton")
    Close.Parent = MainFrame
    Close.Size = UDim2.new(0, 40, 0, 40)
    Close.Position = UDim2.new(1, -50, 0, 20)
    Close.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    Close.Text = Text.Close
    Close.TextColor3 = Color3.new(1,1,1)
    Close.TextSize = 28
    local CC = Instance.new("UICorner", Close)

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Parent = MainFrame
    TabContainer.Size = UDim2.new(1, -60, 0, 60)
    TabContainer.Position = UDim2.new(0, 30, 0, 120)
    TabContainer.BackgroundTransparency = 1

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabContainer
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 15)

    -- Content
    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.Position = UDim2.new(0, 30, 0, 190)
    Content.Size = UDim2.new(1, -60, 1, -220)
    Content.BackgroundTransparency = 1
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.ScrollBarThickness = 8
    Content.ScrollBarImageColor3 = Theme.Accent

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = Content
    ContentLayout.Padding = UDim.new(0, 15)

    local currentTab = nil

    function SaveWaveUVL:CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(0, 150, 1, 0)
        TabBtn.BackgroundColor3 = Theme.Sec
        TabBtn.Text = name or Text.TabMain
        TabBtn.TextColor3 = Theme.TextC
        TabBtn.TextSize = 18
        local TC = Instance.new("UICorner", TabBtn)

        local TabContent = Instance.new("Frame")
        TabContent.Parent = Content
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false

        local TabL = Instance.new("UIListLayout")
        TabL.Parent = TabContent
        TabL.Padding = UDim.new(0, 12)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then currentTab.Visible = false end
            TabContent.Visible = true
            currentTab = TabContent
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Sec}):Play()
                end
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
        end)

        local Elements = {}

        function Elements:Toggle(name, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 55)
            frame.BackgroundColor3 = Theme.Sec
            local fc = Instance.new("UICorner", frame)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Position = UDim2.new(0, 20, 0, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Theme.TextC
            label.TextXAlignment = Enum.TextXAlignment.Left

            local switch = Instance.new("TextButton")
            switch.Parent = frame
            switch.Size = UDim2.new(0, 70, 0, 35)
            switch.Position = UDim2.new(1, -90, 0.5, -17.5)
            switch.BackgroundColor3 = default and Theme.Accent or Color3.fromRGB(255, 80, 80)
            switch.Text = default and Text.ToggleOn or Text.ToggleOff
            switch.TextColor3 = Color3.new(1,1,1)
            local sc = Instance.new("UICorner", switch)

            local state = default or false
            switch.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(255, 80, 80)}):Play()
                switch.Text = state and Text.ToggleOn or Text.ToggleOff
                if callback then callback(state) end
            end)
        end

        function Elements:Button(name, callback)
            local btn = Instance.new("TextButton")
            btn.Parent = TabContent
            btn.Size = UDim2.new(1, 0, 0, 55)
            btn.BackgroundColor3 = Theme.Accent
            btn.Text = name
            btn.TextColor3 = Color3.new(0,0,0)
            btn.TextSize = 18
            local bc = Instance.new("UICorner", btn)

            btn.MouseButton1Click:Connect(callback or function() end)
        end

        function Elements:Slider(name, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 80)
            frame.BackgroundColor3 = Theme.Sec
            local fc = Instance.new("UICorner", frame)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name .. ": " .. default
            label.Position = UDim2.new(0, 20, 0, 10)
            label.Size = UDim2.new(1, -40, 0, 35)
            label.BackgroundTransparency = 1
            label.TextColor3 = Theme.TextC
            label.TextXAlignment = Enum.TextXAlignment.Left

            local bar = Instance.new("Frame")
            bar.Parent = frame
            bar.Position = UDim2.new(0, 20, 1, -35)
            bar.Size = UDim2.new(1, -40, 0, 20)
            bar.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
            local bc = Instance.new("UICorner", bar)

            local fill = Instance.new("Frame")
            fill.Parent = bar
            fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            fill.BackgroundColor3 = Theme.Accent
            local fc2 = Instance.new("UICorner", fill)

            local knob = Instance.new("TextButton")
            knob.Parent = fill
            knob.Size = UDim2.new(0, 32, 0, 32)
            knob.Position = UDim2.new(1, -16, 0, -6)
            knob.BackgroundColor3 = Color3.new(1,1,1)
            knob.Text = ""
            local kc = Instance.new("UICorner", knob)
            kc.CornerRadius = UDim.new(1, 0)

            local dragging = false
            knob.MouseButton1Down:Connect(function() dragging = true end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mouse = Player:GetMouse()
                    local percent = math.clamp((mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + (max - min) * percent)
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    label.Text = name .. ": " .. value
                    if callback then callback(value) end
                end
            end)
        end

        return Elements
    end

    -- Example Tabs
    local MainTab = SaveWaveUVL:CreateTab(Text.TabMain)
    local ToolsTab = SaveWaveUVL:CreateTab(Text.TabTools)
    local SettingsTab = SaveWaveUVL:CreateTab(Text.TabSettings)

    -- Open Animation
    MainFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 800, 0, 600)}):Play()

    SaveWaveUVL:Notify(Text.Loaded, Text.Welcome, 7)
end

-- Notification
function SaveWaveUVL:Notify(title, content, duration)
    duration = duration or 5
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 350, 0, 120)
    notif.Position = UDim2.new(1, 20, 1, -140)
    notif.BackgroundColor3 = Theme.Sec
    notif.Parent = PlayerGui
    local nc = Instance.new("UICorner", notif)

    local ntitle = Instance.new("TextLabel")
    ntitle.Parent = notif
    ntitle.Text = title
    ntitle.Size = UDim2.new(1, 0, 0, 45)
    ntitle.BackgroundTransparency = 1
    ntitle.TextColor3 = Theme.Accent
    ntitle.TextSize = 22

    local ncontent = Instance.new("TextLabel")
    ncontent.Parent = notif
    ncontent.Position = UDim2.new(0, 15, 0, 45)
    ncontent.Size = UDim2.new(1, -30, 1, -55)
    ncontent.BackgroundTransparency = 1
    ncontent.Text = content
    ncontent.TextColor3 = Theme.TextC
    ncontent.TextWrapped = true

    TweenService:Create(notif, TweenInfo.new(0.6), {Position = UDim2.new(1, -370, 1, -140)}):Play()
    task.wait(duration)
    TweenService:Create(notif, TweenInfo.new(0.6), {Position = UDim2.new(1, 20, 1, -140)}):Play()
    task.wait(0.6)
    notif:Destroy()
end

return SaveWaveUVL
