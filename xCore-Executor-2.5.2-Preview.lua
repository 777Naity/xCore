local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/vKhonshu/intro/main/ui"))()
local HttpService = game:GetService("HttpService")
-- PREMIUM LIST
local PlayerPremiumUsersID = {}
-- GLOBAL VARIABLES
local player = game.Players.LocalPlayer
-- GLOBAL FUNC

NotifyLib.prompt('xCore Executor | Setup', 'xCore Executor is Preparing Environment... Please Wait', 2)

-- [--------------------------------------------------------------]
local function CheckPlayerGroupMembership()
    local isMember = player:IsInGroup(34343285)
    if not isMember then
        player:Kick("We are sharing this script for free! But to use it for free you have to join our Group. | Group ID: 34343285 | URL: https://www.roblox.com/groups/34343285")
    end
end
-- [--------------------------------------------------------------]
local function LoadPremiumUsersList()
    local success, result = pcall(function()
        return HttpService:GetAsync("https://cloud.aeolink.com/ncore/script/nCore-Premium-ID-List.lua")
    end)

    if success then
        local loadedData = loadstring(result)
        if loadedData then
            PlayerPremiumUsersID = loadedData()
        else
            warn("Error while downloading premium users list")
        end
    else
        warn("Error: " .. result)
    end
end
-- [--------------------------------------------------------------]
local initialScript
do
    local success, result = pcall(function()
        return game:HttpGet("https://cloud.aeolink.com/ncore/script/Script-nCore-Executor-2.5.0.lua")
    end)
    if success then
        initialScript = result
    else
        warn("Failed to fetch initial script")
        NotifyLib.prompt('nCore Executor', 'Failed to fetch initial script, Please Restart Roblox!', 10)
    end
end
-- [--------------------------------------------------------------]
local function ChecknCoreUpdates()
    while true do
        wait(30)
        local success, result = pcall(function()
            return game:HttpGet("https://cloud.aeolink.com/ncore/script/Script-nCore-Executor-2.5.0.lua")
        end)

        if success and initialScript then
            if result ~= initialScript then
                NotifyLib.prompt('nCore Executor | Update', 'nCore Script Get Updated. Loading new version...', 10)
                wait(2)
                loadstring(game:HttpGet("https://cloud.aeolink.com/ncore/script/Script-nCore-Executor.lua"))()
                return
            end
        end
    end
end
-- [--------------------------------------------------------------]
local function detectExploit()
    local exploitList = {
        "Macsploit",
        "Sentinel",
        "Krnl",
        "Vega x",
        "Trigon",
        "Evon",
        "Krampus",
        "Codex",
        "Delta",
        "Hydrogen",
        "Arceus X",
        "Fluxus",
        "nCore",
        "Solara"
    }

    for _, exploitName in ipairs(exploitList) do
        if syn and syn.is_synapse_function and syn.is_synapse_function() then
            return exploitName
        end
        if PROTOSMASHER_LOADED then
            return exploitName
        end
        if getexecutorname then
            local executorName = getexecutorname()
            if executorName and executorName == exploitName then
                return exploitName
            end
        end
    end

    return "None"
end
-- [--------------------------------------------------------------]
local flyEnabled = false
local fly_speed = 10
local flySpeed = 100
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local camera = game:GetService("Workspace").CurrentCamera
local targetPlayerName = "None"
local viewEnabled = false
local config = {}
local configFilePath = "nCoreConfig.json"
local Sky = false
local teleportDistance = 120
local teleportSpeed = 0.01 -- Adjust the speed as needed
local Grabbed = false
local Up = false
-- [--------------------------------------------------------------]
local function enableFly(fly_speed)
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    local localplayer = plr

    if workspace:FindFirstChild("Core") then
        workspace.Core:Destroy()
    end

    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)

    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character:WaitForChild("LowerTorso")
    Weld.C0 = CFrame.new(0, 0, 0)

    local torso = Core
    local flying = true
    local keys = {a=false, d=false, w=false, s=false}
    local speed = fly_speed

    local function start()
        local pos = Instance.new("BodyPosition", torso)
        local gyro = Instance.new("BodyGyro", torso)
        pos.Name = "EPIXPOS"
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = torso.Position
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.cframe = torso.CFrame

        repeat
            wait()
            localplayer.Character.Humanoid.PlatformStand = true
            local new = gyro.cframe - gyro.cframe.p + pos.position

            if keys.w then
                new = new + workspace.CurrentCamera.CFrame.LookVector * speed
            end
            if keys.s then
                new = new - workspace.CurrentCamera.CFrame.LookVector * speed
            end
            if keys.d then
                new = new * CFrame.new(speed, 0, 0)
            end
            if keys.a then
                new = new * CFrame.new(-speed, 0, 0)
            end

            pos.position = new.p

            if keys.w then
                gyro.cframe = workspace.CurrentCamera.CFrame * CFrame.Angles(-math.rad(speed * 0), 0, 0)
            elseif keys.s then
                gyro.cframe = workspace.CurrentCamera.CFrame * CFrame.Angles(math.rad(speed * 0), 0, 0)
            else
                gyro.cframe = workspace.CurrentCamera.CFrame
            end
        until not flying

        gyro:Destroy()
        pos:Destroy()
        localplayer.Character.Humanoid.PlatformStand = false
    end

    local e1
    local e2

    e1 = mouse.KeyDown:Connect(function(key)
        if not torso or not torso.Parent then flying = false e1:Disconnect() e2:Disconnect() return end
        if key == "w" then
            keys.w = true
        elseif key == "s" then
            keys.s = true
        elseif key == "a" then
            keys.a = true
        elseif key == "d" then
            keys.d = true
        elseif key == "x" then
            flying = not flying
            if flying then
                start()
            end
        end
    end)

    e2 = mouse.KeyUp:Connect(function(key)
        if key == "w" then
            keys.w = false
        elseif key == "s" then
            keys.s = false
        elseif key == "a" then
            keys.a = false
        elseif key == "d" then
            keys.d = false
        end
    end)

    start()
end
-- [--------------------------------------------------------------]
local animationsList = {
    {
        Name = "TryHard Animation Pack",
        Animations = {
            idle = "http://www.roblox.com/asset/?id=616158929",
            walk = "http://www.roblox.com/asset/?id=616168032",
            run = "http://www.roblox.com/asset/?id=616163682",
            jump = "http://www.roblox.com/asset/?id=656117878",
            fall = "http://www.roblox.com/asset/?id=656115606",
            climb = "http://www.roblox.com/asset/?id=616156119"
        }
    },
    {
        Name = "Zombie Animation Pack",
        Animations = {
            idle = "http://www.roblox.com/asset/?id=616158929",
            walk = "http://www.roblox.com/asset/?id=616168032",
            run = "http://www.roblox.com/asset/?id=616163682",
            jump = "http://www.roblox.com/asset/?id=616161997",
            fall = "http://www.roblox.com/asset/?id=616157476",
            climb = "http://www.roblox.com/asset/?id=616156119"
        }
    },
    {
        Name = "Ninja Animation Pack",
        Animations = {
            idle = "http://www.roblox.com/asset/?id=656117400",
            walk = "http://www.roblox.com/asset/?id=656118852",
            run = "http://www.roblox.com/asset/?id=656118000",
            jump = "http://www.roblox.com/asset/?id=656117878",
            fall = "http://www.roblox.com/asset/?id=656118344",
            climb = "http://www.roblox.com/asset/?id=656114359"
        }
    },
    {
        Name = "Mage Animation Pack",
        Animations = {
            idle = "http://www.roblox.com/asset/?id=707742142",
            walk = "http://www.roblox.com/asset/?id=707897309",
            run = "http://www.roblox.com/asset/?id=707861613",
            jump = "http://www.roblox.com/asset/?id=707853694",
            fall = "http://www.roblox.com/asset/?id=707829716",
            climb = "http://www.roblox.com/asset/?id=707826056"
        }
    },
    {
        Name = "Cartoony Animation Pack",
        Animations = {
            idle = "http://www.roblox.com/asset/?id=742637544",
            walk = "http://www.roblox.com/asset/?id=742640026",
            run = "http://www.roblox.com/asset/?id=742638842",
            jump = "http://www.roblox.com/asset/?id=742637942",
            fall = "http://www.roblox.com/asset/?id=742636889",
            climb = "http://www.roblox.com/asset/?id=742637151"
        }
    },
    {
        Name = "Superhero Animation Pack",
        Animations = {
            idle = "http://www.roblox.com/asset/?id=616111295",
            walk = "http://www.roblox.com/asset/?id=616122287",
            run = "http://www.roblox.com/asset/?id=616117076",
            jump = "http://www.roblox.com/asset/?id=616115533",
            fall = "http://www.roblox.com/asset/?id=616113948",
            climb = "http://www.roblox.com/asset/?id=616104706"
        }
    }
}
-- [--------------------------------------------------------------]
TweenService = game:GetService("TweenService")
OWNER = game:GetService("Players").LocalPlayer
local OriginalKeyUpValue = 0
function StopAudio()
    game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("BoomboxStop")
end
function stop(ID, Key)
    local cor = coroutine.wrap(function()
        wait(OWNER.Character.LowerTorso.BOOMBOXSOUND.TimeLength-0.1)
        if OWNER.Character.LowerTorso.BOOMBOXSOUND.SoundId == "rbxassetid://"..ID and OriginalKeyUpValue == Key then
            StopAudio()
        end
    end)
    cor()
end
function Play(ID)
    if OWNER.Backpack:FindFirstChild("[Boombox]") then
        local Tool = nil
        OWNER.Backpack["[Boombox]"].Parent = OWNER.Character
        game.ReplicatedStorage.MainEvent:FireServer("Boombox", ID)
        OWNER.Character["[Boombox]"].RequiresHandle = false
        OWNER.Character["[Boombox]"].Parent = OWNER.Backpack
        OWNER.PlayerGui.MainScreenGui.BoomboxFrame.Visible = false
        if Tool ~= true then
            if Tool then
                Tool.Parent = OWNER.Character
            end
        end
        OWNER.Character.LowerTorso:WaitForChild("BOOMBOXSOUND")
            local cor = coroutine.wrap(function()
                repeat wait() until OWNER.Character.LowerTorso.BOOMBOXSOUND.SoundId == "rbxassetid://"..ID and OWNER.Character.LowerTorso.BOOMBOXSOUND.TimeLength > 0.01
                OriginalKeyUpValue = OriginalKeyUpValue+1
                stop(ID, OriginalKeyUpValue)
            end)
        cor()
    end
end
function hasBoombox()
    local playerjebanywdupe = game.Players.LocalPlayer
    return playerjebanywdupe.Backpack:FindFirstChild("[Boombox]") ~= nil
end
-- [--------------------------------------------------------------]
local function NeckGrab()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local ActivateTool = Instance.new("Tool", LocalPlayer.Backpack)
    local Mouse = LocalPlayer:GetMouse()
    ActivateTool.RequiresHandle = false
    ActivateTool.Name = "NeckGrab"
    
    ActivateTool.Activated:Connect(function()
        game:GetService("ReplicatedStorage").MainEvent:FireServer('Grabbing', true)
        repeat task.wait(0.1)
        until game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value ~= nil and game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value ~= ''
        
        if game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value ~= nil and game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value ~= '' then
            local target = tostring(game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value)
            local Grabbed = true
            game.Players[target].Character:FindFirstChild('GRABBING_CONSTRAINT').H.Length = 99e99
            
            for i, Track in pairs(game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                if Track.Animation.AnimationId == "rbxassetid://11075367458" then
                    Track:Stop()
                end
            end 
            
            spawn(function()
                local Animation = Instance.new("Animation")
                Animation.AnimationId = "rbxassetid://3135389157"
                local LoadAnimation = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
                LoadAnimation.Priority = Enum.AnimationPriority.Action
                LoadAnimation:Play()
                LoadAnimation:AdjustSpeed(0.2)
                wait(0.8)
                LoadAnimation:AdjustSpeed(0)
            end)
            
            if game.Players[target].Character.UpperTorso:FindFirstChild("BodyPosition") then
                game.Players[target].Character.UpperTorso:FindFirstChild("BodyPosition"):Destroy()
                game.Players[target].Character.UpperTorso:FindFirstChild("BodyGyro"):Destroy()
            else
                getfenv().bodypos = Instance.new('BodyPosition', game.Players[target].Character.UpperTorso)
                getfenv().bodypos.D = 200
                getfenv().bodypos.MaxForce = Vector3.new(10000,10000,10000)
                getfenv().bodygyro = Instance.new('BodyGyro', game.Players[target].Character.UpperTorso)
                getfenv().bodygyro.MaxTorque = Vector3.new(10000,10000,10000)
                getfenv().bodygyro.D = 100
            end
            
            game:GetService('RunService'):BindToRenderStep("Pos", 0, function()
                game.Players[target].Character.UpperTorso.BodyPosition.Position = game.Players.LocalPlayer.Character.RightHand.Position + Vector3.new(0, -0.7, 0)
                game.Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(game.Players[target].Character.UpperTorso.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Pos")
            Grabbed = false
            Up = false
            game.Players[target].Character.UpperTorso:FindFirstChild("BodyPosition"):Destroy()
            game.Players[target].Character.UpperTorso:FindFirstChild("BodyGyro"):Destroy()
            
            for i, Track in pairs(game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                    Track:Stop()
                end
            end 
        end
        
        game.Players.LocalPlayer.Character.BodyEffects.Grabbed:GetPropertyChangedSignal('Value'):Connect(function()
            if game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value == nil then 
                game:GetService('RunService'):UnbindFromRenderStep("Pos")
                for i, Track in pairs(game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                    if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                        Track:Stop()
                    elseif Track.Animation.AnimationId == "rbxassetid://14496531574" then
                        Track:Stop()
                    elseif Track.Animation.AnimationId == "rbxassetid://3096047107" then
                        Track:Stop()
                    end
                end 
            end
        end)
    end)
end
-- [--------------------------------------------------------------]
local function DarthVaderGrab()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local UpTool = Instance.new("Tool",LocalPlayer.Backpack)
    local Mouse = LocalPlayer:GetMouse()
    UpTool.RequiresHandle = false 
    UpTool.Name = "Force Choke"
    UpTool.Activated:Connect(function()
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I will tolerate your weakness no longer.", "All")   
        if Grabbed == true then
            if Up == false then
                local target = tostring(game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value)
                Up = true
                for i, Track in pairs (game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                    if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                        Track:Stop()
                    end
                end
                spawn(function()
                    local Animation = Instance.new("Animation")
                    Animation.AnimationId = "rbxassetid://14496531574"
                    local LoadAnimation = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
                    LoadAnimation.Priority = Enum.AnimationPriority.Action
                    LoadAnimation:Play()
                    LoadAnimation:AdjustSpeed(1)
                    wait(1)
                    LoadAnimation:AdjustSpeed(0)
                end)
                spawn(function()
                    wait(0.3)
                    game:GetService('RunService'):UnbindFromRenderStep("Pos")
                    wait(0.05)
                    game:GetService('RunService'):BindToRenderStep("Pos", 0 , function()
                        game.Players[target].Character.UpperTorso.BodyPosition.Position =  game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 8 + Vector3.new(0,23,0)
                        game.Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(game.Players[target].Character.UpperTorso.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                    end)
                    game.Players[target].Character.UpperTorso.BodyPosition.D = 1200
                end)
            else
                for i, Track in pairs (game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                    if Track.Animation.AnimationId == "rbxassetid://14496531574" then
                        Track:Stop(1)
                    end
                end
                spawn(function()
                    wait(0.45)
                    local Animation = Instance.new("Animation")
                    Animation.AnimationId = "rbxassetid://3135389157"
                    local LoadAnimation = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
                    LoadAnimation.Priority = Enum.AnimationPriority.Action
                    LoadAnimation:Play()
                    LoadAnimation:AdjustSpeed(0.2)
                    task.wait(0.8)
                    LoadAnimation:AdjustSpeed(0)
                end)
                local target = tostring(game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value)
                game:GetService('RunService'):UnbindFromRenderStep("Pos")
                Up = false
                game:GetService('RunService'):BindToRenderStep("Pos", 0 , function()
                    game.Players[target].Character.UpperTorso.BodyPosition.Position = game.Players.LocalPlayer.Character.RightHand.Position + Vector3.new(0,-0.7,0)
                    game.Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(game.Players[target].Character.UpperTorso.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                end)
                wait(1)
                game.Players[target].Character.UpperTorso.BodyPosition.D = 200
            end
        end
    end)      
end
-- [--------------------------------------------------------------]
local function NeckGrabPunch()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local PunchTool = Instance.new("Tool", LocalPlayer.Backpack)
    PunchTool.RequiresHandle = false 
    PunchTool.Name = "Punch Player"
    PunchTool.Activated:Connect(function()
        if Grabbed == true and Up == false then
            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)
            for _, Track in pairs(LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                    Track:Stop()
                end
            end
            game:GetService('RunService'):UnbindFromRenderStep("Pos")
            game:GetService('RunService'):BindToRenderStep("Pos", 0, function()
                game.Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(game.Players[target].Character.UpperTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
            end)
            game.Players[target].Character.UpperTorso.BodyPosition.D = 1200
            game.Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 9 + Vector3.new(0, 1, 0)
            wait(3)
            local Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://3354696735"
            local LoadAnimation = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Animation)
            LoadAnimation.Priority = Enum.AnimationPriority.Action
            LoadAnimation:Play()
            wait(1)
            game.Players[target].Character.UpperTorso:FindFirstChild("BodyPosition"):Destroy()
            game:GetService('RunService'):UnbindFromRenderStep("Pos")
            game.Players[target].Character.UpperTorso:FindFirstChild("BodyGyro"):Destroy()
            for _ = 1, 2 do
                wait()
                game.Players[target].Character.UpperTorso.Velocity = Vector3.new(LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector.X * 950, -200, LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector.Z * 950)
            end
            wait(1)
            game:GetService("ReplicatedStorage").MainEvent:FireServer('Grabbing', false)
        end
    end)
end
-- [--------------------------------------------------------------]
local function NeckGrabFloorSlam()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local SlamTool = Instance.new("Tool", LocalPlayer.Backpack)
    local Mouse = LocalPlayer:GetMouse()
    SlamTool.RequiresHandle = false 
    SlamTool.Name = "Floor Slam Player"

    SlamTool.Activated:Connect(function()
        if Grabbed == true then
            if Up == false then
                local target = tostring(game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value)
                for i, Track in pairs(game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                    if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                        Track:Stop()
                    end
                end 

                local Animation = Instance.new("Animation")
                Animation.AnimationId = "rbxassetid://14228857569"
                local LoadAnimation = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
                LoadAnimation.Priority = Enum.AnimationPriority.Action
                LoadAnimation:Play()
                LoadAnimation:AdjustSpeed(1)
                wait(0.1)

                game:GetService('RunService'):UnbindFromRenderStep("Pos")
                game.Players[target].Character.UpperTorso:FindFirstChild("BodyGyro"):Destroy()
                wait(0.01)
                
                game.Players[target].Character.UpperTorso.BodyPosition.D = 500
                game.Players[target].Character.UpperTorso.BodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 5 + Vector3.new(0, 350, 0)
                wait(0.59)

                game.Players[target].Character.UpperTorso.BodyPosition.D = 100
                game.Players[target].Character.UpperTorso.BodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 35 + Vector3.new(0, -100, 0)
                wait(0.7)

                game:GetService("ReplicatedStorage").MainEvent:FireServer('Grabbing', false)
            end
        end
    end)
end
-- [--------------------------------------------------------------]
local function NeckGrabHeavenThrow()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local HeavenTool = Instance.new("Tool", LocalPlayer.Backpack)
    HeavenTool.RequiresHandle = false 
    HeavenTool.Name = "Heaven Throw Player"
    HeavenTool.Activated:Connect(function()
        if Grabbed == true and Up == false then
            local target = tostring(game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value)
            for _, Track in pairs(LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                    Track:Stop()
                end
            end
            local Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://14496531574"
            local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(Animation)
            LoadAnimation.Priority = Enum.AnimationPriority.Action
            LoadAnimation:Play()
            LoadAnimation:AdjustSpeed(1)
            wait(0.4)
            game:GetService('RunService'):UnbindFromRenderStep("Pos")
            game.Players[target].Character.UpperTorso:FindFirstChild("BodyGyro"):Destroy()
            wait(0.01)
            game.Players[target].Character.UpperTorso.BodyPosition.D = 200
            game.Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 3 + Vector3.new(0, 3000, 0)
            wait(2)
            game:GetService("ReplicatedStorage").MainEvent:FireServer('Grabbing', false)
        end
    end)
end
-- [--------------------------------------------------------------]
local function NeckGrabKick()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local KickTool = Instance.new("Tool", LocalPlayer.Backpack)
    KickTool.RequiresHandle = false 
    KickTool.Name = "Kick Player"
    KickTool.Activated:Connect(function()
        if Grabbed == true and Up == false then
            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)
            for _, Track in pairs(LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
                if Track.Animation.AnimationId == "rbxassetid://3135389157" then
                    Track:Stop()
                end
            end
            local Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://14228857569"
            local LoadAnimation = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Animation)
            LoadAnimation.Priority = Enum.AnimationPriority.Action
            LoadAnimation:Play()
            LoadAnimation:AdjustSpeed(0.55)
            wait(0.4)
            game:GetService('RunService'):UnbindFromRenderStep("Pos")
            game.Players[target].Character.UpperTorso:FindFirstChild("BodyGyro"):Destroy()
            game.Players[target].Character.UpperTorso.BodyPosition.D = 900
            game.Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 3 + Vector3.new(0, 80, 0)
            wait(0.4)
            LoadAnimation:Stop(0.5)
            wait(0.3)
            local Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://2788306916"
            local LoadAnimation = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Animation)
            LoadAnimation.Priority = Enum.AnimationPriority.Action
            LoadAnimation:Play()
            wait(0.9)
            for _ = 1, 2 do
                wait()
                game.Players[target].Character.UpperTorso.Velocity = Vector3.new(LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector.X * 450, 300, LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector.Z * 450)
            end
            wait(1)
            game:GetService("ReplicatedStorage").MainEvent:FireServer('Grabbing', false)
        end
    end)
end
-- [--------------------------------------------------------------]
local function addPassiveRipTool()
    local PLR = game:GetService("Players").LocalPlayer
    local CHAR = game:GetService("Players").LocalPlayer.Character
    local RIP_CD = false

        NeckGrab()
        DarthVaderGrab()
    
        local RIPINHALF = Instance.new("Tool", PLR.Backpack)
        RIPINHALF.Name = "RIP Player"
        RIPINHALF.CanBeDropped = false
        RIPINHALF.RequiresHandle = false
        RIPINHALF.Activated:connect(function()
            local GrabbedPLR = CHAR.BodyEffects:FindFirstChild("Grabbed")
            if GrabbedPLR.Value ~= nil then
                if RIP_CD == true then return end
                RIP_CD = true
                local GrabbedCHAR = GrabbedPLR.Value
       
                if hasBoombox() then
                    Play(7508024588)
                end
       
                wait(0.3)

                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Welcome...", "All")   

                wait(1.5)
    
                GrabbedCHAR.RightUpperArm.Position = Vector3.new(0,-1200,0)
                GrabbedCHAR.LeftUpperArm.Position = Vector3.new(0,-1200,0)
                GrabbedCHAR.RightUpperLeg.Position = Vector3.new(0,-1200,0)
                GrabbedCHAR.LeftUpperLeg.Position = Vector3.new(0,-1200,0)

            wait(1.4)

                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("to the true man's world...", "All")   

                wait(0.8)

                task.wait(.1)
                game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing", false)
                RIP_CD = false
            end
        end)
    
        local RIPINHALF = Instance.new("Tool", PLR.Backpack)
        RIPINHALF.Name = "RIP Player + Glitch"
        RIPINHALF.CanBeDropped = false
        RIPINHALF.RequiresHandle = false
        RIPINHALF.Activated:connect(function()
            local GrabbedPLR = CHAR.BodyEffects:FindFirstChild("Grabbed")
            if GrabbedPLR.Value ~= nil then
                if RIP_CD == true then return end
                RIP_CD = true
                local GrabbedCHAR = GrabbedPLR.Value

                if hasBoombox() then
                    Play(474545527)
                end

                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("How do you call someone with no arms?", "All")

                wait(0.3)   
    
                GrabbedCHAR.RightUpperArm.Position = Vector3.new(0,-1200,0)
                GrabbedCHAR.LeftUpperArm.Position = Vector3.new(0,-1200,0)
                GrabbedCHAR.LowerTorso.Position = Vector3.new(0,-1200,0)

                wait(0.2)

                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Disarmed", "All")   

                wait(0.6)

                task.wait(.1)
                game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing", false)
                RIP_CD = false
            end
        end)

    --NeckGrabFloorSlam()
    --NeckGrabHeavenThrow()
    --NeckGrabKick()
    NeckGrabPunch()
end
-- [--------------------------------------------------------------]
local function loadAimlock()
    getgenv().OldAimPart = "Head"
    getgenv().AimPart = "HumanoidRootPart" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}  
    getgenv().AimlockKey = "z"
    getgenv().AimRadius = 100 -- How far away from someones character you want to lock on at
    getgenv().ThirdPerson = true 
    getgenv().FirstPerson = true
    getgenv().TeamCheck = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
    getgenv().PredictMovement = true -- Predicts if they are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed 
    getgenv().PredictionVelocity = 7.8
    getgenv().CheckIfJumped = true
    getgenv().Smoothness = true
    getgenv().SmoothnessAmount = 0.5

    local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
    local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
    local Aimlock, MousePressed, CanNotify = true, false, false;
    local AimlockTarget;
    local OldPre;
    
    getgenv().WorldToViewportPoint = function(P)
        return Camera:WorldToViewportPoint(P)
    end
    
    getgenv().WorldToScreenPoint = function(P)
        return Camera.WorldToScreenPoint(Camera, P)
    end
    
    getgenv().GetObscuringObjects = function(T)
        if T and T:FindFirstChild(getgenv().AimPart) and Client and Client.Character:FindFirstChild("Head") then 
            local RayPos = workspace:FindPartOnRay(RNew(
                T[getgenv().AimPart].Position, Client.Character.Head.Position)
            )
            if RayPos then return RayPos:IsDescendantOf(T) end
        end
    end
    
    getgenv().GetNearestTarget = function()
        -- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
        local players = {}
        local PLAYER_HOLD  = {}
        local DISTANCES = {}
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= Client then
                table.insert(players, v)
            end
        end
        for i, v in pairs(players) do
            if v.Character ~= nil then
                local AIM = v.Character:FindFirstChild("Head")
                if getgenv().TeamCheck == true and v.Team ~= Client.Team then
                    local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                    local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                    local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i] = {}
                    PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr = v
                    PLAYER_HOLD[v.Name .. i].diff = DIFF
                    table.insert(DISTANCES, DIFF)
                elseif getgenv().TeamCheck == false and v.Team == Client.Team then 
                    local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                    local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                    local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i] = {}
                    PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr = v
                    PLAYER_HOLD[v.Name .. i].diff = DIFF
                    table.insert(DISTANCES, DIFF)
                end
            end
        end
        
        if unpack(DISTANCES) == nil then
            return nil
        end
        
        local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
        if L_DISTANCE > getgenv().AimRadius then
            return nil
        end
        
        for i, v in pairs(PLAYER_HOLD) do
            if v.diff == L_DISTANCE then
                return v.plr
            end
        end
        return nil
    end
    
    Mouse.KeyDown:Connect(function(a)
        if not (Uis:GetFocusedTextBox()) then 
            if a == AimlockKey and AimlockTarget == nil then
                pcall(function()
                    if MousePressed ~= true then MousePressed = true end 
                    local Target = GetNearestTarget()
                    if Target ~= nil then 
                        AimlockTarget = Target
                        NotifyLib.prompt('nCore Executor | Aimlock', 'User Locked: ' .. AimlockTarget.Name, 5)
                    end
                end)
            elseif a == AimlockKey and AimlockTarget ~= nil then
                if AimlockTarget ~= nil then AimlockTarget = nil end
                if MousePressed ~= false then 
                    MousePressed = false 
                end
            end
        end
    end)
    
    RService.RenderStepped:Connect(function()
        if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        end
        if Aimlock == true and MousePressed == true then 
            if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then 
                if getgenv().FirstPerson == true then
                    if CanNotify == true then
                        if getgenv().PredictMovement == true then
                            if getgenv().Smoothness == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                                
                                --// Making it work \\--
                                Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().SmoothnessAmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                            end
                        elseif getgenv().PredictMovement == false then 
                            if getgenv().Smoothness == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)

                                --// Making it work \\--
                                Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().SmoothnessAmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
                            end
                        end
                    end
                end
            end
        end
         if CheckIfJumped == true then
       if AimlockTarget.Character.Humanoid.FloorMaterial == Enum.Material.Air then
    
           getgenv().AimPart = "UpperTorso"
       else
         getgenv().AimPart = getgenv().OldAimPart

       end
    end
end)
end
-- [--------------------------------------------------------------]
local TPLocationsList = {
    Safe1 = Vector3.new(2, 14, 215), -- replace with actual coordinates
    Safe2 = Vector3.new(-113, -57, 148), -- replace with actual coordinates
    MilitaryBase = Vector3.new(36, 28, -834), -- replace with actual coordinates
    Bank = Vector3.new(-443, 41, -281), -- replace with actual coordinates
    Food1 = Vector3.new(-325.2913818359375, 23.680667877197266, -290.97052001953125),
    Food2 = Vector3.new(306.7019958496094, 49.280677795410156, -624.3306274414062),
    GunShop_Uphill = Vector3.new(481.9706115722656, 48.06851577758789, -619.31591796875),
    GunShop_Downhill = Vector3.new(-579.2317504882812, 8.3128080368042, -736.921630859375),
    UFO = Vector3.new(69.88544464111328, 156.4752655029297, -689.2923583984375),
    MediumArmor = Vector3.new(409.1221923828125, 48.02474594116211, -54.851078033447266),
    Roof = Vector3.new(-327.1116027832031, 80.43189239501953, -296.4517517089844),
    Sewer = Vector3.new(162.3624725341797, -41.95204544067383, 154.61416625976562),
    RPG = Vector3.new(111.15089416503906, -26.752010345458984, -272.96734619140625),
    UFO2 = Vector3.new(48.126922607421875, -58.7020378112793, 133.43624877929688),
    GunShop_New = Vector3.new(-1183.7650146484375, 28.378028869628906, -510.0019836425781)
}
-- [--------------------------------------------------------------]
local WeaponsList = {
    {Name = "SMG - $796", ShopItem = "[SMG] - $796"},
    {Name = "Shotgun - $1326", ShopItem = "[Shotgun] - $1326"},
    {Name = "Pistol - $250", ShopItem = "[Pistol] - $250"},
    {Name = "Silencer - $583", ShopItem = "[Silencer] - $583"},
    {Name = "AK47 - $2387", ShopItem = "[AK47] - $2387"},
    {Name = "AR - $1061", ShopItem = "[AR] - $1061"},
    {Name = "Flamethrower - $15914", ShopItem = "[Flamethrower] - $15914"},
    {Name = "140 Ammo for Flamethrower - $1644", ShopItem = "140 [Flamethrower Ammo] - $1644"},
    {Name = "RPG - $21218", ShopItem = "[RPG] - $21218"},
    {Name = "5 Ammo for RPG - $1061", ShopItem = "5 [RPG Ammo] - $1061"},
    {Name = "Tactical Shotgun - $1857", ShopItem = "[TacticalShotgun] - $1857"},
    {Name = "20 Ammo for Tactical Shotgun - $64", ShopItem = "20 [TacticalShotgun Ammo] - $64"},
    {Name = "Drum Gun - $3183", ShopItem = "[DrumGun] - $3183"},
    {Name = "100 Ammo for Drum Gun - $212", ShopItem = "100 [DrumGun Ammo] - $212"},
    {Name = "Grenade - $743", ShopItem = "[Grenade]] - $743"},
    {Name = "Flashbang - $583", ShopItem = "[Flashbang] - $583"},
    {Name = "Surgeon Mask - $27", ShopItem = "[Surgeon Mask] - $27"},
    {Name = "Medium Armor - $1697", ShopItem = "[Medium Armor] - $1697"},
    {Name = "Fire Armor - $2546", ShopItem = "[Fire Armor] - $2546"},
    {Name = "Knife - $159", ShopItem = "[Knife] - $159"},
    {Name = "Key - $133", ShopItem = "[Key] - $133"},
    {Name = "LockPicker - $133", ShopItem = "[LockPicker] - $133"},
    {Name = "Taser - $1061", ShopItem = "[Taser] - $1061"},
    {Name = "Bag - $27", ShopItem = "[BrownBag] - $27"}
}
-- [--------------------------------------------------------------]
local function buyWeapon(weapon)
    local plr = game:GetService("Players").LocalPlayer
    local k = game.Workspace.Ignored.Shop[weapon.ShopItem]
    local savedPos = plr.Character.HumanoidRootPart.CFrame
    plr.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
    wait(0.5)
    fireclickdetector(k.ClickDetector)
    wait(0.1) -- Small delay to ensure the purchase is completed
    plr.Character.HumanoidRootPart.CFrame = savedPos
    NotifyLib.prompt('nCore Executor', "Item: " .. weapon.Name .. " Has been added to your EQ", 2)
end
-- [--------------------------------------------------------------]

-- [--------------------------------------------------------------]
local function saveConfig()
    local jsonData = HttpService:JSONEncode(config)
    writefile(configFilePath, jsonData)
    NotifyLib.prompt('xCore Executor', 'Config saved successfully!', 5)
end
-- [--------------------------------------------------------------]
local function loadConfig()
    if isfile(configFilePath) then
        local jsonData = readfile(configFilePath)
        config = HttpService:JSONDecode(jsonData)
        applyConfig() -- Apply loaded config settings
        NotifyLib.prompt('xCore Executor', 'Config loaded successfully!', 5)
    else
        NotifyLib.prompt('xCore Executor', 'No config file found!', 5)
    end
end
-- [--------------------------------------------------------------]
local function applyConfig()
    if config.flySpeed then
        fly_speed = config.flySpeed
    end
end
-- [--------------------------------------------------------------]
    -- Global variables to control Anti-Lock
    getgenv().Sky = false --disable or enable the antilock
    getgenv().SkyAmount = 90 --how far it should be

    local function applyAntiLock()
        if getgenv().Sky then
            local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,      getgenv().SkyAmount,0) 
            game:GetService("RunService").RenderStepped:Wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
        end
    end

    game:GetService("RunService").Heartbeat:Connect(function()
        if getgenv().Sky then
            applyAntiLock()
        end
    end)

    game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            if getgenv().AntiLock then
                repeat wait() until humanoid.Health > 0
                applyAntiLock()
            end
        end)
    end)
-- [--------------------------------------------------------------]


if game.PlaceId == 2788229376 or game.PlaceId == 7213786345 or game.PlaceId == 17502123056 or game.PlaceId == 17718959553 or game.PlaceId == 17326592548 then

    NotifyLib.prompt('xCore Executor | Setup', 'Loading GUI...', 5)

    local Window = OrionLib:MakeWindow({Name = "xCore Executor | Version: 2.5.2 Preview", HidePremium = true, IntroText = "xCore Executor | Version: 2.5.2 Preview"})

    local AboutTab = Window:MakeTab({
        Name = "About",
        PremiumOnly = false,
        Icon = "rbxassetid://7733924216"
    })

    local MainTab = Window:MakeTab({
        Name = "Main",
        PremiumOnly = false,
        Icon = "rbxassetid://7733765045"
    })

    local TargetTab = Window:MakeTab({
        Name = "Target",
        PremiumOnly = false,
        Icon = "rbxassetid://7743872758"
    })

    local function updateTargetLabel()
        if not TargetPlayerLabel then
            TargetPlayerLabel = TargetTab:AddLabel("Player: " .. targetPlayerName)
        else
            TargetPlayerLabel:Set("Player: " .. targetPlayerName)
        end
    end

    local OptionsTab = Window:MakeTab({
        Name = "Options",
        PremiumOnly = false,
        Icon = "rbxassetid://7734021300"
    })

    local MiscellaneousTab = Window:MakeTab({
        Name = "Miscellaneous",
        PremiumOnly = false,
        Icon = "rbxassetid://7733701545"
    })

    local TeleportandQuickTab = Window:MakeTab({
        Name = "TP & QB",
        PremiumOnly = false,
        Icon = "rbxassetid://7734058345"
    })

    local SettingsTab = Window:MakeTab({
        Name = "Settings",
        PremiumOnly = false,
        Icon = "rbxassetid://8997386997"
    })

    -- INIT SCRIPT DO NOT REMOVE

    CheckPlayerGroupMembership()
    LoadPremiumUsersList()

    NotifyLib.prompt('xCore Executor', 'Checking for Update...', 5)

    coroutine.wrap(ChecknCoreUpdates)()

    if PlayerPremiumUsersID[player.UserId] then
        NotifyLib.prompt('xCore Executor', 'User: Premium', 5)
    else
        NotifyLib.prompt('xCore Executor', 'User: Basic', 5)
    end

    -- INIT SCRIPT DO NOT REMOVE
    -- DETECT EXPLOIT
    local currentExploit = detectExploit()

    -- ABOUT TAB
    AboutTab:AddLabel("Version: 2.5.1 PDB")
    AboutTab:AddLabel("Executor: " .. currentExploit)
    AboutTab:AddLabel("Status: Premium")

    -- MAIN TAB
    local SectionLock =  MainTab:AddSection({
	    Name = "Main"
    })
    MainTab:AddButton({
        Name = "Fly [x]",
        Callback = function()
            NotifyLib.prompt('nCore Executor | Main', 'Fly [X] Loaded!', 2)
            enableFly(fly_speed)
        end
    })
    
    MainTab:AddTextbox({
        Name = "Fly Speed",
        Default = tostring(config.flySpeed),
        TextDisappear = false,
        Callback = function(value)
            local num = tonumber(value)
            if num then
                fly_speed = num
                config.flySpeed = num
            else
                NotifyLib.prompt('xCore Executor | Error', 'Please enter a valid number for fly speed.', 2)
            end
        end
    })    

    MainTab:AddButton({
        Name = "Fake Macro [C]",
        Callback = function()
            NotifyLib.prompt('nCore Executor | Main', 'Fake Macro [C] Loaded!', 2)
            plr = game:GetService('Players').LocalPlayer
            down = true
             
            function onButton1Down(mouse)
                down = true
                while down do
                    if not down then break end
                    local char = plr.Character
                    char.HumanoidRootPart.Velocity = char.HumanoidRootPart.CFrame.lookVector * 190
                    wait()
                end
            end
             
            function onButton1Up(mouse)
                down = false
            end
             
            function onSelected(mouse)
                mouse.KeyDown:connect(function(c) if c:lower()=="c"then onButton1Down(mouse)end end)
                mouse.KeyUp:connect(function(c) if c:lower()=="c"then onButton1Up(mouse)end end)
            end
            onSelected(game.Players.LocalPlayer:GetMouse())
        end
    })

    -- TARGET TAB 

    updateTargetLabel()

    TargetTab:AddTextbox({
        Name = "Target Player",
        Default = "",
        TextDisappear = true,
        Callback = function(Value)
            local lowerValue = Value:lower()
            local foundPlayer = nil
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Name:lower():find(lowerValue) or player.DisplayName:lower():find(lowerValue) then
                    foundPlayer = player
                    break
                end
            end
            if foundPlayer then
                targetPlayerName = foundPlayer.Name
            else
                NotifyLib.prompt('xCore Executor', 'User with this Username or Display Name are not found!', 2)
                targetPlayerName = "None"
            end
            updateTargetLabel()
        end
    })

    local SectionTarget =  TargetTab:AddSection({
	    Name = "Main"
    })

    TargetTab:AddToggle({
        Name = "View",
        Default = false,
        Callback = function(Value)
            viewEnabled = Value
            if viewEnabled then
                NotifyLib.prompt('xCore Executor', 'View Enabled!', 2)
                coroutine.wrap(function()
                    while viewEnabled do
                        local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
                        if targetPlayer and targetPlayer.Character then
                            camera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                        end
                        wait(0.2)
                    end
                end)()
            else
                camera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") -- Reset camera to local player
            end
        end
    })

    TargetTab:AddButton({
        Name = "TP to Player",
        Callback = function()
            local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
            if targetPlayer then
                humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    })

    local SectionTarget =  TargetTab:AddSection({
	    Name = "Combat Options"
    })

    TargetTab:AddButton({
        Name = "Knock",
        Callback = function()
        end
    })

    TargetTab:AddButton({
        Name = "Bring",
        Callback = function()
            local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
            if targetPlayer then
                humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    })

    TargetTab:AddButton({
        Name = "Stomp",
        Callback = function()
        end
    })

    local SectionTarget =  TargetTab:AddSection({
	    Name = "Troll Options"
    })

    TargetTab:AddButton({
        Name = "Bag",
        Callback = function()
            local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
            if targetPlayer then
                local success = buyAndEquipBag()
                if success then
                    teleportAndClickLoop(targetPlayer)
                end
            else
                NotifyLib.prompt('nCore Executor', 'Target player not found!', 2)
            end
        end
    })

    -- LOCKS TAB
    local SectionLock =  MiscellaneousTab:AddSection({
	    Name = "Lock Options"
    })
    MiscellaneousTab:AddButton({
        Name = "Camlock v2 [Z]",
        Callback = function()
            NotifyLib.prompt('nCore Executor', 'Camlock v2 [Z] Loaded!', 5)
            loadAimlock()
        end
    })

    MiscellaneousTab:AddButton({
        Name = "Reslover v2",
        Callback = function()
            local RunService = game:GetService("RunService")
            NotifyLib.prompt('nCore Executor', 'Reslover v2 Loaded!', 2)     
            RunService.Heartbeat:Connect(function()
                pcall(function()
                    for i,v in pairs(game.Players:GetChildren()) do
                        if v.Name ~= game.Players.LocalPlayer.Name then
                            local hrp = v.Character.HumanoidRootPart
                            hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                            hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)   
                        end
                    end
                end)
            end)
        end
    })

    -- TROLL TAB
    local SectionTroll =  MiscellaneousTab:AddSection({
	    Name = "Troll Actions"
    })
    MiscellaneousTab:AddButton({
        Name = "Add RIP Tools",
        Callback = function()
            addPassiveRipTool()
        end
    })

    MiscellaneousTab:AddButton({
        Name ="Play Sound [ BETA VERSION ]",
        Callback = function()
            Play(16190757458)
        end
    })

    -- ANIMATION TAB
    local SectionAnimations =  MiscellaneousTab:AddSection({
	    Name = "Animations"
    })
    for _, animationPack in pairs(animationsList) do
        MiscellaneousTab:AddButton({
            Name = animationPack.Name,
            Callback = function()
                local animations = animationPack.Animations
                local animateScript = player.Character:FindFirstChild("Animate")
                if animateScript then
                    animateScript.idle.Animation1.AnimationId = animations.idle
                    animateScript.walk.WalkAnim.AnimationId = animations.walk
                    animateScript.run.RunAnim.AnimationId = animations.run
                    animateScript.jump.JumpAnim.AnimationId = animations.jump
                    animateScript.fall.FallAnim.AnimationId = animations.fall
                    animateScript.climb.ClimbAnim.AnimationId = animations.climb
                end
                NotifyLib.prompt('xCore Executor', animationPack.Name .. ' Loaded!', 2)
            end
        })
    end

    -- OPTIONS TAB

    local SectionQuickBuy = OptionsTab:AddSection({
	    Name = "Player Options"
    })

    OptionsTab:AddToggle({
        Name = "Anti-Afk",
        Default = true,
        Callback = function(Value)
            if Value then
                NotifyLib.prompt('nCore Executor', 'Anti-Afk Enabled!', 2)
                local VirtualUser = game:GetService('VirtualUser')
                game:GetService('Players').LocalPlayer.Idled:connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                    NotifyLib.prompt('xCore Executor', 'Roblox tried to kick you for being AFK, but you were protected!', 2)
                end)
            end
        end
    })

    OptionsTab:AddToggle({
        Name = "Anti-Stomp",
        Default = false,
        Callback = function(x)
            if x == true then
                NotifyLib.prompt('nCore Executor | Comabt', 'Anti-Stomp Enabled!', 2)
                game:GetService('RunService'):BindToRenderStep("Anti-Stomp", 0 , function()
                    if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v:IsA('MeshPart') or v:IsA('Part') then
                                v:Destroy()
                            end
                        end
                        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v:IsA('Accessory') then
                                v.Handle:Destroy()
                            end
                        end
                    end
                end)
            elseif x == false then
                game:GetService('RunService'):UnbindFromRenderStep("Anti-Stomp")
            end
        end
    })

    local SectionQuickBuy = OptionsTab:AddSection({
	    Name = "Comabt Options"
    })

    OptionsTab:AddToggle({
        Name = "Auto-Reload",
        Default = false,
        Callback = function(r)
            if r == true then
                NotifyLib.prompt('nCore Executor | Combat', 'Auto-Reload Enabled!', 2)
                game:GetService('RunService'):BindToRenderStep("Auto-Reload", 0 , function()
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                                game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                                wait(1)
                            end
                        end
                    end
                end)
            elseif r == false then
                game:GetService('RunService'):UnbindFromRenderStep("Auto-Reload")
            end
        end
    })

    OptionsTab:AddToggle({
        Name = "Auto-Stomp",
        Default = false,
        Callback = function(Value)
            if Value then
                NotifyLib.prompt('nCore Executor | Combat', 'Auto-Stomp Enabled!', 2)
                game:GetService('RunService'):BindToRenderStep("Auto-Stomp", 0 , function()
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("Stomp")
                end)
            else
                game:GetService('RunService'):UnbindFromRenderStep("Auto-Stomp")
            end
        end
    })

    local SectionQuickBuy = OptionsTab:AddSection({
	    Name = "Exploiters Options"
    })

    OptionsTab:AddToggle({
        Name = "Anti-Lock",
        Default = false,
        Callback = function(Value)
            Sky = Value
            if Sky then
                NotifyLib.prompt('xCore Executor', 'Anti-Lock Enabled!', 2)
            else
                NotifyLib.prompt('xCore Executor', 'Anti-Lock Disabled!', 2)
            end
        end
    })

    OptionsTab:AddButton({
        Name = "Anti-Fling",
        Callback = function()
            loadstring(game:HttpGet('https://cloud.aeolink.com/ncore/script/Script-nCore-Executor-AntiFling.lua', true))()
        end
    })

    OptionsTab:AddButton({
        Name = "Chat Spy",
        Callback = function()
            loadstring(game:HttpGet('https://cloud.aeolink.com/ncore/script/Script-nCore-Executor-ChatSpy.lua', true))()
        end
    })

    local SectionQuickBuy = OptionsTab:AddSection({
	    Name = "People Options"
    })
    
    OptionsTab:AddButton({
        Name = "Force Reset",
        Callback = function()
            player.Character.Humanoid.Health = 0
            wait(0.1)
            player:LoadCharacter()
        end
    })

    -- TP & Quick Buy TAB
    local SectionQuickBuy =  TeleportandQuickTab:AddSection({
	    Name = "Quick Buy"
    })
    for _, weapon in ipairs(WeaponsList) do
        TeleportandQuickTab:AddButton({
            Name = weapon.Name,
            Callback = function()
                buyWeapon(weapon)
            end
        })
    end

    -- TELEPORT TAB
    local SectionTeleport =  TeleportandQuickTab:AddSection({
	    Name = "Teleport Locations"
    })

    for location, coords in pairs(TPLocationsList) do
        TeleportandQuickTab:AddButton({
            Name = location,
            Callback = function()
                humanoidRootPart.CFrame = CFrame.new(coords)
            end
        })
    end

    -- STAND MODE TAB
    local SectionStand =  SettingsTab:AddSection({
	    Name = "Stand Mode"
    })
    SettingsTab:AddButton({
        Name = "Enable Stand Mode",
        Callback = function()
            loadstring(game:HttpGet("https://cloud.aeolink.com/ncore/script/nCore-Executor-Script-StandMode-1.0.0.lua"))()
        end
    })

    -- CONFIG TAB
    local SectionStand =  SettingsTab:AddSection({
	    Name = "Config"
    })


    SettingsTab:AddButton({
        Name = "Save Config",
        Callback = function()
            saveConfig()
        end
    })
    
    SettingsTab:AddButton({
        Name = "Load Config",
        Callback = function()
            NotifyLib.prompt('nCore Executor', 'Load Config is not available in Preview Version.', 5)
            loadConfig()
        end
    })    

    OrionLib:Init()
else
    NotifyLib.prompt('xCore Executor | Game', 'Game is not Supported!', 10)
end
