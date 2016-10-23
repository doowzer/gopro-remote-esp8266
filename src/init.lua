print("\n*** Bunker GoPro Remote ***\n")

-- Files
l = file.list()
for f, s in pairs(l) do 
    print("Name: "..f.." ("..s..")")
end

-- WiFi configuration
dofile("config.lua")

wifi.setmode(wifi.STATION)
wifi.sta.config(ssid, password)

-- Run main program
dofile("main.lua")