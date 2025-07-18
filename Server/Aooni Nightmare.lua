local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/ESP.lua"))()
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Toggle = {
    AooniESPTog = false,
    ItemESPTog = false,
    CoinESPTog = false,
    PlayerESPTog = false
}

ESP.AddFolder("AooniESPFolder")
ESP.AddFolder("ItemESPFolder")
ESP.AddFolder("CoinESPFolder")
ESP.AddFolder("PlayerESPFolder")

local Window = WindUI:CreateWindow({
    Title = "Aooni Nightmare",
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
    Title = "Aooni ESP",
    Image = "bird",
    Value = false,
    Callback = function(state)
        Toggle.AooniESPTog = state
        if Toggle.AooniESPTog then
            for _,v in next,workspace.Aooni:GetChildren() do
                if v.Name == "Aooni" then
                    ESP.AddESP("AooniESPFolder", v.Name, v, Color3.new(0,0,1))
                end
            end
            workspace.Aooni.ChildAdded:Connect(function(v)
                if Toggle.AooniESPTog then
                    if v.Name == "Aooni" then
                        ESP.AddESP("AooniESPFolder", v.Name, v, Color3.new(0,0,1))
                    end
                end
            end)
        else
            ESP.Clear("AooniESPFolder")
        end
    end
})

Main:Toggle({
    Title = "Item ESP",
    Image = "bird",
    Value = false,
    Callback = function(state)
        Toggle.ItemESPTog = state
        if Toggle.ItemESPTog then
            for _,v in next,workspace.School.Item:GetChildren() do
                if v.Name == "Doll" then
                    ESP.AddESP("ItemESPFolder", "Doll", v, Color3.new(1, 1, 1))
                elseif v.Name == "BookStand" then
                    ESP.AddESP("ItemESPFolder", "Book", v, Color3.new(1, 1, 1))
                elseif v.Name == "Flask" then
                    ESP.AddESP("ItemESPFolder", "Flask", v, Color3.new(1, 1, 1))
                end
            end
            workspace.School.Item.ChildAdded:Connect(function(v)
                if Toggle.ItemESPTog then
                    if v.Name == "Doll" then
                        ESP.AddESP("ItemESPFolder", "Doll", v, Color3.new(1, 1, 1))
                    elseif v.Name == "BookStand" then
                        ESP.AddESP("ItemESPFolder", "Book", v, Color3.new(1, 1, 1))
                    elseif v.Name == "Flask" then
                        ESP.AddESP("ItemESPFolder", "Flask", v, Color3.new(1, 1, 1))
                    end
                end
            end)
        else
            ESP.Clear("ItemESPFolder")
        end
    end
})

Main:Toggle({
    Title = "Coin ESP",
    Image = "bird",
    Value = false,
    Callback = function(state)
        Toggle.CoinESPTog = state
        if Toggle.CoinESPTog then
            for _,v in next,workspace.School.Aozeni:GetChildren() do
                if v.Name == "zeniBig" then
                    ESP.AddESP("CoinESPFolder", "Big Coin", v, Color3.new(1, 1, 1))
                elseif v.Name == "zeniSmall" then
                    ESP.AddESP("CoinESPFolder", "Small Coin", v, Color3.new(1, 1, 1))
                elseif v.Name == "zeniMedium" then
                    ESP.AddESP("CoinESPFolder", "Medium Coin", v, Color3.new(1, 1, 1))
                end
            end
            workspace.School.Aozeni.ChildAdded:Connect(function(v)
                if Toggle.CoinESPTog then
                    if v.Name == "zeniBig" then
                        ESP.AddESP("CoinESPFolder", "Big Coin", v, Color3.new(1, 1, 1))
                    elseif v.Name == "zeniSmall" then
                        ESP.AddESP("CoinESPFolder", "Small Coin", v, Color3.new(1, 1, 1))
                    elseif v.Name == "zeniMedium" then
                        ESP.AddESP("CoinESPFolder", "Medium Coin", v, Color3.new(1, 1, 1))
                    end
                end
            end)
        else
            ESP.Clear("CoinESPFolder")
        end
    end
})

Main:Toggle({
    Title = "Player ESP",
    Image = "bird",
    Value = false,
    Callback = function(state)
        Toggle.PlayerESPTog = state
        if Toggle.PlayerESPTog then
            for _,v in next,Players:GetPlayers() do
                if v ~= LocalPlayer then
                    ESP.AddESP("PlayerESPFolder", v.Name, v.Character, Color3.new(1, 1, 1))
                end
            end
        else
            ESP.Clear("PlayerESPFolder")
        end
    end
})
