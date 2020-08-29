local internet = require("Internet")
local gui = require("GUI")

internet.download("https://raw.githubusercontent.com/KKosty4ka/Solaris/master/OS.lua", "/OS.lua")

gui.alert("you need protogent")
computer.shutdown(true)