local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Game Loader",
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
    Title = "Main",
    Opened = true,
})

Main = MainSection:Tab({ Title = "Tab", Icon = "Sword" })

local gamelist = require("/data.lua")

for name, exec in pairs(gamelist) do
    Main:Button({
        Title = name,
        Desc = "click the button to open the script",
        Callback = function()
            loadstring(game:HttpGet(exec))()
        end
    })
end
