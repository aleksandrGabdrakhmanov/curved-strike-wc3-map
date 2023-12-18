
function initTimers()

--[[    local timer = CreateTimer()
    TimerStart(timer,1,true, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local text = BlzFrameGetChild(player.statePanel, 0)
                BlzFrameSetText(text, "Next wave: " .. player.spawnTimer)
                if team.i == 1 then
                    print('Team: ' .. team.i .. ' Player: ' .. player.i .. '; delay: ' .. player.spawnTimer)
                end
                player.spawnTimer = player.spawnTimer - 1
            end
        end
    end)]]
end