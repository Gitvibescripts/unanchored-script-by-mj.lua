local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.BackgroundTransparency = 0.2
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0.1, 0)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Text = "by king_baconROYALTY"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

local InfoText = Instance.new("TextLabel", MainFrame)
InfoText.Size = UDim2.new(1, 0, 0.2, 0)
InfoText.Position = UDim2.new(0, 0, 0.8, 0)
InfoText.Text = "This script was created by a user with the username 'king_baconROYALTY', and it does not possess any copyright."
InfoText.TextScaled = true
InfoText.BackgroundTransparency = 1
InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)

local UsernameBar = Instance.new("TextBox", MainFrame)
UsernameBar.Size = UDim2.new(0.7, 0, 0.1, 0)
UsernameBar.Position = UDim2.new(0.05, 0, 0.15, 0)
UsernameBar.PlaceholderText = "Username"
UsernameBar.Text = ""
UsernameBar.TextScaled = true
UsernameBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
UsernameBar.TextColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", UsernameBar).CornerRadius = UDim.new(0.1, 0)

local BringButton = Instance.new("TextButton", MainFrame)
BringButton.Size = UDim2.new(0.3, 0, 0.1, 0)
BringButton.Position = UDim2.new(0.75, 0, 0.15, 0)
BringButton.Text = "Bring"
BringButton.TextScaled = true
BringButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
BringButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", BringButton).CornerRadius = UDim.new(0.1, 0)

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 150, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.Text = "Toggle Menu"
ToggleButton.TextScaled = true
ToggleButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0.1, 0)
ToggleButton.BackgroundTransparency = 0.5

local function autoComplete(input)
    for _, player in pairs(Players:GetPlayers()) do
        local nameMatch = string.lower(player.Name):sub(1, #input) == string.lower(input)
        if nameMatch then
            return player.Name
        end
    end
    return input
end

UsernameBar:GetPropertyChangedSignal("Text"):Connect(function()
    UsernameBar.Text = autoComplete(UsernameBar.Text)
end)

local function bringUnanchoredToPlayer(targetPlayer)
    local targetChar = targetPlayer.Character
    if not targetChar then return end
    local targetPosition = targetChar.HumanoidRootPart.Position
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Anchored then
            part.Position = targetPosition
        end
    end
end

BringButton.MouseButton1Click:Connect(function()
    local targetName = UsernameBar.Text
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name == targetName then
            bringUnanchoredToPlayer(player)
            break
        end
    end
end)

local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputState == Enum.UserInputState.End then dragging = false end
end)

local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

local draggingToggle, dragStartToggle, startPosToggle
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingToggle, dragStartToggle, startPosToggle = true, input.Position, ToggleButton.Position
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if draggingToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartToggle
        ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputState == Enum.UserInputState.End then draggingToggle = false end
end)
