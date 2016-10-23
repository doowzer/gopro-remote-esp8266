TIMER_WIFI = 1
TIMER_MAIN = 2
GOPRO_ADDR = "10.5.5.9"

record = 0

function http(url)
    fmt = "Host: %s\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n"
    header = string.format(fmt, GOPRO_ADDR)
    client = net.createConnection(net.TCP, 0)
    client:connect(80, GOPRO_ADDR);
    client:on("connection", function(sck, c)
        sck:send(url..header)
    end)    
end

function goproRecord()
    fmt = "GET http://%s/bacpac/SH?t=%s&p=%%0%d HTTP/1.1\r\n"
    if record == 0 then
        record = 1
        http(string.format(fmt, GOPRO_ADDR, password, record))
    else
        record = 0
        http(string.format(fmt, GOPRO_ADDR, password, record))
    end
end

-- Setup GPIO pins.
gpio.mode(3, gpio.OUTPUT)
gpio.write(3, gpio.HIGH)

gpio.mode(2, gpio.INPUT, gpio.PULLUP)

-- Verify connection to camera, turn off LED when connected.
tmr.alarm(TIMER_WIFI, 1000, 1, function()
    if wifi.sta.getip() == nil then
        print("Connecting to GoPro camera...")
    else 
        tmr.stop(TIMER_WIFI)
        print("Connected to GoPro camera "..wifi.sta.getip())
        gpio.write(3, gpio.LOW);
    end
end)

-- Main loop, read button state.
tmr.alarm(TIMER_MAIN, 1000, 1, function()
    if gpio.read(2) == 0 then 
        goproRecord()
    end
end)