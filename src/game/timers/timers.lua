--[[function initTimers()
    local timer = CreateTimer()
    my_func = game_config.spawnPolicy.interval
    TimerStart(timer,1,true, function()
        BlzFrameSetText(frame, "Next wave:  |cffFF0303" .. my_func .. "|r")
        my_func = my_func - 1
    end)
end]]

function initTimers()

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local timer = CreateTimer()
            TimerStart(timer, player.i * game_config.spawnPolicy.firstDelay, false, function()
                spawnTrigger(player)
            end)
        end
    end


    local timer = CreateTimer()
    my_func = game_config.spawnPolicy.interval
    TimerStart(timer,1,true, function()
        BlzFrameSetText(frame, "Next wave:  |cffFF0303" .. my_func .. "|r")
        my_func = my_func - 1
    end)
end