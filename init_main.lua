LED = require "LEDblink"

print("set up wifi mode")
wifi.setmode(wifi.STATION)
wifi.sta.autoconnect(0)

-- se quiser testar o smartconfig, desconecte a board primeiro

wifi.sta.disconnect()

tmr.alarm(1,600,1,function()
    if wifi.sta.getip() == nil then
        print("Waiting for smartconfig, IP unabailable...")
        
        wifi.startsmart(0, 
            function(ssid,password)
            print(string.format("Sucess. SSID: %s; PASSOWRD: %s, ssid,password))
        end)
        LED.fast()
    else
        tmr.stop(1)
        tmr.stop(2)
        print("Config done, IP is" ..wifi.sta.getip())
 
        wifi.stopsmart()
 
        dofile("mqtt2.lua")    
    end
end)
