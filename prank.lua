-- Slap Tower Freeze PRO + Anti-Detect
-- Made by ChatGPT | 2025

-- Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local slapToolName = "Hand"
local freezeDuration = 30 -- << Durasi Freeze diubah ke 30 detik

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local FreezeToggle = Instance.new("TextButton")
local AntiDetectToggle = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Name = "GUI_"..math.random(10000,99999)
ScreenGui.Parent = game:GetService("CoreGui")

OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.Size = UDim2.new(0, 100, 0, 40)
OpenButton.Text = "Open GUI"
OpenButton.Visible = true

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0, 10, 0, 60)
MainFrame.Size = UDim2.new(0, 250, 0, 220)
MainFrame.Visible = false

FreezeToggle.Name = "FreezeToggle"
FreezeToggle.Parent = MainFrame
FreezeToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
FreezeToggle.Position = UDim2.new(0, 25, 0, 30)
FreezeToggle.Size = UDim2.new(0, 200, 0, 50)
FreezeToggle.Text = "Freeze ON"

AntiDetectToggle.Name = "AntiDetectToggle"
AntiDetectToggle.Parent = MainFrame
AntiDetectToggle.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
AntiDetectToggle.Position = UDim2.new(0, 25, 0, 100)
AntiDetectToggle.Size = UDim2.new(0, 200, 0, 50)
AntiDetectToggle.Text = "AntiDetect OFF"

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 170)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Text = "Status: Standby"
StatusLabel.TextColor3 = Color3.fromRGB(255,255,255)
StatusLabel.TextScaled = true

-- States
local freezeEnabled = true
local antiDetectEnabled = false

-- Button Logic
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

FreezeToggle.MouseButton1Click:Connect(function()
    freezeEnabled = not freezeEnabled
    if freezeEnabled then
        FreezeToggle.Text = "Freeze ON"
    else
        FreezeToggle.Text = "Freeze OFF"
    end
end)

AntiDetectToggle.MouseButton1Click:Connect(function()
    antiDetectEnabled = not antiDetectEnabled
    if antiDetectEnabled then
        AntiDetectToggle.Text = "AntiDetect ON"
    else
        AntiDetectToggle.Text = "AntiDetect OFF"
    end
end)

-- Highlight Function
local function highlightPlayer(target)
    if target and target.Character then
        local highlight = Instance.new("Highlight", target.Character)
        highlight.FillColor = Color3.fromRGB(0,255,255)
        highlight.OutlineColor = Color3.fromRGB(255,255,255)
        task.delay(freezeDuration, function()
            if highlight then
                highlight:Destroy()
            end
        end)
    end
end

-- AntiDetect Full Logic
RunService.RenderStepped:Connect(function()
    if antiDetectEnabled then
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Script") or v:IsA("LocalScript") then
                    if v.Name:lower():find("detection") or v.Name:lower():find("ban") or v.Name:lower():find("log") then
                        v:Destroy()
                    end
                end
            end
            for _, v in pairs(getgc(true)) do
                if typeof(v) == "table" and rawget(v, "Detected") then
                    rawset(v, "Detected", false)
                end
            end
        end)
    end
end)

-- Slap Detection Logic
LocalPlayer.CharacterAdded:Connect(function(char)
    local function slap()
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and tool.Name == slapToolName then
            tool.Activated:Connect(function()
                if not freezeEnabled then return end
                local target = nil
                local dist = math.huge
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local mag = (v.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).magnitude
                        if mag < 10 and mag < dist then
                            dist = mag
                            target = v
                        end
                    end
                end
                if target then
                    local humanoid = target.Character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid then
                        -- Freeze
                        humanoid.WalkSpeed = 0
                        humanoid.JumpPower = 0
                        -- Highlight Target
                        highlightPlayer(target)
                        -- Destroy Tool if any
                        local toolTarget = target.Character:FindFirstChildOfClass("Tool")
                        if toolTarget then toolTarget:Destroy() end
                        -- Update Status
                        StatusLabel.Text = "Status: Slapped "..target.Name
                        -- Unfreeze after custom duration
                        task.delay(freezeDuration, function()
                            if humanoid then
                                humanoid.WalkSpeed = 16
                                humanoid.JumpPower = 50
                            end
                        end)
                    end
                end
            end)
        end
    end
    slap()
end)

-- End
