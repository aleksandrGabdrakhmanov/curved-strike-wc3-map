Debug.beginFile('game-time-timer.lua')
function initGameTimer()
    totalGameSeconds = 0
    local gameTimer = CreateTimer()
    TimerStart(gameTimer, 1.0, true, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if GetLocalPlayer() == player.id then
                    BlzFrameSetVisible(player.multiFrame, true)
                end
            end
        end
        totalGameSeconds = totalGameSeconds + 1
    end)
end

function GetFormattedGameTime()
    local hours = math.floor(totalGameSeconds / 3600)
    local mins = math.floor((totalGameSeconds % 3600) / 60)
    local secs = totalGameSeconds % 60

    if hours > 0 then
        return string.format("%d:%02d:%02d", hours, mins, secs)
    elseif mins > 0 then
        return string.format("%02d:%02d", mins, secs)
    else
        return string.format("%02d", secs)
    end
end
Debug.endFile()
