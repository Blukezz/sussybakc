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