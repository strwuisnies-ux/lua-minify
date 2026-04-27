-- [[ KING MOD - UNIVERSAL AIMBOT ]] --

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

-- [[ KING MOD SETTINGS ]] --
_G.KingModEnabled = true
_G.TeamCheck = false 
_G.AimPart = "Head" 
_G.Sensitivity = 0 -- ความเร็วในการล็อค (0 คือทันที)

-- [[ FOV SETTINGS ]] --
_G.CircleSides = 64 
_G.CircleColor = Color3.fromRGB(255, 255, 255) 
_G.CircleTransparency = 0.7 
_G.CircleRadius = 80 
_G.CircleFilled = false 
_G.CircleVisible = true 
_G.CircleThickness = 1

local KingModCircle = Drawing.new("Circle")
KingModCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
KingModCircle.Radius = _G.CircleRadius
KingModCircle.Filled = _G.CircleFilled
KingModCircle.Color = _G.CircleColor
KingModCircle.Visible = _G.CircleVisible
KingModCircle.Transparency = _G.CircleTransparency
KingModCircle.NumSides = _G.CircleSides
KingModCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if _G.TeamCheck == true then
				if v.Team ~= LocalPlayer.Team then
					if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
							
							if VectorDistance < MaximumDistance then
								Target = v
								MaximumDistance = VectorDistance
							end
						end
					end
				end
			else
				if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
					if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 then
						local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
						local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
						
						if VectorDistance < MaximumDistance then
							Target = v
							MaximumDistance = VectorDistance
						end
					end
				end
			end
		end
	end
	return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    -- Update Circle
    KingModCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    KingModCircle.Radius = _G.CircleRadius
    KingModCircle.Filled = _G.CircleFilled
    KingModCircle.Color = _G.CircleColor
    KingModCircle.Visible = _G.CircleVisible
    KingModCircle.Transparency = _G.CircleTransparency
    KingModCircle.NumSides = _G.CircleSides
    KingModCircle.Thickness = _G.CircleThickness

    -- King Mod Aimbot Logic
    if Holding == true and _G.KingModEnabled == true then
        local Target = GetClosestPlayer()
        if Target and Target.Character and Target.Character:FindFirstChild(_G.AimPart) then
            TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Target.Character[_G.AimPart].Position)}):Play()
        end
    end
end)
