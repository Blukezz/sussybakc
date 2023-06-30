local Global = (getgenv and getgenv()) or shared
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/FunctionPack.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/AudioPack.lua"))()
local getsynasset = getsynasset or getcustomasset or function() warn("no getcustomasset/getsynasset") end
local Events = Global.KryptonData['Global Events']
Global.AntiScript()
-- its funny how i turned a SS script with like 40 instances into 1 signle file
local PLAYER = game:GetService("Players").LocalPlayer
local CHARACTER = PLAYER.Character
local HUM = CHARACTER.Humanoid

local ROOT = CHARACTER.HumanoidRootPart
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
Mouse,mouse,UserInputService,ToolFunction,GuiWire,RenderStepped,Player=PLAYER:GetMouse(),PLAYER:GetMouse(),game:GetService("UserInputService"),nil,nil,game:GetService("RunService").RenderStepped,PLAYER
--------------------------------------------------------------
--//====================================================\\--
--||                  BACKGROUND VALUES
--\\====================================================//--

local ANIM_SPEED = 3
local MOUSE = Mouse
local FRAME_SPEED = 1 / 60 -- (1 / 30) OR (1 / 60)
local CHANGE = 2 / ANIM_SPEED
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local KEYHOLD = false
local MOUSEHOLD = false
local SINE = 0
local ATTACKING = false
local Debris = game:GetService("Debris")
local Effects = IT("Folder",CHARACTER)
Effects.Name = "FXFolder"
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

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
		return SOUND
	end
end

function OofOuchBlood(LOCATION,TO,AMOUNT)
	local P = CreatePart(3, Effects, "Granite", 0, 1, BRICKC("Pearl"), "Blood", VT(0,0,0), true)
	P.CFrame = CF(LOCATION,TO)
	local BLOOD = Instance.new("ParticleEmitter")
	BLOOD.Name = "Blood"
	BLOOD.Speed = NumberRange.new(10, 35)
	BLOOD.Rotation = NumberRange.new(0, 360)
	BLOOD.Color = ColorSequence.new(Color3.new(1, 0, 0),Color3.new(0.490196, 0.0156863, 0.0156863))
	BLOOD.Enabled = false
	BLOOD.LightEmission = 0.5
	BLOOD.Texture = "rbxassetid://387288028"
	BLOOD.Transparency = NumberSequence.new(0.4375,0.7472527027130127,0.8626373410224915,0.9450549483299255,1)
	BLOOD.Size = NumberSequence.new(0,1.187499761581421,1.3124996423721313,1.4375001192092896,2.249999523162842,3.125,4.625)
	BLOOD.Acceleration = Vector3.new(0, -35, 0)
	BLOOD.Drag = 5
	BLOOD.EmissionDirection = Enum.NormalId.Front
	BLOOD.Lifetime = NumberRange.new(1, 2)
	BLOOD.Rate = 999
	BLOOD.RotSpeed = NumberRange.new(-5, 5)
	BLOOD.SpreadAngle = Vector2.new(35, 35)
	BLOOD.VelocitySpread = 35
	BLOOD.Parent = P
	BLOOD:Emit(AMOUNT)
	Debris:AddItem(P,2)
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
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

function Raycast(POSITION, DIRECTION, RANGE, TABLE)
	local TABLE = ((type(TABLE) == "table" and TABLE) or {TABLE})
	return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(POSITION, DIRECTION * RANGE), TABLE)
end

function CameraShake(AREA,RANGE,SHAKE,TIMER)
	for index, CHILD in pairs(workspace:GetChildren()) do
		if CHILD:FindFirstChildOfClass("Humanoid") then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT = HUMAN.Torso
			if ROOT and game.Players:GetPlayerFromCharacter(CHILD) then
				if (ROOT.Position - AREA).Magnitude <= RANGE then
					if CHILD:FindFirstChild("CamShake") then
						Debris:AddItem(CHILD:FindFirstChild("CamShake"),0.05)
					end
					local CAMSHAKE = script.CamShake:Clone()
					CAMSHAKE.Parent = CHILD
					local TIMER_V = IT("NumberValue",CAMSHAKE)
					TIMER_V.Name = "Timer"
					TIMER_V.Value = TIMER
					local SHAKE_V = IT("NumberValue",CAMSHAKE)
					SHAKE_V.Name = "Shake"
					SHAKE_V.Value = SHAKE
					CAMSHAKE.Disabled = false
					Debris:AddItem(CAMSHAKE,15)
				end
			end
		end
	end
end

--Debree({Delay = 1.5,Variant = "",Location = ROOT.Position,Color = C3(1,1,1),Size = 1,Distance = 1,Material = "Slate",Scatter = 1,Amount = 1,DebreeCount = 1})
function Debree(Table)
	local KindOf = (Table.Variant or "Ring")
	local Position = (Table.Location or ROOT.Position)
	local Coloration = (Table.Color or C3(1,1,1))
	local Texture = (Table.Material or "Slate")
	local Fling = (Table.Scatter or 1)
	local Number = (Table.Amount or 1)
	local Rocks = (Table.DebreeCount or 1)
	local Range = (Table.Distance or 1)
	local Scale = (Table.Size or 1)
	local Timer = (Table.Delay or 1.5)
	coroutine.resume(coroutine.create(function()
		local ScaleVector = VT(Scale,Scale,Scale)
		local Boulders = {}
		Position = CF(Position)
		if KindOf == "Ring" or KindOf == "Both" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),Range)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		if KindOf == "Loose" or KindOf == "Both" then
			for RockValue = 1, Rocks do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale-(Scale/2)),math.ceil(Scale-(Scale/2))),0.7)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Velocity = CF(BOULDER.Position-VT(0,4,0),BOULDER.CFrame*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,5,0).p).lookVector*MRANDOM(Fling-(Fling/1.5),Fling+(Fling/1.5))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		if KindOf == "Random" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),MRANDOM(0,Range))
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		wait(Timer)
		for E = 1, 45 do
			Swait()
			for A = 1, #Boulders do
				Boulders[A].Transparency = Boulders[A].Transparency + 1/45
			end
		end
		for A = 1, #Boulders do
			Boulders[A]:Destroy()
		end
	end))
end

function Chatter(Text,Timer)
	local chat = coroutine.wrap(function()
		if CHARACTER:FindFirstChild("SpeechBoard")~= nil then
			CHARACTER:FindFirstChild("SpeechBoard"):destroy()
		end
		local naeeym2 = IT("BillboardGui",CHARACTER)
		naeeym2.Size = UD2(0,100,0,40)
		naeeym2.StudsOffset = Vector3.new(0,2,0)
		naeeym2.Adornee = HEAD
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Legacy"
		tecks2.TextSize = 15
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = Color3.new(1,1,1)
		tecks2.TextStrokeColor3 = Color3.new(0,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)
		for i = 1,string.len(Text),1 do
			if naeeym2.Parent ~= CHARACTER then 
				break
			end
			NewSound({ID = 418252437,PARENT = HEAD,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			tecks2.Text = string.sub(Text,1,i)
			wait(Timer)
		end
		wait(1)
		naeeym2:Destroy()
	end)
	chat()
end

function SpawnPuddle(POSITION,IGNR,GOO)
	local HIT,POS,NOR = Raycast(POSITION, CFrame.new(POSITION,POSITION-Vector3.new(0,1,0)).lookVector, 12, {IGNR,CHARACTER})
	if HIT then
		coroutine.resume(coroutine.create(function()
			local GOREPART = CreatePart(3, Effects, "Slate", 0, 1, "Pearl", "Gore", VT(3,0,3), true)
			local SURFACE = script.PuddleSurface:Clone()
			SURFACE.Parent = GOREPART
			if GOO == true then
				SURFACE.Image.ImageColor3 = C3(0,0,0)
			end
			GOREPART.CFrame = CFrame.new(POS,POS+NOR)*CFrame.Angles(math.rad(-90),math.rad(math.random(0,360)),0)
			for i = 1, math.random(25,65) do
				Swait()
				GOREPART.Size = GOREPART.Size + Vector3.new(0.1,0,0.1)
			end
			wait(math.random(10,25)/50)
			for i = 1, 25 do
				Swait()
				SURFACE.Image.ImageTransparency = SURFACE.Image.ImageTransparency + 1/25
			end
			GOREPART:Remove()
		end))
	end
end

function Dismember(MAN,DOWHAT)
	if DOWHAT == "Ragdoll" then
		local HUM = MAN:FindFirstChildOfClass("Humanoid")
		if HUM then

		end
	else
		local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
		local HED = MAN:FindFirstChild("Head")
		if TORSO and HED then
			
		end
	end
end

function Speak(ID)
	local S = NewSound({ID = ID,PARENT = HEAD,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 300,EMITTERSIZE = 35,PLAYING = false,PLAYONREMOVE = false,DOESDEBRIS = true})
	script.ChorusSoundEffect:Clone().Parent = S
	script.Pitch:Clone().Parent = S
	S:Play()
	Debris:AddItem(S,S.TimeLength+5)
end

--//====================================================\\--
--||                     CHARACTER
--\\====================================================//--

local ARMOR = IT("Model",CHARACTER)
ARMOR.Name = "Goner"
HEAD.Size = VT(1,1,1)
NECK.Parent = TORSO
local PARTS = {}
local BITSS = {}
for index, CHILD in pairs(CHARACTER:GetChildren()) do
	if CHILD:IsA("BasePart") then
		BITS = Instance.new("ParticleEmitter")
		BITS.Name = "Bits"
		BITS.Speed = NumberRange.new(0, 0)
		BITS.Rotation = NumberRange.new(0, 359)
		BITS.Color = ColorSequence.new(Color3.new(0.0901961, 0.0862745, 0.156863),Color3.new(0.0901961, 0.0862745, 0.156863))
		BITS.Texture = "rbxasset://textures/particles/fire_main.dds"
		BITS.Transparency = NumberSequence.new(1,0.6593406200408936,0.39560437202453613,0.2252746820449829,0.23076921701431274,0.43406593799591064,1)
		BITS.ZOffset = -1
		BITS.Size = NumberSequence.new(0.12499988079071045,0)
		BITS.Acceleration = Vector3.new(0, 5, 0)
		BITS.Lifetime = NumberRange.new(0.20000000298023224, 1)
		BITS.Rate = 65
		BITS.RotSpeed = NumberRange.new(-25, 25)
		BITS.Parent = CHILD
		BITS.Enabled = true
		table.insert(BITSS, BITS)
	end
end
for _, c in pairs(CHARACTER:GetDescendants()) do
	if c:IsA("BasePart") then
		c.Locked = false
	end
end
local SWORD = Instance.new("Part", CHARACTER); do
	pcall(function()
		SWORD.CastShadow = true
		SWORD.Color = Color3.fromRGB(0,0,0)
		SWORD.Material = Enum.Material.Slate
		SWORD.Size = Vector3.new(2, 5.925, 0.25)
		SWORD.CanCollide = false
		SWORD.CanQuery = true
		SWORD.CanTouch = true
		SWORD.Massless = true
	end)
	local Mesh = Instance.new("SpecialMesh", SWORD)
	Mesh.MeshId = "rbxassetid://500489601"
	Mesh.Scale = Vector3.new(0.01,0.01,0.01)
end

local Attachment1 = Instance.new("Attachment")
Attachment1.Position = Vector3.new(-0.2, 2.55, 0)
Attachment1.Parent = SWORD
local Attachment2 = Instance.new("Attachment")
Attachment2.Position = Vector3.new(-0.3, -0.65, 0)
Attachment2.Parent = SWORD

local GRIPC0 = CF(0,-0.9,0)*ANGLES(RAD(90),RAD(90),0)
local HOLD = IT("ManualWeld")
HOLD.Part0 = RIGHTARM
HOLD.Part1 = SWORD
HOLD.C0 = GRIPC0
HOLD.C1 = CF(0,-SWORD.Size.Y/3,0)
HOLD.Parent = RIGHTARM
HOLD.Name = "GripWeld"
local TRAIL = Instance.new("Trail"); do
	pcall(function()
		TRAIL.Attachment0 = Attachment1
		TRAIL.Attachment1 = Attachment2
		TRAIL.Color = ColorSequence.new(Color3.new(0.745098, 0, 0.0117647),Color3.new(0, 0, 0))
		TRAIL.Enabled = false
		TRAIL.Texture = "rbxassetid://1978704853"
		TRAIL.TextureLength = 0.625
		TRAIL.Transparency = NumberSequence.new(0,1)
		TRAIL.MinLength = 0
		TRAIL.Lifetime = 0.23000000417232513
		TRAIL.WidthScale = NumberSequence.new(2,2)
		TRAIL.Parent = SWORD
	end)
end
local Hat = CHARACTER:FindFirstChild("K2")
--local Bullet = Global.RealChar:FindFirstChild("Bullet")
if Hat then
	SWORD.Transparency = 1
	Hat.Handle:BreakJoints()
	Global.AlignPart(Hat.Handle,SWORD, Vector3.new(0,-0.5,0), Vector3.new(-0, 0, -117))
end
--[[
if Bullet then
	if Bullet:FindFirstChild("AntiRotate") then
		Bullet:FindFirstChild("AntiRotate"):Destroy()
	end
	Global.PartDisconnected = true
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local RootTo = SWORD
	if Hat then
		RootTo = Hat.Handle
	end
	local Pos = Instance.new("BodyPosition")
	Pos.MaxForce = Vector3.new(1,1,1)*math.huge
	Pos.P = 25000
	Pos.D = 125
	Pos.Name = "Movement"
	Pos.Position = Bullet.Position
	Pos.Parent = Bullet
	local Flinger = Instance.new("BodyAngularVelocity")
	Flinger.MaxTorque = Vector3.new(1,1,1)*math.huge
	Flinger.P = math.huge
	Flinger.AngularVelocity = Vector3.new(5000,5000,5000)
	Flinger.Name = "Flinger"
	Flinger.Parent = Bullet
	table.insert(Events, game:GetService("RunService").PostSimulation:Connect(function()
		Pos.Position = RootTo.Position
	end))
end]]--
local SOUND_SNAP = 150315649
local SUBMERGED = false
table.insert(PARTS,SWORD)

--//====================================================\\--
--||                     ABILITIES
--\\====================================================//--

function Slash()
	ATTACKING = true
	for i=0, 0.2, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(180), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 2 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	end
	TRAIL.Enabled = true
	NewSound({ID = 211059653,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
	for i=0, 0.1, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(0), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 0.65 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 0.75 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(-5), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	end
	for index, CHILD in pairs(workspace:GetChildren()) do
		if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT2 = HUMAN.Torso
			if ROOT2 and HUMAN.Health > 0 then
				if (ROOT2.Position - ROOT.CFrame*CF(0,0,-2).p).Magnitude < 4.5 then
					local HEAD = CHILD:FindFirstChild("Head")
					if HEAD then
						local FACE = HEAD:FindFirstChild("face")
						if FACE then
							FACE.Texture = "http://www.roblox.com/asset/?id=145854465"
							FACE.Transparency = 0.5
						end
					end
					Dismember(CHILD,"Ragdoll")
					Dismember(CHILD,"Head")
					NewSound({ID = 264486467,PARENT = ROOT2,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					for i = 1, 7 do
						OofOuchBlood(ROOT2.Position,CF(ROOT2.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
					end
					coroutine.resume(coroutine.create(function()
						for i = 1, 25 do
							SpawnPuddle(ROOT2.Position,CHILD,false)
							Swait()
						end
					end))
				end
			end
		end
	end
	for i=0, 0.3, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(0), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 0.65 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 0.75 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(-5), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	end
	TRAIL.Enabled = false
	ATTACKING = false
end

function Execute(INPUT)
	local TARGET = nil
	local DIST = 6
	for index, CHILD in pairs(workspace:GetChildren()) do
		if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT2 = HUMAN.Torso
			if ROOT2 and HUMAN.Health > 0 then
				if (ROOT2.Position - ROOT.Position).Magnitude < DIST then
					TARGET = CHILD
					DIST = (ROOT2.Position - ROOT.Position).Magnitude
				end
			end
		end
	end
	if TARGET and (SUBMERGED == false or ((INPUT == "x" or INPUT == "z" or INPUT == "c") and SUBMERGED == true)) then
		local DedFace = function()
			local HEAD = TARGET:FindFirstChild("Head")
			if HEAD then
				local FACE = HEAD:FindFirstChild("face")
				if FACE then
					FACE.Texture = "http://www.roblox.com/asset/?id=145854465"
					FACE.Transparency = 0.5
				end
			end
		end
		local TARGETSTATIC = nil
		if game:GetService("Players"):GetPlayerFromCharacter(TARGET) then
			TARGETSTATIC = script.GonerStatic:Clone()
			TARGETSTATIC.Parent = game:GetService("Players"):GetPlayerFromCharacter(TARGET).PlayerGui
			local SOUND = NewSound({ID = 2737898305,PARENT = TARGETSTATIC.Script,VOLUME = 3,PITCH = 1,LOOP = true,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = false})
			SOUND.Name = "Static"
			Swait()
			TARGETSTATIC.Script.Disabled = false
		end
		local STATIC = script.GonerStatic:Clone()
		STATIC.Parent = PLAYER.PlayerGui
		local SOUND = NewSound({ID = 2737898305,PARENT = STATIC.Script,VOLUME = 3,PITCH = 1,LOOP = true,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = false})
		SOUND.Name = "Static"
		Swait()
		STATIC.Script.Disabled = false
		local TARGETTORSO = TARGET:FindFirstChild("Torso") or TARGET:FindFirstChild("UpperTorso")
		local GRABA = IT("Attachment",LEFTARM)
		GRABA.Position = VT(0,-1.5,0)
		local GRABB = IT("Attachment",TARGETTORSO)
		local GRAB = IT("BallSocketConstraint",GRABA)
		GRAB.Attachment0 = GRABA
		GRAB.Attachment1 = GRABB
		local GYRO = IT("BodyGyro")
		GYRO.D = 20
		GYRO.P = 5000
		GYRO.MaxTorque = VT(0,4000000,0)
		GYRO.CFrame = CF(TARGETTORSO.Position,ROOT.Position)
		GYRO.Parent = TARGETTORSO
		ATTACKING = true
		ROOT.Anchored = true
		if INPUT == "z" then
			for i=0, 1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(85), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = true
			NewSound({ID = 211059653,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i=0, 0.1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(35), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(85), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			CameraShake(ROOT.Position,4.6,15,25)
			Dismember(TARGET,"Ragdoll")
			Dismember(TARGET,"Head")
			DedFace()
			GYRO:Remove()
			NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i = 1, 7 do
				OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
			end
			coroutine.resume(coroutine.create(function()
				for i = 1, 25 do
					SpawnPuddle(TARGETTORSO.Position,TARGET,false)
					Swait()
				end
			end))
			for i=0, 0.9, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-1)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(35), RAD(0), RAD(-90)) * ANGLES(RAD(25), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(85), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = false
		elseif INPUT == "x" then
			for i=0, 1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(125), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = true
			NewSound({ID = 536642316,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i=0, 0.1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.35, -0.85) * ANGLES(RAD(-25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(125), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			CameraShake(ROOT.Position,4.6,15,25)
			Dismember(TARGET,"Ragdoll")
			Dismember(TARGET,"Legs")
			DedFace()
			GYRO:Remove()
			NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i = 1, 7 do
				OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
			end
			coroutine.resume(coroutine.create(function()
				for i = 1, 25 do
					SpawnPuddle(TARGETTORSO.Position,TARGET,false)
					Swait()
				end
			end))
			for i=0, 0.9, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-1)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.35, -0.85) * ANGLES(RAD(-25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(125), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = false
		elseif INPUT == "c" then
			if SUBMERGED == false then
				GRABA:Remove()
				GRABB:Remove()
				TARGETTORSO.Anchored = true
				local DEAD = false
				Dismember(TARGET,"Ragdoll")
				coroutine.resume(coroutine.create(function()
					repeat
						Swait()
						TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame,ROOT.CFrame*CF(0,-3,-1.5) * ANGLES(RAD(-90), RAD(0), RAD(0)),0.3)
					until DEAD == true
					coroutine.resume(coroutine.create(function()
						for i = 1, 25 do
							SpawnPuddle(TARGETTORSO.Position+VT(0,1,0),TARGET,false)
							Swait()
						end
					end))
					DedFace()
				end))
				for i=0, 1.5, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-5)) * CF(0,-0.75,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
				end
				CameraShake(ROOT.Position,4.6,15,25)
				Dismember(TARGET,"LeftArm")
				local ARM = TARGET:FindFirstChild("Left Arm") or TARGET:FindFirstChild("LeftUpperArm")
				if ARM then
					local BV = IT("BodyVelocity")
					BV.MaxForce = BV.MaxForce * 500
					BV.Velocity = CF(ARM.Position,ROOT.Position+VT(0,2,0)).lookVector*65
					BV.Parent = ARM
					Debris:AddItem(BV,0.05)
				end
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				for i=0, 0.3, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 1) * ANGLES(RAD(90), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				for i=0, 0.3, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.5) * ANGLES(RAD(90), RAD(0), RAD(85)) * CF(0,-1.25,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
				end
				CameraShake(ROOT.Position,4.6,15,25)
				Dismember(TARGET,"RightArm")
				local ARM = TARGET:FindFirstChild("Right Arm") or TARGET:FindFirstChild("RightUpperArm")
				if ARM then
					local BV = IT("BodyVelocity")
					BV.MaxForce = BV.MaxForce * 500
					BV.Velocity = CF(ARM.Position,ROOT.Position+VT(0,2,0)).lookVector*65
					BV.Parent = ARM
					Debris:AddItem(BV,0.05)
				end
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				DEAD = true
				for i=0, 0.3, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 1) * ANGLES(RAD(90), RAD(0), RAD(85)) * CF(0,0.75,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
			else
				TARGETTORSO.Anchored = true
				local POS = ROOT.Position
				Dismember(TARGET,"Ragdoll")
				TARGET.Parent = Effects
				for i = 1, 60 do
					Swait()
					SpawnPuddle(TARGETTORSO.Position,TARGET,true)
					TARGETTORSO.CFrame = TARGETTORSO.CFrame*CF(0,-0.1,0)
				end
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,50,-1).p,3)
				end
				TARGET:Remove()
			end
		elseif INPUT == "v" then
			GRABA:Remove()
			GRABB:Remove()
			TARGETTORSO.Anchored = true
			local DEAD = false
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame,ROOT.CFrame*CF(0,-3,-1.2) * ANGLES(RAD(-90), RAD(0), RAD(0)),0.3)
				until DEAD == true
				DedFace()
				Dismember(TARGET,"Ragdoll")
				coroutine.resume(coroutine.create(function()
					for i = 1, 25 do
						SpawnPuddle(TARGETTORSO.Position+VT(0,1,0),TARGET,false)
						Swait()
					end
				end))
			end))
			for i=0, 0.5, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0.3, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(20)), 1.5 / ANIM_SPEED)
			end
			for i = 1, MRANDOM(6,12) do
				for i=0, 0.5, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0.3, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(20)), 1.5 / ANIM_SPEED)
				end
				for i=0, 0.1, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
				end
				CameraShake(ROOT.Position,4.6,15,25)
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 1,PITCH = 1.25,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
				end
				for i=0, 0.2, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
				end
			end
			DEAD = true
			for i=0, 0.6, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
			end
		end
		GYRO:Remove()
		if (INPUT ~= "c" or SUBMERGED == false) then
			Speak(2291326656)
		end
		STATIC:Remove()
		if TARGETSTATIC then
			TARGETSTATIC:Remove()
		end
		GRABA:Remove()
		GRABB:Remove()
		ROOT.Anchored = false
		ATTACKING = false
	end
end

function Shriek()
	ROOT.Anchored = true
	ATTACKING = true
	for i=0, 0.15, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.2) * ANGLES(RAD(0), RAD(0), RAD(10)), 2 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(5), RAD(0)), 2 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.7, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 2 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(45), RAD(-10), RAD(25)) * LEFTSHOULDERC0, 2 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.8, -0.4) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 2 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.8, -0.4) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(20)), 2 / ANIM_SPEED)
	end
	local FACE = IT("Attachment",HEAD)
	Speak(2466752906)
	CameraShake(ROOT.Position,65,8,150)
	for i=0, 1.75, 0.1 / ANIM_SPEED do
		Swait()
		for index, CHILD in pairs(workspace:GetChildren()) do
			if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER then
				local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
				local ROOT2 = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if ROOT2 and HUMAN.Health > 0 and CHILD:FindFirstChild("Head") then
					if (ROOT2.Position - ROOT.Position).Magnitude < 45 then
						local HED = CHILD:FindFirstChild("Head")
						Dismember(CHILD,"Ragdoll")
						for i = 1, 7 do
							OofOuchBlood(HED.Position,CF(HED.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
						end
						NewSound({ID = 264486467,PARENT = ROOT2,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						coroutine.resume(coroutine.create(function()
							for i = 1, 8 do
								SpawnPuddle(ROOT2.Position+VT(0,1,0),CHILD,false)
								Swait()
							end
						end))
						HED:Remove()
					end
				end
			end
		end
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25+MRANDOM(-5,5)), RAD(5+MRANDOM(-5,5)), RAD(MRANDOM(-5,5))), 0.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(45+MRANDOM(-5,5)), RAD(-10+MRANDOM(-5,5)), RAD(-25+MRANDOM(-5,5))) * ANGLES(RAD(-75), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
	end
	Debris:AddItem(FACE,1)
	ATTACKING = false
	ROOT.Anchored = false
end

function Speech(INPUT)
	ATTACKING = true
	if INPUT == "t" then
		--Speak(2316600989)
	elseif INPUT == "y" then
		--Speak(2290634374)
	elseif INPUT == "u" then
		--Speak(2291325961)
	end
	ATTACKING = false
end

--//====================================================\\--
--||                       WRAP
--\\====================================================//--

local clicked
table.insert(Events, MOUSE.Button1Down:Connect(function(Mouse)
	if ATTACKING == false then
		if SUBMERGED == false then
			MOUSEHOLD = true
			Slash()
		end
	end
end))
table.insert(Events, MOUSE.Button1Up:Connect(function(Mouse)
	MOUSEHOLD = false
end))
table.insert(Events, MOUSE.KeyUp:Connect(function(V1)
	clicked = false
	KEYHOLD = false
end))
table.insert(Events, MOUSE.KeyDown:Connect(function(V2)
	clicked = true
	if ANIM ~= "Sit" then
		if ATTACKING == false then
			if clicked then
				KEYHOLD = true
				if V2 == "e" then

				elseif V2 == "z" or V2 == "x" or V2 == "c" or V2 == "v" then
					Execute(V2)
				elseif V2 == "g" and SUBMERGED == false then
					Shriek()
				elseif V2 == "q" then
					if SUBMERGED == false then
						SUBMERGED = true
					else
						ROOT.Anchored = false
						SUBMERGED = false
						ROOT.CFrame = ROOT.CFrame*CF(0,3,0)
					end
				elseif V2 == "w" and SUBMERGED == true and ATTACKING == false then
					repeat
						ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(0,0,-0.5)
						Swait()
					until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
				elseif V2 == "s" and SUBMERGED == true and ATTACKING == false then
					repeat
						ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(0,0,0.25)
						Swait()
					until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
				elseif V2 == "a" and SUBMERGED == true and ATTACKING == false then
					repeat
						ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(-0.1,0,0)
						Swait()
					until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
				elseif V2 == "d" and SUBMERGED == true and ATTACKING == false then
					repeat
						ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(0.1,0,0)
						Swait()
					until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
				elseif V2 == "t" or V2 == "y" or V2 == "u" then

				end
			end
		end
	end
end))
local M = NewSound({ID = 2598782592,PARENT = ROOT,VOLUME = 1.5,PITCH = 0.4,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
M.Name = "BGM_MUSIC"

HUM.PlatformStand = false
HUM.MaxHealth = 3000
HUM.Health = 3000
local TWITCH = 0
local Eventussy
Eventussy = game:GetService("RunService").Stepped:Connect(function()
	if Global.Stopped == true then for _,v in pairs(BITSS) do v:Destroy() end M:Destroy() Eventussy:Disconnect() end
	Swait()
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
	local HITFLOOR,HITPOS = Raycast(ROOT.Position, (CF(ROOT.Position, ROOT.Position + VT(0, -1, 0))).lookVector, 4+HUM.HipHeight, CHARACTER)
	local WALKSPEEDVALUE = 10
	local SITTING = HUM.Sit
	if ANIM == "Walk" and TORSOVELOCITY > 1 and ATTACKING == false and SITTING == false then
		ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, -0.015 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
		NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - HEAD.RotVelocity.Y / 30), 0.2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 0.875 - 0.3 * SIN(SINE / WALKSPEEDVALUE), -0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 0.875 + 0.3 * SIN(SINE / WALKSPEEDVALUE), 0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or ATTACKING == true or SITTING == true then
		ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
	end
	if SITTING == false then
		if HITFLOOR then
			if SUBMERGED == false then
				HUM.JumpPower = 50
				HUM.WalkSpeed = 8
				if TORSOVELOCITY < 1 and HITFLOOR ~= nil then
					ANIM = "Idle"
					if MRANDOM(1,15) == 1 and ATTACKING == false then
						SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
					end
					if ATTACKING == false then
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 0.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
					end
				elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
					ANIM = "Walk"
					if MRANDOM(1,5) == 1 and ATTACKING == false then
						SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
					end
					if ATTACKING == false then
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 1 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5-0.015 * COS(SINE / (WALKSPEEDVALUE / 2)), 0) * ANGLES(RAD(25), RAD(20), RAD(5)) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(5)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.45, 0.5-0.015 * SIN(SINE / (WALKSPEEDVALUE / 2)), -0.5) * ANGLES(RAD(95), RAD(-5), RAD(-5)) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(-15)), 2 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(15)), 2 / ANIM_SPEED)
					end
				end
			elseif SUBMERGED == true then
				HUM.JumpPower = 0
				HUM.WalkSpeed = 0
				MOUSEPOS = Mouse.Hit.Position
				if MRANDOM(1,2) == 1 then
					SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
				end
				ANIM = "Submerged"
				ROOT.Anchored = true
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1.5) * ANGLES(RAD(90), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(90)), 0.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
				end
				ROOT.CFrame = CF(HITPOS+VT(0,0.05,0))*ANGLES(0,RAD(ROOT.Orientation.Y),0)
			end
		else
			SUBMERGED = false
			ANIM = "Midair"
			if ATTACKING == false then
				ROOT.Anchored = false
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1 / ANIM_SPEED)
			end
		end
	else
		SUBMERGED = false
		ANIM = "Sit"
		if ATTACKING == false then
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.65, 0) * ANGLES(RAD(50), RAD(10), RAD(-45))*CF(0,-0.25,0) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.65, 0) * ANGLES(RAD(50), RAD(-10), RAD(45))*CF(0,-0.25,0) * LEFTSHOULDERC0, 1.25 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.25, -1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.25 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.25, -1) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.25 / ANIM_SPEED)
		end
	end
	if TWITCH > 0 then
		TWITCH = TWITCH - 1
		NECK.C0 = NECK.C0 * ANGLES(RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,5)))
	else
		if MRANDOM(1,25) == 1 then
			TWITCH = MRANDOM(2,12)
		end
	end
end)
