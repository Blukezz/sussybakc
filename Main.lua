local DevTools = loadstring(game:HttpGet("https://raw.githubusercontent.com/05-4/DevTools/main/index.lua"))()
local Global = (getgenv and getgenv()) or getfenv(0)

local Window = DevTools:Init({
    Name = "Blukez's Reanimation Hub", -- Required: Provide a name for the window
    Title = "Blukez's Reanimation Hub", -- Required: Set the title of the loading screen
    Subtitle = "by Blukez", -- Required: Add a brief description for the loading screen
    Icon = "rbxassetid://13300918071", -- Optional: Set an icon for the window
    LoadingBackgroundImage = "rbxassetid://13677037989", -- Optional: Set a background image for the loading screen
    Options = {
        KillYourself = false, -- Optional: Set to true to reset character on launch
        FOVAnimations = false, -- Optional: Set to true to enable FOV Animations
    }
})

local Tab = Window:CreateTab({ Name = "Scripts" })
Tab:CreateSection("Scripts")

local Reanimate
Tab:CreateToggle({
    Name = "Free Mode",
    Callback = function(Value)
        if Value then
            Reanimate = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Krypton%20Reanimate%20Free.lua'))()
                wait(0.5)
            end
        else
            Reanimate = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Krypton%20Reanimate.lua'))()
                wait(0.5)
            end
        end
    end,
})

Tab:CreateButton({
    Name = "Atack Rifle",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Attack%20Rifle.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Banzi Bazooka",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Banzai%20Bazooka.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Dual Ultima",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Dual%20Ultima.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Ender",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Ender.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Neptunion V",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Neptunion%20V.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Quenox",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Quenox.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Carnage",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/The%20Carnage.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Chips",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/The%20Chips.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Gale Fighter",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Gale%20Fighter.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "Goner",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/Goner.lua'))()
    end,
 })

 Tab:CreateButton({
    Name = "The Hotline",
    Callback = function()
        Reanimate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Blukezz/sussybakc/main/The%20Hotline.lua'))()
    end,
 })

 print("sup")