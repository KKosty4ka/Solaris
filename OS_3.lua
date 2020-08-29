local cp, cl = component.proxy, component.list
local gpu = cp(cl("gpu")())
local efi = cp(cl("eeprom")())

local resX, resY = gpu.getResolution()

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

local text1 = "no computer today, silly boy"
local text2 = "go outside to play"

while true do
	back = math.random(0x000000, 0xFFFFFF)
	textback = back - 0x333333
	front = 0xFFFFFF - textback
	gpu.setBackground(back)
	gpu.setForeground(front)
	gpu.fill(1, 1, resX, resY, " ")
	gpu.setBackground(textback)

	gpu.set( (resX / 2) - (#text1 / 2), resY / 2, text1)
	gpu.set( (resX / 2) - (#text2 / 2), (resY / 2) + 1, text2)
	sleep(0.125)
end