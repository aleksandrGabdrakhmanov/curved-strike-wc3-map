Debug.beginFile('win-trigger.lua')
function winTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        local notLoseTeams = {}
        for _, team in ipairs(all_teams) do
            if team.lose ~= true then
                table.insert(notLoseTeams, team)
            end
        end
        if #notLoseTeams == 1 then
            for _, player in ipairs(notLoseTeams[1].players) do
                CustomVictoryBJ(player.id, true, true)
            end
        end
    end)
end
Debug.endFile()