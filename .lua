local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()

local Window = ArrayField:CreateWindow({
    Name = "ADMINUS | Emergency Hamburg",
    LoadingTitle = "Adminus Interface Suite",
    LoadingSubtitle = "by adminus",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Adminus"
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using ArrayField may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
       Actions = {
             [1] = {
                 Text = 'Click here to copy the key link <--',
                 OnPress = function()
                     print('Pressed')
                 end,
                 }
             },
       Key = {"Hello"}--  List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

--// Random Stuff
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/flerci42/ESP/main/.lua'))()
local player = game.Players.LocalPlayer
local minHealth
local choosenWeapon

local JewelryPart = Instance.new("Part")
JewelryPart.Parent = game:GetService("Workspace").Buildings.Jeweler
JewelryPart.Name = "JewelryLocator"
JewelryPart.Anchored = true
JewelryPart.CanCollide = false
JewelryPart.Transparency = 1
JewelryPart.CFrame = CFrame.new(-394.5513, 5.52547216, 3568.09302)

local bankPart = Instance.new("Part")
bankPart.Parent = game:GetService("Workspace").Buildings.Bank
bankPart.Name = "BankLocator"
bankPart.Anchored = true
bankPart.CanCollide = false
bankPart.Transparency = 1
bankPart.CFrame = CFrame.new(-1167.87585, 7.87799263, 3161.57544)

local gasStation1Part = Instance.new("Part")
gasStation1Part.Parent = game:GetService("Workspace").Buildings["GasStation-GasNGo"]
gasStation1Part.Name = "gasStationLocator"
gasStation1Part.Anchored = true
gasStation1Part.CanCollide = false
gasStation1Part.Transparency = 1
gasStation1Part.CFrame = CFrame.new(-1531.9585, 5.74999857, 3769.5564)

local gasStation2Part = Instance.new("Part")
gasStation2Part.Parent = game:GetService("Workspace").Buildings["GasStation-Ares"]
gasStation2Part.Name = "gasStationLocator"
gasStation2Part.Anchored = true
gasStation2Part.CanCollide = false
gasStation2Part.Transparency = 1
gasStation2Part.CFrame = CFrame.new(-867.554138, 5.04301023, 1543.24878)

local toolShopPart = Instance.new("Part")
toolShopPart.Parent = game:GetService("Workspace").Buildings.ToolShop
toolShopPart.Name = "toolShopLocator"
toolShopPart.Anchored = true
toolShopPart.CanCollide = false
toolShopPart.Transparency = 1
toolShopPart.CFrame = CFrame.new(-746.765015, 5.51895142, 636.716064)

--// Tabs
local MainTab = Window:CreateTab("Main", 7510996733)
local PlayerTab = Window:CreateTab("Player", 7549504320)
local VehicleTab = Window:CreateTab("Vehicle", 7511000774)
local WeaponTab = Window:CreateTab("Weapons", 7536784790)
local VisualsTab = Window:CreateTab("Visuals", 7514709535)
local SettingsTab = Window:CreateTab("Settings", 7541906831)

Window:Prompt({
    Title = 'Important Notification',
    SubTitle = 'ADMINUS',
    Content = 'This script is new and it may contain bugs, if you find any please report them at our Discord server.',
    Actions = {
        Accept = {
            Name = 'Accept',
            Callback = function()
                print('Agreed.')
            end,
        }
    }
})

--// Main Tab

local PlayerSection = MainTab:CreateSection("Player Information",false)

local GameSection = MainTab:CreateSection("Game Information",false)

MainTab:CreateParagraph({Title = "Player Information", 
Content = "Username: "..player.Name.. 
"\nDisplay Name: "..player.DisplayName..
"\nPlayer Id: "..player.UserId}, PlayerSection)

MainTab:CreateParagraph({Title = "Game Information", 
Content = "Game Name: Emergency Hamburg"..
"\nGame Id: "..game.GameId}, GameSection)

--// Player Tab

local GameSection = PlayerTab:CreateSection("Player Tab",true)

local EscapeSection = PlayerTab:CreateSection("Escape Jail",false)

local Label = PlayerTab:CreateLabel("By clicking the button your character will reset, meaning you will lose your items.", EscapeSection)

local Label = PlayerTab:CreateLabel("Make sure to click this when you are in jail!", EscapeSection)

local Button = PlayerTab:CreateButton({
    Name = "Escape",
    Interact = 'Click',
    SectionParent = EscapeSection,
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.Head:Destroy()
    end,
})

local AutoEatSection = PlayerTab:CreateSection("Auto Eat",false)

local Label = PlayerTab:CreateLabel("By enabling this toggle, you will automatically eat a cookie when low on health.", AutoEatSection)

local Slider = PlayerTab:CreateSlider({
    Name = "Minimum Health",
    Range = {1, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    SectionParent = AutoEatSection,
    Flag = "Slider1", 
    Callback = function(Value)
        minHealth = Value
    end,
})

local Toggle = PlayerTab:CreateToggle({
    Name = "Auto Eat",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = AutoEatSection,
    Callback = function(Value)
        getgenv().autoEat = Value
        while true do
            if not getgenv().autoEat then return end
            local LPH = game:GetService("Players").LocalPlayer.Character.Humanoid.Health

            if LPH < minHealth then
                print("Health is under "..minHealth)
                local args = {
                    [1] = "Cookie"
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("events-vqp"):WaitForChild("4faf9ae9-9bd7-476f-8c36-9a3965c2f9dc"):FireServer(unpack(args))
                wait(0.8)
                local args = {
                    [1] = game:GetService("Players").LocalPlayer.Character.Cookie
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("events-vqp"):WaitForChild("c8bc12bd-7a75-40f8-8b12-988efcb4b124"):FireServer(unpack(args))
                wait(3)
            else
                print("Health is safe.")
            end
            task.wait()
        end
    end,
})

local OtherSection = PlayerTab:CreateSection("Other",false)

local Toggle = PlayerTab:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = OtherSection,
    Callback = function(Value)
        getgenv().godMode = Value
        while true do
            if not getgenv().godMode then return end

            game.Players.LocalPlayer.Character.Humanoid.Health = 100
            task.wait()
        end
    end,
})

-- // Vehicle Tab

local Section = VehicleTab:CreateSection("Vehicle Tab",true)

local ModificationSection = VehicleTab:CreateSection("Vehicle Modifications",false)

local Toggle = VehicleTab:CreateToggle({
    Name = "Car God Mode / Inf Fuel",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = ModificationSection,
    Callback = function(Value)
        getgenv().carGodMode = Value
        if getgenv().carGodMode == true then
            workspace.Vehicles[player.Name]:SetAttribute("IsOn", Value)
        else
            workspace.Vehicles[player.Name]:SetAttribute("IsOn", Value)
        end
    end,
})

local Toggle = VehicleTab:CreateToggle({
    Name = "Towable",
    CurrentValue = true,
    Flag = "Toggle1",
    SectionParent = ModificationSection,
    Callback = function(Value)
        workspace.Vehicles[player.Name]:SetAttribute("Towable", Value)
    end,
})

local Slider = VehicleTab:CreateSlider({
    Name = "Max Speed",
    Range = {1, 400},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    SectionParent = ModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        workspace.Vehicles[player.Name]:SetAttribute("MaxSpeed", Value)
    end,
})

local Slider = VehicleTab:CreateSlider({
    Name = "Reverse Max Speed",
    Range = {1, 400},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    SectionParent = ModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        workspace.Vehicles[player.Name]:SetAttribute("ReverseMaxSpeed", Value)
    end,
})

local Slider = VehicleTab:CreateSlider({
    Name = "Accelerate Force",
    Range = {1, 1000},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    SectionParent = ModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        workspace.Vehicles[player.Name]:SetAttribute("MaxAccelerateForce", Value)
        workspace.Vehicles[player.Name]:SetAttribute("MinAccelerateForce", Value)
    end,
})

local Slider = VehicleTab:CreateSlider({
    Name = "Brake Force",
    Range = {1, 1000},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    SectionParent = ModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        workspace.Vehicles[player.Name]:SetAttribute("MaxBrakeForce", Value)
        workspace.Vehicles[player.Name]:SetAttribute("MinBrakeForce", Value)
    end,
})

local ColorPicker = VehicleTab:CreateColorPicker({
    Name = "Car Color",
    Color = Color3.fromRGB(255,255,255),
    SectionParent = ModificationSection,
    Flag = "ColorPicker1",
    Callback = function(Value)
        game:GetService("Workspace").Vehicles[""..player.Name].Body.Body.Color = Value
    end
})

local Section = WeaponTab:CreateSection("Weapons Tab",true)

local WeaponModificationSection = WeaponTab:CreateSection("Weapon Modification",false)

local Label = WeaponTab:CreateLabel("Make sure you are holding the gun you want to modify!", WeaponModificationSection)

local Slider = WeaponTab:CreateSlider({
    Name = "Aim Delay",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.5,
    SectionParent = WeaponModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        for i,v in next, game.Workspace[player.Name]:GetChildren() do
            if v:IsA("Tool") then
                v:SetAttribute("AimDelay", Value)
            else
                print("ADMINUS - You aren't holding a weapon!")
            end
        end
    end,
})

local Slider = WeaponTab:CreateSlider({
    Name = "Aim FOV",
    Range = {50, 120},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    SectionParent = WeaponModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        for i,v in next, game.Workspace[player.Name]:GetChildren() do
            if v:IsA("Tool") then
                v:SetAttribute("AimFieldOfView", Value)
            else
                print("ADMINUS - You aren't holding a weapon!")
            end
        end
    end,
})

local Slider = WeaponTab:CreateSlider({
    Name = "Mag Size",
    Range = {17, 999},
    Increment = 1,
    Suffix = "",
    CurrentValue = 17,
    SectionParent = WeaponModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        for i,v in next, game.Workspace[player.Name]:GetChildren() do
            if v:IsA("Tool") then
                v:SetAttribute("MagMaxSize", Value)
                v:SetAttribute("MagCurrentSize", Value)
            else
                print("ADMINUS - You aren't holding a weapon!")
            end
        end
    end,
})

local Slider = WeaponTab:CreateSlider({
    Name = "Reload Time",
    Range = {0, 3},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 2.3,
    SectionParent = WeaponModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        for i,v in next, game.Workspace[player.Name]:GetChildren() do
            if v:IsA("Tool") then
                v:SetAttribute("ReloadTime", Value)
            else
                print("ADMINUS - You aren't holding a weapon!")
            end
        end
    end,
})

local Slider = WeaponTab:CreateSlider({
    Name = "Shoot Delay",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.5,
    SectionParent = WeaponModificationSection,
    Flag = "Slider1", 
    Callback = function(Value)
        for i,v in next, game.Workspace[player.Name]:GetChildren() do
            if v:IsA("Tool") then
                v:SetAttribute("ShootDelay", Value)
            else
                print("ADMINUS - You aren't holding a weapon!")
            end
        end
    end,
})

local Section = VisualsTab:CreateSection("Visuals Tab",true)

local PlayerVisualsSection = VisualsTab:CreateSection("Player Visuals",false)

local Toggle = VisualsTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.enabled = Value
        Sense.teamSettings.friendly.enabled = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Box",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.box = Value
        Sense.teamSettings.friendly.box = Value
        Sense.teamSettings.enemy.boxColor = { "Team Color", 1 }
        Sense.teamSettings.friendly.boxColor = { "Team Color", 1 }
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Box 3D",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.box3d = Value
        Sense.teamSettings.friendly.box3d = Value
        Sense.teamSettings.enemy.box3dColor = { "Team Color", 1 }
        Sense.teamSettings.friendly.box3dColor = { "Team Color", 1 }
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Health Bar",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.healthBar = Value
        Sense.teamSettings.friendly.healthBar = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Health Text",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.healthText = Value
        Sense.teamSettings.friendly.healthText = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Name Text",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.name = Value
        Sense.teamSettings.friendly.name = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Weapon Text",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.weapon = Value
        Sense.teamSettings.friendly.weapon = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Distance Text",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.distance = Value
        Sense.teamSettings.friendly.distance = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Tracer",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.tracer = Value
        Sense.teamSettings.friendly.tracer = Value
        Sense.teamSettings.enemy.tracerColor = { "Team Color", 1 }
        Sense.teamSettings.friendly.tracerColor = { "Team Color", 1 }
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Chams",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = PlayerVisualsSection,
    Callback = function(Value)
        Sense.teamSettings.enemy.chams = Value
        Sense.teamSettings.friendly.chams = Value
        Sense.teamSettings.enemy.chamsFillColor  = { "Team Color", 0.5 }
        Sense.teamSettings.friendly.chamsFillColor = { "Team Color", 0.5 }
        Sense.teamSettings.enemy.chamsOutlineColor = { "Team Color", 0 }
        Sense.teamSettings.friendly.chamsOutlineColor = { "Team Color", 0 }
    end,
})

local BuildingVisualsSection = VisualsTab:CreateSection("Building Visuals",false)

local Toggle = VisualsTab:CreateToggle({
    Name = "Bank",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = BuildingVisualsSection,
    Callback = function(Value)
        local object = Sense.AddInstance(game:GetService("Workspace").Buildings.Bank.BankLocator, {
            text = "Bank",
            textColor = { Color3.new(1,1,1), 1 },
            textOutline = true,
            textOutlineColor = Color3.new(),
            textSize = 20,
            textFont = 2,
            limitDistance = false,
            maxDistance = 150
        })
        object.options.enabled = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Jewelry",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = BuildingVisualsSection,
    Callback = function(Value)
        local object = Sense.AddInstance(game:GetService("Workspace").Buildings.Jeweler.JewelryLocator, {
            text = "Jewelry",
            textColor = { Color3.new(1,1,1), 1 },
            textOutline = true,
            textOutlineColor = Color3.new(),
            textSize = 20,
            textFont = 2,
            limitDistance = false,
            maxDistance = 150
        })
        object.options.enabled = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Gas Station",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = BuildingVisualsSection,
    Callback = function(Value)
        local object = Sense.AddInstance(game:GetService("Workspace").Buildings["GasStation-Ares"].gasStationLocator, {
            text = "Gas Station",
            textColor = { Color3.new(1,1,1), 1 },
            textOutline = true,
            textOutlineColor = Color3.new(),
            textSize = 20,
            textFont = 2,
            limitDistance = false,
            maxDistance = 150
        })
        local object2 = Sense.AddInstance(game:GetService("Workspace").Buildings["GasStation-GasNGo"].gasStationLocator, {
            text = "Gas Station",
            textColor = { Color3.new(1,1,1), 1 },
            textOutline = true,
            textOutlineColor = Color3.new(),
            textSize = 20,
            textFont = 2,
            limitDistance = false,
            maxDistance = 150
        })
        object.options.enabled = Value
        object2.options.enabled = Value
    end,
})

local Toggle = VisualsTab:CreateToggle({
    Name = "Tool Shop",
    CurrentValue = false,
    Flag = "Toggle1",
    SectionParent = BuildingVisualsSection,
    Callback = function(Value)
        local object = Sense.AddInstance(game:GetService("Workspace").Buildings.ToolShop.toolShopLocator, {
            text = "Tool Shop",
            textColor = { Color3.new(1,1,1), 1 },
            textOutline = true,
            textOutlineColor = Color3.new(),
            textSize = 20,
            textFont = 2,
            limitDistance = false,
            maxDistance = 150
        })
        object.options.enabled = Value
    end,
})

Sense.Load()

-- // Settings Tab

local Section = SettingsTab:CreateSection("Settings Tab",true)

local Button = SettingsTab:CreateButton({
    Name = "Close Adminus",
    Interact = 'Click',
    Callback = function()
        ArrayField:Destroy()
    end,
})
