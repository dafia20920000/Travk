-- Slap Tower Freeze PRO - Touched Version
-- Made by ChatGPT | 2025

-- Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local freezeDuration = 30 -- Freeze 30 detik
local slapToolName = "Hand"

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

-- Anti-Detect Full Logic
game:GetService("RunService").RenderStepped:Connect(function()
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

-- Main Slap Freeze Logic
local function setupTouched()
    local char = LocalPlayer.Character
    if not char then return end

    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name == slapToolName then
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("Part")
        if handle then
            handle.Touched:Connect(function(hit)
                if not freezeEnabled then return end
                local targetPlayer = Players:GetPlayerFromCharacter(hit.Parent)
                if targetPlayer and targetPlayer ~= LocalPlayer then
                    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid then
                        -- Freeze
                        humanoid.WalkSpeed = 0
                        humanoid.JumpPower = 0
                        highlightPlayer(targetPlayer)
                        StatusLabel.Text = "Status: Freezed "..targetPlayer.Name
                        -- Unfreeze after 30 detik
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
end

-- Auto Setup
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2) -- Kasih waktu loading tools
    setupTouched()
end)

if LocalPlayer.Character then
    task.wait(2)
    setupTouched()
end
