-- [[ The King Mod Thailand | TK V20 - FIXED EVERYTHING ]]
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")

-- [[ 1. ระบบแจ้งเตือน (โชว์ก่อนเริ่ม) ]]
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "THE KING MOD V20";
    Text = "แยกฟังก์ชัน ESP และ Hitbox เรียบร้อย!";
    Duration = 5;
})

local SG = Instance.new("ScreenGui", LP.PlayerGui)
SG.Name = "TK_V20"
SG.ResetOnSpawn = false

-- [[ 2. ปุ่มเปิดเมนู TK ]]
local TK_BTN = Instance.new("TextButton", SG)
TK_BTN.Size = UDim2.new(0, 50, 0, 50); TK_BTN.Position = UDim2.new(0, 15, 0.4, 0)
TK_BTN.Text = "TK"; TK_BTN.TextSize = 20; TK_BTN.BackgroundColor3 = Color3.fromRGB(200, 0, 0); TK_BTN.TextColor3 = Color3.fromRGB(255, 255, 255)
TK_BTN.Draggable = true
Instance.new("UICorner", TK_BTN).CornerRadius = UDim.new(1, 0)

-- [[ 3. เมนูหลัก ]]
local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 240, 0, 400); MF.Position = UDim2.new(0.5, -120, 0.5, -200)
MF.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MF.Visible = false
TK_BTN.MouseButton1Click:Connect(function() MF.Visible = not MF.Visible end)

local Title = Instance.new("TextLabel", MF)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "THE KING V20"; Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ฟังก์ชันสร้างปุ่ม (แยกขาดจากกัน)
local function AddToggle(name, pos, key)
    _G[key] = false
    local b = Instance.new("TextButton", MF)
    b.Size = UDim2.new(0.8, 0, 0, 35); b.Position = UDim2.new(0.1, 0, pos, 0)
    b.Text = name .. ": OFF"; b.BackgroundColor3 = Color3.fromRGB(60, 60, 60); b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(function()
        _G[key] = not _G[key]
        b.Text = _G[key] and name .. ": ON" or name .. ": OFF"
        b.BackgroundColor3 = _G[key] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    end)
end

local function AddInput(name, pos, key, def)
    _G[key] = def
    local l = Instance.new("TextLabel", MF)
    l.Size = UDim2.new(0.4, 0, 0, 20); l.Position = UDim2.new(0.1, 0, pos, 0); l.Text = name; l.TextColor3 = Color3.fromRGB(255,255,255); l.BackgroundTransparency = 1
    local i = Instance.new("TextBox", MF)
    i.Size = UDim2.new(0.4, 0, 0, 25); i.Position = UDim2.new(0.5, 0, pos, 0); i.Text = tostring(def); i.BackgroundColor3 = Color3.fromRGB(40,40,40); i.TextColor3 = Color3.fromRGB(0, 255, 0)
    i.FocusLost:Connect(function() _G[key] = tonumber(i.Text) or def end)
end

AddToggle("เปิดกล่องขาว + เส้นชมพู", 0.15, "ESP_ON")
AddToggle("เปิดระบบขยายตัว", 0.35, "HIT_ON")
AddInput("ขนาดขยาย", 0.48, "HIT_VAL", 20)
AddToggle("เปิดจอกว้าง FOV", 0.65, "FOV_ON")
AddInput("ระยะ FOV", 0.78, "FOV_VAL", 100)

-- [[ 4. ระบบทำงาน (แยกฟังก์ชัน 100%) ]]
RS.RenderStepped:Connect(function()
    -- ระบบ FOV
    if _G.FOV_ON then workspace.CurrentCamera.FieldOfView = _G.FOV_VAL end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local n = p.Name .. "_TK20"
            
            -- ฟังก์ชันขยายตัว (แยกต่างหาก)
            if _G.HIT_ON then
                hrp.Size = Vector3.new(_G.HIT_VAL, _G.HIT_VAL, _G.HIT_VAL)
                hrp.Transparency = 0.8; hrp.CanCollide = false
            else
                hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 0
            end

            -- ฟังก์ชันกล่องมองทะลุ (แยกต่างหาก)
            if _G.ESP_ON and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local pos, on = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                if on then
                    local g = SG:FindFirstChild(n) or Instance.new("Frame", SG)
                    if not SG:FindFirstChild(n) then
                        g.Name = n; g.BackgroundTransparency = 1
                        local b = Instance.new("Frame", g); b.Name = "B"; b.Size = UDim2.new(0, 30, 0, 40); b.BackgroundTransparency = 1; b.BorderSizePixel = 1; b.BorderColor3 = Color3.fromRGB(255, 255, 255)
                        local l = Instance.new("Frame", g); l.Name = "L"; l.BorderSizePixel = 0; l.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
                        local t = Instance.new("TextLabel", g); t.Name = "T"; t.BackgroundTransparency = 1; t.TextColor3 = Color3.fromRGB(255, 255, 255); t.TextSize = 10
                    end
                    -- อัปเดตกล่องขาว
                    g.B.Position = UDim2.new(0, pos.X - 15, 0, pos.Y - 20)
                    -- อัปเดตเส้นชมพูติดกับกล่อง
                    local sPos = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y)
                    local ePos = Vector2.new(pos.X, pos.Y)
                    local mag = (ePos - sPos).Magnitude
                    g.L.Size = UDim2.new(0, mag, 0, 1); g.L.Position = UDim2.new(0, (sPos.X + ePos.X)/2 - mag/2, 0, (sPos.Y + ePos.Y)/2)
                    g.L.Rotation = math.deg(math.atan2(ePos.Y - sPos.Y, ePos.X - sPos.X))
                    -- อัปเดตระยะทางใต้กล่อง
                    local dist = math.floor((LP.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    g.T.Position = UDim2.new(0, pos.X - 40, 0, pos.Y + 20); g.T.Text = dist .. " M"
                else if SG:FindFirstChild(n) then SG[n]:Destroy() end end
            else
                if SG:FindFirstChild(n) then SG[n]:Destroy() end
            end
        end
    end
end)
