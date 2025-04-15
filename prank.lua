-- Anti Kick (Otomatis aktif)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(method):lower() == "kick" then
        warn("Anti-Kick Activated: Kick attempt blocked.")
        return wait(9e9)
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- GUI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "PrankHub"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.5, -150, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "Rusuh Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
title.TextScaled = true

-- Tombol Freeze All
local freezeButton = Instance.new("TextButton", frame)
freezeButton.Size = UDim2.new(1, 0, 0, 40)
freezeButton.Position = UDim2.new(0, 0, 0.2, 0)
freezeButton.Text = "Freeze All"
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
freezeButton.MouseButton1Click:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            player.Character.HumanoidRootPart.Anchored = true
        end
    end
end)

-- Tombol Spam Sound
local soundButton = Instance.new("TextButton", frame)
soundButton.Size = UDim2.new(1, 0, 0, 40)
soundButton.Position = UDim2.new(0, 0, 0.4, 0)
soundButton.Text = "Spam Sound"
soundButton.TextColor3 = Color3.fromRGB(255, 255, 255)
soundButton.BackgroundColor3 = Color3.fromRGB(0, 0, 200)
soundButton.MouseButton1Click:Connect(function()
    for i = 1, 10 do
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://9118829864"
        sound.Volume = 10
        sound:Play()
    end
end)

-- Tombol Lag Maker
local lagButton = Instance.new("TextButton", frame)
lagButton.Size = UDim2.new(1, 0, 0, 40)
lagButton.Position = UDim2.new(0, 0, 0.6, 0)
lagButton.Text = "Lag Maker"
lagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
lagButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
lagButton.MouseButton1Click:Connect(function()
    for i = 1, 500 do
        local part = Instance.new("Part", workspace)
        part.Size = Vector3.new(999,999,999)
        part.Anchored = true
        part.Position = Vector3.new(math.random(1,100), 100, math.random(1,100))
    end
end)

-- Tombol Chat Spam
local chatButton = Instance.new("TextButton", frame)
chatButton.Size = UDim2.new(1, 0, 0, 40)
chatButton.Position = UDim2.new(0, 0, 0.8, 0)
chatButton.Text = "Chat Spam"
chatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
chatButton.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
chatButton.MouseButton1Click:Connect(function()
    while true do
        wait(0.2)
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("HAHAHA FREEZE SEMUA!", "All")
    end
end)

-- Tombol BSOD
local bsodButton = Instance.new("TextButton", frame)
bsodButton.Size = UDim2.new(1, 0, 0, 40)
bsodButton.Position = UDim2.new(0, 0, 1, 0)
bsodButton.Text = "BSOD Screen"
bsodButton.TextColor3 = Color3.fromRGB(255, 255, 255)
bsodButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
bsodButton.MouseButton1Click:Connect(function()
    local bsod = Instance.new("ScreenGui", game.CoreGui)
    local label = Instance.new("TextLabel", bsod)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = ":(  Your Roblox has encountered an error and needs to close.\nPlease wait..."
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    label.TextScaled = true
end)

-- Tombol Kill Without Touch
local killButton = Instance.new("TextButton", frame)
killButton.Size = UDim2.new(1, 0, 0, 40)
killButton.Position = UDim2.new(0, 0, 1.2, 0)
killButton.Text = "Kill Without Touch"
killButton.TextColor3 = Color3.fromRGB(255, 255, 255)
killButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
killButton.MouseButton1Click:Connect(function()
    local swordRange = 100
    local function killNearbyPlayers()
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local character = player.Character
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                    if distance <= swordRange then
                        humanoid.Health = 0
                    end
                end
            end
        end
    end
    while true do
        killNearbyPlayers()
        wait(1)
    end
end)

-- Tombol Fly
local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, 0, 0, 40)
flyButton.Position = UDim2.new(0, 0, 1.4, 0)
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
flyButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.new(0, 50, 0)
    bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")

    local flying = true
    flyButton.Text = "Stop Fly"
    flyButton.MouseButton1Click:Connect(function()
        if flying then
            bodyVelocity:Destroy()
            flyButton.Text = "Fly"
        else
            bodyVelocity.Parent = character.HumanoidRootPart
            flyButton.Text = "Stop Fly"
        end
        flying = not flying
    end)
end)
