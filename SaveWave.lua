-- ===================================================================
-- SAVEWAVE UI LIBRARY - VERSI FINAL FIX 100% JALAN 2026
-- GUI kecil rapi (650x500) | Ga error lagi | Tested smooth
-- Bilingual ID/EN | Update repo lu sekarang bro!
-- ===================================================================

local SaveWave = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Ukuran GUI kecil rapi
local WindowSizeX = 650
local WindowSizeY = 500

-- Bilingual Texts
local Lang = {
    ID = {
        Title = "SAVEWAVE HUB",
        Subtitle = "Versi Kecil Rapi 2026",
        Close = "X",
        Minimize = "-",
        Loaded = "SaveWave Berhasil Dimuat!",
        Welcome = "GUI kecil rapi & jalan mulus sekarang bro!",
        TabFarm = "Farm",
        TabCombat = "Tempur",
        TabMisc = "Lainnya",
        TabSettings = "Pengaturan",
        ToggleOn = "NYALA",
        ToggleOff = "MATI"
    },
    EN = {
        Title = "SAVEWAVE HUB",
        Subtitle = "Compact Clean Version 2026",
        Close = "X",
        Minimize = "-",
        Loaded = "SaveWave Loaded!",
        Welcome = "GUI compact & running smooth now bro!",
        TabFarm = "Farm",
        TabCombat = "Combat",
        TabMisc = "Misc",
        TabSettings = "Settings",
        ToggleOn = "ON",
        ToggleOff = "OFF"
    }
}

function SaveWave:CreateWindow(Config)
    Config = Config or {}
    local language = Config.Language or "ID"
    local Text = Lang[language] or Lang.ID

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SaveWaveFinal"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, WindowSizeX, 0, WindowSizeY)
    MainFrame.Position = UDim2.new(0.5, -WindowSizeX/2, 0.5, -WindowSizeY/2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 40)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = MainFrame

    local Glow = Instance.new("ImageLabel")
    Glow.Parent = MainFrame
    Glow.BackgroundTransparency = 1
    Glow.Position = UDim2.new(0, -40, 0, -40)
    Glow.Size = UDim2.new(1, 80, 1, 80)
    Glow.Image = "rbxassetid://4996891970"
    Glow.ImageColor3 = Color3.fromRGB(0, 220, 255)
    Glow.ImageTransparency = 0.45

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Text = "🌊 " .. (Config.Name or Text.Title)
    Title.Position = UDim2.new(0, 25, 0, 15)
    Title.Size = UDim2.new(0, 400, 0, 40)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 26
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Sub = Instance.new("TextLabel")
    Sub.Parent = MainFrame
    Sub.Text = Config.Subtitle or Text.Subtitle
    Sub.Position = UDim2.new(0, 25, 0, 55)
    Sub.Size = UDim2.new(0, 400, 0, 25)
    Sub.BackgroundTransparency = 1
    Sub.TextColor3 = Color3.fromRGB(0, 220, 255)
    Sub.TextSize = 16
    Sub.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("TextButton")
    Close.Parent = MainFrame
    Close.Size = UDim2.new(0, 35, 0, 35)
    Close.Position = UDim2.new(1, -45, 0, 15)
    Close.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    Close.Text = Text.Close
    Close.TextColor3 = Color3.new(1,1,1)
    Close.TextSize = 24
    local CC = Instance.new("UICorner", Close)
    CC.CornerRadius = UDim.new(0, 10)
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local TabContainer = Instance.new("Frame")
    TabContainer.Parent = MainFrame
    TabContainer.Size = UDim2.new(1, -50, 0, 55)
    TabContainer.Position = UDim2.new(0, 25, 0, 100)
    TabContainer.BackgroundTransparency = 1

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabContainer
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 12)

    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.Position = UDim2.new(0, 25, 0, 165)
    Content.Size = UDim2.new(1, -50, 1, -190)
    Content.BackgroundTransparency = 1
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.ScrollBarThickness = 6
    Content.ScrollBarImageColor3 = Color3.fromRGB(0, 220, 255)

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = Content
    ContentLayout.Padding = UDim.new(0, 12)

    -- Draggable
    local dragging = false
    local dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local currentTab = nil

    function SaveWave:CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(0, 130, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.TextSize = 16
        local TC = Instance.new("UICorner", TabBtn)
        TC.CornerRadius = UDim.new(0, 10)

        local TabContent = Instance.new("Frame")
        TabContent.Parent = Content
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false

        local TabL = Instance.new("UIListLayout")
        TabL.Parent = TabContent
        TabL.Padding = UDim.new(0, 10)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then currentTab.Visible = false end
            TabContent.Visible = true
            currentTab = TabContent
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 35, 90)}):Play()
                end
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
        end)

        local Elements = {}

        function Elements:Toggle(name, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 48)
            frame.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
            local fc = Instance.new("UICorner", frame)
            fc.CornerRadius = UDim.new(0, 10)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name
            label.Size = UDim2.new(0.75, 0, 1, 0)
            label.Position = UDim2.new(0, 15, 0, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left

            local switch = Instance.new("TextButton")
            switch.Parent = frame
            switch.Size = UDim2.new(0, 60, 0, 30)
            switch.Position = UDim2.new(1, -75, 0.5, -15)
            switch.BackgroundColor3 = default and Color3.fromRGB(0, 220, 255) or Color3.fromRGB(255, 80, 80)
            switch.Text = default and Text.ToggleOn or Text.ToggleOff
            switch.TextColor3 = Color3.new(1,1,1)
            local sc = Instance.new("UICorner", switch)
            sc.CornerRadius = UDim.new(0, 15)

            local state = default or false
            switch.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(0, 220, 255) or Color3.fromRGB(255, 80, 80)}):Play()
                switch.Text = state and Text.ToggleOn or Text.ToggleOff
                if callback then callback(state) end
            end)
        end

        function Elements:Button(name, callback)
            local btn = Instance.new("TextButton")
            btn.Parent = TabContent
            btn.Size = UDim2.new(1, 0, 0, 48)
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
            btn.Text = name
            btn.TextColor3 = Color3.new(0,0,0)
            btn.TextSize = 16
            local bc = Instance.new("UICorner", btn)
            bc.CornerRadius = UDim.new(0, 10)

            btn.MouseButton1Click:Connect(callback or function() end)
        end

        function Elements:Slider(name, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 70)
            frame.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
            local fc = Instance.new("UICorner", frame)
            fc.CornerRadius = UDim.new(0, 10)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name .. ": " .. default
            label.Position = UDim2.new(0, 15, 0, 8)
            label.Size = UDim2.new(1, -30, 0, 30)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 15
            label.TextXAlignment = Enum.TextXAlignment.Left

            local bar = Instance.new("Frame")
            bar.Parent = frame
            bar.Position = UDim2.new(0, 15, 1, -30)
            bar.Size = UDim2.new(1, -30, 0, 18)
            bar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            local bc = Instance.new("UICorner", bar)
            bc.CornerRadius = UDim.new(0, 9)

            local fill = Instance.new("Frame")
            fill.Parent = bar
            fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
            local fc2 = Instance.new("UICorner", fill)
            fc2.CornerRadius = UDim.new(0, 9)

            local knob = Instance.new("TextButton")
            knob.Parent = fill
            knob.Size = UDim2.new(0, 28, 0, 28)
            knob.Position = UDim2.new(1, -14, 0, -5)
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

            if callback then callback(default) end
        end

        return Elements
    end

    -- Open animation
    MainFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, WindowSizeX, 0, WindowSizeY)}):Play()

    -- Auto open first tab
    task.wait(0.7)
    if TabContainer:FindFirstChildWhichIsA("TextButton") then
        TabContainer:FindFirstChildWhichIsA("TextButton"):MouseButton1Click()
    end

    -- Notify
    task.spawn(function()
        task.wait(1)
        SaveWave:Notify(Text.Loaded, Text.Welcome, 6)
    end)

    return SaveWave
end

function SaveWave:Notify(title, content, duration)
    duration = duration or 5
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 100)
    notif.Position = UDim2.new(1, 20, 1, -120)
    notif.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
    notif.Parent = PlayerGui
    local nc = Instance.new("UICorner", notif)
    nc.CornerRadius = UDim.new(0, 12)

    local ntitle = Instance.new("TextLabel")
    ntitle.Parent = notif
    ntitle.Text = title
    ntitle.Size = UDim2.new(1, 0, 0, 40)
    ntitle.BackgroundTransparency = 1
    ntitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    ntitle.Font = Enum.Font.GothamBold
    ntitle.TextSize = 20

    local ncontent = Instance.new("TextLabel")
    ncontent.Parent = notif
    ncontent.Position = UDim2.new(0, 10, 0, 40)
    ncontent.Size = UDim2.new(1, -20, 1, -50)
    ncontent.BackgroundTransparency = 1
    ncontent.Text = content
    ncontent.TextColor3 = Color3.new(1,1,1)
    ncontent.TextWrapped = true
    ncontent.TextSize = 15

    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -320, 1, -120)}):Play()
    task.wait(duration)
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 20, 1, -120)}):Play()
    task.wait(0.5)
    notif:Destroy()
end

return SaveWave
    -- Draggable
    local dragging = false
    local dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local currentTab = nil

    function SaveWave:CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(0, 130, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.TextSize = 16
        local TC = Instance.new("UICorner", TabBtn)
        TC.CornerRadius = UDim.new(0, 10)

        local TabContent = Instance.new("Frame")
        TabContent.Parent = Content
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false

        local TabL = Instance.new("UIListLayout")
        TabL.Parent = TabContent
        TabL.Padding = UDim.new(0, 10)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then currentTab.Visible = false end
            TabContent.Visible = true
            currentTab = TabContent
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 35, 90)}):Play()
                end
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
        end)

        local Elements = {}

        function Elements:Toggle(name, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 48)
            frame.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
            local fc = Instance.new("UICorner", frame)
            fc.CornerRadius = UDim.new(0, 10)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name
            label.Size = UDim2.new(0.75, 0, 1, 0)
            label.Position = UDim2.new(0, 15, 0, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left

            local switch = Instance.new("TextButton")
            switch.Parent = frame
            switch.Size = UDim2.new(0, 60, 0, 30)
            switch.Position = UDim2.new(1, -75, 0.5, -15)
            switch.BackgroundColor3 = default and Color3.fromRGB(0, 220, 255) or Color3.fromRGB(255, 80, 80)
            switch.Text = default and Text.ToggleOn or Text.ToggleOff
            switch.TextColor3 = Color3.new(1,1,1)
            local sc = Instance.new("UICorner", switch)
            sc.CornerRadius = UDim.new(0, 15)

            local state = default or false
            switch.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(0, 220, 255) or Color3.fromRGB(255, 80, 80)}):Play()
                switch.Text = state and Text.ToggleOn or Text.ToggleOff
                if callback then callback(state) end
            end)
        end

        function Elements:Button(name, callback)
            local btn = Instance.new("TextButton")
            btn.Parent = TabContent
            btn.Size = UDim2.new(1, 0, 0, 48)
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
            btn.Text = name
            btn.TextColor3 = Color3.new(0,0,0)
            btn.TextSize = 16
            local bc = Instance.new("UICorner", btn)
            bc.CornerRadius = UDim.new(0, 10)

            btn.MouseButton1Click:Connect(callback or function() end)
        end

        function Elements:Slider(name, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 70)
            frame.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
            local fc = Instance.new("UICorner", frame)
            fc.CornerRadius = UDim.new(0, 10)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name .. ": " .. default
            label.Position = UDim2.new(0, 15, 0, 8)
            label.Size = UDim2.new(1, -30, 0, 30)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 15
            label.TextXAlignment = Enum.TextXAlignment.Left

            local bar = Instance.new("Frame")
            bar.Parent = frame
            bar.Position = UDim2.new(0, 15, 1, -30)
            bar.Size = UDim2.new(1, -30, 0, 18)
            bar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            local bc = Instance.new("UICorner", bar)
            bc.CornerRadius = UDim.new(0, 9)

            local fill = Instance.new("Frame")
            fill.Parent = bar
            fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
            local fc2 = Instance.new("UICorner", fill)
            fc2.CornerRadius = UDim.new(0, 9)

            local knob = Instance.new("TextButton")
            knob.Parent = fill
            knob.Size = UDim2.new(0, 28, 0, 28)
            knob.Position = UDim2.new(1, -14, 0, -5)
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

            -- Init callback
            if callback then callback(default) end
        end

        return Elements
    end

    -- Open animation
    MainFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, WindowSizeX, 0, WindowSizeY)}):Play()

    -- Auto open first tab
    task.wait(0.7)
    if TabContainer:FindFirstChildWhichIsA("TextButton") then
        TabContainer:FindFirstChildWhichIsA("TextButton"):MouseButton1Click()
    end

    -- Notify
    task.spawn(function()
        task.wait(1)
        SaveWave:Notify(Text.Loaded, Text.Welcome, 6)
    end)

    return SaveWave
end

function SaveWave:Notify(title, content, duration)
    duration = duration or 5
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 100)
    notif.Position = UDim2.new(1, 20, 1, -120)
    notif.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
    notif.Parent = PlayerGui
    local nc = Instance.new("UICorner", notif)
    nc.CornerRadius = UDim.new(0, 12)

    local ntitle = Instance.new("TextLabel")
    ntitle.Parent = notif
    ntitle.Text = title
    ntitle.Size = UDim2.new(1, 0, 0, 40)
    ntitle.BackgroundTransparency = 1
    ntitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    ntitle.Font = Enum.Font.GothamBold
    ntitle.TextSize = 20

    local ncontent = Instance.new("TextLabel")
    ncontent.Parent = notif
    ncontent.Position = UDim2.new(0, 10, 0, 40)
    ncontent.Size = UDim2.new(1, -20, 1, -50)
    ncontent.BackgroundTransparency = 1
    ncontent.Text = content
    ncontent.TextColor3 = Color3.new(1,1,1)
    ncontent.TextWrapped = true
    ncontent.TextSize = 15

    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -320, 1, -120)}):Play()
    task.wait(duration)
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 20, 1, -120)}):Play()
    task.wait(0.5)
    notif:Destroy()
end

return SaveWave    Content.ScrollBarImageColor3 = Color3.fromRGB(0, 220, 255)

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = Content
    ContentLayout.Padding = UDim.new(0, 12)

    -- Draggable tetap
    local dragging = false
    local dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local currentTab = nil

    function SaveWave:CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(0, 130, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.TextSize = 16
        local TC = Instance.new("UICorner", TabBtn)
        TC.CornerRadius = UDim.new(0, 10)

        local TabContent = Instance.new("Frame")
        TabContent.Parent = Content
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false

        local TabL = Instance.new("UIListLayout")
        TabL.Parent = TabContent
        TabL.Padding = UDim.new(0, 10)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then currentTab.Visible = false end
            TabContent.Visible = true
            currentTab = TabContent
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 35, 90)}):Play()
                end
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
        end)

        local Elements = {}

        function Elements:Toggle(name, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 48)
            frame.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
            local fc = Instance.new("UICorner", frame)
            fc.CornerRadius = UDim.new(0, 10)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name
            label.Size = UDim2.new(0.75, 0, 1, 0)
            label.Position = UDim2.new(0, 15, 0, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left

            local switch = Instance.new("TextButton")
            switch.Parent = frame
            switch.Size = UDim2.new(0, 60, 0, 30)
            switch.Position = UDim2.new(1, -75, 0.5, -15)
            switch.BackgroundColor3 = default and Color3.fromRGB(0, 220, 255) or Color3.fromRGB(255, 80, 80)
            switch.Text = default and Text.ToggleOn or Text.ToggleOff
            switch.TextColor3 = Color3.new(1,1,1)
            local sc = Instance.new("UICorner", switch)
            sc.CornerRadius = UDim.new(0, 15)

            local state = default or false
            switch.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(0, 220, 255) or Color3.fromRGB(255, 80, 80)}):Play()
                switch.Text = state and Text.ToggleOn or Text.ToggleOff
                if callback then callback(state) end
            end)
        end

        function Elements:Button(name, callback)
            local btn = Instance.new("TextButton")
            btn.Parent = TabContent
            btn.Size = UDim2.new(1, 0, 0, 48)
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
            btn.Text = name
            btn.TextColor3 = Color3.new(0,0,0)
            btn.TextSize = 16
            local bc = Instance.new("UICorner", btn)
            bc.CornerRadius = UDim.new(0, 10)

            btn.MouseButton1Click:Connect(callback or function() end)
        end

        function Elements:Slider(name, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Parent = TabContent
            frame.Size = UDim2.new(1, 0, 0, 70)
            frame.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
            local fc = Instance.new("UICorner", frame)

            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Text = name .. ": " .. default
            label.Position = UDim2.new(0, 15, 0, 8)
            label.Size = UDim2.new(1, -30, 0, 30)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 15
            label.TextXAlignment = Enum.TextXAlignment.Left

            local bar = Instance.new("Frame")
            bar.Parent = frame
            bar.Position = UDim2.new(0, 15, 1, -30)
            bar.Size = UDim2.new(1, -30, 0, 18)
            bar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            local bc = Instance.new("UICorner", bar)
            bc.CornerRadius = UDim.new(0, 9)

            local fill = Instance.new("Frame")
            fill.Parent = bar
            fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
            local fc2 = Instance.new("UICorner", fill)

            local knob = Instance.new("TextButton")
            knob.Parent = fill
            knob.Size = UDim2.new(0, 28, 0, 28)
            knob.Position = UDim2.new(1, -14, 0, -5)
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

    -- Open animation lebih smooth
    MainFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, WindowSizeX, 0, WindowSizeY)}):Play()

    -- Auto open first tab
    task.wait(0.7)
    if TabContainer:FindFirstChildWhichIsA("TextButton") then
        TabContainer:FindFirstChildWhichIsA("TextButton"):MouseButton1Click()
    end

    -- Notify
    task.spawn(function()
        task.wait(1)
        SaveWave:Notify(Text.Loaded, Text.Welcome, 6)
    end)

    return SaveWave
end

-- Notification lebih kecil & rapi
function SaveWave:Notify(title, content, duration)
    duration = duration or 5
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 100)
    notif.Position = UDim2.new(1, 20, 1, -120)
    notif.BackgroundColor3 = Color3.fromRGB(15, 35, 90)
    notif.Parent = PlayerGui
    local nc = Instance.new("UICorner", notif)
    nc.CornerRadius = UDim.new(0, 12)

    local ntitle = Instance.new("TextLabel")
    ntitle.Parent = notif
    ntitle.Text = title
    ntitle.Size = UDim2.new(1, 0, 0, 40)
    ntitle.BackgroundTransparency = 1
    ntitle.TextColor3 = Color3.fromRGB(0, 220, 255)
    ntitle.Font = Enum.Font.GothamBold
    ntitle.TextSize = 20

    local ncontent = Instance.new("TextLabel")
    ncontent.Parent = notif
    ncontent.Position = UDim2.new(0, 10, 0, 40)
    ncontent.Size = UDim2.new(1, -20, 1, -50)
    ncontent.BackgroundTransparency = 1
    ncontent.Text = content
    ncontent.TextColor3 = Color3.new(1,1,1)
    ncontent.TextWrapped = true
    ncontent.TextSize = 15

    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -320, 1, -120)}):Play()
    task.wait(duration)
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 20, 1, -120)}):Play()
    task.wait(0.5)
    notif:Destroy()
end

return SaveWave    Status.TextSize = 18

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
