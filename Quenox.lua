
local Global = (getgenv and getgenv()) or shared
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/FunctionPack.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/AudioPack.lua"))()
local getsynasset = getsynasset or getcustomasset or function() warn("no getcustomasset/getsynasset") end
local Events = Global.KryptonData['Global Events']
Global.AntiScript()


local script = game:GetObjects("rbxassetid://10259776706")[1]

local math=setmetatable({random=function(Arg1,Arg2,DIV) DIV=DIV or 1 return math.random(Arg1*DIV,Arg2*DIV)/DIV end,CosSin=function(Arg) return (math.sin(Arg/2)*math.cos(Arg/2)) end,},{__index=math,})
local CFrame=setmetatable({Angles=function(Arg1,Arg2,Arg3,Angles) if not Angles then return CFrame.Angles(Arg1,Arg2,Arg3) else return CFrame.Angles(math.rad(Arg1),math.rad(Arg2),math.rad(Arg3)) end end,},{__index=CFrame,})
local Instance=setmetatable({new=function(type,args) local instance=Instance.new(type) if args then if string.lower(typeof(args)) == "instance" then instance.Parent=args elseif string.lower(typeof(args))=="table" then for i,v in pairs(args) do pcall(function() instance[i]=v end) end end end return instance end,Remove=function(Instance_,Time) if string.lower(typeof(Instance_))=="instance" then game:GetService("Debris"):AddItem(Instance_,Time or 0) elseif string.lower(typeof(Instance_))=="table" then table.foreach(Instance_,function(_,v) game:GetService("Debris"):AddItem(v,Time or 0) end) end end},{__index=Instance,})
local Player,UIS,Mouse,CrossClient=game.Players.LocalPlayer,nil,nil,nil
do
	local Client=script.Data.Scripts.SClient
	local Rem=Client:WaitForChild("Input",5)
	local InfoRef=Rem:WaitForChild("InfoRef",5)
	local function NewEv(MultipleFuncs)
		local Table={FE=true}
		if MultipleFuncs then
			Table.Funcs={}
		end
		Table.Connect=function(self,Name,Func) -- t:Connect(nil,...) nil - skip indexing and keep it as a rewritable function
			local T={}
			local TableFuncs=Name~=nil
			if not TableFuncs then
				self.Function=Func
			else
				self.Funcs[Name]=Func
			end
			T.Disconnect=function(self)
				if not TableFuncs then
					self.Function=nil
				else
					self.Funcs[Name]=nil
				end
			end
			T.disconnect=T.Disconnect
			return T
		end
		Table.connect=Table.Connect
		return Table
	end
	CrossClient={Events=NewEv(true),Functions=NewEv(true)}
	UIS={InputBegan=NewEv(),InputEnded=NewEv()}
	Mouse={Hit=CFrame.new(),Target=CFrame.new(),Origin=CFrame.new(),TargetSurface=Vector3.new()}
	local function FireEUIS(self,Name,...)
		local F=UIS[Name]
		if F and F.FE then
			if F.Function then
				F.Function(...)
			elseif F.Funcs then
				for i,v in pairs(F.Funcs) do
					v(...)
				end
			end
		end
	end
	CrossClient.AddFunction=function(self,Type,Name,Function)
		if not self then return end
		if type(Name)=="function" then Function=Name Name=nil end
		assert(CrossClient[Type.."s"],"unsupported event type")
		if Name then
			CrossClient[Type.."s"][Name]=Function
		else
			table.insert(CrossClient[Type.."s"],Function)
		end
	end
	CrossClient.RemoveFunction=function(self,Type,Name)
		if not self then return end
		assert(CrossClient[Type.."s"],"unsupported event type")
		assert(Name,"no event name given")
		CrossClient[Type.."s"][Name]=nil
	end
	CrossClient.FireClient=function(self,Type,Name,...)
		if not self then return end
		assert(CrossClient[Type.."s"],"unsupported event type")
		assert(Name,"no event name given")
		if Type=="Event" then
			return Rem:FireClient(Player,Name,...)
		elseif Type=="Function" then
			return InfoRef:InvokeClient(Player,Name,...)
		end
	end
	UIS.FireEv=FireEUIS
	InfoRef.OnServerInvoke=function(PLR,...)
		if PLR~=Player then return end
		local Args={...}
		if Args[1]=="R" then
			return CrossClient.Functions[Args[2]](Args[3])
		end
	end
	table.insert(Events,Rem.OnServerEvent:Connect(function(PLR,IO,L,...)
		if PLR~=Player then return end
		local Args={...}
		if #Args>0 then
			if Args[1]=="S" then
				local T={} for i,v in pairs({...}) do if i>2 then table.insert(T,v) end end
				return CrossClient.Events[Args[2]](unpack(#T>0 and T or {1}))
			end
		end
		if IO.Mouse then
			Mouse.Hit=IO.Hit
			Mouse.Target=IO.Target
			Mouse.Origin=IO.Origin
			Mouse.TargetSurface=IO.TargetSurface
		else
			if IO.UserInputState==Enum.UserInputState.Begin then
				UIS:FireEv("InputBegan",IO,L)
			else
				UIS:FireEv("InputEnded",IO,L)
			end
		end
	end))
	--Client.Parent=Player.PlayerGui
	Client.Disabled=false
end


local ins=Instance.new
local v3=Vector3.new
local v2=Vector2.new
local cf=CFrame.new
local angles=CFrame.Angles
local ud=UDim.new
local ud2=UDim2.new
local c3=Color3.new
local rgb=Color3.fromRGB
local hsv=Color3.fromHSV
local bc=BrickColor.new
local bcRandom=BrickColor.Random
local palette=BrickColor.palette
local cs=ColorSequence.new
local ns=NumberSequence.new
local nsk=NumberSequenceKeypoint.new
local nr=NumberRange.new
local random=math.random
local rad=math.rad
local sin=math.sin
local cos=math.cos
local tan=math.tan
local cotan=math.CosSin
local floor=math.floor
local pi=math.pi
local abs=math.abs
local sqrt=math.sqrt
local clamp=math.clamp
local ray=Ray.new
local huge=math.huge
--// Basic functions
function Tween(Object,Args,Info)
	if Object and Args then
		Info = Info or TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0)
		if typeof(Info) == "table" then Info = TweenInfo.new(unpack(Info)) end
		game:GetService("TweenService"):Create(Object,Info,Args):Play()
	end
end
function Sound(Id,Volume,Pitch,Parent,MaxDistance,EmitterSize,Looped)
	if Id==0 then return end
	local S=ins("Sound",{Volume=Volume or 1,Pitch=Pitch or 1,MaxDistance=MaxDistance or 500,EmitterSize=EmitterSize or 5,Looped=Looped or false,SoundId="rbxassetid://"..Id,Parent=Parent})
	S:Play()
	coroutine.wrap(function()
		if S.Looped then return end
		if S.IsLoaded then
			Instance.Remove(S,S.TimeLength/S.Pitch)
		else
			table.insert(Events,S.Loaded:Connect(function()
				Instance.Remove(S,S.TimeLength/S.Pitch)
			end))
		end
	end)()
	return S
end
function Raycast(Origin,Direction,Blacklist,MaxDistance,IgnoreWater)
	return workspace:FindPartOnRayWithIgnoreList(ray(Origin,Direction.Unit*MaxDistance),Blacklist or {},false,IgnoreWater)
end
--// Setup 1
for i,v in pairs(Player.Character:GetDescendants()) do
	if (v.Name=="Animate" and v:IsA("LocalScript")) or v:IsA("Animator") then
		Instance.Remove(v)
	end
end
--// Character indexing
local LockWS,LockJP=false,false
local Type="R6"
Char,char=Player.Character,Player.Character
local Hum,hum=Char:FindFirstChildOfClass("Humanoid"),Char:FindFirstChildOfClass("Humanoid")
local hrp,HRP=Char.HumanoidRootPart,Char.HumanoidRootPart
local h,t,ra,la,rl,ll
local nec,rs,ls,rh,lh,rutj
local necC0,necC1=cf(),cf()
local rutjC0,rutjC1=cf(),cf()
local rsC0,rsC1=cf(),cf()
local lsC0,lsC1=cf(),cf()
local rhC0,rhC1=cf(),cf()
local lhC0,lhC1=cf(),cf()
local h,ut,lt,rua,rla,rh,lua,lla,lh,rul,rll,rf,lul,lll,lf
local CFs={}
local Joints={}
local jointyjointy = {}
BLOODPARENT=workspace.Terrain
if Type=="R6" then
	h,t,ra,la,rl,ll=char.Head,char.Torso,char["Right Arm"],char["Left Arm"],char["Right Leg"],char["Left Leg"]
	nec,rutj,rs,ls,rh,lh=t.Neck,hrp.RootJoint,t["Right Shoulder"],t["Left Shoulder"],t["Right Hip"],t["Left Hip"]
	necC0,necC1=cf(0,t.Size.Y/2,0),cf(0,-h.Size.Y/2,0)
	rutjC0,rutjC1=cf(0,0,0),cf(0,0,0)
	rsC0,rsC1=cf(t.Size.X/2,t.Size.Y/4,0),cf(-ra.Size.X/2,ra.Size.Y/4,0)
	lsC0,lsC1=cf(-t.Size.X/2,t.Size.Y/4,0),cf(la.Size.X/2,la.Size.Y/4,0)
	rhC0,rhC1=cf(t.Size.X/4,-t.Size.Y/2,0),cf(0,rl.Size.Y/2,0)
	lhC0,lhC1=cf(-t.Size.X/4,-t.Size.Y/2,0),cf(0,ll.Size.Y/2,0)
	Instance.Remove({rutj,rs,ls,rh,lh})
	nec=ins("Motor",{Name="Neck",Part0=t,Part1=h,C0=necC0,C1=necC1,Parent=t,})
	table.insert(jointyjointy, nec)
	rutj=ins("Motor",{Name="RootJoint",Part0=hrp,Part1=t,C0=rutjC0,C1=rutjC1,Parent=hrp,})
	table.insert(jointyjointy, rutj)
	rs=ins("Motor",{Name="Right Shoulder",Part0=t,Part1=ra,C0=rsC0,C1=rsC1,Parent=t,})
	table.insert(jointyjointy, rs)
	ls=ins("Motor",{Name="Left Shoulder",Part0=t,Part1=la,C0=lsC0,C1=lsC1,Parent=t,})
	table.insert(jointyjointy, ls)
	rh=ins("Motor",{Name="Right Hip",Part0=t,Part1=rl,C0=rhC0,C1=rhC1,Parent=t,})
	table.insert(jointyjointy, rh)
	lh=ins("Motor",{Name="Left Hip",Part0=t,Part1=ll,C0=lhC0,C1=lhC1,Parent=t,})
	table.insert(jointyjointy, lh)
elseif Type=="R15" then
	h,hrp=Char.Head,Char.HumanoidRootPart
	ut,lt=Char.UpperTorso,Char.LowerTorso
	rua,rla,rh=Char.RightUpperArm,Char.RightLowerArm,Char.RightHand
	lua,lla,lh=Char.LeftUpperArm,Char.LeftLowerArm,Char.LeftHand
	rul,rll,rf=Char.RightUpperLeg,Char.RightLowerLeg,Char.RightFoot
	lul,lll,lf=Char.LeftUpperLeg,Char.LeftLowerLeg,Char.LeftFoot
	for i,v in pairs(Char:GetDescendants()) do
		if v:IsA("Motor") then
			local CFData={C0=cf(v.C0.Position),C1=cf(v.C1.Position),Part0=v.Part0,Part1=v.Part1,Parent=v.Parent}
			local Joint=ins("Motor",{C0=CFData.C0,C1=CFData.C1,Part0=CFData.Part0,Part1=CFData.Part1,Name=v.Name,Parent=CFData.Parent,})
			CFs[v.Name]=CFData
			Joints[v.Name]=setmetatable({Object=Joint,Link=CFData,Remove=function(Time) Instance.Remove(Joint,Time) end},{__index=Joint,__newindex=function(self,k,v) Joint[k]=v end})
			v.Parent=nil
			Instance.Remove(v)
		end
	end
end
--// Variables
local Mode,Step="E","R"
local Using,Muted,Equipped,Sitting,UniqueStance=false,false,false,false,true
local Combo,EquippedPool,LastSitTick,LastLevTick=1,0,tick(),tick()
local RB,LB={},{}
local RBT,LBT=1,1
local Sine,Change=0,1
local WS,JP=16,50
local TimePos=0
local WCF=cf()
local MovingVel
local StepSounds={Glass=4085889170,Plastic=2812418291,SmoothPlastic=2812418291,Neon=2812418291,ForceField=2812418291,Metal=2812417769,DiamondPlate=2812417769,CorrodedMetal=2812417769,Foil=2812417769,Sand=619188333,Grass=619188333,Slate=941640049,Concrete=941640049,Granite=941640049,Pebble=941640049,Marble=941640049,Cobblestone=941640049,Brick=941640049,Water=1110489303,Wood=2812419402,WoodPlanks=2812419402,Fabric=133705377,Snow=619083295}
local Modules,Models=script.Data.Scripts.Modules,script.Data.Models
local SBeam,ThroatCut,BC,LevIdleEff=Models.SBeam:Clone(),Models.ThroatCut:Clone(),Models.BloodCloudFX:Clone(),Models.LevIdleEff:Clone()
local Modes = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/LuaStuff/main/QuenoxConvert/Modes.lua"))()
local Anims = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/LuaStuff/main/QuenoxConvert/Animations.lua"))()
local Damage = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/LuaStuff/main/QuenoxConvert/Damage.lua"))()
local Ragdoll = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/LuaStuff/main/QuenoxConvert/Ragdoll.lua"))()
local Blood = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/LuaStuff/main/QuenoxConvert/Blood.lua"))()
local BN = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/LuaStuff/main/QuenoxConvert/BN.lua"))()
local C1,C2=Modes.Modes[Mode].Colours.Ring.Prim,Modes.Modes[Mode].Colours.Ring.Sec
local ModeVal,ModePos=script.Data.Scripts.SClient.Values.Mode,script.Data.Scripts.SClient.Values.Mode.Position
--// Setup 2
Models.Parent=nil
Blood()
for i,v in pairs(Models.ArmBlood:GetChildren()) do
	local C=v:Clone()
	C.Transparency=1
	C.Parent=rl
	table.insert(RB,C)
end
for i,v in pairs(Models.ArmBlood:GetChildren()) do
	local C=v:Clone()
	C.Transparency=1
	C.Parent=ll
	table.insert(LB,C)
end
local LevIdleEffP=ins("Part",{Size=v3(),CanCollide=false,Locked=true,Massless=true,Transparency=1,CFrame=t.CFrame,Parent=t})
local LIEPos=ins("BodyPosition",{D=500,P=25000,MaxForce=v3(huge,huge,huge),Position=t.Position,Parent=LevIdleEffP})
local LIEGyr=ins("BodyGyro",{D=500,P=25000,MaxTorque=v3(huge,huge,huge),Parent=LevIdleEffP})
local LIEAtt=ins("Attachment",{Orientation=v3(90,0,0),Parent=LevIdleEffP})
local Theme=Sound(Modes.Modes[Mode].Theme.Id,Modes.Modes[Mode].Theme.Volume,Modes.Modes[Mode].Theme.Pitch,t,150,7.5,true)
local PrepParts,Parts={W=Models.Wing:Clone(),R=Models.HalfRing:Clone()},{Ring={},WingR={},WingL={}}
local Effects=ins("Model",{Name="Effects",Parent=Char})
ins("ForceField",{Parent=char,Visible=false})
for i,v in pairs(Modes.WingSetup.Ring) do
	local P=PrepParts.R:Clone() P.Parent=t
	local W=ins("Motor6D",{Parent=t,Part0=t,Part1=P,C0=v.C0,C1=v.C1})
	Parts.Ring[i]={P,W}
end
for i,v in pairs(Modes.WingSetup.WingR) do
	local P=PrepParts.W:Clone() P.Parent=Parts.Ring.R1[1]
	local W=ins("Motor6D",{Parent=t,Part0=Parts.Ring.R1[1],Part1=P,C0=v.C0,C1=v.C1})
	Parts.WingR[i]={P,W,P.Sec}
end
for i,v in pairs(Modes.WingSetup.WingL) do
	local P=PrepParts.W:Clone() P.Parent=Parts.Ring.R2[1]
	local W=ins("Motor6D",{Parent=t,Part0=Parts.Ring.R2[1],Part1=P,C0=v.C0,C1=v.C1})
	Parts.WingL[i]={P,W,P.Sec}
end
Parts.Ring.R2[1].Size=Parts.Ring.R2[1].Size-v3(0,0,.1)
Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B
Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B
local B1,B2=Parts.Ring.R1[1].Beam,Parts.Ring.R2[1].Beam
LevIdleEff.Parent=LIEAtt
--// Functions
function PlayAnimSingle(...)
	local Joints_={nec=nec,rutj=rutj,rs=rs,ls=ls,rh=rh,lh=lh,r1=Parts.Ring.R1[2],r2=Parts.Ring.R2[2]}
	local CFs_={necC0=necC0,necC1=necC1,rutjC0=rutjC0,rutjC1=rutjC1,rsC0=rsC0,rsC1=rsC1,lsC0=lsC0,lsC1=lsC1,rhC0=rhC0,rhC1=rhC1,lhC0=lhC0,lhC1=lhC1,r1C0=Modes.WingSetup.Ring.R1.C0,r1C1=Modes.WingSetup.Ring.R1.C1,r2C0=Modes.WingSetup.Ring.R2.C0,r2C1=Modes.WingSetup.Ring.R2.C1}
	for i,v in pairs({...}) do
		if Joints_[v[1]] then
			local T={}
			table.foreach(v[2],function(i,v) T[i]=v end)
			local C0=((CFs_[v[1].."C0"] or cf(0,0,0))*(T.C0 or cf(0,0,0))) or CFs_[v[1].."C0"]
			local C1=((CFs_[v[1].."C1"] or cf(0,0,0))*((T.C1 or cf(0,0,0))):Inverse())
			for i,v in pairs(T) do if i=="C0" then T.C0=C0 elseif i=="C1" then T.C1=C1 end end
			Tween(Joints_[v[1]],T,v[3])
		end
	end
end
function PlayAnim(Table,AddFuncs)
	AddFuncs=AddFuncs or {}
	local Waits=Table.Waits
	for i=1,#Table do
		local v=Table[i]
		if i~="Waits" and Waits[i] then
			--local Values={}
			--for i,v in pairs(v) do table.insert(Values,v[3][1]) end
			--local WaitTime=math.max(unpack(Values))--Waits[i]
			local WaitTime=Waits[i]
			PlayAnimSingle(unpack(v))
			if WaitTime==1/60 then
				game:GetService("RunService").Heartbeat:Wait()
			else
				wait(WaitTime)
			end
			if AddFuncs[i] then AddFuncs[i]() end
		end
	end
end
function SoundWave(Position,Id1,Vol1,Pitch1,Duration,Magnitude,CamShake,Intensity)

end
function Switch(Key)
	if Modes.Modes[Key] and Mode~=Key then
		if Modes.Modes[Key].Exception and Modes.Modes[Key].Exception~=Mode then return end
		if Modes.Modes[Key].WL then
			if type(Modes.Modes[Key].WL)=="number" then
				if Player.UserId~=Modes.Modes[Key].WL then return end
			elseif type(Modes.Modes[Key].WL)=="table" then
				local Keep=false
				for i,v in pairs(Modes.Modes[Key].WL) do
					if Player.UserId==v then Keep=true break end
				end
				if not Keep then return end
			end
		end
		local T=Modes.Modes[Key]
		ModePos.Value=T.Pos
		ModeVal.Value=Key
		B1.Color=T.Colours.Ring.Prim=="rb" and cs(hsv(tick()/3%1,1,1),hsv(tick()/3%1,1,1)) or cs(T.Colours.Ring.Prim,T.Colours.Ring.Sec)
		B2.Color=T.Colours.Ring.Sec=="rb" and cs(hsv(tick()/3%1,1,1),hsv(tick()/3%1,1,1)) or cs(T.Colours.Ring.Sec,T.Colours.Ring.Prim)
		for i,v in pairs(Parts) do
			if i=="Ring" then
				Parts.Ring.R1[1].Color=T.Colours.Ring.Prim=="rb" and hsv(tick()/3%1,1,1) or T.Colours.Ring.Prim
				Parts.Ring.R2[1].Color=T.Colours.Ring.Sec=="rb" and hsv(tick()/3%1,1,1) or T.Colours.Ring.Sec
				Parts.Ring.R1[1].Light.Color=Parts.Ring.R1[1].Color
				Parts.Ring.R2[1].Light.Color=Parts.Ring.R2[1].Color
			elseif string.sub(i,1,4)=="Wing" then
				for _,v in pairs(v) do
					v[1].Color=T.Colours[i].Prim=="rb" and hsv(tick()/3%1,1,1) or T.Colours[i].Prim
					v[3].Color=T.Colours[i].Sec=="rb" and hsv(tick()/3%1,1,1) or T.Colours[i].Sec
					v[1].Sparks.Color=T.Colours[i].Sec=="rb" and cs(hsv(tick()/3%1,1,1),hsv(tick()/3%1,1,1)) or cs(T.Colours[i].Sec)
					v[1].Trail.Color=T.Colours[i].Sec=="rb" and cs(hsv(tick()/3%1,1,1),hsv(tick()/3%1,1,1)) or cs(T.Colours[i].Sec)
				end
			end
		end
		Parts.Ring.R1[2].C0=Modes.WingSetup.Ring.R1.C0*cf(0,-7.5,0)*angles(0,180,0,true)
		Parts.Ring.R2[2].C0=Modes.WingSetup.Ring.R2.C0*cf(0,-7.5,0)*angles(0,180,0,true)
		Mode=Key
		C1,C2=T.Colours.Ring.Prim=="rb" and hsv(tick()/3%1,1,1) or Modes.Modes[Mode].Colours.Ring.Prim,T.Colours.Ring.Sec=="rb" and hsv(tick()/3%1,1,1) or Modes.Modes[Mode].Colours.Ring.Sec
		local SE=Models.SwitchExp:Clone() SE.Parent=t SE.Color=cs(({C1,C2})[random(1,2)]) SE:Emit(random(10,20)) Instance.Remove(SE,3.5)
		local SE=Models.SESparks:Clone() SE.Parent=t SE.Color=cs(({C1,C2})[random(1,2)]) SE:Emit(random(15,30)) Instance.Remove(SE,2)
		Sound(1842444531,1,random(.9,1.1,100),t,150,10)
		Sound(3264923,.75,random(.9,1.1,100),t,150,10)
		Sound(192410089,.8,random(.9,1.1,100),t,150,10)
		SoundWave(hrp.Position,2770705979,.65,random(.9,1.1,100),70,35,true,.75)
		local SPuff=Models.SwitchPuff:Clone()
		SPuff.CFrame=cf(t.Position)*cf(0,-3.5,0)
		SPuff.Color=({C1,C2})[random(1,2)]
		SPuff.Parent=Effects
		SPuff.Script.Disabled=false
		Instance.Remove(SPuff,3)
		for i=1,random(3,7) do
			local Hit,Pos,NID=Raycast(HRP.Position+v3(random(-7.5,7.5,10),random(1,5,10),random(-7.5,7.5,10)),-angles(random(-25,25,10),random(-25,25,10),random(-25,25,10),true).UpVector,{Char,workspace.Terrain},25,true)
			if Hit then
				local Color=({C1,C2})[random(1,2)]
				local ModColor
				local T={Color.R,Color.G,Color.B}
				local Highest,Pos_=math.max(unpack(T)),1
				for i,v in pairs(T) do if v==Highest then Pos_=i end end
				ModColor=c3(Color.R*(Pos_==1 and 10 or 5),Color.G*(Pos_==2 and 10 or 5),Color.B*(Pos_==3 and 10 or 5))
				local Size=random(5,15,10)
				local P=SBeam:Clone() P.Parent=Effects local B=P.B
				local P1=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Massless=true,Anchored=true,Locked=true,CFrame=cf(Pos,Pos-NID)*angles(90,0,0,true),Parent=workspace.Terrain})
				local M=ins("BlockMesh",{Scale=v3(1,0,1)*20,Parent=P1})
				local Dec=ins("Decal",{Texture="rbxassetid://4381464218",Face="Top",Color3=ModColor,Parent=P1})
				P.A1.Position,P.A2.Position=v3(0,Size/2,0),v3(0,-Size/2,0)
				P.CFrame,B.Color=cf(Pos,Pos-NID)*angles(90,0,0,true)*angles(random(-25,25,10),random(-25,25,10),random(-25,25,10),true)*cf(0,-Size/2,0),cs(Color)
				Instance.Remove(P,Size/10) Instance.Remove(P1,Size/7.5)
				Tween(P.A1,{Position=P.A1.Position+v3(0,Size*2,0)},{Size/10,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
				Tween(P.A2,{Position=P.A1.Position+v3(0,Size*2,0)},{Size/10,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
				Tween(B,{Width0=0,Width1=0},{Size/10,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
				Tween(M,{Scale=v3(Size/3.5,0,Size/3.5)*20},{Size/7.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0})
				Tween(Dec,{Transparency=1},{Size/7.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0})
			end
		end
	end
end
function DisplayDamage(Pos,Text,Time)
	local P=Models.DD:Clone() P.CFrame,P.Parent=Pos*cf(random(-2,2,100),random(-2,2,100),random(-2,2,100)),Effects
	local G=P.BGUI local T=G.Text local W,C=T.Wave,T.Cut
	Instance.Remove(P,Time)
	T.TextColor3,T.TextStrokeColor3,W.ImageColor3,C.ImageColor3,T.Text,G.Size=C1,C2,C1,C2,Text,ud2(4+#tostring(Text)/2,0,4,0)
	Tween(C,{Position=ud2(-1,0,2,0)},{.5}) Tween(C,{ImageTransparency=0},{.25,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,0,true,0})
	Tween(W,{Size=ud2(3,0,3,0)},{.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,.25}) Tween(W,{ImageTransparency=1},{.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,.25})
	Tween(T,{TextTransparency=0,TextStrokeTransparency=.5},{.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out,0,false,.25})
	coroutine.wrap(function()
		wait(.5)
		Tween(T,{TextTransparency=1,TextStrokeTransparency=1},{.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out,0,false,Time-.75})
	end)()
end
function SpikeEff(CF,Parts,MoreTent,SegmentLength)
	local Col=({C1,C2})[random(1,2)]
	local AngleAcc=angles(random(-30,30,10),random(-30,30,10),random(-30,30,10),true)
	local Parts,SegmentLength=Parts or random(5,20),SegmentLength or random(1,2,100)
	local CF=(CF or cf())*cf(0,SegmentLength/2,0)
	local Mod=ins("Model",workspace.Terrain)
	if MoreTent then
		local P=ins("Part",{Massless=true,Anchored=true,CanCollide=false,Locked=true,CastShadow=false,Size=v3(Parts/2.5,0,Parts/2.5),Transparency=0,Material="Neon",Color=Col,CFrame=CF*cf(0,-SegmentLength/2,0),Parent=Mod})
		local So=Sound(1836741154,4*(Parts/20),random(.8,1.2,100),P,450*(Parts/20),5)
		local So1=Sound(1146693898,5*(Parts/20),random(.8,1.2,100),P,450*(Parts/20),5)
		local So2=Sound(1177785010,6*(Parts/20),random(.8,1.2,100),P,450*(Parts/20),5)
		local Light=ins("PointLight",{Brightness=.25,Range=35,Color=P.Color,Shadows=true,Parent=P})
		ins("SpecialMesh",{MeshType="Sphere",Parent=P})
		local PE=Models.SwitchExp:Clone()
		PE.Color=cs(P.Color)
		PE.Parent=P
		PE:Emit(random(2,3))
		coroutine.wrap(function()
			wait(.05)
			PE.Parent=t
		end)()
		Instance.Remove(PE,2)
		Instance.Remove(P,So.TimeLength+.1)
		Tween(P,{Color=bc("Really black").Color,Transparency=1},{Parts/10,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0})
		Tween(Light,{Color=bc("Really black").Color},{Parts/10,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0})
	end
	coroutine.wrap(function()
		local TotalTime=0
		for i=Parts,1,-1 do
			local Time=i/10
			TotalTime=TotalTime+Time
			local P=ins("Part",{Locked=true,Massless=true,Anchored=true,CanCollide=false,CastShadow=false,Material="Neon",Color=Col,Size=v3(i/5,SegmentLength,i/5),CFrame=CF,Parent=Mod})
			local Light=ins("PointLight",{Brightness=.25,Range=20,Color=P.Color,Shadows=true,Parent=P})
			local Mesh=ins("CylinderMesh",P)
			local PE=Models.SawBladeSpawn:Clone()
			PE.Color=cs(P.Color)
			PE.Parent=P
			PE:Emit(random(1,2))
			coroutine.wrap(function()
				wait(.05)
				PE.Parent=t
			end)()
			Instance.Remove(PE,1.5)
			Instance.Remove(P,Time*2)
			Tween(Mesh,{Scale=v3(0,1,0)},{Time,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0})
			Tween(P,{Color=bc("Really black").Color,Orientation=P.Orientation+v3(AngleAcc:ToOrientation())*random(-5,5,100)},{Time,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0})
			local FallPos=P.Position-v3(0,Time*random(-2,10,100),0)
			local AngleAcc1=AngleAcc
			local Hit1,Pos1,NID1=Raycast(P.Position,CF.UpVector,{char,workspace.Terrain},SegmentLength*3)
			local Hit2,Pos2,NID2=Raycast(P.Position,FallPos-P.Position,{char,workspace.Terrain},(P.Position-FallPos).Magnitude)
			if Hit1 then AngleAcc1=AngleAcc1*angles(NID1.X*90,NID1.Y*90,NID1.Z*90,true) end
			if Hit2 then FallPos=Pos2 end
			Tween(P,{Position=FallPos},{Time*1.75,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0})
			Tween(Light,{Brightness=0},{Time*1.75,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0})
			local VAng=v3(AngleAcc1:ToOrientation())*(180/pi)
			if (math.cos(i/10))<-.2 and (math.cos(i/10))>.2 then
				VAng=VAng*(math.cos(i/5)-math.sin(math.pow(i%25)/15))*5
			end
			local CF1=CF
			if random(0,1,10)==1 and MoreTent then
				SpikeEff(CF1,random(5,math.clamp(i,5,1000)))
			end
			CF=CF*cf(0,SegmentLength/2,0)*angles(VAng.X,VAng.Y,VAng.Z,true)*cf(0,SegmentLength/2,0)
			game:GetService("RunService").Heartbeat:Wait()
		end
		Instance.Remove(Mod,TotalTime*2)
	end)()
end

local Global = (getgenv and getgenv()) or getfenv(0)
local Bullet = Global.KryptonData.FlingPart
local funnyfunction
if Bullet then
	local TargetPart
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	warn(Bullet.Name)

	local Rotation = CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
	table.insert(Global.KryptonData["Global Events"], game:GetService("RunService").Heartbeat:Connect(function()
		Rotation = CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
		if Bullet and Global.KryptonData.Flinging then
			Bullet.RotVelocity = Vector3.new(0, 7500, 0)
			Bullet.CFrame = Mouse.Hit * Rotation
		end
	end))

	funnyfunction = function()
		Global.KryptonData.Flinging = true
		coroutine.wrap(function() wait(0.7) end)()
		Global.KryptonData.Flinging = false
    end
end


function Ignite(Hit)
	local hum = Hit.Parent:FindFirstChild("Humanoid") or Hit.Parent.Parent:FindFirstChild("Humanoid")
	local FR=Models.Fire:Clone() 
	FR.Size=ns(.75,0) 
	FR.SpreadAngle=v2() 
	FR.Speed=nr(0) 
	FR.Acceleration=v3(0,25,0) 
	FR.Lifetime=nr(.5,1.3) 
	FR.Rate=35 
	FR.Parent=Hit 
	coroutine.wrap(function() 
	for i=1,random(10,30) do 
	local D=Damage.new(Hit.CFrame*cf(random(-Hit.Size.X/2,Hit.Size.X/2,1),random(-Hit.Size.Y/2,Hit.Size.Y/2,1),random(-Hit.Size.Z/2,Hit.Size.Z/2,1)).Position,v3(1,1,1),0,0,0,0,{char})
	D:SetOnHitFunction(function(Hit)
	Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) 
	Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) 
	if random(0,1,10)==1 then Ignite(Hit) end end) D:Check() wait(random(.05,.25,100)) end for i=0,1,1/25 do FR.Transparency=ns(i*1.1) game:GetService("RunService").Heartbeat:Wait() end FR:Destroy() end)()
end
--// Moves
local DMG=function() local D=Damage.new(Parts.WingR.W2[1].Position,v3(3,3,3),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) 
	if Mode=="P" and random(0,1,10)==1 then 
	Ignite(Hit) end Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) D:Check() end
local DMG1=function() coroutine.wrap(function() for i=1,10 do local D=Damage.new(Parts.WingR.W2[1].Position,v3(3,3,3),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) if Mode=="P" and random(0,1,10)==1 then Ignite(Hit) end Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) D:Check() game:GetService("RunService").Heartbeat:Wait() end end)() end
local Combos={
	function()
		Using=true
		funnyfunction()
		EquippedPool=120
		PlayAnim(Anims.Swing1,{[1]=DMG,[2]=DMG1,[3]=function()
			
			local StandL,LPos,LNID=Raycast(t.CFrame*cf(t.Size.X/4,-t.Size.Y/2,0).Position,-t.CFrame.UpVector,{char},3,false)
			if not StandL then return end
			local SoundId=StepSounds[StandL.Material.Name] or 0
			if StandL.Material==Enum.Material.Sand and (StandL.Color.r>.7 and StandL.Color.g>.7 and StandL.Color.b>.7) then
				SoundId=StepSounds["Snow"]
			end
			if StandL.Name=="Water" then  SoundId=StepSounds.Water end
			local SizeVal=StandL.Size*LNID
			if SoundId==941640049 then
				SizeVal=SizeVal/2
			end
			Sound(SoundId,(.35*clamp((6)/1.5,.5,3.5))/clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z),.5,1.25),random(.9,1.1,100)*clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z)/10,.5,1.2)*clamp((6)/1.5,.5,2),t)
		end})
		Using=false
	end,
	function()
		Using=true
		funnyfunction()
		EquippedPool=120
		PlayAnim(Anims.Swing2,{[1]=DMG,[2]=DMG1,[3]=DMG,[4]=DMG1,[5]=DMG,[6]=function()
			
			local StandL,LPos,LNID=Raycast(t.CFrame*cf(-t.Size.X/4,-t.Size.Y/2,0).Position,-t.CFrame.UpVector,{char},3,false)
			if not StandL then return end
			local SoundId=StepSounds[StandL.Material.Name] or 0
			if StandL.Material==Enum.Material.Sand and (StandL.Color.r>.7 and StandL.Color.g>.7 and StandL.Color.b>.7) then
				SoundId=StepSounds["Snow"]
			end
			if StandL.Name=="Water" then  SoundId=StepSounds.Water end
			local SizeVal=StandL.Size*LNID
			if SoundId==941640049 then
				SizeVal=SizeVal/2
			end
			Sound(SoundId,(.35*clamp((6)/1.5,.5,3.5))/clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z),.5,1.25),random(.9,1.1,100)*clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z)/10,.5,1.2)*clamp((6)/1.5,.5,2),t)
		end})
		Using=false
	end
}
function PerformCombo()
	LastSitTick=tick()
	Using=true
	if not Equipped then EquippedPool=120 PlayAnim(Anims.Equip) EquippedPool=120 Equipped=true Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R1[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R2[1].B end
	Combo=Combo+1
	if Combo>#Combos then Combo=1 end
	Combos[Combo]()
	Using=false
end
local Moves={
	Equals=function()
		Using=true
		if Equipped then PlayAnim(Anims.Equip) Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B end
		PlayAnim(Anims.Grab,{[1]=function() CrossClient:FireClient("Function","LookToClosestChar") end,[2]=function()
			local CHAR=CrossClient:FireClient("Function","LookToClosestChar")
			if not CHAR then return end
			local HUM,HE,TOR=CHAR:FindFirstChildOfClass("Humanoid"),CHAR:FindFirstChild("Head"),CHAR:FindFirstChild("Torso") or CHAR:FindFirstChild("UpperTorso")
			if not HUM or not HE or not TOR then return end
			HRP.Anchored=true
			local W=ins("Motor6D",{Part0=ra,Part1=HE,C0=cf(0,-ra.Size.Y/2,0)*angles(-90,180,0,true)*angles(0,0,90,true),Parent=ra})
			Ragdoll:Ragdollify(CHAR)
			PlayAnim(Anims.Grab_Throw,{[2]=function()
				HE:Destroy()
				Sound(2801263,random(.4,.85,100),random(.8,1.1,100),ra,100,5)
				Sound(4459576935,random(.2,.4,100),random(.8,1.1,100),ra,100,5).TimePosition=.1
				Sound(264486467,.35,random(.9,1.1),ra,100,5).TimePosition=.25
				local Hit,Pos,NID=Raycast(TOR.CFrame*cf(0,TOR.Size.Y/2,0).Position,v3(0,-1,0),{char,CHAR},10,false)
				if Hit then
					local Time,GrowTime=random(10,20,10),random(.35,1,100)
					local BP=Models.BP:Clone()
					BP.Parent=BLOODPARENT
					BP.CFrame=cf(Pos,Pos-NID)*angles(90,random(-180,180,10),0,true)
					local W=ins("WeldConstraint",{Part0=Hit,Part1=BP,Parent=BP})
					Instance.Remove(BP,Time)
					Tween(BP,{Size=v3(random(.75,1.25,100),0,random(.75,1.25,100))*random(1,2,100)},{GrowTime,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
					Tween(BP,{Transparency=1},{GrowTime,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,Time-(GrowTime*2)})
				end
				DisplayDamage(HE.CFrame*cf(random(-1,1,10),random(-1,1,10),random(-1,1,10)),-floor(HUM.Health),2)
				local TC2=ThroatCut:Clone()
				local TCPE=TC2.A.PE
				TC2.Parent,TC2.Size=TOR,v3(.75*TOR.Size.Z,.065*HE.Size.Y,.75*TOR.Size.Z) ins("Motor6D",{Part0=TOR,Part1=TC2,C0=cf(0,TOR.Size.Y/2,0)*angles(0,180,0,true),Parent=TC2})
				local BC_=BC:Clone() BC_.Parent=TC2 BC_:Emit(random(5,15))
				local BD=Models.BloodDrops:Clone() BD.Parent=ra Instance.Remove(BD,15)
				coroutine.wrap(function()
					wait(12.5)
					BD.Enabled=false
				end)()
				for i,v in pairs(Models.ArmBlood:GetChildren()) do
					local C=v:Clone()
					C.Parent=ra
					Instance.Remove(C,20)
					Tween(C,{Transparency=1},{7.5,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,12.5})
				end
				coroutine.wrap(function()
					local Intensity=1
					while CHAR.Parent do
						for i=1,random(1,3) do
							local Create=true
							local DownDir=random(.2,1,100)
							local Hit,Pos,NID=Raycast(TOR.CFrame*cf(0,(TOR.Size.Y/2)+random(0,2,100),0).Position,TOR.CFrame.UpVector-v3(random(-.15,.15,1000),DownDir,random(-.15,.15,1000)),{CHAR},50*DownDir,false)
							if Hit and Intensity>0 then
								TCPE:Emit(floor(random(0,1,1/Intensity)+.35))
								if Hit.Name=="BP" and (Pos-Hit.Position).Magnitude<1.5 then Create=false Tween(Hit,{Size=Hit.Size+v3(1,0,1)*(random(.025,.075,1000)*Intensity),Transparency=clamp(Hit.Transparency-(random(.005,.015,1000)*Intensity),0.05,1)},{.5,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0}) end
								if Create then
									local Time,GrowTime=random(10,20,10),random(.35,1,100)
									local BP=Models.BP:Clone()
									BP.Parent=BLOODPARENT
									BP.CFrame=cf(Pos,Pos-NID)*angles(90,random(-180,180,10),0,true)
									BP.Transparency=(1.1-Intensity)+(1*(Pos-TOR.CFrame*cf(0,TOR.Size.Y/2,0).Position).Magnitude/10)
									local W=ins("WeldConstraint",{Part0=Hit,Part1=BP,Parent=BP})
									Instance.Remove(BP,Time)
									Tween(BP,{Size=(v3(random(.75,1.25,100),0,random(.75,1.25,100))*random(1,2,100))*Intensity},{GrowTime,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
									Tween(BP,{Transparency=1},{GrowTime,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,Time-(GrowTime*2)})
								end
							end
						end
						Intensity=Intensity-.0025
						wait()
					end
				end)()
				Ragdoll:Ragdollify(CHAR,true)
			end})
			W:Destroy()
			HRP.Anchored=false
		end})
		Using=false
	end,
	R=function()
		Using=true
		if not Equipped then EquippedPool=120 PlayAnim(Anims.Equip) EquippedPool=120 Equipped=true Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R1[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R2[1].B end
		CrossClient:FireClient("Event","ToggleTTM",true)
		WCF=angles(0,-80,0,true)
		PlayAnim(Anims.TBeam,{
			[2]=function()
				coroutine.wrap(function()
					for i=1,3 do
						EquippedPool=120
						Sound(181004957,1,random(1.25,1.5,100),ra,250,7.5)
						local Colours=({{C1,C2},{C2,C1}})[random(1,2)]
						local P=ins("Part",{Locked=true,CanCollide=false,Anchored=true,Size=v3(0,0,0),Transparency=1,Parent=Effects})
						local Dir=Mouse.Hit.Position-ra.CFrame*cf(0,-ra.Size.Y/2,0).Position
						local Hit,Pos,NID=Raycast(ra.CFrame*cf(0,-ra.Size.Y/2,0).Position,Dir,{char,BLOODPARENT},500,true)
						local A1,A2=ins("Attachment",{WorldPosition=ra.CFrame*cf(0,-ra.Size.Y/2,0).Position,Parent=P}),ins("Attachment",{WorldPosition=Pos,Parent=P})
						local B=ins("Beam",{Attachment0=A1,Attachment1=A2,Texture="rbxassetid://3517446796",FaceCamera=true,LightInfluence=0,LightEmission=1,Width0=0,Width1=0,Color=cs(Colours[1]),TextureSpeed=.2,TextureLength=.25,Parent=P})
						local D=Damage.new(Pos,v3(7.5,7.5,7.5),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) D:Check()
						local Color=Colours[1] local ModColor local T={Color.R,Color.G,Color.B} local Highest,Pos_=math.max(unpack(T)),1 for i,v in pairs(T) do if v==Highest then Pos_=i end end ModColor=c3(Color.R*(Pos_==1 and 10 or 5),Color.G*(Pos_==2 and 10 or 5),Color.B*(Pos_==3 and 10 or 5))
						local PE=Models.SwitchExp:Clone() PE.Parent,PE.Color=A2,cs(Colours[1]) PE:Emit(random(10,20))
						local P1=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Massless=true,Anchored=true,Locked=true,CFrame=cf(Pos,Pos-NID)*angles(90,0,0,true),Parent=workspace.Terrain})
						local BM=ins("BlockMesh",{Scale=v3(7.5,.05,7.5)*20,Parent=P1})
						local Dec=ins("Decal",{Texture="rbxassetid://4381464218",Face="Top",Transparency=1,Color3=ModColor,Parent=P1})
						Tween(B,{Width0=5},{.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,true,0})
						Tween(B,{Width1=5},{.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,true,.0625})
						Tween(Dec,{Transparency=0},{.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,true,0})
						Tween(BM,{Scale=v3(25,.05,25)*20},{.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
						Sound(2767090,1,random(.9,1.1,100),P1,250,7.5)
						Sound(192410089,1,random(.9,1.1,100),P1,250,7.5)
						Sound(1177785010,1,random(.9,1.1,100),P1,250,7.5)
						SoundWave(Pos,2770705979,.65,random(.9,1.1,100),70,35,true,.75)
						coroutine.wrap(function()
							if Hit then
								wait(.5)
								local _Hit,_Pos,_NID=Raycast(Pos,Dir.Unit+NID,{char,BLOODPARENT},500,true)
								A1.WorldPosition=_Pos
								B.Color=cs(Colours[2])
								Tween(B,{Width0=10},{.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,true,0})
								Tween(B,{Width1=10},{.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,true,.0625})
								local PE=Models.SwitchExp:Clone() PE.Size=ns(10) PE.Parent,PE.Color=A1,cs(Colours[2]) PE:Emit(random(10,20))
								local Color=Colours[2] local ModColor local T={Color.R,Color.G,Color.B} local Highest,Pos_=math.max(unpack(T)),1 for i,v in pairs(T) do if v==Highest then Pos_=i end end ModColor=c3(Color.R*(Pos_==1 and 10 or 5),Color.G*(Pos_==2 and 10 or 5),Color.B*(Pos_==3 and 10 or 5))
								Dec.Color3=ModColor
								BM.Scale=v3(7.5,.05,7.5)*20
								Tween(Dec,{Transparency=0},{.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,true,0})
								Tween(BM,{Scale=v3(35,.05,35)*20},{.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
								local D=Damage.new(Pos,v3(12.5,12.5,12.5),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) D:Check()
								coroutine.wrap(function()
									wait()
									PE.Parent=A2 PE:Emit(random(10,20))
								end)()
								Sound(2767090,1.5,random(.9,1.1,100),P1,250,7.5)
								Sound(192410089,1.5,random(.9,1.1,100),P1,250,7.5)
								Sound(1177785010,1.5,random(.9,1.1,100),P1,250,7.5)
								SoundWave(Pos,2770705979,.65,random(.9,1.1,100),90,35,true,1)
							end
							Instance.Remove({P,P1},3)
						end)()
						wait(.1)
					end
				end)()
			end
		})
		CrossClient:FireClient("Event","ToggleTTM",false)
		WCF=cf()
		Using=false
	end,
	P=function()
		Using=true
		if Equipped then PlayAnim(Anims.Equip) Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B end
		local FB
		CrossClient:FireClient("Event","ToggleTTM",true)
		PlayAnim(Anims.FBThrow,{
		[1]=function()
			FB=Models.Fireball:Clone()
			FB.CFrame=la.CFrame*cf(0,-la.Size.Y/2,0)
			ins("Motor6D",{Part0=la,Part1=FB,C0=cf(0,-la.Size.Y/2,0),Parent=FB})
			FB.Parent=Effects
		end,
		[3]=function()
			FB:Destroy()
			local P=Models.Fireball:Clone()
			P.CFrame=cf(la.CFrame*cf(0,-la.Size.Y/2,0).Position,Mouse.Hit.Position)
			P.Parent=Effects
			CrossClient:FireClient("Event","ActivateFireball",P)
		end})
		CrossClient:FireClient("Event","ToggleTTM",false)
		Using=false
	end,
	Q=function()
		Using=true
		if Equipped then PlayAnim(Anims.Equip) Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B end
		local FB
		CrossClient:FireClient("Event","ToggleTTM",true)
		PlayAnim(Anims.FBThrow,{
			[1]=function()
				FB=Models.Petal:Clone()
				FB.CFrame=la.CFrame*cf(0,-la.Size.Y/2,0)
				ins("Motor6D",{Part0=la,Part1=FB,C0=cf(0,-la.Size.Y/2,0)*angles(-90,0,0,true),Parent=FB})
				FB.Parent=Effects
			end,
			[3]=function()
				FB:Destroy()
				local P=Models.Petal:Clone()
				P.CFrame=cf(la.CFrame*cf(0,-la.Size.Y/2,0).Position,Mouse.Hit.Position)
				P.Color=({C1,C2})[random(1,2)]
				P.T.Color=cs(P.Color)
				P.Parent=Effects
				CrossClient:FireClient("Event","ActivateFireball",P)
			end
		})
		CrossClient:FireClient("Event","ToggleTTM",false)
		Using=false
	end,
	E=function()
		local OldWS=Hum.WalkSpeed
		local AnimFuncTable={}
		for i=1,12 do AnimFuncTable[i]=function() hrp.Velocity=hrp.CFrame.LookVector*57.5 local D=Damage.new(hrp.Position,v3(12,5,12),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) D:Check() end end
		Using=true
		WS=4 Hum.WalkSpeed=WS LockWS=true
		Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R1[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R2[1].B
		PlayAnim(Anims.BBlade)
		WS=24
		local S1,S2=Models.BBSparks:Clone(),Models.BBSparks:Clone()
		S1.Parent,S2.Parent=t,t
		S1.Color,S2.Color=cs(C1),cs(C2)
		CrossClient:FireClient("Event","ToggleDFOV",true)
		for i=1,6 do
			for i=1,random(1,4) do
				local Color=({C1,C2})[random(1,2)] local ModColor local T={Color.R,Color.G,Color.B} local Highest,Pos_=math.max(unpack(T)),1 for i,v in pairs(T) do if v==Highest then Pos_=i end end ModColor=c3(Color.R*(Pos_==1 and 10 or 5),Color.G*(Pos_==2 and 10 or 5),Color.B*(Pos_==3 and 10 or 5))
				local P=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Massless=true,Anchored=true,Locked=true,CFrame=hrp.CFrame*cf(0,0,-5)*angles(random(-25,25,10),0,random(-25,25,10),true),Parent=workspace.Terrain})
				local M=ins("BlockMesh",{Scale=v3(1,0,1)*20,Parent=P})
				local Dec1,Dec2=ins("Decal",{Texture="rbxassetid://4381464218",Face="Top",Color3=ModColor,Parent=P}),ins("Decal",{Texture="rbxassetid://4381464218",Face="Bottom",Color3=ModColor,Parent=P})
				local L=ins("PointLight",{Shadows=true,Color=Color,Brightness=2.5,Range=8,Parent=P})
				Instance.Remove(P,.5)
				Tween(L,{Range=40,Color=c3()},{.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0})
				Tween(M,{Scale=v3(40,0,40)*20,Offset=v3(0,0,-5)},{.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0})
				Tween(Dec1,{Transparency=1},{.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0}) Tween(Dec2,{Transparency=1},{.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0})
			end	
			local T=Anims.BBladeLoop
			if i==5 then
				T[12]=nil
			end
			Sound(4255432837,1.25,random(.6,1.1,100),t,65,4) Sound(1177785010,.85,random(.7,1,100),t,100,5) Sound(1146693387,.2,random(.9,1.1,100),t,100,5)
			PlayAnim(T,AnimFuncTable)
		end
		CrossClient:FireClient("Event","ToggleDFOV",false)
		S1.Enabled,S2.Enabled=false,false
		hrp.Velocity=v3()
		WS=0
		PlayAnim(Anims.BBladeStop)
		Instance.Remove({S1,S2},3)
		Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B
		WS=OldWS Hum.WalkSpeed=WS LockWS=false
		Using=false
	end,
	T=function()
		Using=true
		local OldWS=Hum.WalkSpeed
		Hum.WalkSpeed=0
		if Equipped then PlayAnim(Anims.Equip) Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B end
		local C=C1
		local P=ins("Part",{Size=v3(),Anchored=false,CanCollide=false,Transparency=1,CFrame=angles(0,random(-180,180),0,true),Parent=BLOODPARENT})
		local W=ins("Motor6D",{Part0=ra,Part1=P,C0=angles(0,random(-180,180),0,true),Parent=ra})
		local M=ins("SpecialMesh",{MeshType=Enum.MeshType.FileMesh,MeshId="rbxassetid://5880296360",TextureId="rbxassetid://5874730960",VertexColor=v3(C.r*5,C.g*5,C.b*5),Scale=v3(1.5,10,1.5),Parent=P})
		local L=ins("PointLight",{Color=C,Range=7.5,Brightness=0,Shadows=true,Parent=P})
		Tween(P,{Transparency=.011},{.4,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
		Tween(W,{C0=W.C0*angles(0,random(.5,5,10)*180,0,true)},{.6,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
		Tween(L,{Brightness=1.5},{.4,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0})
		PlayAnim(Anims.SawCast,{
			[3]=function()
				local PE,PE1,PE2=Models.SwitchExp:Clone(),Models.SawBladeSpawn:Clone(),Models.SawBladeSpawnS:Clone()
				PE.Color,PE1.Color,PE2.Color=cs(C),cs(C),cs(C)
				PE.Size=ns(2)
				PE.Speed=nr(3,7)
				PE.Acceleration=v3(0,-1,0)
				PE.Parent,PE1.Parent,PE2.Parent=P,P,P
				PE:Emit(random(3,10))
				PE1:Emit(random(10,25))
				PE2:Emit(random(20,35))
				PE.Parent,PE1.Parent,PE2.Parent=ra,ra,ra
				Instance.Remove({PE,PE1,PE2},3.5)
				W:Destroy()
				P.Anchored=true
				Instance.Remove(P,.5)
				Tween(P,{Transparency=1},{.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
				Tween(L,{Brightness=0},{.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
				Tween(M,{Scale=v3(5,2,5),Offset=v3(0,-1,0)},{.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
			end
		})
		Hum.WalkSpeed=OldWS
		Using=false
	end,
	LeftBracket=function()
		Using=true
		local OldWS=Hum.WalkSpeed
		--Hum.WalkSpeed=0
		CrossClient:FireClient("Event","ToggleTTM",true)
		PlayAnim(Anims.SpikeBFlip,{
			[1]=function()
				Sound(1197392844,3.5,random(1.15,1.3,100),t,150,5).TimePosition=3.3
				Sound(1843028946,3,random(.9,1.1,100),t,150,5).TimePosition=.8
				local SO=Sound(1839756886,3,random(.9,1.1,100),t,100,5) SO.TimePosition=.75
				Instance.Remove(SO,5)
			end,
			[2]=coroutine.wrap(function()
				Damage.new(t.Position,10,0,0,0,0,{char}):Check(nil,nil,function(P) Sound(220025675,2.25,random(.9,1.1,100),P,125,6) end)
				CrossClient:FireClient("Event","ToggleTTM",false)
				local SCF=cf(0,30,0)*cf(hrp.Position,v3(Mouse.Hit.X,hrp.Position.Y,Mouse.Hit.Z))
				local Length,MaxSpread=90,55
				local CS=false
				local CHit,CPos,CNID=Raycast(hrp.Position,v3(0,-1,0),{char,workspace.Terrain},15,true)
				if CHit then
					local C=({C1,C2})[random(1,2)]
					local P=ins("Part",{Size=v3(),Anchored=true,CanCollide=false,Transparency=0,CFrame=cf(CPos,CPos-CNID)*angles(90,random(-180,180,10),0,true)*cf(0,2,0),Parent=BLOODPARENT})
					local M=ins("SpecialMesh",{MeshType=Enum.MeshType.FileMesh,MeshId="rbxassetid://5880296360",TextureId="rbxassetid://5874730960",VertexColor=v3(C.r*5,C.g*5,C.b*5),Scale=v3(),Offset=v3(0,-2,0),Parent=P})
					local L=ins("PointLight",{Color=C,Range=0,Brightness=1.5,Shadows=true,Parent=P})
					Tween(L,{Range=30,Brightness=0},{.35,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
					Tween(P,{Transparency=1},{.35,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
					Tween(M,{Scale=v3(30,15,30),Offset=v3(0,2.2,0)},{.35,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
					Instance.Remove(P,.35)
					local C=({C1,C2})[random(1,2)]
					local P=ins("Part",{Size=v3(),Anchored=true,CanCollide=false,Transparency=0,CFrame=cf(CPos,CPos-CNID)*angles(90,random(-180,180,10),0,true)*cf(0,2,0),Parent=BLOODPARENT})
					local M=ins("SpecialMesh",{MeshType=Enum.MeshType.FileMesh,MeshId="rbxassetid://5880296360",TextureId="rbxassetid://5874730960",VertexColor=v3(C.r*5,C.g*5,C.b*5),Scale=v3(),Offset=v3(0,-2,0),Parent=P})
					local L=ins("PointLight",{Color=C,Range=0,Brightness=1.5,Shadows=true,Parent=P})
					Tween(L,{Range=30,Brightness=0},{.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
					Tween(P,{Transparency=1},{.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
					Tween(M,{Scale=v3(20,45,20),Offset=v3(0,4,0)},{.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0})
					Instance.Remove(P,.5)
					local Time=random(1.5,7.5,100)
					local P=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Anchored=true,Locked=true,Massless=true,CFrame=cf(CPos,CPos-CNID)*angles(90,0,0,true)*angles(0,random(-180,180,10),0),Parent=Effects})
					local M=ins("BlockMesh",{Scale=v3(15,0,15)*20,Parent=P})
					local Dec=ins("Decal",{Texture="rbxassetid://453789629",Transparency=.15,Face="Top",Parent=P})
					Tween(M,{Scale=v3(110,0,110)*20},{Time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
					Tween(Dec,{Transparency=1},{Time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
					Instance.Remove(P,Time)
					local DJ=Models.DJImpact:Clone()
					DJ.Parent=P
					DJ:Emit(60)
					DJ.EmissionDirection="Front"
					Instance.Remove(DJ,4)
					coroutine.wrap(function()
						wait(.1)
						DJ.Parent=t
					end)()
				end
				for i=4.5,Length,4.5 do
					local SP=MaxSpread*(i/Length)
					local SPOS=SCF*cf(random(-SP,SP,10000),0,-i).Position
					local Hit,Pos,NID=Raycast(SPOS,v3(0,-1,0),{char,workspace.Terrain},80,true)
					if Hit then
						SCF*=cf(0,(Pos-SPOS).Y+30,0)
						if i>40 and not CS then
							CS=true
							SoundWave(Pos,2770705979,1,random(.9,1.1,100),100,35,true,.75)
						end
						local Times=random(5,12)
						Damage.new(Pos+v3(0,Times*2,0),v3(10,Times*4,10),0,0,0,0,{char}):Check(nil,nil,function(P) Sound(566593606,1.75,random(.9,1.1,100),P,125,6) end)
						SpikeEff(cf(Pos,Pos-NID)*angles(pi/2,0,0),Times,true,4)
					end
					game:GetService("RunService").Heartbeat:Wait()
				end
			end)
		})
		Hum.WalkSpeed=OldWS
		Using=false
	end
}
CrossClient:AddFunction("Event","CreateFBImpact",function(Hit,Pos,NID,Name)
	local function SpawnCres(Pos,Offset,Thickness,ThicknessEnd,Speed,Rot,Lifetime)
		local P=Models.FlameCres:Clone()
		local Val=ins("NumberValue")
		P.BV.Velocity,P.BAV.AngularVelocity,P.A1.Position,P.A2.Position,P.CFrame=v3(0,Speed,0),v3(0,Rot,0),v3(0,0,Thickness/2),v3(0,0,-Thickness/2),Pos
		P.Parent=BLOODPARENT
		Instance.Remove({P,Val},Lifetime+1)
		Tween(P.A1,{Position=v3(Offset,0,ThicknessEnd/2)},{Lifetime,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
		Tween(P.A2,{Position=v3(Offset,0,-ThicknessEnd/2)},{Lifetime,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
		Tween(Val,{Value=1},{Lifetime,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
		table.insert(Events,Val.Changed:Connect(function()
			P.T.Transparency=ns(Val.Value)
			P.T1.Transparency=ns(Val.Value)
			P.T2.Transparency=ns(Val.Value)
		end))
	end
	if Name=="Fireball" then
		local Color=C1 local ModColor local T={Color.R,Color.G,Color.B} local Highest,Pos_=math.max(unpack(T)),1 for i,v in pairs(T) do if v==Highest then Pos_=i end end ModColor=c3(Color.R*(Pos_==1 and 10 or 5),Color.G*(Pos_==2 and 10 or 5),Color.B*(Pos_==3 and 10 or 5))
		SoundWave(Pos,2770705979,1,random(.9,1.1,100),70,35,true,1)
		local P1=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Massless=true,Anchored=true,Locked=true,CFrame=cf(Pos,Pos-NID)*angles(90,0,0,true),Parent=workspace.Terrain})
		local BM=ins("BlockMesh",{Scale=v3(25,.05,25)*20,Parent=P1})
		local Dec=ins("Decal",{Texture="rbxassetid://4381464218",Face="Top",Transparency=1,Color3=ModColor,Parent=P1})
		local LightP=ins("Part",{Anchored=true,CanCollide=false,Transparency=1,CFrame=P1.CFrame*cf(0,10,0),Parent=P1})
		local Li=ins("PointLight",{Shadows=true,Color=rgb(255,59,0),Range=35,Parent=LightP})
		Tween(Dec,{Transparency=0},{.25})
		local S=Sound(181004957,2,random(.3,.4,100),P1,200,10)
		Sound(1177785010,1.5,random(.6,.8,100),P1,200,10)
		local PE=Models.SwitchExp:Clone() PE.Size=ns(10) PE.Parent,PE.Color=P1,cs(rgb(255,59,0)) PE:Emit(random(10,20))
		local A=ins("Attachment",{Orientation=v3(90,0,0),Parent=P1})
		local FPE=Models.Fire:Clone() FPE.Parent=A
		Instance.Remove(P1,10)
		local D=Damage.new(Pos,v3(30,65,30),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) if random(0,1,15)==1 then Ignite(Hit) end end) 
		coroutine.wrap(function()
			for i=1,random(30,50) do
				D:Check()
				SpawnCres(P1.CFrame*angles(0,random(-180,180,10),0),random(1,20,10),.2,random(.5,5,100),random(10,35,10),random(-15,15,10),random(.25,2,100))
				wait(random(.01,.05,100))
			end
			Tween(Dec,{Transparency=1},{.25})
			Tween(Li,{Color=c3()},{.25})
			Instance.Remove(P1,3)
			for i=0,1,1/35 do
				FPE.Transparency=ns(i*1.1)
				game:GetService("RunService").Heartbeat:Wait()
			end
		end)()
	elseif Name=="Petal" then
		local Color=({C1,C2})[random(1,2)] local ModColor local T={Color.R,Color.G,Color.B} local Highest,Pos_=math.max(unpack(T)),1 for i,v in pairs(T) do if v==Highest then Pos_=i end end ModColor=c3(Color.R*(Pos_==1 and 10 or 5),Color.G*(Pos_==2 and 10 or 5),Color.B*(Pos_==3 and 10 or 5))
		SoundWave(Pos,2770705979,1,random(.9,1.1,100),70,35,true,1)
		local P1=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Massless=true,Anchored=true,Locked=true,CFrame=cf(Pos,Pos-NID)*angles(90,0,0,true),Parent=workspace.Terrain})
		local LightP=ins("Part",{Anchored=true,CanCollide=false,Transparency=1,CFrame=P1.CFrame*cf(0,10,0),Parent=P1})
		local Li=ins("PointLight",{Shadows=true,Color=Color,Range=35,Parent=LightP})
		local BM=ins("BlockMesh",{Scale=v3(25,.05,25)*20,Parent=P1})
		local Dec=ins("Decal",{Texture="rbxassetid://4381464218",Face="Top",Transparency=1,Color3=ModColor,Parent=P1})
		Tween(Dec,{Transparency=0},{.25})
		local S=Sound(1837829140,3,random(.7,.9,100),P1,200,10)
		local PE=Models.SwitchExp:Clone() PE.Size=ns(10) PE.Parent,PE.Color=P1,cs(Color) PE:Emit(random(30,60))
		local Petal=Models.Petal:Clone() Petal.Color=Color Petal.CFrame=P1.CFrame Petal.Size=v3(9,.75,9) Petal.Anchored=true Petal.Parent=P1 Petal.SFX1:Play() Petal.Particles.PE1.Enabled,Petal.Particles.PE2.Enabled=true,true for i,v in pairs(Petal:GetChildren()) do if v:IsA("Beam") then v.Color=cs(Color) v.Enabled=true end end
		Instance.Remove(P1,10)
		local D=Damage.new(Pos,v3(15,15,15),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) 
		coroutine.wrap(function()
			for i=1,random(30,65) do
				D:Check()
				Tween(Petal,{CFrame=Petal.CFrame*angles(0,75,0,true)},{.2})
				wait(random(.05,.15,100))
			end
			Sound(1837829122,3,random(.7,.9,100),P1,200,10)
			PE:Emit(random(30,60))
			SoundWave(Pos,2770705979,1,random(.9,1.1,100),70,35,true,1)
			Petal.Transparency=1
			Petal.SFX1:Stop() Petal.Particles.PE1.Enabled,Petal.Particles.PE2.Enabled=false,false for i,v in pairs(Petal:GetChildren()) do if v:IsA("Beam") then v.Enabled=false end end
			Tween(Dec,{Transparency=1},{.05})
			Tween(Li,{Color=c3()},{.05})
			Instance.Remove(P1,3)
		end)()
	end
end)
CrossClient:AddFunction("Event","CreateFBCHARImpact",function(Hit,Pos,Name)
	local D=Damage.new(Pos,v3(5,5,5),0,0,0,0,{char}) D:SetOnHitFunction(function(Hit) Sound(851453784,.75,random(.9,1.1,100),Hit,150,5) Sound(2974875851,.35,random(.9,1.1,100),Hit,150,5) end) D:Check()
	local A=ins("Attachment",{WorldPosition=Pos,Parent=Hit}) A.WorldPosition=Pos
	local PE=Models.SwitchExp:Clone() PE.Size=ns(5) PE.Parent,PE.Color=A,cs(Name~="Petal" and rgb(255,59,0) or rgb(9,137,207)) PE:Emit(random(10,20))
	if Name~="Petal" then Ignite(Hit) end
	Instance.Remove(A,3)
end)
--[[
CrossClient:AddFunction("Event","SwitchMode",function(Key)
	if Using then return end
	Switch(Key)
end) ]]
CrossClient:AddFunction("Event","DJ",function()
	Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B
	local DJPE1,DJPE2,DJPE3,DJPE4=Models.DJPE1:Clone(),Models.DJPE2:Clone(),Models.DJPE2:Clone(),Models.DJPE3:Clone()
	local A=ins("Attachment",{Orientation=v3(90,0,0),Parent=t})
	local Hit,Pos,NID=Raycast(t.Position,v3(0,-1,0),{Char},15,false)
	if Hit then
		for i=1,random(2,5) do
			local Time=random(1.5,7.5,100)
			local P=ins("Part",{Size=v3(0,0,0),Transparency=1,CanCollide=false,Anchored=true,Locked=true,Massless=true,CFrame=cf(Pos,Pos-NID)*angles(90,0,0,true)*angles(0,random(-180,180,10),0),Parent=Effects})
			local M=ins("BlockMesh",{Scale=v3(15,0,15)*20,Parent=P})
			local Dec=ins("Decal",{Texture="rbxassetid://453789629",Transparency=.15,Face="Top",Parent=P})
			Tween(M,{Scale=v3(110,0,110)*20},{Time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
			Tween(Dec,{Transparency=1},{Time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0})
			Instance.Remove(P,Time)
		end
		local PImp=ins("Part",{Anchored=true,CanCollide=false,Transparency=1,CFrame=cf(Pos,Pos-NID)*angles(90,0,0,true),Parent=Effects})
		local A=ins("Attachment",{Orientation=v3(90,0,0),Parent=PImp})
		local DJImpact=Models.DJImpact:Clone()
		DJImpact.Parent=A
		DJImpact:Emit(100)
		Instance.Remove(PImp,5)
	end
	Sound(689786169,1.35,random(.9,1.1,100),t,125,5).TimePosition=.1
	Sound(1842444531,.85,random(.9,1.1,100),t,125,5)--.TimePosition=.1
	Sound(1842431666,.75,random(.9,1.1,100),t,125,5)--.TimePosition=.1
	DJPE2.Color,DJPE3.Color=cs(C1),cs(C2)
	DJPE1.Parent,DJPE2.Parent,DJPE3.Parent,DJPE4.Parent=A,A,A,A
	DJPE1:Emit(250) DJPE2:Emit(25) DJPE3:Emit(25)
	SoundWave(t.Position+t.Velocity/2,2770705979,1,random(.9,1.1,100),70,60,true,.5)
	coroutine.wrap(function()
		wait(.5)
		DJPE4.Enabled=false
		wait(1)
		DJPE2.Enabled,DJPE3.Enabled=false,false
	end)()
	Instance.Remove(A,5)
end)
--// Connections
table.insert(Events,UIS.InputBegan:Connect(nil,function(IO,L)
	if L then return end
	if IO.UserInputType==Enum.UserInputType.Keyboard then
		if IO.KeyCode==Enum.KeyCode.M then Muted=not Muted end
		if L then return end
		if not Using then
			if IO.KeyCode==Enum.KeyCode.F and Moves[Mode] then LastSitTick=tick() Moves[Mode]() return end
			for i,v in pairs(Modes.Modes) do
				if i==IO.KeyCode.Name then LastSitTick=tick() Switch(IO.KeyCode.Name) end
			end
		end
		if IO.KeyCode==Enum.KeyCode.X and not Sitting and not Using then
			LastSitTick=tick()
			if Equipped then PlayAnim(Anims.Equip) Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B end
			Using=true WS=0 Hum.WalkSpeed=WS LockWS=true PlayAnim(Anims.IdleSit) Sitting=true
		elseif IO.KeyCode==Enum.KeyCode.X and Sitting then
			LastSitTick=tick()
			Sitting=false WS=16 Hum.WalkSpeed=WS LockWS=false Using=false
		elseif IO.KeyCode==Enum.KeyCode.N then
			UniqueStance=not UniqueStance
		end
	elseif IO.UserInputType==Enum.UserInputType.MouseButton1 then
		if Using then return end
		PerformCombo()
	end
end))
table.insert(Events, game:GetService("UserInputService").InputBegan:Connect(function(lol, gameprocess)
	if Using then return end
	if (not gameprocess) then
		if lol.KeyCode == Enum.KeyCode.E then
			Switch("E")
		elseif lol.KeyCode == Enum.KeyCode.Q then
			Switch("Q")
		elseif lol.KeyCode == Enum.KeyCode.R then
			Switch("R")
		elseif lol.KeyCode == Enum.KeyCode.T then
			Switch("T")
		elseif lol.KeyCode == Enum.KeyCode.Y then
			Switch("Y")
		elseif lol.KeyCode == Enum.KeyCode.U then
			Switch("U")
		elseif lol.KeyCode == Enum.KeyCode.P then
			Switch("P")
		elseif lol.KeyCode == Enum.KeyCode.LeftBracket then
			Switch("LeftBracket")
		elseif lol.KeyCode == Enum.KeyCode.RightBracket then
			Switch("RightBracket")
		elseif lol.KeyCode == Enum.KeyCode.BackSlash then
			Switch("BackSlash")
		elseif lol.KeyCode == Enum.KeyCode.Backspace then
			Switch("Backspace")
		elseif lol.KeyCode == Enum.KeyCode.Equals then
			Switch("Equals")
		end
	end
end))
local hahaheaaea = game.Players.LocalPlayer:GetMouse()
table.insert(Events, hahaheaaea.Button1Down:Connect(function()
	if Using then return end
	PerformCombo()
end))
--Convert Here
for i,v in pairs(Char.Torso:GetChildren()) do
	if v.Name == "HalfRing" then
		v.Wing.Name = "Wing1"
		v.Wing.Name = "Wing2"
		v.Wing.Name = "Wing3"
		
		for i,v in pairs(v:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("Texture") then v.Transparency = 1 end
		end
	end
end
Char.Torso.HalfRing.Name = "HalfRing2"
local HalfRing1 = Char.Torso:FindFirstChild("HalfRing")
local HalfRing2 = Char.Torso:FindFirstChild("HalfRing2")

local Hat1 = Char:FindFirstChild("MeshPartAccessory"); if Hat1 then Hat1.Handle:BreakJoints() end
local Hat2 = Char:FindFirstChild("MeshPartAccessory1"); if Hat2 then Hat2.Handle:BreakJoints() end
local Hat3 = Char:FindFirstChild("MeshPartAccessory2"); if Hat3 then Hat3.Handle:BreakJoints() end
local Hat4 = Char:FindFirstChild("MeshPartAccessory3"); if Hat4 then Hat4.Handle:BreakJoints() end
local Hat5 = Char:FindFirstChild("ShadowBladeMasterAccessory"); if Hat5 then Hat5.Handle:BreakJoints() end
local Hat6 = Char:FindFirstChild("BladeMasterAccessory"); if Hat6 then Hat6.Handle:BreakJoints() end

if not Hat1 then HalfRing1.Wing1.Transparency = 0 end
if not Hat2 then HalfRing1.Wing2.Transparency = 0 end
if not Hat5 then HalfRing1.Wing3.Transparency = 0 end

if not Hat3 then HalfRing2.Wing1.Transparency = 0 end
if not Hat4 then HalfRing2.Wing2.Transparency = 0 end
if not Hat6 then HalfRing2.Wing3.Transparency = 0 end

local function Align(Part0,Part1,OffSetPos,OffsetAngles)
	local Pos = OffSetPos or CFrame.new(0,0,0)
	local Angles = OffsetAngles or CFrame.Angles(0,0,0)
	Part0.Velocity = Vector3.new(0,0,0)
	Part0.CFrame = Part1.CFrame * Pos * Angles
end

table.insert(Events,game:GetService("RunService").Heartbeat:Connect(function()
	if Hat1 then Align(Hat1.Handle, HalfRing1.Wing1, CFrame.new(0,0,0), CFrame.Angles(0,math.rad(90),math.rad(45))) end
	if Hat2 then Align(Hat2.Handle, HalfRing1.Wing2, CFrame.new(0,0,0), CFrame.Angles(0,math.rad(90),math.rad(45))) end
	if Hat5 then Align(Hat5.Handle, HalfRing1.Wing3, CFrame.new(0,0,0), CFrame.Angles(0,math.rad(90),math.rad(45))) end
		
	if Hat3 then Align(Hat3.Handle, HalfRing2.Wing1, CFrame.new(0,0,0), CFrame.Angles(0,math.rad(90),math.rad(45))) end
	if Hat4 then Align(Hat4.Handle, HalfRing2.Wing2, CFrame.new(0,0,0), CFrame.Angles(0,math.rad(90),math.rad(45))) end
	if Hat6 then Align(Hat6.Handle, HalfRing2.Wing3, CFrame.new(0,0,0), CFrame.Angles(0,math.rad(90),math.rad(45))) end
end))

local sussybaka
sussybaka = game:GetService("RunService").Heartbeat:Connect(function()
	if Global.Stopped == true then
		for i,v in pairs(jointyjointy) do v:Destroy() end
		LevIdleEffP:Destroy()
		HalfRing1:Destroy()
		HalfRing2:Destroy()
		sussybaka:Disconnect()
	end
	if Effects.Parent~=Char then Effects=ins("Model",{Name="Effects",Parent=Char}) end
	if Theme.Parent~=t then Instance.Remove(Theme) Theme=Sound(Modes.Modes[Mode].Theme.Id,Modes.Modes[Mode].Theme.Volume,Modes.Modes[Mode].Theme.Pitch,t,150,7.5,true) Theme.TimePosition=TimePos end
	Theme.SoundId,Theme.Volume,Theme.Pitch="rbxassetid://"..Modes.Modes[Mode].Theme.Id,not Muted and Modes.Modes[Mode].Theme.Volume or 0,Modes.Modes[Mode].Theme.Pitch TimePos=Theme.TimePosition Theme:Resume()
	Sine=Sine+Change
	local Direction=hum.MoveDirection
	if Direction.Magnitude==0 then Direction=t.Velocity/7.5 end
	local MoveZ=clamp((Direction*t.CFrame.LookVector).X+(Direction*t.CFrame.LookVector).Z,-1,1)
	local MoveX=clamp((Direction*t.CFrame.RightVector).X+(Direction*t.CFrame.RightVector).Z,-1,1)
	local Moving=(t.Velocity*v3(1,0,1)).Magnitude>.01
	local VerY=t.Velocity.Y
	local StandR,RPos,RNID=Raycast(t.CFrame*cf(t.Size.X/4,-t.Size.Y/2,0).Position,-t.CFrame.UpVector,{char},4,false)
	local StandL,LPos,LNID=Raycast(t.CFrame*cf(-t.Size.X/4,-t.Size.Y/2,0).Position,-t.CFrame.UpVector,{char},4,false)
	local StandC,CPos,CNID=Raycast(t.CFrame*cf(0,-t.Size.Y/2,0).Position,-t.CFrame.UpVector,{char,BLOODPARENT},4,false)
	local Stand=StandR or StandL or StandC
	hum.WalkSpeed,hum.JumpPower=(LockWS and WS or hum.WalkSpeed),(LockJP and JP or hum.JumpPower)
	EquippedPool=clamp(EquippedPool-1,0,120)
	RBT,LBT=clamp(RBT+((StandR and StandR.Name=="BP") and -.025 or .001),.1,1),clamp(LBT+((StandL and StandL.Name=="BP") and -.025 or .001),.1,1)
	if Sitting and Hum.MoveDirection.Magnitude~=0 then
		LastSitTick=tick()
		Sitting=false WS=16 Hum.WalkSpeed=WS LockWS=false Using=false
	elseif not Sitting and tick()-LastSitTick>=210 then
		LastSitTick=tick()
		Using=true WS=0 Hum.WalkSpeed=WS LockWS=true PlayAnim(Anims.IdleSit) Sitting=true
	end
	LIEPos.Position,LIEGyr.CFrame=CPos,cf(CPos,CPos-CNID)*angles(90,0,0,true)
	if Equipped and EquippedPool==0 and not Using then coroutine.wrap(function() Using=true PlayAnim(Anims.Equip) Equipped=false Parts.Ring.R1[1].Beam.Attachment1=Parts.Ring.R2[1].B Parts.Ring.R2[1].Beam.Attachment1=Parts.Ring.R1[1].B Using=false end)() end
	local T=Modes.Modes[Mode]
	B1.Color=T.Colours.Ring.Prim=="rb" and cs(hsv(tick()/5%1,.8,1),hsv(tick()/5%1,.8,1)) or cs(T.Colours.Ring.Prim,T.Colours.Ring.Sec)
	B2.Color=T.Colours.Ring.Sec=="rb" and cs(hsv(tick()/5%1,.8,1),hsv(tick()/5%1,.8,1)) or cs(T.Colours.Ring.Sec,T.Colours.Ring.Prim)
	for i,v in pairs(Parts) do
		if i=="Ring" then
			Parts.Ring.R1[1].Color=T.Colours.Ring.Prim=="rb" and hsv(tick()/5%1,.8,1) or T.Colours.Ring.Prim
			Parts.Ring.R2[1].Color=T.Colours.Ring.Sec=="rb" and hsv(tick()/5%1,.8,1) or T.Colours.Ring.Sec
			Parts.Ring.R1[1].Light.Color=Parts.Ring.R1[1].Color
			Parts.Ring.R2[1].Light.Color=Parts.Ring.R2[1].Color
		elseif string.sub(i,1,4)=="Wing" then
			for _,v in pairs(v) do
				pcall(function()
					v[1].Color=T.Colours[i].Prim=="rb" and hsv(tick()/5%1,.8,1) or T.Colours[i].Prim
					v[3].Color=T.Colours[i].Sec=="rb" and hsv(tick()/5%1,.8,1) or T.Colours[i].Sec
					v[1].Sparks.Color=T.Colours[i].Sec=="rb" and cs(hsv(tick()/5%1,.8,1),hsv(tick()/5%1,.8,1)) or cs(T.Colours[i].Sec)
					v[1].Trail.Color=T.Colours[i].Sec=="rb" and cs(hsv(tick()/5%1,1,1),hsv(tick()/5%1,1,1)) or cs(T.Colours[i].Sec)
				end)
			end
		end
	end
	for i,v in pairs(RB) do v.Transparency=RBT end for i,v in pairs(LB) do v.Transparency=LBT end
	C1,C2=T.Colours.Ring.Prim=="rb" and hsv(tick()/5%1,.8,1) or Modes.Modes[Mode].Colours.Ring.Prim,T.Colours.Ring.Sec=="rb" and hsv(tick()/5%1,.8,1) or Modes.Modes[Mode].Colours.Ring.Sec
	if not Moving and Stand then
		if Modes.Modes[Mode].Elevated and StandC and UniqueStance and not Sitting then LevIdleEff:Emit(1) if tick()-LastLevTick>.2 and StandC then LastLevTick=tick() local C=({C1,C2})[random(1,2)] local P=ins("Part",{Size=v3(),Anchored=true,CanCollide=false,Transparency=0,CFrame=cf(CPos,CPos-CNID)*angles(90,random(-180,180,10),0,true)*cf(0,2,0),Parent=BLOODPARENT}) local M=ins("SpecialMesh",{MeshType=Enum.MeshType.FileMesh,MeshId="rbxassetid://5880296360",TextureId="rbxassetid://5874730960",VertexColor=v3(C.r*5,C.g*5,C.b*5),Scale=v3(),Offset=v3(0,-2,0),Parent=P}) local L=ins("PointLight",{Color=C,Range=0,Brightness=1.5,Shadows=true,Parent=P}) Tween(L,{Range=30,Brightness=0},{.75,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0}) Tween(P,{Transparency=1},{.75,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0}) Tween(M,{Scale=v3(10,7.5,10),Offset=v3(0,1.2-2,0)},{.75,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0}) Instance.Remove(P,.75) end end
		Change=1
		local IdleVal=25
		nec.C0=nec.C0:Lerp(necC0*cf(0,0,0)*angles(sin(Sine/IdleVal)*2,cotan(Sine/(IdleVal*3))*7.5,0,true)*(Sitting and Anims.IdleSit[3][1][2].C0 or UniqueStance and Modes.Modes[Mode].Stance and Modes.Modes[Mode].Stance[1] or cf(0,0,0)*angles(0,0,0,true)),.1)
		rutj.C0=rutj.C0:Lerp(rutjC0*cf(0,.05*cos(Sine/IdleVal),.05*cotan(Sine/IdleVal))*angles(cotan(Sine/IdleVal)*2,sin(Sine/(IdleVal*3.5))*2.5,cotan(Sine/(IdleVal*2))*-4,true)*(Sitting and Anims.IdleSit[3][2][2].C0 or UniqueStance and Modes.Modes[Mode].Stance and Modes.Modes[Mode].Stance[2] or cf(0,0,0)*angles(0,0,0,true)),.1)
		if not Using then
			rs.C0=rs.C0:Lerp(rsC0*cf(0,-.05*cos(Sine/IdleVal),0)*angles(sin(Sine/IdleVal)*2.25,-sin(Sine/(IdleVal*3.5))*2.5,sin(Sine/IdleVal)*1.5,true)*(Sitting and Anims.IdleSit[3][3][2].C0 or UniqueStance and Modes.Modes[Mode].Stance and Modes.Modes[Mode].Stance[3] or (Equipped and cf(-0.2,-0.25,-0.1)*angles(5,10,45,true)*angles(5,0,0,true) or cf(-.1,-.035,.025)*angles(1.5,3,-2,true))),.1)
			ls.C0=ls.C0:Lerp(lsC0*cf(0,-.05*cos(Sine/IdleVal),0)*angles(sin(Sine/IdleVal)*2.25,-sin(Sine/(IdleVal*3.5))*2.5,sin(Sine/IdleVal)*-1.5,true)*(Sitting and Anims.IdleSit[3][4][2].C0 or UniqueStance and Modes.Modes[Mode].Stance and Modes.Modes[Mode].Stance[4] or cf(.1,-.035,.025)*angles(1.5,-3,2,true)),.1)
		end
		rh.C0=rh.C0:Lerp(rhC0*angles(0,UniqueStance and Modes.Modes[Mode].Stance.LegRot or 0,0,true)*cf(0,-.05*cos(Sine/IdleVal)+.025*cotan(Sine/(IdleVal*2)),0)*angles(cotan(Sine/IdleVal)*-2+sin(Sine/(IdleVal*3.5))*-1.25,0,cotan(Sine/(IdleVal*2))*6.5,true)*angles(0,UniqueStance and -Modes.Modes[Mode].Stance.LegRot or 0,0,true)*(Sitting and Anims.IdleSit[3][5][2].C0 or UniqueStance and Modes.Modes[Mode].Stance and Modes.Modes[Mode].Stance[5] or cf(0,0,0)*angles(0,-5,2.5,true)*angles(not StandR and -10 or 0,not StandL and -10 or 0,not StandR and -15 or 0,true)),.1)
		lh.C0=lh.C0:Lerp(lhC0*angles(0,UniqueStance and Modes.Modes[Mode].Stance.LegRot or 0,0,true)*cf(0,-.05*cos(Sine/IdleVal)-.025*cotan(Sine/(IdleVal*2)),0)*angles(cotan(Sine/IdleVal)*-2+sin(Sine/(IdleVal*3.5))*1.25,0,cotan(Sine/(IdleVal*2))*6.5,true)*angles(0,UniqueStance and -Modes.Modes[Mode].Stance.LegRot or 0,0,true)*(Sitting and Anims.IdleSit[3][6][2].C0 or UniqueStance and Modes.Modes[Mode].Stance and Modes.Modes[Mode].Stance[6] or cf(0,0,0)*angles(0,5,-2.5,true)*angles(not StandL and -10 or 0,not StandL and 10 or 0,not StandL and 15 or 0,true)),.1)
		if not StandC and (not StandR or not StandL) and (not MovingVel or not MovingVel.Parent) then
			MovingVel=ins("BodyVelocity",{Velocity=StandR and HRP.CFrame.RightVector*250 or StandL and -HRP.CFrame.RightVector*250,Parent=HRP})
			Instance.Remove(MovingVel,.1)
		end
		IdleVal=IdleVal*2
		Parts.Ring.R1[2].C0=Parts.Ring.R1[2].C0:Lerp(Equipped and t.CFrame:ToObjectSpace(ra.CFrame*cf(0,-ra.Size.Y/2,0))*angles(0,90,-90,true)*WCF*angles(0,Using and 0 or -15,0,true) or (Modes.WingSetup.Ring.R1.C0*cf(0,cotan(Sine/IdleVal)*.25,0)*angles(0,0,sin(Sine/IdleVal)*20,true)*angles(0,0,-clamp(hrp.Velocity.Y*4,-50,80),true)),Equipped and .25 or .1)
		Parts.Ring.R2[2].C0=Parts.Ring.R2[2].C0:Lerp(Modes.WingSetup.Ring.R2.C0*cf(0,cotan(Sine/IdleVal)*.25,0)*angles(0,0,-sin(Sine/IdleVal)*20,true)*angles(0,0,clamp(hrp.Velocity.Y*4,-50,80),true),.1)
		for i,v in pairs(Parts.WingR) do
			v[2].C0=v[2].C0:Lerp(Modes.WingSetup.WingR[i].C0*(Equipped and cf() or angles(-10+cos(Sine/IdleVal)*10,0,-cos(Sine/IdleVal)*15,true)),.1)
		end
		for i,v in pairs(Parts.WingL) do
			v[2].C0=v[2].C0:Lerp(Modes.WingSetup.WingL[i].C0*angles(-10+cos(Sine/IdleVal)*10,0,cos(Sine/IdleVal)*15,true),.1)
		end
	elseif Moving and Stand then
		LastSitTick=tick()
		local WSVal=6/clamp(hum.WalkSpeed/16,.25,2)*t.Size.Y/2
		local WSMul=(1+(WSVal/4))
		Change=1
		if not Modes.Modes[Mode].Idiotic then
			Change=.875
			nec.C0=nec.C0:Lerp(necC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(sin(Sine/(WSVal/2))*7.5,-sin(Sine/WSVal)*15,0,true)*angles(MoveZ/12,-MoveX/1.5,0),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
			rutj.C0=rutj.C0:Lerp(rutjC0*cf(0,-2,0)*angles(VerY*2.5*MoveZ,0,VerY*2.5*MoveX,true)*cf(0,2,0)*cf(0,0,0)*angles(0,0,0,true)*cf(-.5*(t.Size.Y/2)*sin(Sine/(WSVal/2))/(1+(WSVal/4))*MoveX,1.5*(t.Size.Y/2)*cos(Sine/(WSVal/2))/(1+(WSVal/4)),-.5*(t.Size.Y/2)*sin(Sine/(WSVal/2))/(1+(WSVal/4))*MoveZ)*angles(cos(Sine/(WSVal/2))*7.5*MoveZ,math.CosSin(Sine/WSVal)*35,cos(Sine/(WSVal/2))*7.5*MoveX,true)*angles((-MoveZ/7.5)*math.clamp((hum.WalkSpeed/16)/(t.Size.Y/2),.5,3.5),0,-MoveX/5),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
			rs.C0=rs.C0:Lerp(rsC0*cf(0,0,0)*angles(0,0,0,true)*(Equipped and cf(-0.1,-0.25,-0.1)*angles(5,10,65,true)*angles(5,0,0,true) or cf(-.1,-.035,.025)*angles(1.5,3,-2,true))*cf(0,0,(Equipped and .35 or .75)*(t.Size.Y/2)*sin(Sine/WSVal)/(1+(WSVal/4))*math.abs(MoveZ))*angles((Equipped and 3.5 or 7.5)-sin(Sine/WSVal)*(Equipped and 100 or 200)/(1+(WSVal/4))*MoveZ,-sin(Sine/WSVal)*(Equipped and 15 or 30),-(Equipped and 7 or 15)*MoveZ,true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
			ls.C0=ls.C0:Lerp(lsC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,-.75*(t.Size.Y/2)*sin(Sine/WSVal)/(1+(WSVal/4))*math.abs(MoveZ))*angles(7.5+sin(Sine/WSVal)*200/(1+(WSVal/4))*MoveZ,-sin(Sine/WSVal)*30,15*MoveZ,true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
			rh.C0=rh.C0:Lerp(rhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,.5*(t.Size.Y/2)*cos(Sine/WSVal),-.15-(1)*(t.Size.Y/2)*cos(Sine/WSVal))*angles(-5+math.clamp((sin(Sine/WSVal)*200/(1+(WSVal/4)))*MoveZ,-130,130),cos(Sine/WSVal)*5,(sin(Sine/WSVal)*60)*MoveX,true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
			lh.C0=lh.C0:Lerp(lhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,-.5*(t.Size.Y/2)*cos(Sine/WSVal),-.15+(1)*(t.Size.Y/2)*cos(Sine/WSVal))*angles(-5-math.clamp((sin(Sine/WSVal)*200/(1+(WSVal/4)))*MoveZ,-130,130),cos(Sine/WSVal)*5,-(sin(Sine/WSVal)*60)*MoveX,true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		else
			nec.C0=nec.C0:Lerp(necC0*cf(0,0,0)*angles(cotan(Sine/(WSVal/2))*25,0,cos(Sine/WSVal)*35,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3) --*cf((VerY/7.5)*MoveX,1*clamp(abs(VerY),0,1),(-VerY/7.5)*MoveZ)
			rutj.C0=rutj.C0:Lerp(rutjC0*cf(0,-2,0)*angles(VerY*2.5*MoveZ,0,VerY*2.5*MoveX,true)*cf(0,2,0)*cf(cos(Sine/(WSVal/2))*MoveX,sin(Sine/(WSVal/2)),cos(Sine/(WSVal/2))*MoveZ)*angles(cotan(Sine/(WSVal/2))*50*MoveZ,sin(Sine/WSVal)*35,cotan(Sine/(WSVal/2))*50*MoveX,true)*cf(0,0,0)*angles(0,0,0,true)*angles(-10*MoveZ,0,-10*MoveX,true),.2/(t.Size.Y/2)*(WSVal)/3)
			if not Using then
				rs.C0=rs.C0:Lerp(rsC0*cf(0,0,.25*-cos(Sine/WSVal)*MoveZ)*angles(cos(Sine/WSVal)*170*MoveZ,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
				ls.C0=ls.C0:Lerp(lsC0*cf(0,0,.25*cos(Sine/WSVal)*MoveZ)*angles(-cos(Sine/WSVal)*170*MoveZ,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
			end
			rh.C0=rh.C0:Lerp(rhC0*cf(0,.5*-cos(Sine/WSVal),.5*cos(Sine/WSVal))*angles(-cotan(Sine/WSVal)*120*MoveZ,0,-cotan(Sine/WSVal)*120*MoveX,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
			lh.C0=lh.C0:Lerp(lhC0*cf(0,.5*cos(Sine/WSVal),.5*-cos(Sine/WSVal))*angles(cotan(Sine/WSVal)*120*MoveZ,0,cotan(Sine/WSVal)*120*MoveX,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		end
		if not StandC and (not StandR or not StandL) and (not MovingVel or not MovingVel.Parent) then
			hrp.Velocity=StandR and HRP.CFrame.RightVector*5 or StandL and -HRP.CFrame.RightVector*5
		end
		Parts.Ring.R1[2].C0=Parts.Ring.R1[2].C0:Lerp(Equipped and t.CFrame:ToObjectSpace(ra.CFrame*cf(0,-ra.Size.Y/2,0))*angles(0,90,-90,true)*WCF*angles(0,Using and 0 or -15,0,true) or Modes.WingSetup.Ring.R1.C0*cf(clamp(.5*-MoveZ,0,.5),cotan(Sine/(WSVal/2))*.25,-clamp(.5*-MoveZ,0,.25))*angles(0,clamp(-35*MoveZ,-35,20)+clamp(-50*MoveX,-50,0),sin(Sine/(WSVal/2))*10,true)*angles(0,0,-clamp(hrp.Velocity.Y*4,-50,80),true),Equipped and .25 or .2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		Parts.Ring.R2[2].C0=Parts.Ring.R2[2].C0:Lerp(Modes.WingSetup.Ring.R1.C0*cf(-clamp(.5*-MoveZ,0,.5),cotan(Sine/(WSVal/2))*.25,-clamp(.5*-MoveZ,0,.25))*angles(0,clamp(35*MoveZ,-20,35)-clamp(50*MoveX,-50,0),-sin(Sine/(WSVal/2))*10,true)*angles(0,0,clamp(hrp.Velocity.Y*4,-50,80),true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		for i,v in pairs(Parts.WingR) do
			v[2].C0=v[2].C0:Lerp(Modes.WingSetup.WingR[i].C0*(Equipped and cf() or angles(-10+cos(Sine/WSVal)*10,0,-cos(Sine/WSVal)*10,true)),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		end
		for i,v in pairs(Parts.WingL) do
			v[2].C0=v[2].C0:Lerp(Modes.WingSetup.WingL[i].C0*angles(-10+cos(Sine/WSVal)*10,0,cos(Sine/WSVal)*10,true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		end
		--thanks to kyu or neb.. whatever
		if cos(Sine/WSVal)/2>.2 and Step=="L" then
			Step="R"
			if StandR then
				local SoundId=StepSounds[StandR.Material.Name] or 0
				if StandR.Material==Enum.Material.Sand and (StandR.Color.r>.7 and StandR.Color.g>.7 and StandR.Color.b>.7) then SoundId=StepSounds["Snow"] end  if StandR.Name=="Water" then  SoundId=StepSounds.Water end
				local SizeVal=StandR.Size*RNID
				if SoundId==941640049 then
					SizeVal=SizeVal/2
				end
				Sound(SoundId,(.35*clamp((WSVal)/1.5,.5,3.5))/clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z),.5,1.25),random(.9,1.1,100)*clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z)/10,.5,1.2)*clamp((WSVal)/1.5,.5,2),t)
				if RBT<1 then
					local P=ins("Part",{Massless=true,Locked=true,CanCollide=false,Anchored=false,Size=v3(1,1,0),Material="Glass",Color=bc("Maroon").Color,Transparency=RBT,CFrame=cf(RPos,RPos-RNID)*angles(0,0,rl.Orientation.Y,true)})
					local W=ins("WeldConstraint",{Part0=StandR,Part1=P,Parent=StandR}) P.Parent=W
					Sound(685857471,.1,random(.8,1.1,100),P,50,5)
					Instance.Remove(P,5)
				end
			end
		end
		if cos(Sine/WSVal)/2<-.2 and Step=="R" then
			Step="L"
			if StandL then
				local SoundId=StepSounds[StandL.Material.Name] or 0
				if StandL.Material==Enum.Material.Sand and (StandL.Color.r>.7 and StandL.Color.g>.7 and StandL.Color.b>.7) then SoundId=StepSounds["Snow"] end if StandL.Name=="Water" then SoundId=StepSounds.Water end
				local SizeVal=StandL.Size*LNID
				if SoundId==941640049 then
					SizeVal=SizeVal/2
				end
				Sound(SoundId,(.35*clamp((WSVal)/1.5,.5,3.5))/clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z),.5,1.25),random(.9,1.1,100)*clamp(math.max(SizeVal.X,SizeVal.Y,SizeVal.Z)/10,.5,1.2)*clamp((WSVal)/1.5,.5,2),t)
				if LBT<1 then
					local P=ins("Part",{Massless=true,Locked=true,CanCollide=false,Anchored=false,Size=v3(1,1,0),Material="Glass",Color=bc("Maroon").Color,Transparency=LBT,CFrame=cf(LPos,LPos-LNID)*angles(0,0,ll.Orientation.Y,true)})
					local W=ins("WeldConstraint",{Part0=StandL,Part1=P,Parent=StandL}) P.Parent=W
					Sound(685857471,.1,random(.8,1.1,100),P,50,5)
					Instance.Remove(P,5)
				end
			end
		end
		--[[
		nec.C0=nec.C0:Lerp(necC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		rutj.C0=rutj.C0:Lerp(rutjC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		rs.C0=rs.C0:Lerp(rsC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		ls.C0=ls.C0:Lerp(lsC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		rh.C0=rh.C0:Lerp(rhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		lh.C0=lh.C0:Lerp(lhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		
		nec.C0=nec.C0:Lerp(necC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		rutj.C0=rutj.C0:Lerp(rutjC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		rs.C0=rs.C0:Lerp(rsC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		ls.C0=ls.C0:Lerp(lsC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		rh.C0=rh.C0:Lerp(rhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		lh.C0=lh.C0:Lerp(lhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.2/(t.Size.Y/2)*(WSVal)/3)
		
		-																									-
		
		Joints.Neck.C0=Joints.Neck.C0:Lerp(Joints.Neck.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.Root.C0=Joints.Root.C0:Lerp(Joints.Root.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.Waist.C0=Joints.Waist.C0:Lerp(Joints.Waist.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.RightShoulder.C0=Joints.RightShoulder.C0:Lerp(Joints.RightShoulder.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.RightElbow.C0=Joints.RightElbow.C0:Lerp(Joints.RightElbow.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.RightWrist.C0=Joints.RightWrist.C0:Lerp(Joints.RightWrist.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.LeftShoulder.C0=Joints.LeftShoulder.C0:Lerp(Joints.LeftShoulder.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.LeftElbow.C0=Joints.LeftElbow.C0:Lerp(Joints.LeftElbow.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.LeftWrist.C0=Joints.LeftWrist.C0:Lerp(Joints.LeftWrist.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.RightHip.C0=Joints.RightHip.C0:Lerp(Joints.RightHip.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.RightKnee.C0=Joints.RightKnee.C0:Lerp(Joints.RightKnee.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.RightAnkle.C0=Joints.RightAnkle.C0:Lerp(Joints.RightAnkle.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.LeftHip.C0=Joints.LeftHip.C0:Lerp(Joints.LeftHip.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.LeftKnee.C0=Joints.LeftKnee.C0:Lerp(Joints.LeftKnee.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		Joints.LeftAnkle.C0=Joints.LeftAnkle.C0:Lerp(Joints.LeftAnkle.Link.C0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(0,0,0,true),.1)
		--]]
	elseif not Stand then
		LastSitTick=tick()
		if MovingVel then MovingVel:Destroy() end
		Change=1
		nec.C0=nec.C0:Lerp(necC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(clamp(hrp.Velocity.Y,-15,15),0,0,true),.2)
		rutj.C0=rutj.C0:Lerp(rutjC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,0,0)*angles(clamp(hrp.Velocity.Y,-30,20),0,0,true),.2)
		if not Using then
			rs.C0=rs.C0:Lerp(rsC0*cf(0,0,0)*angles(0,5,-7.5,true)*cf(-(clamp(hrp.Velocity.Y/20,-.45,0)),0,0)*angles((clamp(hrp.Velocity.Y*4,0,150)),0,-(clamp(hrp.Velocity.Y*4,-120,0)),true),.2)
			ls.C0=ls.C0:Lerp(lsC0*cf(0,0,0)*angles(0,-5,7.5,true)*cf((clamp(hrp.Velocity.Y/20,-.45,0)),0,0)*angles((clamp(hrp.Velocity.Y*4,0,150)),0,(clamp(hrp.Velocity.Y*4,-120,0)),true),.2)
		end	
		rh.C0=rh.C0:Lerp(rhC0*cf(0,0,0)*angles(0,0,0,true)*cf(0,.4,-.35)*angles(-10,-5,5,true),.2)
		lh.C0=lh.C0:Lerp(lhC0*cf(0,0,0)*angles(clamp(-hrp.Velocity.Y,-25,35),0,0,true)*cf(0,.2,-.15)*angles(-2.5,5,-5,true),.2)
		Parts.Ring.R1[2].C0=Parts.Ring.R1[2].C0:Lerp(Equipped and t.CFrame:ToObjectSpace(ra.CFrame*cf(0,-ra.Size.Y/2,0))*angles(0,90,-90,true)*WCF*angles(0,Using and 0 or -15,0,true) or Modes.WingSetup.Ring.R1.C0*cf(clamp(.5*-MoveZ,0,.5),cotan(Sine/(20/2))*.25,-clamp(.5*-MoveZ,0,.25))*angles(0,clamp(-35*MoveZ,-35,20)+clamp(-50*MoveX,-50,0),sin(Sine/(20/2))*10,true)*angles(0,0,-clamp(hrp.Velocity.Y*4,-50,80),true),Equipped and .25 or .2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		Parts.Ring.R2[2].C0=Parts.Ring.R2[2].C0:Lerp(Modes.WingSetup.Ring.R1.C0*cf(-clamp(.5*-MoveZ,0,.5),cotan(Sine/(20/2))*.25,-clamp(.5*-MoveZ,0,.25))*angles(0,clamp(35*MoveZ,-20,35)-clamp(50*MoveX,-50,0),-sin(Sine/(20/2))*10,true)*angles(0,0,clamp(hrp.Velocity.Y*4,-50,80),true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		for i,v in pairs(Parts.WingR) do
			v[2].C0=v[2].C0:Lerp(Modes.WingSetup.WingR[i].C0*(Equipped and cf() or angles(-10+cos(Sine/20)*10,0,-cos(Sine/20)*10,true)),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		end
		for i,v in pairs(Parts.WingL) do
			v[2].C0=v[2].C0:Lerp(Modes.WingSetup.WingL[i].C0*angles(-10+cos(Sine/20)*10,0,cos(Sine/20)*10,true),.2/(t.Size.Y/2)*(hum.WalkSpeed/16)/3)
		end
	end
	if Type=="R6" and not Using then
		nec.C1=nec.C1:Lerp(necC1,.2)
		rutj.C1=rutj.C1:Lerp(rutjC1,.2)
		rs.C1=rs.C1:Lerp(rsC1,.2)
		ls.C1=ls.C1:Lerp(lsC1,.2)
		rh.C1=rh.C1:Lerp(rhC1,.2)
		lh.C1=lh.C1:Lerp(lhC1,.2)
		necC0,necC1=cf(0,t.Size.Y/2,0),cf(0,-h.Size.Y/2,0)
		rutjC0,rutjC1=cf(0,0,0),cf(0,0,0)
		rsC0,rsC1=cf(t.Size.X/2,t.Size.Y/4,0),cf(-ra.Size.X/2,ra.Size.Y/4,0)
		lsC0,lsC1=cf(-t.Size.X/2,t.Size.Y/4,0),cf(la.Size.X/2,la.Size.Y/4,0)
		rhC0,rhC1=cf(t.Size.X/4,-t.Size.Y/2,0),cf(0,rl.Size.Y/2,0)
		lhC0,lhC1=cf(-t.Size.X/4,-t.Size.Y/2,0),cf(0,ll.Size.Y/2,0)
	end
end)
