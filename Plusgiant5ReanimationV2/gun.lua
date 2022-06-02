_G.e = _G.e and _G.e + 1 or 0
wait()
local frame = 0
local good = _G.e
local plr = game.Players.LocalPlayer
local char = plr.Character
local hum = char.Humanoid
local torso = char.Torso
local head = char.Head
local hrp = char.HumanoidRootPart
local rs,ls,rh,lh,n,r = torso["Right Shoulder"],torso["Left Shoulder"],torso["Right Hip"],torso["Left Hip"],torso.Neck,hrp.RootJoint
local rso,lso,rho,lho,no,ro = rs.C0,ls.C0,rh.C0,lh.C0,n.C0,r.C0
local rad = math.rad
local deg = math.deg
local min = math.min
local max = math.max
local sin = math.sin
local cos = math.cos
local mouse = plr:GetMouse()
local zoom = 10
local reanimating = _G.Get
local uis = game:GetService("UserInputService")
local gun = Instance.new("Part")
gun.Size = Vector3.new(3.362, 1.273, 0.296)
gun.CanCollide = false
gun.Massless = true
local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://7667204705"
mesh.TextureId = "http://www.roblox.com/asset/?id=7667119641"
mesh.Parent = gun
gun.Parent = char
local gg = Instance.new("Motor6D")
gg.C1 = CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(0))
gg.Part0 = char.HumanoidRootPart
gg.Part1 = gun
gg.Parent = char.HumanoidRootPart
local bullet = Instance.new("Part")
bullet.Size = Vector3.new(1,1,1)
bullet.CanCollide = false
bullet.Massless = true
bullet.Anchored = true
bullet.Parent = workspace
local mousepart = Instance.new("Part")
mousepart.Size = Vector3.new(1,1,1)
mousepart.CanCollide = false
mousepart.Massless = true
mousepart.Anchored = true
mousepart.Transparency = 1
mousepart.Parent = workspace
local mouseray = RaycastParams.new()
mouseray.FilterType = Enum.RaycastFilterType.Blacklist
mouseray.FilterDescendantsInstances = {bullet,gun,mousepart}
mouseray.IgnoreWater = true
local rstepped = game:GetService("RunService").RenderStepped
if char:FindFirstChild("Animate") then
	char.Animate:Destroy()
	for _,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do 
		v:Stop()
	end 
end
local lerpdb = {}
function lerp(joint,target,speed,usespawn)
	local e
	local function doit(joint,target,speed)
		if not lerpdb[joint] then
			lerpdb[joint] = true
			local old = joint.C0
			local tar = max(speed*60,1)
			for i = 0,tar do
				if _G.e == good then
					joint.C0 = old:lerp(target,i/tar)
					rstepped:Wait()
				else
					break
				end
			end
			lerpdb[joint] = nil
		end
	end
	if usespawn then
		local HAX = Instance.new("BindableEvent")
		e = HAX.Event:Connect(function()
			doit(joint,target,speed)
			HAX:Destroy()
		end)
		HAX:Fire()
	else
		doit(joint,target,speed)
	end
end
local pose = "idle"
local mainloop
function endscript()
	mainloop:Disconnect()
	gg:Destroy()
	gun:Destroy()
	bullet:Destroy()
	rs.C0 = rso
	ls.C0 = lso
	rh.C0 = rho
	lh.C0 = lho
	n.C0 = no
	r.C0 = ro
end
local aiming = false
local shooting = false
uis.InputBegan:Connect(function(k,a)
	if k.KeyCode == Enum.KeyCode.E then
		aiming = not aiming
		if not aiming then
			shooting = false
		end
	elseif k.UserInputType == Enum.UserInputType.MouseButton1 and aiming then
		shooting = true
	end
end)
uis.InputEnded:Connect(function(k,a)
	if k.UserInputType == Enum.UserInputType.MouseButton1 and aiming then
		shooting = false
	end
end)
local angle
local look
local lookz,lookx,looky
local realhrp = reanimating and _G:GetCharPart("HumanoidRootPart")
if reanimating then
	table.insert(mouseray.FilterDescendantsInstances,char.Parent)
else
	table.insert(mouseray.FilterDescendantsInstances,char)
end
gun.Transparency = reanimating and 1 or 0
bullet.Transparency = reanimating and 1 or 0
local gunatt = reanimating and _G:Get("Meshes/CRL4Accessory")
local bulletatt = reanimating and _G:Get("RockAccessory")
local hrpatt = reanimating and _G:Get("HumanoidRootPart")
mainloop = rstepped:Connect(function()
	if _G.e ~= good or not char or not char.Parent then
		endscript()
		return
	end
	--local ray = mouse.UnitRay
	--ray.Direction *= 1000
	local oldhrp
	if reanimating then
		oldhrp = realhrp.Position
		realhrp.Position = Vector3.new(0,0,0)
	end
	local rayhit = workspace:Raycast(mouse.UnitRay.Origin,mouse.UnitRay.Direction*99999,mouseray)
	rayhit = (rayhit and rayhit.Position) or mouse.hit.p
	if reanimating then
		realhrp.Position = oldhrp
	end
	frame += 1
	zoom = (workspace.CurrentCamera.CFrame.p-head.Position).magnitude
	local move = hum.MoveDirection ~= Vector3.new(0,0,0)
	if pose ~= "aiming" then
		if move then
			pose = "walking"
		else
			pose = "idle"
		end
	end
	local basespeed = .2
	local breath = sin(rad(frame*7))/60
	local recoil = sin(rad(frame*55))/5+.06
	local recoilverticalmult = math.random(10,100)/100
	local recoilhorizontalmult = math.random(10,40)/100
	local hrpp = gun.Position
	local hitp = rayhit
	pcall(function()
		angle = deg(math.atan2(hrpp.X-hitp.X,hrpp.Z-hitp.Z))
		look = CFrame.new(hrpp,hitp)
		lookz,lookx,looky = look:ToOrientation()
	end)
	local bulletspeed = 6
	mousepart.Position = Vector3.new(hitp.X,workspace.FallenPartsDestroyHeight+10,hitp.Z)
	if aiming and angle then
		if shooting then
			
			lerp(gg,rso*CFrame.Angles(0,rad(180),-lookz)*CFrame.new(-2.3+recoil,.25+(recoil*recoilverticalmult),1+(recoil*recoilhorizontalmult)),0,true)
			
			lerp(rs,rso*CFrame.new(.1-recoil,recoil*recoilverticalmult,-.5+(recoil*recoilhorizontalmult))*CFrame.Angles(rad(0),rad(25),rad(90+deg(lookz))),0,true)
			lerp(ls,lso*CFrame.new(-.7+recoil,recoil*recoilverticalmult,-.6+(recoil*recoilhorizontalmult))*CFrame.Angles(rad(5),rad(-17),rad(-90-deg(lookz))),0,true)
			
			if frame % (bulletspeed*2) >= bulletspeed then
				bullet.CFrame = gun.CFrame
			else
				if frame % (bulletspeed*2) == 1 then
					bullet.CFrame = CFrame.new(hitp)
				else
					bullet.CFrame = bullet.CFrame
				end
			end
			
			if reanimating then
				--hrpatt.Position = hitp
			end
		else
			lerp(gg,rso*CFrame.Angles(0,rad(180),-lookz)*CFrame.new(-2.3,.25,1),0,true)
			
			lerp(rs,rso*CFrame.new(.1,0,-.5)*CFrame.Angles(rad(0),rad(25),rad(90+deg(lookz))),0,true)
			lerp(ls,lso*CFrame.new(-.7,0,-.6)*CFrame.Angles(rad(5),rad(-17),rad(-90-deg(lookz))),0,true)
			
			if reanimating then
				--hrpatt.Position = hrp.Position + Vector3.new(0,10,0)
			end
			
			bullet.CFrame = hrp.CFrame
		end
		
		lerp(n,no*CFrame.new(0,0,0)*CFrame.Angles(-lookz/2,0,0),0,true)
		
		hrp.CFrame *= hrp.CFrame.Rotation:inverse()*CFrame.Angles(rad(0),rad(angle),rad(0))
		
		if shooting then
			mousepart.Position = hitp
		end
	else
		bullet.CFrame = hrp.CFrame
		lerp(gg,rso*CFrame.new(0,breath-1,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
		if pose == "walking" then
			lerp(rs,rso*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(sin(rad((frame)*12))*30)),0,true)
			lerp(ls,lso*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(sin(rad((frame)*12))*30)),0,true)
		else
			lerp(rs,rso*CFrame.new(0,breath,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
			lerp(ls,lso*CFrame.new(0,breath,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
		end
		
		lerp(n,no*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
	end
	if pose == "idle" then
		lerp(rh,rho*CFrame.new(0,breath,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
		lerp(lh,lho*CFrame.new(0,breath,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
		
		lerp(r,ro*CFrame.new(0,0,breath)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
		
		lerp(n,no*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
	elseif pose == "walking" then
		lerp(rh,rho*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(sin(rad(frame*12+180))*30)),0,true)
		lerp(lh,lho*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(sin(rad(frame*12+180))*30)),0,true)
		
		lerp(r,ro*CFrame.new(0,0,breath)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
		
		lerp(n,no*CFrame.new(0,0,0)*CFrame.Angles(rad(0),rad(0),rad(0)),basespeed,true)
	end
end)
hum.WalkSpeed = 20
if reanimating then
	gunatt.Position = Vector3.new(0,0,-.6)
	gunatt.Orientation = Vector3.new(0,0,-40)
	gunatt.Parent = gun
	pcall(function()
		_G:Block("RockAccessory")
	end)
	bulletatt.Position = Vector3.new(-.75,-1.1,0)
	bulletatt.Orientation = Vector3.new(0,0,0)
	bulletatt.Parent = bullet
	hrpatt.Position = Vector3.new()
	hrpatt.Orientation = Vector3.new()
	hrpatt.Parent = mousepart
	_G:GetCharPart("RockAccessory").Handle.CanQuery = false
	realhrp.CanQuery = false
	mousepart.CanQuery = false
	bullet.CanQuery = false
	gun.CanQuery = false
	table.insert(mouseray.FilterDescendantsInstances,realhrp)
end
