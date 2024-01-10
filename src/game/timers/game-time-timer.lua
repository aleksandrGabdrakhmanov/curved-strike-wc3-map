Debug.beginFile('game-time-timer.lua')
function initGameTimer()
    totalSeconds = 0
    local gameTimer = CreateTimer()
    TimerStart(gameTimer, 1.0, true, function()
        totalSeconds = totalSeconds + 1
    end)
end

function GetFormattedGameTime()
    local hours = math.floor(totalSeconds / 3600)
    local mins = math.floor((totalSeconds % 3600) / 60)
    local secs = totalSeconds % 60

    if hours > 0 then
        return string.format("%d:%02d:%02d", hours, mins, secs)
    elseif mins > 0 then
        return string.format("%02d:%02d", mins, secs)
    else
        return string.format("%02d", secs)
    end
end
Debug.endFile()
