function initTimers()
    local timer = CreateTimer()
    my_func = 30
    TimerStart(timer,1,true, function()
        BlzFrameSetText(frame, "Next wave:  |cffFF0303" .. my_func .. "|r")
        my_func = my_func - 1
    end)
end