local setting = {
    autobuild = false,
    autocollect = false,
    autocollectcrate = false,
    autocollectdollar = false,
    autocollectchest = false
}

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Elemental Powers Tcyoon",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "Moon Hub",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = false
    },
    SideBarWidth = 200,
    -- HideSearchBar = true,
    ScrollBarEnabled = true,
    -- Background = "rbxassetid://13511292247", -- rbxassetid only
})

Window:EditOpenButton({
    Title = "Open UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

MainSection = Window:Section({
    Title = "main",
    Opened = true,
})

Main = MainSection:Tab({ Title = "Main", Icon = "Sword" })

Main:Toggle({
    Title = "Auto Build Tcyoon",
    Image = "bird",
    Value = false,
    Callback = function(state)
        setting.autobuild = state
        task.spawn(function()
            while setting.autobuild and task.wait() do
                for _,v in next,workspace.Tycoons:GetChildren() do
                    if v.Name == game.Players.LocalPlayer.Name then
                        for _,a in next,v.Buttons:GetChildren() do
                            if a.Button.Color == Color3.fromRGB(0,127,0) then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.Button.CFrame
                            end
                        end
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "Auto Collect Money",
    Image = "bird",
    Value = false,
    Callback = function(state)
        setting.autocollect = state
        task.spawn(function()
            while setting.autocollect and task.wait() do
                for _,v in next,workspace.Tycoons:GetChildren() do
                    if v.Name == game.Players.LocalPlayer.Name then
                        for _,a in next,v.Buttons:GetChildren() do
                            if a.Button.Color ~= Color3.fromRGB(0,127,0) then
                                oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Auxiliary.Collector.Collect.CFrame
                                wait(1.5)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                            end
                        end
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "Auto Collect Dollar",
    Image = "bird",
    Value = false,
    Callback = function(state)
        setting.autocollectdollar = state
        task.spawn(function()
            while setting.autocollectdollar and task.wait() do
                for _,v in next,workspace:GetChildren() do
                    if v.Name == "Dollar" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "Auto Collect BalloonCrate",
    Image = "bird",
    Value = false,
    Callback = function(state)
        setting.autocollectcrate = state
        task.spawn(function()
            while setting.autocollectcrate and task.wait() do
                for _,v in next,workspace:GetChildren() do
                    if v.Name == "BalloonCrate" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Crate.CFrame
                        fireproximityprompt(v.Crate.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "Auto Collect Chest",
    Image = "bird",
    Value = false,
    Callback = function(state)
        setting.autocollectchest = state
        task.spawn(function()
            while setting.autocollectchest and task.wait() do
                for _, v in pairs(workspace.Treasure.Chests:GetChildren()) do
                    if v.Name == "Chest" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        fireproximityprompt(v.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

Main:Button({
    Title = "tp center",
    Desc = "emmm",
    Callback = function()
        local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Center.CFrame
        wait(0.3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
    end
})
