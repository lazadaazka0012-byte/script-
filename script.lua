-- === Custom Auth GUI ===
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Bersihkan GUI lama kalau ada
if playerGui:FindFirstChild("ScriptHubAuth") then
   playerGui.ScriptHubAuth:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptHubAuth"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- === Main Frame ===
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 320)
Main.Position = UDim2.new(0.5, -240, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

-- === Title Bar ===
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Patch supaya bagian bawah titlebar nggak rounded
local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 8)
TitleFix.Position = UDim2.new(0, 0, 1, -8)
TitleFix.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "bokk Script HUB  "
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local SubTitle = Instance.new("TextLabel")
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 130, 0, 0)
SubTitle.Size = UDim2.new(0, 150, 1, 0)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Premium Build"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.TextSize = 13
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

-- Tombol Minimize, Maximize, Close
local function createTitleButton(icon, xOffset, color)
   local Btn = Instance.new("TextButton")
   Btn.Size = UDim2.new(0, 24, 0, 24)
   Btn.Position = UDim2.new(1, xOffset, 0.5, -12)
   Btn.BackgroundTransparency = 1
   Btn.Font = Enum.Font.GothamBold
   Btn.Text = icon
   Btn.TextColor3 = color
   Btn.TextSize = 16
   Btn.Parent = TitleBar
   return Btn
end

local CloseBtn = createTitleButton("×", -32, Color3.fromRGB(200, 80, 80))
local MaxBtn = createTitleButton("□", -60, Color3.fromRGB(200, 200, 200))
local MinBtn = createTitleButton("—", -88, Color3.fromRGB(200, 200, 200))

CloseBtn.MouseButton1Click:Connect(function()
   ScreenGui:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
   minimized = not minimized
   Main.Visible = not minimized
end)

-- === Sidebar ===
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 4)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = Sidebar

local function createTab(name, icon, order)
   local TabBtn = Instance.new("TextButton")
   TabBtn.Name = name
   TabBtn.Size = UDim2.new(1, -16, 0, 36)
   TabBtn.Position = UDim2.new(0, 8, 0, 0)
   TabBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 220)
   TabBtn.BackgroundTransparency = 1
   TabBtn.Font = Enum.Font.Gotham
   TabBtn.Text = "   " .. icon .. "  " .. name
   TabBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
   TabBtn.TextSize = 13
   TabBtn.TextXAlignment = Enum.TextXAlignment.Left
   TabBtn.LayoutOrder = order
   TabBtn.AutoButtonColor = false
   TabBtn.Parent = Sidebar

   local Corner = Instance.new("UICorner")
   Corner.CornerRadius = UDim.new(0, 6)
   Corner.Parent = TabBtn

   local Indicator = Instance.new("Frame")
   Indicator.Size = UDim2.new(0, 3, 0.6, 0)
   Indicator.Position = UDim2.new(0, 0, 0.2, 0)
   Indicator.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
   Indicator.BorderSizePixel = 0
   Indicator.Visible = false
   Indicator.Parent = TabBtn

   local IndCorner = Instance.new("UICorner")
   IndCorner.CornerRadius = UDim.new(1, 0)
   IndCorner.Parent = Indicator

   return TabBtn, Indicator
end

local AuthTab, AuthIndicator = createTab("Authentication", "🛡", 1)
local InstrTab, InstrIndicator = createTab("Instructions", "ℹ", 2)

-- === Content Area ===
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -140, 1, -36)
Content.Position = UDim2.new(0, 140, 0, 36)
Content.BackgroundTransparency = 1
Content.Parent = Main

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingLeft = UDim.new(0, 20)
ContentPadding.PaddingTop = UDim.new(0, 16)
ContentPadding.PaddingRight = UDim.new(0, 20)
ContentPadding.Parent = Content

local PageTitle = Instance.new("TextLabel")
PageTitle.BackgroundTransparency = 1
PageTitle.Size = UDim2.new(1, 0, 0, 30)
PageTitle.Font = Enum.Font.GothamBold
PageTitle.Text = "Authentication"
PageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PageTitle.TextSize = 22
PageTitle.TextXAlignment = Enum.TextXAlignment.Left
PageTitle.Parent = Content

-- Card: Access Locked
local LockedCard = Instance.new("Frame")
LockedCard.Size = UDim2.new(1, 0, 0, 60)
LockedCard.Position = UDim2.new(0, 0, 0, 44)
LockedCard.BackgroundColor3 = Color3.fromRGB(42, 42, 46)
LockedCard.BorderSizePixel = 0
LockedCard.Parent = Content

local LockedCorner = Instance.new("UICorner")
LockedCorner.CornerRadius = UDim.new(0, 6)
LockedCorner.Parent = LockedCard

local LockedTitle = Instance.new("TextLabel")
LockedTitle.BackgroundTransparency = 1
LockedTitle.Position = UDim2.new(0, 12, 0, 6)
LockedTitle.Size = UDim2.new(1, -24, 0, 18)
LockedTitle.Font = Enum.Font.GothamBold
LockedTitle.Text = "Access Locked"
LockedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LockedTitle.TextSize = 14
LockedTitle.TextXAlignment = Enum.TextXAlignment.Left
LockedTitle.Parent = LockedCard

local LockedDesc = Instance.new("TextLabel")
LockedDesc.BackgroundTransparency = 1
LockedDesc.Position = UDim2.new(0, 12, 0, 24)
LockedDesc.Size = UDim2.new(1, -24, 0, 30)
LockedDesc.Font = Enum.Font.Gotham
LockedDesc.Text = "This Scripthub requires you to join our group to access the rest of the script"
LockedDesc.TextColor3 = Color3.fromRGB(160, 160, 160)
LockedDesc.TextSize = 12
LockedDesc.TextWrapped = true
LockedDesc.TextXAlignment = Enum.TextXAlignment.Left
LockedDesc.Parent = LockedCard

-- Card: Copy Access Link (button)
local CopyCard = Instance.new("TextButton")
CopyCard.Size = UDim2.new(1, 0, 0, 60)
CopyCard.Position = UDim2.new(0, 0, 0, 116)
CopyCard.BackgroundColor3 = Color3.fromRGB(42, 42, 46)
CopyCard.BorderSizePixel = 0
CopyCard.AutoButtonColor = false
CopyCard.Text = ""
CopyCard.Parent = Content

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 6)
CopyCorner.Parent = CopyCard

local CopyTitle = Instance.new("TextLabel")
CopyTitle.BackgroundTransparency = 1
CopyTitle.Position = UDim2.new(0, 12, 0, 6)
CopyTitle.Size = UDim2.new(1, -40, 0, 18)
CopyTitle.Font = Enum.Font.GothamBold
CopyTitle.Text = "Copy Access Link"
CopyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyTitle.TextSize = 14
CopyTitle.TextXAlignment = Enum.TextXAlignment.Left
CopyTitle.Parent = CopyCard

local CopyDesc = Instance.new("TextLabel")
CopyDesc.BackgroundTransparency = 1
CopyDesc.Position = UDim2.new(0, 12, 0, 24)
CopyDesc.Size = UDim2.new(1, -24, 0, 30)
CopyDesc.Font = Enum.Font.Gotham
CopyDesc.Text = "Copies the group URL to your clipboard"
CopyDesc.TextColor3 = Color3.fromRGB(160, 160, 160)
CopyDesc.TextSize = 12
CopyDesc.TextWrapped = true
CopyDesc.TextXAlignment = Enum.TextXAlignment.Left
CopyDesc.Parent = CopyCard

local Arrow = Instance.new("TextLabel")
Arrow.BackgroundTransparency = 1
Arrow.Position = UDim2.new(1, -28, 0, 18)
Arrow.Size = UDim2.new(0, 20, 0, 20)
Arrow.Font = Enum.Font.GothamBold
Arrow.Text = "›"
Arrow.TextColor3 = Color3.fromRGB(160, 160, 160)
Arrow.TextSize = 18
Arrow.Parent = CopyCard

-- === Instructions Page (hidden by default) ===
local InstrPage = Instance.new("Frame")
InstrPage.Size = UDim2.new(1, 0, 1, -30)
InstrPage.Position = UDim2.new(0, 0, 0, 44)
InstrPage.BackgroundTransparency = 1
InstrPage.Visible = false
InstrPage.Parent = Content

local InstrText = Instance.new("TextLabel")
InstrText.BackgroundTransparency = 1
InstrText.Size = UDim2.new(1, 0, 1, 0)
InstrText.Font = Enum.Font.Gotham
InstrText.Text = "1. Join the group\n2. Come back and click Verify\n3. Enjoy the script!"
InstrText.TextColor3 = Color3.fromRGB(200, 200, 200)
InstrText.TextSize = 13
InstrText.TextWrapped = true
InstrText.TextXAlignment = Enum.TextXAlignment.Left
InstrText.TextYAlignment = Enum.TextYAlignment.Top
InstrText.Parent = InstrPage

-- === Tab Switch Logic ===
local function switchTab(tab)
   if tab == "auth" then
      PageTitle.Text = "Authentication"
      LockedCard.Visible = true
      CopyCard.Visible = true
      InstrPage.Visible = false
      AuthIndicator.Visible = true
      InstrIndicator.Visible = false
      AuthTab.BackgroundTransparency = 0.7
      InstrTab.BackgroundTransparency = 1
   else
      PageTitle.Text = "Instructions"
      LockedCard.Visible = false
      CopyCard.Visible = false
      InstrPage.Visible = true
      AuthIndicator.Visible = false
      InstrIndicator.Visible = true
      AuthTab.BackgroundTransparency = 1
      InstrTab.BackgroundTransparency = 0.7
   end
end

AuthTab.MouseButton1Click:Connect(function() switchTab("auth") end)
InstrTab.MouseButton1Click:Connect(function() switchTab("instr") end)
switchTab("auth") -- default page

-- === Copy Access Link Action ===
local GROUP_URL = "https://roblox.com.bz/communities/2895643568/" -- ganti dengan link grup kamu

CopyCard.MouseButton1Click:Connect(function()
   setclipboard(GROUP_URL)
   game.StarterGui:SetCore("SendNotification", {
      Title = "bok Script HUB",
      Text = "Access link copied to clipboard!",
      Duration = 4,
   })
end)

-- === Drag Functionality ===
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 then
      dragging = true
      dragStart = input.Position
      startPos = Main.Position
      input.Changed:Connect(function()
         if input.UserInputState == Enum.UserInputState.End then
            dragging = false
         end
      end)
   end
end)

TitleBar.InputChanged:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseMovement then
      dragInput = input
   end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
   if input == dragInput and dragging then
      local delta = input.Position - dragStart
      Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
   end
end)