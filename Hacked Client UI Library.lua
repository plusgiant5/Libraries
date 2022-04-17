--[[

almost all arguments are optional

Library:New(length,color,Settings) > Creates new Library
	Library:GetResolution() > Gets the screen resolution in a Vector2
	Library:Window(title) > Creates new Window
		Window:Text(text) > Creates new Text window object
			Button:SetText(text) > Changes text
			Button:Destroy() > Deletes the text
		Window:Button(text,callback) > Creates new Button
			Button:Click() > Artificially clicks the button
			Button:SetText(text) > Changes text of button
			Button:Destroy() > Deletes the button
		Window:Toggle(text,callback,defaultvalue) > Creates new Toggle window object
			Toggle:Set(value) > Turns the toggle on or off
			Toggle:Get() > Gets the value of the toggle
			Toggle:Destroy() > Deletes the toggle
		Window:Destroy() > Deletes the window
	Library:ToggleVisibility() > Hides or shows all the windows
	Library:Settings(object,sizex,sizey) > Creates settings for a window object
		Settings:Text(text) > Creates new Text for settings
			Button:SetText(text) > Changes text
			Button:Destroy() > Deletes the text
		Settings:Button(text,callback) > Creates new Button for settings
			Button:Click() > Artificially clicks the button
			Button:SetText(text) > Changes text of button
			Button:Destroy() > Deletes the button
		Settings:Toggle(text,callback,defaultvalue) > Creates new Toggle for settings
			Toggle:Set(value) > Turns the toggle on or off
			Toggle:Get() > Gets the value of the toggle
			Toggle:Destroy() > Deletes the toggle
		Settings:Slider(text,min,max,default,callback,nodecimals) > Creates new Toggle for settings
			Slider:SetText(text) > Changes the text of the slider
			Slider:Reset() > Changes the slider value to the default
			Slider:Destroy() > Deletes the slider
		Settings:SetVisiblility(value) > Opens or closes the settings without clicking the settings button
		Settings:GetVisiblility(value) > Returns true if the settings are open
		Settings:Delete() > Deletes the settings
	Library:GetSettings() > Returns a table of all the settings so you can save it to a file and load it in Library:New
	Library:Destroy() > Deletes the UI

]]












local ts,uis,plrs = game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local core = pcall(function() return game.CoreGui:GetChildren() and true end)
function getfromlist(list,value)
	for i,v in pairs(list) do
		if v == value then
			return i
		end
	end
end
function rs(len)
	local f = ""
	for _ = 1,len do
		f ..= string.char(math.random(0,255))
	end
	return f
end

local lib = {}

function lib:New(length,color,Settings)
	length = length or 200
	color = color or Color3.new(0.117647, 0.901961, 0)
	local ui = {}
	local windows = 0
	local oldframepos = {}
	local enabled = true
	local function dragify(Frame)
		local dragToggle,dragInput,dragStart,dragPos,startPos
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if (input.UserInputState == Enum.UserInputState.End) then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				dragInput = input
			end
		end)
		uis.InputChanged:Connect(function(input)
			if (input == dragInput and dragToggle) then
				local Delta = input.Position - dragStart
				local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
				ts:Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
				oldframepos[Frame] = Position
			end
		end)
	end
	local sg = Instance.new("ScreenGui")
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	if syn then
		syn.protect_gui(sg)
	end
	function ui:GetResolution()
		return sg.AbsoluteSize
	end
	function ui:Window(title)
		title = title or "Title"
		local window = {}
		local dropped = false
		local dy = 0
		local top = Instance.new("Frame")
		windows += 1
		top.Position = UDim2.fromOffset(((length+25)*windows)-length,25)
		top.Size = UDim2.fromOffset(length,30)
		top.BackgroundColor3 = color
		top.BorderSizePixel = 0
		local dd = Instance.new("ImageLabel")
		dd.Image = "http://www.roblox.com/asset/?id=1215682490"
		dd.Rotation = 90
		dd.BackgroundTransparency = 1
		dd.ImageTransparency = .25
		dd.Position = UDim2.fromOffset(length-25,5)
		dd.ImageColor3 = Color3.new(1, 1, 1)
		dd.Size = UDim2.fromOffset(20,20)
		local t = Instance.new("TextLabel")
		t.BackgroundTransparency = 1
		t.TextColor3 = Color3.new(1,1,1)
		t.Text = " "..title
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.TextSize = 20
		t.Font = Enum.Font.Code
		t.Size = UDim2.fromOffset(length-60,30)
		local drop = Instance.new("Frame")
		drop.BorderSizePixel = 0
		drop.BackgroundColor3 = Color3.new()
		drop.BackgroundTransparency = .5
		drop.Size = UDim2.fromOffset(length,dy)
		drop.ClipsDescendants = true
		drop.Position = UDim2.fromScale(0,1)
		local beg
		top.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				beg = uis:GetMouseLocation()
			end
		end)
		top.InputEnded:Connect(function(input)
			if beg and input.UserInputType == Enum.UserInputType.MouseButton1 and (uis:GetMouseLocation()-beg).Magnitude < 10 then
				if dropped then
					dropped = false
					drop:TweenSize(UDim2.fromOffset(length,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
					ts:Create(dd, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 90}):Play()
					ts:Create(dd, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				else
					dropped = true
					drop:TweenSize(UDim2.fromOffset(length,dy),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
					ts:Create(dd, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
					ts:Create(dd, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				end
			end
		end)
		top.MouseEnter:Connect(function()
			ts:Create(dd, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
		end)
		top.MouseLeave:Connect(function()
			beg = nil
			ts:Create(dd, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.25}):Play()
		end)
		function window:Button(text,callback)
			local blib = {}
			text = text or "Text"
			callback = callback or function() end
			local b = Instance.new("TextButton")
			b.BackgroundTransparency = 1
			b.Size = UDim2.new(1,-35,0,30)
			b.BackgroundTransparency = 1
			b.TextColor3 = Color3.new(1,1,1)
			b.Font = Enum.Font.Code
			b.TextTransparency = .25
			b.Text = text
			b.TextXAlignment = Enum.TextXAlignment.Left
			b.TextSize = 16
			b.Position = UDim2.fromOffset(5,dy)
			dy += 30
			b.MouseEnter:Connect(function()
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			b.MouseLeave:Connect(function()
				beg = nil
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
			end)
			b.MouseButton1Down:Connect(function()
				ts:Create(b, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.35}):Play()
			end)
			b.MouseButton1Up:Connect(function()
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			b.MouseButton1Click:Connect(function()
				callback()
			end)
			function blib:Click()
				b.TextTransparency = .35
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				callback()
			end
			function blib:SetText(text)
				text = text or "?"
				b.Text = text
			end
			function blib:Destroy()
				dy -= 30
				drop.Size = UDim2.fromOffset(length,dy)
				b:Destroy()
			end
			blib.__obj = b
			blib.__name = text
			b.Parent = drop
			return blib
		end
		function window:Text(text)
			local tlib = {}
			text = text or "Text"
			local t = Instance.new("TextLabel")
			t.BackgroundTransparency = 1
			t.Size = UDim2.new(1,-5,0,30)
			t.BackgroundTransparency = 1
			t.TextColor3 = Color3.new(1,1,1)
			t.Font = Enum.Font.Code
			t.TextTransparency = 0
			t.Text = text
			t.TextXAlignment = Enum.TextXAlignment.Center
			t.TextSize = 16
			t.Position = UDim2.fromOffset(5,dy)
			dy += 30
			function tlib:SetText(text)
				text = text or "?"
				t.Text = text
			end
			function tlib:Destroy()
				dy -= 30
				drop.Size = UDim2.fromOffset(length,dy)
				t:Destroy()
			end
			tlib.__obj = t
			tlib.__name = text
			t.Parent = drop
			return tlib
		end
		function window:Toggle(text,callback,defaultvalue)
			local toggle = {}
			text = text or "Text"
			callback = callback or function() end
			local toggled = defaultvalue or false
			local wb = Instance.new("TextButton")
			wb.BackgroundTransparency = 1
			wb.Text = ""
			wb.ZIndex = 2
			wb.Size = UDim2.new(1,-30,0,30)
			wb.Position = UDim2.fromOffset(0,dy)
			local b = Instance.new("TextButton")
			b.BackgroundTransparency = 1
			b.Size = UDim2.new(1,-60,0,30)
			b.BackgroundTransparency = 1
			b.TextColor3 = Color3.new(1,1,1)
			b.Font = Enum.Font.Code
			b.TextTransparency = .25
			b.Text = text
			b.TextXAlignment = Enum.TextXAlignment.Left
			b.TextSize = 16
			b.Position = UDim2.fromOffset(30,dy)
			local on = Instance.new("Frame")
			on.BorderSizePixel = 0
			on.BackgroundColor3 = color
			local base = dy
			local bgon = Instance.new("Frame")
			bgon.BorderSizePixel = 0
			bgon.BackgroundTransparency = .35
			bgon.BackgroundColor3 = Color3.new()
			bgon.Size = UDim2.fromOffset(20,20)
			bgon.Position = UDim2.fromOffset(5,base+5)
			local uic = Instance.new("UICorner")
			dy += 30
			uic.CornerRadius = UDim.new(0,3)
			wb.MouseEnter:Connect(function()
				ts:Create(b, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			wb.MouseLeave:Connect(function()
				beg = nil
				ts:Create(b, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
			end)
			wb.MouseButton1Down:Connect(function()
				ts:Create(b, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.35}):Play()
			end)
			wb.MouseButton1Up:Connect(function()
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			local function refresh()
				if toggled then
					on:TweenSizeAndPosition(UDim2.fromOffset(20,20),UDim2.fromOffset(5,base+5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.08,true)
				else
					on:TweenSizeAndPosition(UDim2.fromOffset(0,20),UDim2.fromOffset(15,base+5),Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.08,true)
				end
			end
			wb.MouseButton1Click:Connect(function()
				toggled = not toggled
				callback(toggled)
				refresh()
			end)
			function toggle:Destroy()
				bgon:Destroy()
				on:Destroy()
				wb:Destroy()
				b:Destroy()
				dy -= 30
				drop.Size = UDim2.fromOffset(length,dy)
			end
			function toggle:Set(value)
				toggled = value or not toggled
				refresh()
			end
			function toggle:Get()
				return toggled
			end
			toggle.__obj = wb
			toggle.__name = text
			uic:Clone().Parent = bgon
			uic.Parent = on
			bgon.Parent = drop
			on.Parent = drop
			wb.Parent = drop
			b.Parent = drop
			refresh()
			return toggle
		end
		t.Parent = top
		dd.Parent = top
		drop.Parent = top
		top.Parent = sg
		dragify(top)
		oldframepos[top] = top.Position
		return window
	end
	function ui:ToggleVisibility()
		if enabled then
			for _,v in pairs(sg:GetChildren()) do
				v:TweenPosition(UDim2.new(-2,0,v.Position.Y.Scale,v.Position.Y.Offset),Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.5,true,function()
					if v.Position == UDim2.new(-2,0,v.Position.Y.Scale,v.Position.Y.Offset) then
						v.Visible = false
					end
				end)
			end
			enabled = false
		else
			for _,v in pairs(sg:GetChildren()) do
				v.Visible = true
				v:TweenPosition(oldframepos[v],Enum.EasingDirection.Out,Enum.EasingStyle.Sine,0.5,true)
			end
			enabled = true
		end
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	local Settings = Settings or {}
	function ui:GetSettings()
		return Settings
	end
	function ui:Settings(object,sizex,sizey)
		assert(object and object.__obj,"Window object required for ui:Settings")
		sizex = sizex or 300
		sizey = sizey or 400
		local sets = {}
		Settings[object.__name] = Settings[object.__name] or {}
		local r = ui:GetResolution()/2
		local sf = Instance.new("Frame")
		sf.Size = UDim2.fromOffset(sizex,30)
		sf.Position = UDim2.fromOffset(r.X-(sizex/2),r.Y-(sizey/2))
		sf.BackgroundColor3 = color
		sf.BorderSizePixel = 0
		sf.ZIndex = 10
		sf.Visible = false
		local t = Instance.new("TextLabel")
		t.BackgroundTransparency = 1
		t.TextColor3 = Color3.new(1,1,1)
		t.Text = " "..object.__name.." Settings"
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.TextSize = 20
		t.Font = Enum.Font.Code
		t.Size = UDim2.fromOffset(length-60,30)
		local cb = Instance.new("TextButton")
		cb.BackgroundTransparency = 1
		cb.Text = ""
		cb.Position = UDim2.fromOffset(sizex-30,0)
		cb.Size = UDim2.fromOffset(30,30)
		local ci = Instance.new("ImageLabel")
		ci.BackgroundTransparency = 1
		ci.ImageTransparency = .25
		ci.Image = "http://www.roblox.com/asset/?id=5755239863"
		ci.Position = UDim2.fromOffset(5,5)
		ci.Size = UDim2.fromOffset(20,20)
		local list = Instance.new("ScrollingFrame")
		list.Size = UDim2.fromOffset(sizex,sizey-30)
		list.ScrollBarImageColor3 = Color3.new()
		list.BorderSizePixel = 0
		list.BackgroundTransparency = .5
		list.BackgroundColor3 = Color3.new()
		list.Position = UDim2.fromScale(0,1)
		local uil = Instance.new("UIListLayout")
		uil.FillDirection = Enum.FillDirection.Vertical
		local openb = Instance.new("TextButton")
		openb.Text = ""
		openb.BackgroundTransparency = 1
		openb.Size = UDim2.fromOffset(30,30)
		openb.Position = UDim2.fromOffset(length-30,object.__obj.Position.Y.Offset)
		local uic = Instance.new("UICorner")
		uic.CornerRadius = UDim.new(1)
		local sic = Instance.new("ImageLabel")
		sic.Image = "http://www.roblox.com/asset/?id=1185031129"
		sic.BackgroundTransparency = 1
		sic.ImageTransparency = .25
		sic.Size = UDim2.fromOffset(20,20)
		sic.Position = UDim2.fromOffset(5,5)
		
		
		
		
		
		openb.MouseEnter:Connect(function()
			if sf.Visible then
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.55}):Play()
			else
				ts:Create(sic, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
		end)
		openb.MouseLeave:Connect(function()
			if sf.Visible then
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.45}):Play()
			else
				ts:Create(sic, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.25}):Play()
			end	
		end)
		openb.MouseButton1Down:Connect(function()
			if sf.Visible then
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.75}):Play()
			else
				ts:Create(sic, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.35}):Play()
			end	
		end)
		openb.MouseButton1Up:Connect(function()
			if sf.Visible then
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.45}):Play()
			else
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end	
		end)
		function sets:SetVisibility(value)
			if sf.Visible then
				sf.Visible = false
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.25}):Play()
			else
				sf.Visible = true
				ts:Create(sic, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.45}):Play()
			end	
		end
		
		
		
		
		
		cb.MouseEnter:Connect(function()
			ts:Create(ci, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
		end)
		cb.MouseLeave:Connect(function()
			ts:Create(ci, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.25}):Play()
		end)
		cb.MouseButton1Down:Connect(function()
			ts:Create(ci, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.35}):Play()
		end)
		cb.MouseButton1Up:Connect(function()
			ts:Create(ci, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
		end)
		cb.MouseButton1Click:Connect(function()
			sf.Visible = false
		end)
		--[[
			local lib = {}
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1,0,0,30)
			f.BackgroundTransparency = 1
			function lib:Destroy()
				f:Destroy()
			end
			list.Size = UDim2.fromOffset(sizex,math.min(#list:GetChildren()*30))
			list.CanvasSize = UDim2.fromOffset(0,uil.AbsoluteContentSize.Y)
			f.Parent = list
			return lib
		]]
		function sets:Text(text)
			local lib = {}
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1,0,0,30)
			f.BackgroundTransparency = 1
			local t = Instance.new("TextLabel")
			t.Size = UDim2.fromScale(1,1)
			t.BackgroundTransparency = 1
			t.Text = text
			t.TextSize = 16
			t.Font = Enum.Font.Code
			t.TextColor3 = Color3.new(1,1,1)
			function lib:SetText(text)
				t.Text = text
			end
			function lib:Destroy()
				f:Destroy()
			end
			list.Size = UDim2.fromOffset(sizex,math.min(#list:GetChildren()*30,sizey))
			list.CanvasSize = UDim2.fromOffset(0,uil.AbsoluteContentSize.Y)
			t.Parent = f
			f.Parent = list
			return lib
		end
		function sets:Button(text,callback)
			local lib = {}
			text = text or "Text"
			callback = callback or function() end
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1,0,0,30)
			f.BackgroundTransparency = 1
			local beg
			local b = Instance.new("TextButton")
			b.BackgroundTransparency = 1
			b.Size = UDim2.new(1,-35,0,30)
			b.BackgroundTransparency = 1
			b.TextColor3 = Color3.new(1,1,1)
			b.Font = Enum.Font.Code
			b.TextTransparency = .25
			b.Text = text
			b.TextXAlignment = Enum.TextXAlignment.Left
			b.TextSize = 16
			b.Position = UDim2.fromOffset(5,0)
			b.MouseEnter:Connect(function()
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			b.MouseLeave:Connect(function()
				beg = nil
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
			end)
			b.MouseButton1Down:Connect(function()
				ts:Create(b, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.35}):Play()
			end)
			b.MouseButton1Up:Connect(function()
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			b.MouseButton1Click:Connect(function()
				callback()
			end)
			function lib:Click()
				b.TextTransparency = .35
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				callback()
			end
			function lib:SetText(text)
				text = text or "?"
				b.Text = text
			end
			function lib:Destroy()
				f:Destroy()
			end
			b.Parent = f
			f.Parent = list
			return lib
		end
		function sets:Toggle(text,callback,defaultvalue)
			local lib = {}
			text = text or "Text"
			callback = callback or function() end
			local toggled = defaultvalue or false
			Settings[object.__name][text] = Settings[object.__name][text] or toggled
			local beg
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1,0,0,30)
			f.BackgroundTransparency = 1
			local wb = Instance.new("TextButton")
			wb.BackgroundTransparency = 1
			wb.Text = ""
			wb.ZIndex = 2
			wb.Size = UDim2.new(1,0,0,30)
			wb.Position = UDim2.fromOffset(0,0)
			local b = Instance.new("TextButton")
			b.BackgroundTransparency = 1
			b.Size = UDim2.new(1,-60,0,30)
			b.BackgroundTransparency = 1
			b.TextColor3 = Color3.new(1,1,1)
			b.Font = Enum.Font.Code
			b.TextTransparency = .25
			b.Text = text
			b.TextXAlignment = Enum.TextXAlignment.Left
			b.TextSize = 16
			b.Position = UDim2.fromOffset(30,0)
			local on = Instance.new("Frame")
			on.BorderSizePixel = 0
			on.BackgroundColor3 = color
			local bgon = Instance.new("Frame")
			bgon.BorderSizePixel = 0
			bgon.BackgroundTransparency = .35
			bgon.BackgroundColor3 = Color3.new()
			bgon.Size = UDim2.fromOffset(20,20)
			bgon.Position = UDim2.fromOffset(5,5)
			local uic = Instance.new("UICorner")
			uic.CornerRadius = UDim.new(0,3)
			wb.MouseEnter:Connect(function()
				ts:Create(b, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			wb.MouseLeave:Connect(function()
				beg = nil
				ts:Create(b, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
			end)
			wb.MouseButton1Down:Connect(function()
				ts:Create(b, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.35}):Play()
			end)
			wb.MouseButton1Up:Connect(function()
				ts:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			local function refresh()
				Settings[object.__name][text] = toggled
				if toggled then
					on:TweenSizeAndPosition(UDim2.fromOffset(20,20),UDim2.fromOffset(5,5),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.08,true)
				else
					on:TweenSizeAndPosition(UDim2.fromOffset(0,20),UDim2.fromOffset(15,5),Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.08,true)
				end
			end
			wb.MouseButton1Click:Connect(function()
				toggled = not toggled
				callback(toggled)
				refresh()
			end)
			function lib:Destroy()
				f:Destroy()
			end
			function lib:Set(value)
				toggled = value or not toggled
				refresh()
			end
			function lib:Get()
				return toggled
			end
			uic:Clone().Parent = bgon
			uic.Parent = on
			bgon.Parent = f
			on.Parent = f
			wb.Parent = f
			b.Parent = f
			list.Size = UDim2.fromOffset(sizex,math.min(#list:GetChildren()*30))
			list.CanvasSize = UDim2.fromOffset(0,uil.AbsoluteContentSize.Y)
			f.Parent = list
			refresh()
			return lib
		end
		function sets:Slider(text,min,max,default,callback,nodecimals)
			text = text or "Text"
			min = min or 0
			max = max or 100
			default = ((default or min)-min)/(max-min)
			callback = callback or function() end
			local val = default
			Settings[object.__name][text] = Settings[object.__name][text] or val
			local lib = {}
			local function round(n)
				if nodecimals or max > 1000 then
					return math.floor(n+.5)
				elseif max > 100 then
					return math.floor(n*10+.5)/10
				else
					return math.floor(n*100+.5)/100
				end
			end
			local uic = Instance.new("UICorner")
			uic.CornerRadius = UDim.new(0,3)
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1,0,0,30)
			f.BackgroundTransparency = 1
			local t = Instance.new("TextLabel")
			t.Size = UDim2.new(1,1)
			t.BackgroundTransparency = 1
			t.Text = text
			t.TextSize = 16
			t.TextXAlignment = Enum.TextXAlignment.Left
			t.Font = Enum.Font.Code
			t.TextColor3 = Color3.new(1,1,1)
			t.TextTransparency = .25
			t.Parent = f
			list.Size = UDim2.fromOffset(sizex,math.min(#list:GetChildren()*30))
			list.CanvasSize = UDim2.fromOffset(0,uil.AbsoluteContentSize.Y)
			f.Parent = list
			local tb = Vector2.new(sizex/2,30)
			t.Size = UDim2.fromOffset(tb.X,30)
			t.Position = UDim2.fromOffset(5,0)
			local bg = Instance.new("Frame")
			bg.BackgroundColor3 = Color3.new()
			bg.BackgroundTransparency = .35
			bg.Position = UDim2.fromOffset(tb.X+10,5)
			bg.Size = UDim2.fromOffset(sizex-tb.X-70,20)
			bg.BorderSizePixel = 0
			uic.Parent = bg
			local box = Instance.new("TextButton")
			box.BackgroundTransparency = 1
			box.Text = ""
			box.Position = bg.Position
			box.Size = bg.Size
			box.ZIndex = 12
			local bar = bg:Clone()
			bar.BackgroundColor3 = color
			bar.BackgroundTransparency = 0
			bar.ZIndex = bg.ZIndex+1
			bar.Size = UDim2.fromScale(1,1)
			bar.Position = UDim2.new()
			local count = Instance.new("TextBox")
			count.Position = UDim2.fromOffset(bg.Position.X.Offset+bg.Size.X.Offset,0)
			count.Size = UDim2.fromOffset(60,30)
			count.BackgroundTransparency = 1
			count.TextColor3 = Color3.new(1,1,1)
			count.TextSize = 14
			count.Font = Enum.Font.Code
			count.TextTransparency = .25
			count.Parent = f
			bar.Parent = bg
			box.Parent = f
			bg.Parent = f
			local hovered = false
			local inframe = false
			local dragging = false
			local old = 0
			local function refresh()
				count.TextTransparency = 0
				count.Text = tostring(round((max-min)*val+min))
				bar:TweenSize(UDim2.fromScale(val,1),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true)
				ts:Create(count, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.35}):Play()
			end
			count.FocusLost:Connect(function()
				if tonumber(count.Text) then
					val = math.min(math.max(((tonumber(count.Text) or min)-min)/(max-min),0),1)
					refresh()
				else
					refresh()
				end
			end)
			function lib:Destroy()
				f:Destroy()
			end
			function lib:SetText(text)
				t.Text = text
			end
			function lib:Reset()
				val = default
				refresh()
			end
			box.MouseEnter:Connect(function()
				inframe = true
				ts:Create(count, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
			box.MouseLeave:Connect(function()
				inframe = false
				ts:Create(count, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
			end)
			box.MouseButton1Down:Connect(function()
				dragging = true
				ts:Create(count, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.35}):Play()
			end)
			box.MouseButton1Up:Connect(function()
				dragging = false
				if inframe then
					ts:Create(count, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				else
					ts:Create(count, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
				end
			end)
			uis.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
					if inframe then
						ts:Create(count, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
					else
						ts:Create(count, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.25}):Play()
					end
				end
			end)
			game:GetService("RunService").RenderStepped:Connect(function()
				if dragging then
					local frac = math.min(math.max((mouse.X-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0),1)
					if frac ~= old then
						old = frac
						val = frac
						refresh()
						Settings[object.__name][text] = (max-min)*val+min
						callback((max-min)*val+min)
					end
				end
			end)
			refresh()
			return lib
		end
		function sets:Dropdown(text,items,callback,default) -- WIP
			local lib = {}
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1,0,0,30)
			f.BackgroundTransparency = 1
			function lib:Destroy()
				f:Destroy()
			end
			list.Size = UDim2.fromOffset(sizex,math.min(#list:GetChildren()*30))
			list.CanvasSize = UDim2.fromOffset(0,uil.AbsoluteContentSize.Y)
			f.Parent = list
			return lib
		end
		function sets:GetVisibility()
			return sf.Visible
		end
		function sets:Destroy()
			openb:Destroy()
			sf:Destroy()
		end
		openb.MouseButton1Click:Connect(sets.SetVisibility)
		oldframepos[sf] = sf.Position
		ci.Parent = cb
		cb.Parent = sf
		uil.Parent = list
		t.Parent = sf
		list.Parent = sf
		sf.Parent = sg
		sic.Parent = openb
		uic.Parent = openb
		openb.Parent = object.__obj.Parent
		dragify(sf)
		return sets
	end
	function ui:Destroy()
		sg:Destroy()
	end
	if core then
		sg.Parent = game.CoreGui
	else
		sg.Parent = plrs.LocalPlayer.PlayerGui
	end
	return ui
end

return lib
