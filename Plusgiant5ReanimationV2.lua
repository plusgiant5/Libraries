local netlessmult = _G.netlessmult or 1
local safenetless = _G.safenetless or false



local connections = {}
connections[#connections+1] = game:GetService("RunService").RenderStepped:Connect(function()
	for _,v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer then
			sethiddenproperty(v,"SimulationRadius",0)
			sethiddenproperty(v,"MaxSimulationRadius",0)
		end
	end
	setsimulationradius(math.huge)
end)
function SendNotification(s)
	game.StarterGui:SetCore("SendNotification",{Title="Plusgiant5's Reanimation V2",Text=s})
end
local plr = game.Players.LocalPlayer
local char = plr.Character
local hum = char.Humanoid
local rig = string.split(tostring(hum.RigType),".")[3]
local hrp = char.HumanoidRootPart
local attached = {}
function attach(part,offsetpos,offsetori,customname)
	assert(part,"PART NO EXIST!")
	part.CustomPhysicalProperties = PhysicalProperties.new(1000.0001, 0.0001, 0.0001, 0.0001, 0.0001)
	part.Orientation = Vector3.new(0,0,0)
	part.Massless = true
	local root = Instance.new("Attachment")
	root.Parent = part
	local att = Instance.new("Attachment")
	
	if offsetpos then
		local ap = Instance.new("AlignPosition")
		ap.MaxForce = math.huge
		ap.MaxVelocity = math.huge
		ap.ReactionForceEnabled = false
		ap.Responsiveness = math.huge
		ap.Attachment0 = root
		ap.Attachment1 = att
		ap.RigidityEnabled = false
		ap.Name = "rAP"
		ap.Parent = part
	end
	
	if offsetori then
		local ao = Instance.new("AlignOrientation")
		ao.Attachment1 = att
		ao.Attachment0 = root
		ao.MaxTorque = math.huge
		ao.Responsiveness = math.huge
		ao.Name = "rAO"
		ao.Parent = part
	end
	
	root.Position = offsetpos or Vector3.new()
	root.Orientation = offsetori or Vector3.new()
	root.Name = "rA"
	
	part.CanCollide = false
	local nets = {}
	local net1 = game:GetService("RunService").Heartbeat:Connect(function()
		part.Velocity = Vector3.new(30*netlessmult,0,0)
	end)
	table.insert(nets,net1)
	table.insert(connections,net1)
	if not safenetless then
		local net2 = game:GetService("RunService").RenderStepped:Connect(function()
			part.Velocity = Vector3.new(0,0,0)
		end)
		table.insert(nets,net2)
		table.insert(connections,net2)
	end
	attached[customname or part.Name] = att
	local loop = game:GetService("RunService").Stepped:Connect(function()
		if not att or not att.Parent then
			pcall(function()
				ao:Destroy()
			end)
			pcall(function()
				ap:Destroy()
			end)
			pcall(function()
				root:Destroy()
			end)
			pcall(function()
				--part.Parent = workspace
			end)
			for _,v in pairs(nets) do
				v:Disconnect()
			end
		end
	end)
	table.insert(nets,loop)
	table.insert(connections,loop)
	return att
end
SendNotification("Reanimating "..rig)













--Converted with ttyyuu12345's model to script plugin v4 (Edited by greeny2340)
function sandbox(var,func)
	local env = getfenv(func)local newenv = setmetatable({},{__index = function(self,k)if k=="script" then return var else return env[k] end end, }) setfenv(func,newenv)return func
end
cors = {}mas = Instance.new("Model")
dummy = Instance.new("Model")
Part1 = Instance.new("Part")
SpecialMesh2 = Instance.new("SpecialMesh")
Decal3 = Instance.new("Decal")
Part4 = Instance.new("Part")
Decal5 = Instance.new("Decal")
Motor6D6 = Instance.new("Motor6D")
Motor6D7 = Instance.new("Motor6D")
Motor6D8 = Instance.new("Motor6D")
Motor6D9 = Instance.new("Motor6D")
Motor6D10 = Instance.new("Motor6D")
Part11 = Instance.new("Part")
Part12 = Instance.new("Part")
Part13 = Instance.new("Part")
Part14 = Instance.new("Part")
Humanoid15 = Instance.new("Humanoid")
Part16 = Instance.new("Part")
Sound17 = Instance.new("Sound")
Sound18 = Instance.new("Sound")
Sound19 = Instance.new("Sound")
Sound20 = Instance.new("Sound")
Sound21 = Instance.new("Sound")
Sound22 = Instance.new("Sound")
Sound23 = Instance.new("Sound")
Sound24 = Instance.new("Sound")
Sound25 = Instance.new("Sound")
Motor6D26 = Instance.new("Motor6D")
dummy.Name = plr.Name
dummy.Parent = mas
dummy.PrimaryPart = Part1
Part1.Name = [[Head]]
Part1.Parent = dummy
Part1.CFrame = CFrame.new(-5.5, 4.5, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part1.Position = Vector3.new(-5.5, 4.5, -9)
Part1.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part1.Size = Vector3.new(2, 1, 1)
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.FormFactor = Enum.FormFactor.Symmetric
Part1.formFactor = Enum.FormFactor.Symmetric
SpecialMesh2.Parent = Part1
SpecialMesh2.Scale = Vector3.new(1.25, 1.25, 1.25)
Decal3.Name = [[face]]
Decal3.Parent = Part1
Decal3.Texture = [[rbxasset://textures/face.png]]
Part4.Name = [[Torso]]
Part4.Parent = dummy
Part4.CFrame = CFrame.new(-5.5, 3, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part4.Position = Vector3.new(-5.5, 3, -9)
Part4.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part4.Size = Vector3.new(2, 2, 1)
Part4.LeftParamA = 0
Part4.LeftParamB = 0
Part4.LeftSurface = Enum.SurfaceType.Weld
Part4.RightParamA = 0
Part4.RightParamB = 0
Part4.RightSurface = Enum.SurfaceType.Weld
Part4.FormFactor = Enum.FormFactor.Symmetric
Part4.formFactor = Enum.FormFactor.Symmetric
Decal5.Name = [[roblox]]
Decal5.Parent = Part4
Motor6D6.Name = [[Right Shoulder]]
Motor6D6.Parent = Part4
Motor6D6.MaxVelocity = 0.10000000149011612
Motor6D6.C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Motor6D6.C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Motor6D6.Part0 = Part4
Motor6D6.Part1 = Part12
Motor6D6.part1 = Part12
Motor6D7.Name = [[Left Shoulder]]
Motor6D7.Parent = Part4
Motor6D7.MaxVelocity = 0.10000000149011612
Motor6D7.C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Motor6D7.C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Motor6D7.Part0 = Part4
Motor6D7.Part1 = Part11
Motor6D7.part1 = Part11
Motor6D8.Name = [[Right Hip]]
Motor6D8.Parent = Part4
Motor6D8.MaxVelocity = 0.10000000149011612
Motor6D8.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Motor6D8.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Motor6D8.Part0 = Part4
Motor6D8.Part1 = Part14
Motor6D8.part1 = Part14
Motor6D9.Name = [[Left Hip]]
Motor6D9.Parent = Part4
Motor6D9.MaxVelocity = 0.10000000149011612
Motor6D9.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Motor6D9.C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Motor6D9.Part0 = Part4
Motor6D9.Part1 = Part13
Motor6D9.part1 = Part13
Motor6D10.Name = [[Neck]]
Motor6D10.Parent = Part4
Motor6D10.MaxVelocity = 0.10000000149011612
Motor6D10.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
Motor6D10.C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
Motor6D10.Part0 = Part4
Motor6D10.Part1 = Part1
Motor6D10.part1 = Part1
Part11.Name = [[Left Arm]]
Part11.Parent = dummy
Part11.CFrame = CFrame.new(-7, 3, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part11.Position = Vector3.new(-7, 3, -9)
Part11.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part11.Size = Vector3.new(1, 2, 1)
Part11.CanCollide = false
Part11.FormFactor = Enum.FormFactor.Symmetric
Part11.formFactor = Enum.FormFactor.Symmetric
Part12.Name = [[Right Arm]]
Part12.Parent = dummy
Part12.CFrame = CFrame.new(-4, 3, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part12.Position = Vector3.new(-4, 3, -9)
Part12.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part12.Size = Vector3.new(1, 2, 1)
Part12.CanCollide = false
Part12.FormFactor = Enum.FormFactor.Symmetric
Part12.formFactor = Enum.FormFactor.Symmetric
Part13.Name = [[Left Leg]]
Part13.Parent = dummy
Part13.CFrame = CFrame.new(-6, 1, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part13.Position = Vector3.new(-6, 1, -9)
Part13.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part13.Size = Vector3.new(1, 2, 1)
Part13.BottomSurface = Enum.SurfaceType.Smooth
Part13.CanCollide = false
Part13.FormFactor = Enum.FormFactor.Symmetric
Part13.formFactor = Enum.FormFactor.Symmetric
Part14.Name = [[Right Leg]]
Part14.Parent = dummy
Part14.CFrame = CFrame.new(-5, 1, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part14.Position = Vector3.new(-5, 1, -9)
Part14.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part14.Size = Vector3.new(1, 2, 1)
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.CanCollide = false
Part14.FormFactor = Enum.FormFactor.Symmetric
Part14.formFactor = Enum.FormFactor.Symmetric
Humanoid15.Parent = dummy
Humanoid15.LeftLeg = Part13
Humanoid15.RightLeg = Part14
Humanoid15.Torso = Part16
Humanoid15.DisplayName = [[0plusgiant6]]
Part16.Name = [[HumanoidRootPart]]
dummy.PrimaryPart = Part16
Part16.Parent = dummy
Part16.CFrame = CFrame.new(-5.5, 3, -9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part16.Position = Vector3.new(-5.5, 3, -9)
Part16.Transparency = 1
Part16.Velocity = Vector3.new(0, 0.00007802867912687361, 0)
Part16.Size = Vector3.new(2, 2, 1)
Part16.BottomSurface = Enum.SurfaceType.Smooth
Part16.CanCollide = false
Part16.LeftParamA = 0
Part16.LeftParamB = 0
Part16.RightParamA = 0
Part16.RightParamB = 0
Part16.TopSurface = Enum.SurfaceType.Smooth
Part16.FormFactor = Enum.FormFactor.Symmetric
Part16.formFactor = Enum.FormFactor.Symmetric
Sound17.Name = [[Climbing]]
Sound17.Parent = Part16
Sound17.Looped = true
Sound17.MaxDistance = 150
Sound17.EmitterSize = 5
Sound17.MinDistance = 5
Sound17.SoundId = [[rbxasset://sounds/action_footsteps_plastic.mp3]]
Sound17.Volume = 0.6499999761581421
Sound18.Name = [[Died]]
Sound18.Parent = Part16
Sound18.MaxDistance = 150
Sound18.EmitterSize = 5
Sound18.MinDistance = 5
Sound18.SoundId = [[rbxasset://sounds/uuhhh.mp3]]
Sound18.Volume = 0.6499999761581421
Sound19.Name = [[GettingUp]]
Sound19.Parent = Part16
Sound19.MaxDistance = 150
Sound19.EmitterSize = 5
Sound19.MinDistance = 5
Sound19.SoundId = [[rbxasset://sounds/action_get_up.mp3]]
Sound19.Volume = 0.6499999761581421
Sound20.Name = [[Swimming]]
Sound20.Parent = Part16
Sound20.Looped = true
Sound20.MaxDistance = 150
Sound20.EmitterSize = 5
Sound20.MinDistance = 5
Sound20.Pitch = 1.600000023841858
Sound20.PlaybackSpeed = 1.600000023841858
Sound20.SoundId = [[rbxasset://sounds/action_swim.mp3]]
Sound20.Volume = 0.6499999761581421
Sound21.Name = [[Jumping]]
Sound21.Parent = Part16
Sound21.MaxDistance = 150
Sound21.EmitterSize = 5
Sound21.MinDistance = 5
Sound21.SoundId = [[rbxasset://sounds/action_jump.mp3]]
Sound21.Volume = 0.6499999761581421
Sound22.Name = [[Landing]]
Sound22.Parent = Part16
Sound22.MaxDistance = 150
Sound22.EmitterSize = 5
Sound22.MinDistance = 5
Sound22.SoundId = [[rbxasset://sounds/action_jump_land.mp3]]
Sound22.Volume = 1
Sound23.Name = [[Splash]]
Sound23.Parent = Part16
Sound23.MaxDistance = 150
Sound23.EmitterSize = 5
Sound23.MinDistance = 5
Sound23.SoundId = [[rbxasset://sounds/impact_water.mp3]]
Sound23.Volume = 0.6499999761581421
Sound24.Name = [[FreeFalling]]
Sound24.Parent = Part16
Sound24.Looped = true
Sound24.MaxDistance = 150
Sound24.EmitterSize = 5
Sound24.MinDistance = 5
Sound24.SoundId = [[rbxasset://sounds/action_falling.mp3]]
Sound24.Volume = 0.4950002431869507
Sound25.Name = [[Running]]
Sound25.Parent = Part16
Sound25.Looped = true
Sound25.MaxDistance = 150
Sound25.EmitterSize = 5
Sound25.MinDistance = 5
Sound25.Pitch = 1.850000023841858
Sound25.PlaybackSpeed = 1.850000023841858
Sound25.SoundId = [[rbxasset://sounds/action_footsteps_plastic.mp3]]
Sound25.Volume = 0.6499999761581421
Motor6D26.Name = [[RootJoint]]
Motor6D26.Parent = Part16
Motor6D26.MaxVelocity = 0.10000000149011612
Motor6D26.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
Motor6D26.C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
Motor6D26.Part0 = Part16
Motor6D26.Part1 = Part4
Motor6D26.part1 = Part4
for i,v in pairs(mas:GetChildren()) do
	v.Parent = workspace
	pcall(function() v:MakeJoints() end)
end
mas:Destroy()
for i,v in pairs(cors) do spawn(function()pcall(v)end)end
spawn(function()
	script = Instance.new("Script",dummy)
	script.Name = "Animate"
	
	local Figure = script.Parent
	local Torso = Figure:WaitForChild("Torso")
	local RightShoulder = Torso:WaitForChild("Right Shoulder")
	local LeftShoulder = Torso:WaitForChild("Left Shoulder")
	local RightHip = Torso:WaitForChild("Right Hip")
	local LeftHip = Torso:WaitForChild("Left Hip")
	local Neck = Torso:WaitForChild("Neck")
	local Humanoid = Figure:WaitForChild("Humanoid")
	local pose = "Standing"

	local currentAnim = ""
	local currentAnimInstance = nil
	local currentAnimTrack = nil
	local currentAnimKeyframeHandler = nil
	local currentAnimSpeed = 1.0
	local animTable = {}
	local animNames = { 
		idle = 	{	
					{ id = "http://www.roblox.com/asset/?id=180435571", weight = 9 },
					{ id = "http://www.roblox.com/asset/?id=180435792", weight = 1 }
				},
		walk = 	{ 	
					{ id = "http://www.roblox.com/asset/?id=180426354", weight = 10 } 
				}, 
		run = 	{
					{ id = "run.xml", weight = 10 } 
				}, 
		jump = 	{
					{ id = "http://www.roblox.com/asset/?id=125750702", weight = 10 } 
				}, 
		fall = 	{
					{ id = "http://www.roblox.com/asset/?id=180436148", weight = 10 } 
				}, 
		climb = {
					{ id = "http://www.roblox.com/asset/?id=180436334", weight = 10 } 
				}, 
		sit = 	{
					{ id = "http://www.roblox.com/asset/?id=178130996", weight = 10 } 
				},	
		toolnone = {
					{ id = "http://www.roblox.com/asset/?id=182393478", weight = 10 } 
				},
		toolslash = {
					{ id = "http://www.roblox.com/asset/?id=129967390", weight = 10 } 
	--				{ id = "slash.xml", weight = 10 } 
				},
		toollunge = {
					{ id = "http://www.roblox.com/asset/?id=129967478", weight = 10 } 
				},
		wave = {
					{ id = "http://www.roblox.com/asset/?id=128777973", weight = 10 } 
				},
		point = {
					{ id = "http://www.roblox.com/asset/?id=128853357", weight = 10 } 
				},
		dance1 = {
					{ id = "http://www.roblox.com/asset/?id=182435998", weight = 10 }, 
					{ id = "http://www.roblox.com/asset/?id=182491037", weight = 10 }, 
					{ id = "http://www.roblox.com/asset/?id=182491065", weight = 10 } 
				},
		dance2 = {
					{ id = "http://www.roblox.com/asset/?id=182436842", weight = 10 }, 
					{ id = "http://www.roblox.com/asset/?id=182491248", weight = 10 }, 
					{ id = "http://www.roblox.com/asset/?id=182491277", weight = 10 } 
				},
		dance3 = {
					{ id = "http://www.roblox.com/asset/?id=182436935", weight = 10 }, 
					{ id = "http://www.roblox.com/asset/?id=182491368", weight = 10 }, 
					{ id = "http://www.roblox.com/asset/?id=182491423", weight = 10 } 
				},
		laugh = {
					{ id = "http://www.roblox.com/asset/?id=129423131", weight = 10 } 
				},
		cheer = {
					{ id = "http://www.roblox.com/asset/?id=129423030", weight = 10 } 
				},
	}
	local dances = {"dance1", "dance2", "dance3"}

	-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
	local emoteNames = { wave = false, point = false, dance1 = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

	function configureAnimationSet(name, fileList)
		if (animTable[name] ~= nil) then
			for _, connection in pairs(animTable[name].connections) do
				connection:disconnect()
			end
		end
		animTable[name] = {}
		animTable[name].count = 0
		animTable[name].totalWeight = 0	
		animTable[name].connections = {}

		-- check for config values
		local config = script:FindFirstChild(name)
		if (config ~= nil) then
	--		print("Loading anims " .. name)
			table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
			table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
			local idx = 1
			for _, childPart in pairs(config:GetChildren()) do
				if (childPart:IsA("Animation")) then
					table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
					animTable[name][idx] = {}
					animTable[name][idx].anim = childPart
					local weightObject = childPart:FindFirstChild("Weight")
					if (weightObject == nil) then
						animTable[name][idx].weight = 1
					else
						animTable[name][idx].weight = weightObject.Value
					end
					animTable[name].count = animTable[name].count + 1
					animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
		--			print(name .. " [" .. idx .. "] " .. animTable[name][idx].anim.AnimationId .. " (" .. animTable[name][idx].weight .. ")")
					idx = idx + 1
				end
			end
		end

		-- fallback to defaults
		if (animTable[name].count <= 0) then
			for idx, anim in pairs(fileList) do
				animTable[name][idx] = {}
				animTable[name][idx].anim = Instance.new("Animation")
				animTable[name][idx].anim.Name = name
				animTable[name][idx].anim.AnimationId = anim.id
				animTable[name][idx].weight = anim.weight
				animTable[name].count = animTable[name].count + 1
				animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
	--			print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.weight .. ")")
			end
		end
	end

	-- Setup animation objects
	function scriptChildModified(child)
		local fileList = animNames[child.Name]
		if (fileList ~= nil) then
			configureAnimationSet(child.Name, fileList)
		end	
	end

	script.ChildAdded:connect(scriptChildModified)
	script.ChildRemoved:connect(scriptChildModified)

	-- Clear any existing animation tracks
	-- Fixes issue with characters that are moved in and out of the Workspace accumulating tracks
	local animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator") or nil
	if animator then
		local animTracks = animator:GetPlayingAnimationTracks()
		for i,track in ipairs(animTracks) do
			track:Stop(0)
			track:Destroy()
		end
	end


	for name, fileList in pairs(animNames) do 
		configureAnimationSet(name, fileList)
	end	

	-- ANIMATION

	-- declarations
	local toolAnim = "None"
	local toolAnimTime = 0

	local jumpAnimTime = 0
	local jumpAnimDuration = 0.3

	local toolTransitionTime = 0.1
	local fallTransitionTime = 0.3
	local jumpMaxLimbVelocity = 0.75

	-- functions

	function stopAllAnimations()
		local oldAnim = currentAnim

		-- return to idle if finishing an emote
		if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
			oldAnim = "idle"
		end

		currentAnim = ""
		currentAnimInstance = nil
		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end

		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop()
			currentAnimTrack:Destroy()
			currentAnimTrack = nil
		end
		return oldAnim
	end

	function setAnimationSpeed(speed)
		if speed ~= currentAnimSpeed then
			currentAnimSpeed = speed
			currentAnimTrack:AdjustSpeed(currentAnimSpeed)
		end
	end

	function keyFrameReachedFunc(frameName)
		if (frameName == "End") then

			local repeatAnim = currentAnim
			-- return to idle if finishing an emote
			if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
				repeatAnim = "idle"
			end
			
			local animSpeed = currentAnimSpeed
			playAnimation(repeatAnim, 0.0, Humanoid)
			setAnimationSpeed(animSpeed)
		end
	end

	-- Preload animations
	function playAnimation(animName, transitionTime, humanoid) 
			
		local roll = math.random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
	--		print(animName .. " " .. idx .. " [" .. origRoll .. "]")
		local anim = animTable[animName][idx].anim

		-- switch animation		
		if (anim ~= currentAnimInstance) then
			
			if (currentAnimTrack ~= nil) then
				currentAnimTrack:Stop(transitionTime)
				currentAnimTrack:Destroy()
			end

			currentAnimSpeed = 1.0
		
			-- load it to the humanoid; get AnimationTrack
			currentAnimTrack = humanoid:LoadAnimation(anim)
			currentAnimTrack.Priority = Enum.AnimationPriority.Core
			 
			-- play the animation
			currentAnimTrack:Play(transitionTime)
			currentAnim = animName
			currentAnimInstance = anim

			-- set up keyframe name triggers
			if (currentAnimKeyframeHandler ~= nil) then
				currentAnimKeyframeHandler:disconnect()
			end
			currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
			
		end

	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	local toolAnimName = ""
	local toolAnimTrack = nil
	local toolAnimInstance = nil
	local currentToolAnimKeyframeHandler = nil

	function toolKeyFrameReachedFunc(frameName)
		if (frameName == "End") then
	--		print("Keyframe : ".. frameName)	
			playToolAnimation(toolAnimName, 0.0, Humanoid)
		end
	end


	function playToolAnimation(animName, transitionTime, humanoid, priority)	 
			
			local roll = math.random(1, animTable[animName].totalWeight) 
			local origRoll = roll
			local idx = 1
			while (roll > animTable[animName][idx].weight) do
				roll = roll - animTable[animName][idx].weight
				idx = idx + 1
			end
	--		print(animName .. " * " .. idx .. " [" .. origRoll .. "]")
			local anim = animTable[animName][idx].anim

			if (toolAnimInstance ~= anim) then
				
				if (toolAnimTrack ~= nil) then
					toolAnimTrack:Stop()
					toolAnimTrack:Destroy()
					transitionTime = 0
				end
						
				-- load it to the humanoid; get AnimationTrack
				toolAnimTrack = humanoid:LoadAnimation(anim)
				if priority then
					toolAnimTrack.Priority = priority
				end
				 
				-- play the animation
				toolAnimTrack:Play(transitionTime)
				toolAnimName = animName
				toolAnimInstance = anim

				currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
			end
	end

	function stopToolAnimations()
		local oldAnim = toolAnimName

		if (currentToolAnimKeyframeHandler ~= nil) then
			currentToolAnimKeyframeHandler:disconnect()
		end

		toolAnimName = ""
		toolAnimInstance = nil
		if (toolAnimTrack ~= nil) then
			toolAnimTrack:Stop()
			toolAnimTrack:Destroy()
			toolAnimTrack = nil
		end


		return oldAnim
	end

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------


	function onRunning(speed)
		if speed > 0.01 then
			playAnimation("walk", 0.1, Humanoid)
			if currentAnimInstance and currentAnimInstance.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
				setAnimationSpeed(speed / 14.5)
			end
			pose = "Running"
		else
			if emoteNames[currentAnim] == nil then
				playAnimation("idle", 0.1, Humanoid)
				pose = "Standing"
			end
		end
	end

	function onDied()
		pose = "Dead"
	end

	function onJumping()
		playAnimation("jump", 0.1, Humanoid)
		jumpAnimTime = jumpAnimDuration
		pose = "Jumping"
	end

	function onClimbing(speed)
		playAnimation("climb", 0.1, Humanoid)
		setAnimationSpeed(speed / 12.0)
		pose = "Climbing"
	end

	function onGettingUp()
		pose = "GettingUp"
	end

	function onFreeFall()
		if (jumpAnimTime <= 0) then
			playAnimation("fall", fallTransitionTime, Humanoid)
		end
		pose = "FreeFall"
	end

	function onFallingDown()
		pose = "FallingDown"
	end

	function onSeated()
		pose = "Seated"
	end

	function onPlatformStanding()
		pose = "PlatformStanding"
	end

	function onSwimming(speed)
		if speed > 0 then
			pose = "Running"
		else
			pose = "Standing"
		end
	end

	function getTool()	
		for _, kid in ipairs(Figure:GetChildren()) do
			if kid.className == "Tool" then return kid end
		end
		return nil
	end

	function getToolAnim(tool)
		for _, c in ipairs(tool:GetChildren()) do
			if c.Name == "toolanim" and c.className == "StringValue" then
				return c
			end
		end
		return nil
	end

	function animateTool()
		
		if (toolAnim == "None") then
			playToolAnimation("toolnone", toolTransitionTime, Humanoid, Enum.AnimationPriority.Idle)
			return
		end

		if (toolAnim == "Slash") then
			playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
			return
		end

		if (toolAnim == "Lunge") then
			playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
			return
		end
	end

	function moveSit()
		RightShoulder.MaxVelocity = 0.15
		LeftShoulder.MaxVelocity = 0.15
		RightShoulder:SetDesiredAngle(3.14 /2)
		LeftShoulder:SetDesiredAngle(-3.14 /2)
		RightHip:SetDesiredAngle(3.14 /2)
		LeftHip:SetDesiredAngle(-3.14 /2)
	end

	local lastTick = 0

	function move(time)
		local amplitude = 1
		local frequency = 1
		local deltaTime = time - lastTick
		lastTick = time

		local climbFudge = 0
		local setAngles = false

		if (jumpAnimTime > 0) then
			jumpAnimTime = jumpAnimTime - deltaTime
		end

		if (pose == "FreeFall" and jumpAnimTime <= 0) then
			playAnimation("fall", fallTransitionTime, Humanoid)
		elseif (pose == "Seated") then
			playAnimation("sit", 0.5, Humanoid)
			return
		elseif (pose == "Running") then
			playAnimation("walk", 0.1, Humanoid)
		elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
	--		print("Wha " .. pose)
			stopAllAnimations()
			amplitude = 0.1
			frequency = 1
			setAngles = true
		end

		if (setAngles) then
			local desiredAngle = amplitude * math.sin(time * frequency)

			RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
			LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
			RightHip:SetDesiredAngle(-desiredAngle)
			LeftHip:SetDesiredAngle(-desiredAngle)
		end

		-- Tool Animation handling
		local tool = getTool()
		if tool and tool:FindFirstChild("Handle") then
		
			local animStringValueObject = getToolAnim(tool)

			if animStringValueObject then
				toolAnim = animStringValueObject.Value
				-- message recieved, delete StringValue
				animStringValueObject.Parent = nil
				toolAnimTime = time + .3
			end

			if time > toolAnimTime then
				toolAnimTime = 0
				toolAnim = "None"
			end

			animateTool()		
		else
			stopToolAnimations()
			toolAnim = "None"
			toolAnimInstance = nil
			toolAnimTime = 0
		end
	end

	-- connect events
	local animconns = {}
	animconns[#animconns+1] = Humanoid.Died:connect(onDied)
	animconns[#animconns+1] = Humanoid.Running:connect(onRunning)
	animconns[#animconns+1] = Humanoid.Jumping:connect(onJumping)
	animconns[#animconns+1] = Humanoid.Climbing:connect(onClimbing)
	animconns[#animconns+1] = Humanoid.GettingUp:connect(onGettingUp)
	animconns[#animconns+1] = Humanoid.FreeFalling:connect(onFreeFall)
	animconns[#animconns+1] = Humanoid.FallingDown:connect(onFallingDown)
	animconns[#animconns+1] = Humanoid.Seated:connect(onSeated)
	animconns[#animconns+1] = Humanoid.PlatformStanding:connect(onPlatformStanding)
	animconns[#animconns+1] = Humanoid.Swimming:connect(onSwimming)

	-- setup emote chat hook
	animconns[#animconns+1] = game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
		local emote = ""
		if msg == "/e dance" then
			emote = dances[math.random(1, #dances)]
		elseif (string.sub(msg, 1, 3) == "/e ") then
			emote = string.sub(msg, 4)
		elseif (string.sub(msg, 1, 7) == "/emote ") then
			emote = string.sub(msg, 8)
		end
		
		if (pose == "Standing" and emoteNames[emote] ~= nil) then
			playAnimation(emote, 0.1, Humanoid)
		end

	end)


	-- main program

	-- initialize to idle
	playAnimation("idle", 0.1, Humanoid)
	pose = "Standing"

	_G.RunFunction = onRunning
	_G.ClimbFunction = onClimbing

	
	while script and script.Parent and not script.Disabled and Figure.Parent ~= nil do
		local _, time = wait(0.1)
		move(time)
	end
	print("animation destroyed")
	for _,v in pairs(animconns) do
		v:Disconnect()
	end

	
end)












function nocoll(p,t)
	for _,v in pairs(t:GetChildren()) do
		if v:IsA("BasePart") then
			local c = Instance.new("NoCollisionConstraint")
			c.Part0 = p
			c.Part1 = v
			c.Parent = p
		end
	end
end
for _,v in pairs(dummy:GetChildren()) do
	if v:IsA("BasePart") then
		nocoll(v,char)
	end
end

local keys = {}
local uis = game:GetService("UserInputService")

connections[#connections+1] = uis.InputBegan:Connect(function(k,p)
	if p then
		return
	end
	keys[k.KeyCode] = true
end)

connections[#connections+1] = uis.InputEnded:Connect(function(k,p)
	if p then
		return
	end
	keys[k.KeyCode] = nil
end)

for _,v in pairs(dummy:GetChildren()) do
	if v:IsA("BasePart") then
		v.Anchored = true
		v.Transparency = .5
	end
end

SendNotification("doing anti respawn (wait 5 seconds)")

plr.Character = nil
plr.Character = char
wait(5)
wait()
SendNotification("Anti respawn done")
dummy:SetPrimaryPartCFrame(hrp.CFrame)
for _,v in pairs(dummy:GetChildren()) do
	if v:IsA("BasePart") then
		v.Anchored = false
		v.Transparency = 1
	end
end
char:BreakJoints()
if rig == "R6" then
	attach(char["Right Arm"],Vector3.new(),Vector3.new()).Parent = dummy["Right Arm"]
	attach(char["Left Arm"],Vector3.new(),Vector3.new()).Parent = dummy["Left Arm"]
	attach(char["Right Leg"],Vector3.new(),Vector3.new()).Parent = dummy["Right Leg"]
	attach(char["Left Leg"],Vector3.new(),Vector3.new()).Parent = dummy["Left Leg"]
	attach(char["Torso"],Vector3.new(),Vector3.new()).Parent = dummy["Torso"]
	
	char.ChildAdded:Connect(function(c)
		if c:IsA("Tool") then
			local fake = Instance.new("Tool")
			local handle = Instance.new("Part")
			handle.CanCollide = false
			handle.Transparency = 0
			handle.Name = "Handle"
			handle.Parent = fake
			fake.Name = c.Name
			dummy.Humanoid:EquipTool(fake)
			wait()
			print(handle.Position)
		end
	end)
elseif rig == "R15" then
	attach(char.RightHand,Vector3.new(0,.85,0),Vector3.new()).Parent = dummy["Right Arm"]
	attach(char.RightLowerArm,Vector3.new(0,.224,0),Vector3.new()).Parent = dummy["Right Arm"]
	attach(char.RightUpperArm,Vector3.new(0,-.369,0),Vector3.new()).Parent = dummy["Right Arm"]
	
	attach(char.LeftHand,Vector3.new(0,.85,0),Vector3.new()).Parent = dummy["Left Arm"]
	attach(char.LeftLowerArm,Vector3.new(0,.224,0),Vector3.new()).Parent = dummy["Left Arm"]
	attach(char.LeftUpperArm,Vector3.new(0,-.369,0),Vector3.new()).Parent = dummy["Left Arm"]
	
	attach(char.RightFoot,Vector3.new(0,.85,0),Vector3.new()).Parent = dummy["Right Leg"]
	attach(char.RightLowerLeg,Vector3.new(0,.224,0),Vector3.new()).Parent = dummy["Right Leg"]
	attach(char.RightUpperLeg,Vector3.new(0,-.369,0),Vector3.new()).Parent = dummy["Right Leg"]
	
	attach(char.LeftFoot,Vector3.new(0,.85,0),Vector3.new()).Parent = dummy["Left Leg"]
	attach(char.LeftLowerLeg,Vector3.new(0,.224,0),Vector3.new()).Parent = dummy["Left Leg"]
	attach(char.LeftUpperLeg,Vector3.new(0,-.369,0),Vector3.new()).Parent = dummy["Left Leg"]
	
	attach(char.UpperTorso,Vector3.new(0,-.2,0),Vector3.new()).Parent = dummy["Torso"]
	attach(char.LowerTorso,Vector3.new(0,.8,0),Vector3.new()).Parent = dummy["Torso"]
else
	SendNotification("???????")
	return
end
hrp.Parent = workspace
local box = Instance.new("SelectionBox")
box.Adornee = hrp
box.Parent = hrp
attach(hrp,Vector3.new()).Parent = dummy["HumanoidRootPart"]
delay(1,function()
	local fling = Instance.new("BodyAngularVelocity")
	fling.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
	fling.AngularVelocity = Vector3.new(0,99999,0)
	fling.Parent = hrp
end)
attach(char["Head"],Vector3.new(),Vector3.new()).Parent = dummy["Head"]
function _G:Get(name)
	return attached[name]
end
function _G:Block(name)
	for _,v in pairs(char:GetDescendants()) do
		if v.Name == "rAP" and (v.Attachment0 == attached[name] or v.Attachment1 == attached[name]) then
			v.Parent.SpecialMesh:Destroy()
			break
		end
	end
end
function _G:GetCharPart(name)
	if name == "HumanoidRootPart" then
		return hrp
	else
		return char[name]
	end
end
for _,v in pairs(char:GetDescendants()) do
	if v:IsA("Accessory") then
		local Apos = v.Handle:FindFirstChildOfClass("Attachment")
		local Cpos = true
		for _,d in pairs(char:GetDescendants()) do
			if d:IsA("Attachment") and d.Parent.Name ~= "Handle" and d.Name == Apos.Name then
				Cpos = d
				break
			end
		end
		local bodypart = Cpos.Parent
		local attA = attach(v.Handle,Apos.Position-Cpos.Position,Apos.Orientation-Cpos.Orientation,v.Name)
		attA.Parent = bodypart
	end
end
char.Parent = dummy
connections[#connections+1] = game:GetService("RunService").Stepped:Connect(function()
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
	hrp.CanCollide = false
	--[[pcall(function()
		char.Head.CanCollide = false
	end)
	pcall(function()
		char.UpperTorso.CanCollide = false
	end)
	pcall(function()
		char.LowerTorso.CanCollide = false
	end)
	pcall(function()
		char.Torso.CanCollide = false
	end)
	pcall(function()
		char.HumanoidRootPart.CanCollide = false
	end)]]
	for _,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr then
			pcall(function()
				v.Character.Head.CanCollide = false
			end)
			pcall(function()
				v.Character.UpperTorso.CanCollide = false
			end)
			pcall(function()
				v.Character.LowerTorso.CanCollide = false
			end)
			pcall(function()
				v.Character.Torso.CanCollide = false
			end)
			pcall(function()
				v.Character.HumanoidRootPart.CanCollide = false
			end)
		end
	end
	pcall(function()
		if char.Humanoid.Jump then 
			dummy.Humanoid.Jump = true
			dummy.Humanoid.Sit = false 
		end
	end)
	pcall(function()
		dummy.Humanoid:Move(char.Humanoid.MoveDirection)
	end)
end)
workspace.CurrentCamera.CameraSubject = dummy.Humanoid
connections[#connections+1] = plr.Chatted:Connect(function(msg)
	if msg == "/e ;re" or msg == ";re" then
		SendNotification("Respawning...")
		_G.e += 1
		wait(.1)
		plr.Character = dummy
		for _,c in pairs(connections) do
			c:Disconnect()
		end
		wait()
		dummy:Destroy()
	end
end)
char.DescendantRemoving:Connect(function(c)
	if c:IsA("Tool") then
		dummy[c.Name]:Destroy()
	elseif c.Name == "HumanoidRootPart" then
		SentNotification("You lost your HumanoidRootPart")
	end
end)
local oldi
oldi = hookmetamethod(game,"__index",function(self,i)
	if self == plr and i == "Character" and dummy and dummy.Parent then
		return dummy
	end
	return oldi(self,i)
end)
SendNotification("Done. Type \";re\" or \"/e ;re\" to respawn")
wait(4)
