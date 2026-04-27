-- [[ Kmart king mod Thailand | TK V21 - PROFESSIONAL EDITION ]]
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")

-- [[ 1. ระบบแจ้งเตือนเครดิตร้านและคำเตือน ]]
local function ShowCredit()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kmart king mod Thailand";
        Text = "คำเตือน: เล่นอย่างเหมาะสม อย่าประมาท อาจโดนเตะ/แบน (ไม่รับประกัน 100%)";
        Duration = 10;
    })
end
ShowCredit()

local SG = Instance.new("ScreenGui", LP.PlayerGui)
SG.Name = "TK_V21_PRO"
SG.ResetOnSpawn = false

-- [[ 2. ปุ่มเปิดเมนู TK (ดีไซน์ดุดัน) ]]
local TK_BTN = Instance.new("TextButton", SG)
TK_BTN.Size = UDim2.new(0, 55, 0, 55); TK_BTN.Position = UDim2.new(0, 15, 0.4, 0)
TK_BTN.Text = "TK"; TK_BTN.TextSize = 22; TK_BTN.Font = Enum.Font.GothamBold
TK_BTN.BackgroundColor3 = Color3.fromRGB(180, 0, 0); TK_BTN.TextColor3 = Color3.fromRGB(255, 255, 255)
TK_BTN.Draggable = true
Instance.new("UICorner", TK_BTN).CornerRadius = UDim.new(1, 0)

-- [[ 3. เมนูหลัก ]]
local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 250, 0, 420); MF.Position = UDim2.new(0.5, -125, 0.5, -210)
MF.BackgroundColor3 = Color3.fromRGB(10, 10, 10); MF.Visible = false
TK_BTN.MouseButton1Click:Connect(function() MF.Visible = not MF.Visible end)

local Title = Instance.new("TextLabel", MF)
Title.Size = UDim2.new(1, 0, 0, 45); Title.Text = "Kmart king VIP V21"; Title.BackgroundColor3 = Color3.fromRGB(120, 0, 0); Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- วงกลม FOV/Spin (โชว์เมื่อเปิด)
local Circle = Instance.new("Frame", SG)
Circle.Name = "FOV_Circle"
Circle.Size = UDim2.new(0, 200, 0, 200)
Circle.Position = UDim2.new(0.5, -100, 0.5, -100)
Circle.BackgroundTransparency = 1; Circle.Visible = false
local UICornerCircle = Instance.new("UICorner", Circle); UICornerCircle.CornerRadius = UDim.new(1, 0)
local UIO_Circle = Instance.new("UIStroke", Circle); UIO_Circle.Thickness = 1; UIO_Circle.Color = Color3.fromRGB(255, 255, 255)

-- ฟังก์ชันสร้างปุ่ม
local function AddToggle(name, pos, key)
    _G[key] = false
    local b = Instance.new("TextButton", MF)
    b.Size = UDim2.new(0.85, 0, 0, 35); b.Position = UDim2.new(0.075, 0, pos, 0)
    b.Text = name .. ": OFF"; b.BackgroundColor3 = Color3.fromRGB(45, 45, 45); b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(function()
        _G[key] = not _G[key]
        b.Text = _G[key] and name .. ": ON" or name .. ": OFF"
        b.BackgroundColor3 = _G[key] and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45)
        if key == "SPIN_ON" then Circle.Visible = _G[key] end
    end)
end

local function AddInput(name, pos, key, def)
    _G[key] = def
    local l = Instance.new("TextLabel", MF)
    l.Size = UDim2.new(0.4, 0, 0, 20); l.Position = UDim2.new(0.075, 0, pos, 0); l.Text = name; l.TextColor3 = Color3.fromRGB(255,255,255); l.BackgroundTransparency = 1; l.TextXAlignment = "Left"
    local i = Instance.new("TextBox", MF)
    i.Size = UDim2.new(0.4, 0, 0, 25); i.Position = UDim2.new(0.525, 0, pos, 0); i.Text = tostring(def); i.BackgroundColor3 = Color3.fromRGB(30,30,30); i.TextColor3 = Color3.fromRGB(0, 255, 0)
    i.FocusLost:Connect(function() _G[key] = tonumber(i.Text) or def end)
end

AddToggle("มองทะลุ (กล่องขาว+เส้น)", 0.12, "ESP_ON")
AddToggle("ขยายตัว (Hitbox)", 0.28, "HIT_ON")
AddInput("ขนาด Hitbox", 0.38, "HIT_VAL", 20)
AddToggle("ระบบหมุน (Spin Bot)", 0.52, "SPIN_ON")
AddInput("ความเร็วหมุน", 0.62, "SPIN_VAL", 50)
AddToggle("จอกว้าง FOV", 0.75, "FOV_ON")
AddInput("ระยะ FOV", 0.85, "FOV_VAL", 100)

-- ปุ่มเปลี่ยนสี
_G.ESP_Color = Color3.fromRGB(255, 255, 255)
local ColorBtn = Instance.new("TextButton", MF)
ColorBtn.Size = UDim2.new(0.85, 0, 0, 30); ColorBtn.Position = UDim2.new(0.075, 0, 0.93, 0); ColorBtn.Text = "เปลี่ยนสี ESP"; ColorBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); ColorBtn.TextColor3 = Color3.fromRGB(255,255,255)
ColorBtn.MouseButton1Click:Connect(function()
    if _G.ESP_Color == Color3.fromRGB(255,255,255) then _G.ESP_Color = Color3.fromRGB(255,0,0) elseif _G.ESP_Color == Color3.fromRGB(255,0,0) then _G.ESP_Color = Color3.fromRGB(0,255,0) else _G.ESP_Color = Color3.fromRGB(255,255,255) end
end)

-- [[ 4. ระบบทำงาน ]]
RS.RenderStepped:Connect(function()
    if _G.FOV_ON then workspace.CurrentCamera.FieldOfView = _G.FOV_VAL end
    if _G.SPIN_ON and LP.Character then
        LP.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(_G.SPIN_VAL), 0)
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local n = p.Name .. "_TK21"
            
            -- ขยายตัว
            if _G.HIT_ON then hrp.Size = Vector3.new(_G.HIT_VAL, _G.HIT_VAL, _G.HIT_VAL); hrp.Transparency = 0.8; hrp.CanCollide = false
            else hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 0 end

            -- มองทะลุ (กล่องสี่เหลี่ยมตรงตัว + เส้นลากเข้าหา)
            if _G.ESP_ON and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local pos, on = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                if on then
                    local g = SG:FindFirstChild(n) or Instance.new("Frame", SG)
                    if not SG:FindFirstChild(n) then
                        g.Name = n; g.BackgroundTransparency = 1
                        local b = Instance.new("Frame", g); b.Name = "B"; b.Size = UDim2.new(0, 35, 0, 45); b.BackgroundTransparency = 1; b.BorderSizePixel = 1
                        local l = Instance.new("Frame", g); l.Name = "L"; l.BorderSizePixel = 0
                        local t = Instance.new("TextLabel", g); t.Name = "T"; t.BackgroundTransparency = 1; t.TextColor3 = Color3.fromRGB(255, 255, 255); t.TextSize = 10
                    end
                    -- กล่องสี่เหลี่ยมล้อมศัตรู
                    g.B.Position = UDim2.new(0, pos.X - 17, 0, pos.Y - 22); g.B.BorderColor3 = _G.ESP_Color
                    -- เส้น Tracer ชี้ตรงเข้าหากล่อง
                    local sPos = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y)
                    local ePos = Vector2.new(pos.X, pos.Y)
                    local mag = (ePos - sPos).Magnitude
                    g.L.Size = UDim2.new(0, mag, 0, 1); g.L.Position = UDim2.new(0, (sPos.X + ePos.X)/2 - mag/2, 0, (sPos.Y + ePos.Y)/2)
                    g.L.Rotation = math.deg(math.atan2(ePos.Y - sPos.Y, ePos.X - sPos.X)); g.L.BackgroundColor3 = _G.ESP_Color
                    -- ระยะทางใต้กล่อง
                    local dist = math.floor((LP.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    g.T.Position = UDim2.new(0, pos.X - 40, 0, pos.Y + 23); g.T.Text = dist .. " M"
                else if SG:FindFirstChild(n) then SG[n]:Destroy() end end
            else if SG:FindFirstChild(n) then SG[n]:Destroy() end end
        end
    end
end)
