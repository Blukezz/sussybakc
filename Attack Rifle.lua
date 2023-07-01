local Global = (getgenv and getgenv()) or shared
local getsynasset = getsynasset or getcustomasset or function() warn("no getcustomasset/getsynasset") end
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/FunctionPack.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/AudioPack.lua"))()
local Events = Global.KryptonData['Global Events']
Global.AntiScript()

Player = game:GetService("Players").LocalPlayer
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = game.Players.LocalPlayer.Character
Humanoid = Character.Humanoid
Mouse = Player:GetMouse()
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
local Hat = Character:FindFirstChild("Police K4LAS [Front]")
Equipped = false
-- 6202087882
-------------------------------------------------------------------------
pcall(function() workspace.FakeGun:Destroy() end)
local Gun = Instance.new("Part")
Gun.CanCollide = false
Gun.Size = Vector3.new(1,3,1.2)
Gun.Name = "Gun"
local Weld = Instance.new("ManualWeld")
Weld.Part0 = Gun
Weld.Part1 = RightArm
Weld.Parent = RightArm
Gun.Parent = Character
if Hat then
	Hat = Hat.Handle
	Hat:BreakJoints()
	Gun.Transparency = 1
	Global.AlignPart(Hat, Gun, Vector3.new(0,-0.4,-1.5), Vector3.new(90,-180,0))
else
	Hat = Gun
end
weld = function(parent, part0, part1, c0)
	local weld = it("Weld")
	weld.Parent = parent
	weld.Part0 = part0
	weld.Part1 = part1
    weld.C0 = c0
    return weld
end

function unanchor()
	if UNANCHOR == true then
		g = CharacterA:GetChildren()
		for i = 1, #g do
			if g[i].ClassName == "Part" then
				g[i].Anchored = false
			end
		end
	end
end
local ScreenGUI = Instance.new("ScreenGui")
ScreenGUI.Name = "Info"
ScreenGUI.Parent = game.CoreGui
local Text = Instance.new("TextLabel")
Text.AnchorPoint = Vector2.new(0.5,0.5)
Text.Size = UDim2.new(0.1,0,0.1,0)
Text.Position = UDim2.new(0.9,0,0.5,0)
Text.TextScaled = true
Text.Text = "AUTO"
Text.BackgroundTransparency = 1
Text.TextColor3 = Color3.fromRGB(255,255,255)
Text.Font = Enum.Font.Gotham
Text.Parent = ScreenGUI
Text.Rotation = 35
local sound1 = Instance.new("Sound")
sound1.SoundId = "rbxassetid://5473216896"
sound1.Looped = false
sound1.Parent = Hat
local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://2204318084"
sound2.Looped = true
sound2.Parent = Hat
local sound3 = Instance.new("Sound")
sound3.SoundId = "rbxassetid://138084889"
sound3.Looped = false
sound3.Parent = Hat
IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor
--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//

Animation_Speed = 2.75
Frame_Speed = 0.016666666666666666
local FORCERESET = false
Frame_Speed = 1 / 80 -- (1 / 60) OR (1 / 80)
local Speed = 25
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local HOLD = false
local Rooted = false
local MODE = "AUTO"
local SINE = 0
local SIZE = 1
local UserInputService = game:GetService("UserInputService")
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character:FindFirstChild("Animate")
local UNANCHOR = true
local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i = 1, NUMBER do
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end



local Global = (getgenv and getgenv()) or getfenv(0)
local Bullet = Global.KryptonData.FlingPart
if Bullet then
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	warn(Bullet.Name)

	--[[
	table.insert(Global.KryptonData["Global Events"], Mouse.Button1Down:Connect(function()
		Global.KryptonData.Flinging = true
	end))

	table.insert(Global.KryptonData["Global Events"], Mouse.Button1Up:Connect(function()
		Global.KryptonData.Flinging = false
	end))
	]]--

	local Rotation = CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
	table.insert(Global.KryptonData["Global Events"], game:GetService("RunService").Heartbeat:Connect(function()
		Rotation = CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
		if Bullet and ATTACK then
			Global.KryptonData.Flinging = true
			Bullet.RotVelocity = Vector3.new(0, 7500, 0)
			if Mouse.Target ~= nil then
				Bullet.CFrame = Mouse.Hit * Rotation
			end
		elseif Bullet and not ATTACK then
			Global.KryptonData.Flinging = false
		end
	end))
end



function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
 



function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
 
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
-- weldtest

--[[
 RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0.1 * COS(SINE / 25)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(-0), RAD(-0))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(0), RAD(0))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 * COS(SINE / 12), -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 * COS(SINE / 12) , -0) * ANGLES(RAD(-0), RAD(-90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.5 / Animation_Speed)

]]
function MoveTo(position) -- Taken From Sniper Script
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p, VT(position.X, RootPart.Position.Y, position.Z)) * CFrame.new(0, 0, 0)
end
local function AutoAttack()
	ATTACK = true
	Equipped = true
	Humanoid.WalkSpeed = 6
	sound2:Play()
	repeat Swait()
	if MODE == "AUTO" then
		MoveTo(Mouse.Hit.Position)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0 + 0.05 * COS(SINE/25)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0 + 2.95*SIN(SINE/1)), RAD(-15), RAD(10)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.51, -0.7+ 0.15 * SIN(SINE/1)) * ANGLES(RAD(90), RAD(0), RAD(-35))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.5-0.02 * COS(SINE / 25), -0.4) * ANGLES(RAD(0), RAD(45), RAD(90))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
		if TORSOVELOCITY > 1 then
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.15 * SIN(SINE / 8), -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(45 * SIN(SINE/8))), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * SIN(SINE / 8), -0) * ANGLES(RAD(-0), RAD(-90), RAD(45) * SIN(SINE/8)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		elseif TORSOVELOCITY < 1 then
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0.05 * COS(SINE / 25), -0.1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(-11), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0.05 * COS(SINE / 25) , -0.12) * ANGLES(RAD(-0), RAD(-90), RAD(0)) * ANGLES(RAD(-0), RAD(5), RAD(0)), 0.5 / Animation_Speed)	
		end
	end
	until ATTACK == false
	Humanoid.WalkSpeed = 22
	sound2:Stop()
end
local function SemiAttack()
	ATTACK = true
	Equipped = true
	Humanoid.WalkSpeed = 6
	task.spawn(function()
		repeat Swait()
		MoveTo(Mouse.Hit.Position)
		if TORSOVELOCITY > 1 then
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.15 * SIN(SINE / 8), -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(45 * SIN(SINE/8))), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * SIN(SINE / 8), -0) * ANGLES(RAD(-0), RAD(-90), RAD(45) * SIN(SINE/8)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		elseif TORSOVELOCITY < 1 then
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0.05 * COS(SINE / 25), -0.1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(-11), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0.05 * COS(SINE / 25) , -0.12) * ANGLES(RAD(-0), RAD(-90), RAD(0)) * ANGLES(RAD(-0), RAD(5), RAD(0)), 0.5 / Animation_Speed)	
		end
		until ATTACK == false
	end)
	for i = 0, 0.8, 0.1 / Animation_Speed do
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0 + 0.05 * COS(SINE/25)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0 + 2.95*SIN(SINE/50)), RAD(-15), RAD(10)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -0.25+ 0.1) * ANGLES(RAD(90), RAD(0), RAD(-35))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.5-0.02 * COS(SINE / 25), -0.4) * ANGLES(RAD(0), RAD(90), RAD(90))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
		Swait()
	end
	sound1:Play()
	for i = 0, 0.8, 0.1 / Animation_Speed do
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0 + 0.05 * COS(SINE/25)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-10 + 2.95*SIN(SINE/50)), RAD(-15), RAD(10)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -0.25+ 0.1) * ANGLES(RAD(150), RAD(0), RAD(-15))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.5-0.02 * COS(SINE / 25), -0.4) * ANGLES(RAD(0), RAD(90), RAD(90))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
		Swait()
	end
	Humanoid.WalkSpeed = 22
	ATTACK = false
	Equipped = false
end
Humanoid.WalkSpeed = 22
table.insert(Events, Mouse.Button1Down:Connect(function()
	if MODE == "AUTO" then
		AutoAttack()
	elseif MODE == "SEMI" then
		SemiAttack()
	end
end))
table.insert(Events, Mouse.Button1Up:Connect(function()
	if MODE == "AUTO" then
		ATTACK = false
		Equipped = false
	end
end))
table.insert(Events, Mouse.KeyDown:connect(function(Key)
    if Key == "q" and MODE == "SEMI" and ATTACK == false then
    	sound3:Play()
        MODE = "AUTO"
    elseif Key == "q" and MODE == "AUTO" and ATTACK == false then
    	sound3:Play()
        MODE = "SEMI"
    end
    Text.Text = MODE
end))
--end
local music = Instance.new("Sound")
music.Name = "INNOCENCE"
pcall(function() music.Name = "ł₦₦Ø₵Ɇ₦₵Ɇ" end)
music.Looped = true
music.SoundId = getsynasset("GelatekHub/Scripts/AttackRifle.mp3")
music.Volume = 0.26
music:Resume()
music.Parent = Character.Torso
music.Playing = true
while true do
	if Global.Stopped == true then
		ATTACK = true
		Equipped = true
		ScreenGUI:Destroy()
		break
	end	
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
	    v:Stop();
	end
	TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local NameClan = 0
	local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 5, Character)
	local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
	SINE = SINE + CHANGE
	if TORSOVERTICALVELOCITY > 1 and ATTACK == false and Equipped == false and HITFLOOR == nil then
		ANIM = "Jump"
         RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0 * COS(SINE / 12)) * ANGLES(RAD(3), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(-0), RAD(30))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(0), RAD(-30))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 * COS(SINE / 12), -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 * COS(SINE / 12) , -0) * ANGLES(RAD(-0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	elseif TORSOVERTICALVELOCITY < -1 and ATTACK == false and Equipped == false and HITFLOOR == nil then
		ANIM = "Fall"
         RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(-0), RAD(65))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5-0 * COS(SINE / 12), 0) * ANGLES(RAD(0* COS(SINE / 12)), RAD(0), RAD(-65))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0 * COS(SINE / 12), -0) * ANGLES(RAD(10), RAD(85), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0 * COS(SINE / 12) , -0) * ANGLES(RAD(10), RAD(-85), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
    	    elseif TORSOVELOCITY < 1 and ATTACK == false and Equipped == false and HITFLOOR ~= nil then
		ANIM = "Idle"
         RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0.05 * COS(SINE / 25)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(4 * SIN(SINE/20)), RAD(0)), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5+0.05 * COS(SINE / 25), 0) * ANGLES(RAD(20* COS(SINE / 25)), RAD(-15*COS(SINE/20)), RAD(10))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5+0.05 * COS(SINE / 25), 0) * ANGLES(RAD(20* COS(SINE / 25)), RAD(15 * COS(SINE/20)), RAD(-10))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 -0.05 * COS(SINE / 25), -0) * ANGLES(RAD(-15), RAD(75), RAD(10)) * ANGLES(RAD(-0), RAD(-5*COS(SINE/50)), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 -0.05 * COS(SINE / 25) , -0) * ANGLES(RAD(10), RAD(-85), RAD(15)) * ANGLES(RAD(-0), RAD(5*COS(SINE/50)), RAD(0)), 0.5 / Animation_Speed)
            elseif TORSOVELOCITY > 1 and Equipped == false and HITFLOOR ~= nil then
		ANIM = "Walk"
         RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-10), RAD(-3 - 3 * COS(SINE/40)), RAD(-5)), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5-0 * COS(SINE / 12), -0.5) * ANGLES(RAD(80), RAD(0), RAD(-60))* RIGHTSHOULDERC0,0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.3, 0.5-0 * COS(SINE / 12), -0.1) * ANGLES(RAD(50), RAD(25), RAD(30))* LEFTSHOULDERC0, 0.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.15 * SIN(SINE / 8), -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-0), RAD(0), RAD(45 * SIN(SINE/8))), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * SIN(SINE / 8), -0) * ANGLES(RAD(-0), RAD(-90), RAD(45) * SIN(SINE/8)) * ANGLES(RAD(-0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
        end
    Swait()
end
unanchor()
