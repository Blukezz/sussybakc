--//====================================================\\--
--||                       BASIS
--\\====================================================//--


local Global = (getgenv and getgenv()) or shared
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/FunctionPack.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/AudioPack.lua"))()
local getsynasset = getsynasset or getcustomasset or function() warn("no getcustomasset/getsynasset") end
local Events = Global.KryptonData['Global Events']
Global.AntiScript()

local script = game:GetObjects("rbxassetid://8719564066")[1]
local MODULE = game:GetObjects("rbxassetid://8719564066")[1]
local CHARACTER = game.Players.LocalPlayer.Character
local PLAYER = game.Players.LocalPlayer
local HUM = CHARACTER.Humanoid
local REMOTE = MODULE.Event

local ROOT = HUM.Torso
local HEAD = CHARACTER.Head
local TORSO = CHARACTER.Torso
local RIGHTARM = CHARACTER["Right Arm"]
local LEFTARM = CHARACTER["Left Arm"]
local RIGHTLEG = CHARACTER["Right Leg"]
local LEFTLEG = CHARACTER["Left Leg"]
local ROOTJOINT = ROOT["RootJoint"]
local NECK = TORSO["Neck"]
local RIGHTSHOULDER = TORSO["Right Shoulder"]
local LEFTSHOULDER = TORSO["Left Shoulder"]
local RIGHTHIP = TORSO["Right Hip"]
local LEFTHIP = TORSO["Left Hip"]
local MOUSEPOS = ROOT.Position

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

--//====================================================\\--
--||                       FE CODE
--\\====================================================//--



--//====================================================\\--
--||                  BACKGROUND VALUES
--\\====================================================//--
local Mouse = game.Players.LocalPlayer:GetMouse()
local mouse = game.Players.LocalPlayer:GetMouse()
local ANIM_SPEED = 3
local MOUSE = PLAYER:GetMouse()
local MOUSEPOS = Mouse.Hit.p
local FRAME_SPEED = 1 / 60 -- (1 / 30) OR (1 / 60)
local CHANGE = 2 / ANIM_SPEED
local DAMAGEMULTIPLIER = 0
local ANIM = "Idle"
local KEYHOLD = false
local MOUSEHOLD = false
local SINE = 0
local ATTACKING = false
local Debris = game:GetService("Debris")
local Effects = IT("Folder",CHARACTER)
Effects.Name = "FXFolder"
PLAYER.Character.Humanoid.Died:Connect(function()
Effects:Destroy()    
end)
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local BGM = 213546066
local BOMB = 2671146857
local STORED = 9999999999999

--//====================================================\\--
--||                     HEARTBEAT
--\\====================================================//--

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = FRAME_SPEED
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

table.insert(Events, game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end))

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

--//====================================================\\--
--||                       CLERP
--\\====================================================//--

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

--//====================================================\\--
--||                     FUNCTIONS
--\\====================================================//--

function WeldParts(A,B)
	local WLD = IT("ManualWeld")
	WLD.Part0 = A
	WLD.Part1 = B
	WLD.C1 = B.CFrame:inverse() * A.CFrame
	WLD.Parent = A
	return WLD
end

--NewSound({ID = 0,PARENT = ROOT,VOLUME = 0.5,PITCH = 1,LOOP = false,MAXDISTANCE = 1000,EMITTERSIZE = 10,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
function NewSound(TABLE)
	local ID = "rbxassetid://"..(TABLE.ID or 0)
	local PARENT = (TABLE.PARENT or ROOT)
	local VOLUME = (TABLE.VOLUME or 0.5)
	local PITCH = (TABLE.PITCH or 1)
	local LOOP = (TABLE.LOOP or false)
	local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
	local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
	local PLAYING = (TABLE.PLAYING or true)
	local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
	local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
	if ID ~= "rbxassetid://0" then
		local SOUND = IT("Sound",PARENT)
		SOUND.SoundId = ID
		SOUND.Volume = VOLUME
		SOUND.Pitch = PITCH
		SOUND.Looped = LOOP
		SOUND.MaxDistance = MAXDISTANCE
		SOUND.EmitterSize = EMITTERSIZE
		SOUND.PlayOnRemove = PLAYONREMOVE
		if DOESDEBRIS == true and PLAYING == true and LOOP == false then
			Debris:AddItem(SOUND,SOUND.TimeLength+5)
		end
		if PLAYING == true then
			SOUND:Play()
		end
	end
	return SOUND
end

function ManSlaughter(MAN)

end

function AreaOfEffect(AREA,RANGE,FLING,RETURN)
	local HIT = {}
	for index, CHILD in pairs(workspace:GetChildren()) do
		if CHILD:FindFirstChildOfClass("Humanoid") then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT = HUMAN.Torso
			if ROOT then
				if (ROOT.Position - AREA).Magnitude <= RANGE then
					if RETURN == true then
						if CHILD ~= CHARACTER then
							table.insert(HIT,{CHILD,HUMAN,ROOT})
						end
					else
						if CHILD ~= CHARACTER then
							ManSlaughter(CHILD)
						end
						local BV = IT("BodyVelocity")
						BV.MaxForce = BV.MaxForce * 500
						BV.Velocity = CF(AREA,ROOT.Position+VT(0,0.5,0)).lookVector*FLING
						BV.Parent = ROOT
						Debris:AddItem(BV,0.05)
					end
				end
			end
		end
	end
	if RETURN == true then
		return HIT
	end
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = ROOT.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function CameraShake(AREA,RANGE,SHAKE,TIMER)

end

--//====================================================\\--
--||                     CHARACTER
--\\====================================================//--

local HELMET = MODULE.Helmet
HELMET.Parent = CHARACTER
for index, CHILD in pairs(CHARACTER:GetChildren()) do

end
HELMET.CFrame = HEAD.CFrame*CF(0,0.5,0)
HELMET.Anchored = false
HELMET.Transparency = 1
WeldParts(HEAD,HELMET)
local BAZOOKA = MODULE.Bazooka
BAZOOKA.Parent = CHARACTER
BAZOOKA.Anchored = false
local GRIP = IT("Motor6D")
GRIP.Part0 = RIGHTARM
GRIP.Part1 = BAZOOKA
GRIP.C0 = CF(0,-1,-0.5)*ANGLES(RAD(-90),0,0)*CF(0,0,1.85)
local G_C0 = GRIP.C0
GRIP.Parent = RIGHTARM

local MISSILE = MODULE.Missile
MISSILE.Parent = nil
local GUI = MODULE.ControlsGUI
GUI.Parent = PLAYER.PlayerGui
GUI.ToggleButton.MouseButton1Click:Connect(function()
	if GUI.ToggleButton.Controls.Visible == false then
		GUI.ToggleButton.Controls.Visible = true
	elseif GUI.ToggleButton.Controls.Visible == true then
		GUI.ToggleButton.Controls.Visible = false
	end
end)
local STOREDGUI = GUI.ToggleButton.Stored
STOREDGUI.Text = "STORED: "..STORED
function AddTo(ADD)
	STORED = STORED + ADD
	STOREDGUI.Text = "STORED: "..STORED
end
local fullattack = false



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
		if Bullet and fullattack then
			Global.KryptonData.Flinging = true
			Bullet.RotVelocity = Vector3.new(0, 7500, 0)
			if Mouse.Target ~= nil then
				Bullet.CFrame = Mouse.Hit * Rotation
			end
		elseif Bullet and not fullattack then
			Global.KryptonData.Flinging = false
		end
	end))
end



local Hat = game.Players.LocalPlayer.Character:FindFirstChild('Back Attack Missle Launcher')
if Hat then
Global.AlignPart(Hat.Handle,BAZOOKA,Vector3.new(2, 1.6, 0),Vector3.new(-45,90,0))
BAZOOKA.Transparency = 1
end
--//====================================================\\--
--||                     ABILITIES
--\\====================================================//--

function Fire_in_the_hole()
 
	if STORED > 0 then
		fullattack = true
		ATTACKING = true
		local GYRO = IT("BodyGyro")
		GYRO.D = 50
		GYRO.P = 5000
		GYRO.Name = "gulp"
		GYRO.MaxTorque = VT(0,4000000,0)
		GYRO.CFrame = CF(ROOT.Position,Mouse.Hit.p)
		GYRO.Parent = ROOT
		ATTACKING = true
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				GYRO.CFrame = CF(ROOT.Position,Mouse.Hit.p)
			until ATTACKING == false
			GYRO:Remove()
		end))
		repeat
			for i=0, 0.06, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02) * ANGLES(RAD(0), RAD(0), RAD(45)), 2.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-45)) * ANGLES(RAD(5), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 2.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(-45)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(45), RAD(0)) * CF(0.4,0,0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1.1, -1, 0) * ANGLES(RAD(0), RAD(-135), RAD(0)) * CF(-0.4,0,0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
			end
			AddTo(-1)
			coroutine.resume(coroutine.create(function()
				local GOTO = Mouse.Hit.p
				local ROCKET = MISSILE:Clone()
				ROCKET.Parent = Effects
				ROCKET.CFrame = CF(BAZOOKA.CFrame*CF(0,0,-2).p,GOTO)
				NewSound({ID = 440145223,PARENT = BAZOOKA,VOLUME = 2,PITCH = MRANDOM(9,11)/10,LOOP = false,MAXDISTANCE = 80,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				NewSound({ID = 440145223,PARENT = ROCKET,VOLUME = 2,PITCH = MRANDOM(9,11)/10,LOOP = false,MAXDISTANCE = 80,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				ROCKET:Destroy()
				for i = 1, 200 do
					Swait()
					local HIT,POS = Raycast(ROCKET.Position,ROCKET.CFrame.lookVector,5,CHARACTER)
					if HIT then
						ROCKET.CFrame = CF(POS)
						break
					end
					ROCKET.CFrame = ROCKET.CFrame*CF(0,0,-4)
				end
				pcall(function()
				ROCKET.Transparency = 1
				ROCKET.Hind:Remove()
				ROCKET.CFrame = CF(ROCKET.Position)
				ROCKET.Size = VT(0,0,0)
				end)
				NewSound({ID = 142070127,PARENT = ROCKET,VOLUME = 7,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 300,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				for index, CHILD in pairs(script.Grenade:GetChildren()) do
					local C = CHILD:Clone()
					C.Parent = ROCKET
					C:Emit(125)
				end
			end))
			for i=0, 0.025, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02) * ANGLES(RAD(0), RAD(0), RAD(45)), 2.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-45)) * ANGLES(RAD(5), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(200), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 2.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(-45)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(45), RAD(0)) * CF(0.4,0,0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1.1, -1, 0) * ANGLES(RAD(0), RAD(-135), RAD(0)) * CF(-0.4,0,0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
			end
		until MOUSEHOLD == false or STORED <= 0
		if STORED <= 0 then
			STORED = 0
			STOREDGUI.Text = "STORED: 0"
		end
		fullattack = false
		ATTACKING = false
	end
end
function Store()
	HUM.WalkSpeed = 0
	HUM.JumpPower = 0
	ATTACKING = true
	repeat
		for i=0, 0.01, 0.1 / ANIM_SPEED do
			Swait()
			GRIP.C0 = Clerp(GRIP.C0, CF(0,-1,-0.5)*ANGLES(RAD(-80),RAD(15),0)*CF(0,0,1.85), 2.5 / ANIM_SPEED)
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02 + 0.05 * COS(SINE / 6)) * ANGLES(RAD(0), RAD(0), RAD(-5)), 0.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(15)), 2.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.7, 0.45, 0) * ANGLES(RAD(35), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(-2.5)), 0.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(-2.5)), 0.5 / ANIM_SPEED)
		end
		local ROCKET = MISSILE:Clone()
		ROCKET.Anchored = false
		ROCKET:ClearAllChildren()
		ROCKET.CFrame = LEFTARM.CFrame*CF(0,-1,0) * ANGLES(RAD(0), RAD(90), RAD(0))
		ROCKET.Parent = CHARACTER
		WeldParts(ROCKET,LEFTARM)
		for i=0, 0.02, 0.1 / ANIM_SPEED do
			Swait()
			GRIP.C0 = Clerp(GRIP.C0, CF(0,-1,-0.5)*ANGLES(RAD(-80),RAD(15),0)*CF(0,0,1.85), 2.5 / ANIM_SPEED)
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02 + 0.05 * COS(SINE / 6)) * ANGLES(RAD(0), RAD(0), RAD(-5)), 0.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(15)), 2.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.675, 0.45, 0.3) * ANGLES(RAD(35), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(25)) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(-2.5)), 0.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(-2.5)), 0.5 / ANIM_SPEED)
		end
		for i=0, 0.02, 0.1 / ANIM_SPEED do
			Swait()
			GRIP.C0 = Clerp(GRIP.C0, CF(0,-1,-0.5)*ANGLES(RAD(-80),RAD(15),0)*CF(0,0,1.85), 2.5 / ANIM_SPEED)
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02 + 0.05 * COS(SINE / 6)) * ANGLES(RAD(0), RAD(0), RAD(-5)), 0.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(15)), 2.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.7, 0.45, 0) * ANGLES(RAD(35), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(-2.5)), 0.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(-2.5)), 0.5 / ANIM_SPEED)
		end
		NewSound({ID = 440145223,PARENT = BAZOOKA,VOLUME = 1,PITCH = MRANDOM(9,11)/6,LOOP = false,MAXDISTANCE = 80,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		for i=0, 0.05, 0.1 / ANIM_SPEED do
			Swait()
			GRIP.C0 = Clerp(GRIP.C0, CF(0,-1,-0.5)*ANGLES(RAD(-80),RAD(15),0)*CF(0,0,1.85), 2.5 / ANIM_SPEED)
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02 + 0.05 * COS(SINE / 6)) * ANGLES(RAD(0), RAD(0), RAD(5)), 0.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(-15)), 2.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.75, 0.45, -0.1) * ANGLES(RAD(45), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-0.9, 0.5, -0.75) * ANGLES(RAD(60), RAD(0), RAD(37.5)) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(2.5)), 0.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(2.5)), 0.5 / ANIM_SPEED)
		end
		ROCKET:Remove()
		BAZOOKA.Face.Pop:Emit(5)
		AddTo(1)
	until KEYHOLD == false
	ATTACKING = false
	HUM.WalkSpeed = 100
	HUM.JumpPower = 50
end

function Dance()
	HUM.WalkSpeed = 0
	HUM.JumpPower = 0
	ATTACKING = true
	local REMOVETRACK = false
	local TRACK = nil
	if ROOT:FindFirstChild("BGM_MUSIC") then
		TRACK = ROOT:FindFirstChild("BGM_MUSIC")
		TRACK.Volume = 5
	else
		TRACK = NewSound({ID = BOMB,PARENT = ROOT,VOLUME = 5,PITCH = 1,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		REMOVETRACK = true
	end
	TRACK.SoundId = "rbxassetid://"..BOMB
	TRACK:Play()
	local DONEWITHDANCING = false
	local NC = mouse.KeyDown:connect(function(key)
		key=key:lower()
		local V2 = key
		if V2 == "m" then
			DONEWITHDANCING = true
			ATTACKING = false
			if REMOVETRACK == true then
				TRACK:Remove()
			else
				TRACK:Play()
				TRACK.Volume = 1.25
				TRACK.SoundId = "rbxassetid://"..BGM
			end
		end
	end)
	local I = 0
	local RAVE = IT("PointLight",ROOT)
	RAVE.Brightness = 25
	RAVE.Color = BrickColor.random().Color
	repeat
		I = I + 2
		Swait()
		RAVE.Color = BrickColor.random().Color
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0 - 0.32 * SIN(I / 10), 0, -0.55 - 0.05 * COS(I / 5)) * ANGLES(RAD(0), RAD(0 - 20 * SIN(I / 10)), RAD(0)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0 - 20 * SIN(I / 10)), RAD(0)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(170), RAD(10), RAD(-35 * COS(I/10)))  *CF(0,-1,0) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(170), RAD(-10), RAD(-35 * COS(I/10))) * CF(0,-1,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1.35, -0.475 + 0.36 * SIN(I / 10) + 0.05 * COS(I / 5), -0.35) * ANGLES(RAD(0), RAD(45), RAD(0)) * ANGLES(RAD(-12 - 19 * SIN(I / 10)), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1.35, -0.475 - 0.36 * SIN(I / 10) + 0.05 * COS(I / 5), -0.35) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-12 + 19 * SIN(I / 10)), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	until DONEWITHDANCING == true
	RAVE:Remove()
	NC:Disconnect()
	if REMOVETRACK == true then
		TRACK:Remove()
	else
		TRACK:Play()
		TRACK.Volume = 1.25
		TRACK.SoundId = "rbxassetid://"..BGM
	end
	ATTACKING = false
	HUM.WalkSpeed = 100
	HUM.JumpPower = 50
end

--//====================================================\\--
--||                       WRAP
--\\====================================================//--

table.insert(Events, mouse.Button1Down:connect(function()
	MOUSEHOLD = true
	if ATTACKING == false then
		Fire_in_the_hole()
	end
end))

table.insert(Events, mouse.Button1Up:connect(function()
	MOUSEHOLD = false
end))

table.insert(Events, mouse.KeyDown:connect(function(key)
	key=key:lower()
	local V2 = key
	KEYHOLD = true
				if V2 == "z" then
					Store()
				elseif V2 == "m" then
					Dance()
				elseif V2 == "t" then
					NewSound({ID = 145757437,PARENT = ROOT,VOLUME = 10,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 25,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				elseif V2 == "e" then
					if ROOT:FindFirstChild("BGM_MUSIC") then
						ROOT:FindFirstChild("BGM_MUSIC"):Remove()
					else
						local M = NewSound({ID = BGM,PARENT = ROOT,VOLUME = 1.25,PITCH = 1,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						M.Name = "BGM_MUSIC"
					end
				end
end))

table.insert(Events, mouse.KeyUp:connect(function()
	KEYHOLD = false
end))

--[[
REMOTE.OnServerEvent:Connect(function(PLR,V1,V2)
	if PLR == PLAYER and ANIM ~= "Sit" then
		--if V1 == "MousePositionUpdate" then
			--MOUSEPOS = V2
		if V1 == "KeyUp" then
			KEYHOLD = false
		elseif V1 == "MouseUp" then
			MOUSEHOLD = false
		end
		if ATTACKING == false then
			if V1 == "MouseDown" then
				MOUSEHOLD = true
				Fire_in_the_hole()
			elseif V1 == "KeyDown" then
				KEYHOLD = true
				if V2 == "z" then
					Store()
				elseif V2 == "m" then
					Dance()
				elseif V2 == "t" then
					NewSound({ID = 145757437,PARENT = ROOT,VOLUME = 10,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 25,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				elseif V2 == "e" then
					if ROOT:FindFirstChild("BGM_MUSIC") then
						ROOT:FindFirstChild("BGM_MUSIC"):Remove()
					else
						local M = NewSound({ID = BGM,PARENT = ROOT,VOLUME = 1.25,PITCH = 1,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						M.Name = "BGM_MUSIC"
					end
				end
			end
		end
	end
end)
]]--

local M = Instance.new("Sound"); do
	M.Name = "BGM_MUSIC"
	M.SoundId = getsynasset("GelatekHub/Scripts/BanzaiBazooka.mp3")
	M:Play()
	M.Parent = TORSO
end

HUM.WalkSpeed = 100

local Eventussy
Eventussy = game:GetService("RunService").Stepped:Connect(function()
	if Global.Stopped == true then
		GUI:Destroy()
		if ROOT:FindFirstChild("gulp") then
			ROOT:FindFirstChild("gulp"):Destroy()
		end
		Eventussy:Disconnect()
	end
	Swait()
	local MOUSEPOS = Mouse.Hit.p
	SINE = SINE + CHANGE
	if CHARACTER:FindFirstChild("Animate") then
		CHARACTER:FindFirstChild("Animate"):Destroy()
	end
	if CHARACTER:FindFirstChild("Sound") then
		CHARACTER:FindFirstChild("Sound"):Destroy()
	end
	for _,v in next, HUM:GetPlayingAnimationTracks() do
		v:Stop();
	end
	local TORSOVELOCITY = (ROOT.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = ROOT.Velocity.y
	local HITFLOOR = Raycast(ROOT.Position, (CF(ROOT.Position, ROOT.Position + VT(0, -1, 0))).lookVector, 4+HUM.HipHeight, CHARACTER)
	local WALKSPEEDVALUE = 0.5
	local SITTING = HUM.Sit
	if ANIM == "Walk" and TORSOVELOCITY > 1 and SITTING == false then
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 0.875 - 0.3 * SIN(SINE / WALKSPEEDVALUE), -0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RIGHTLEG.RotVelocity.Y / 35, RAD(0), RAD(55 * COS(SINE / WALKSPEEDVALUE))), 2 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 0.875 + 0.3 * SIN(SINE / WALKSPEEDVALUE), 0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LEFTLEG.RotVelocity.Y / 35, RAD(0), RAD(55 * COS(SINE / WALKSPEEDVALUE))), 2 / ANIM_SPEED)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or SITTING == true then
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
	end
	if ATTACKING == false then
		GRIP.C0 = Clerp(GRIP.C0, G_C0, 1.5 / ANIM_SPEED)
	end
	if SITTING == false then
		if HITFLOOR then
			if TORSOVELOCITY < 1 and HITFLOOR ~= nil then
				ANIM = "Idle"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.02 + 0.05 * COS(SINE / 6)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 6)), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(100), RAD(0), RAD(5 + 2.5 * COS(SINE / 6))) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25 - 2.5 * COS(SINE / 6))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 6), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				end
			elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
				ANIM = "Walk"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.05 + 0.05 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(-10), RAD(0), RAD(0)), 2 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(10), RAD(0), RAD(0)), 2 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(135), RAD(0), RAD(5 + 2.5 * COS(SINE / WALKSPEEDVALUE))) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(-25 - 2.5 * COS(SINE / WALKSPEEDVALUE))) * LEFTSHOULDERC0, 2 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1 - 0.05 * COS(SINE / WALKSPEEDVALUE), 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-15)), 2 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / WALKSPEEDVALUE), 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(15)), 2 / ANIM_SPEED)
				end
			end
		else
			if TORSOVERTICALVELOCITY > 0 then
				ANIM = "Jump"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(5 + 2.5 * COS(SINE / 6))) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(10)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-20)), 1 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
			    end
			else
				ANIM = "Fall"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(150), RAD(0), RAD(5 + 2.5 * COS(SINE / 6))) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(-60)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.5, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1 / ANIM_SPEED)
				end
			end
		end
	else
		ANIM = "Sit"
		if ATTACKING == false then
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.65, 0) * ANGLES(RAD(50), RAD(-10), RAD(45))*CF(0,-0.25,0) * LEFTSHOULDERC0, 1.25 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.25, -1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.25 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.25, -1) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.25 / ANIM_SPEED)
		end
	end
end)
