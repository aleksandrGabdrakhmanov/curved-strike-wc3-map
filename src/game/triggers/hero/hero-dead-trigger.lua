Debug.beginFile('hero-dead-trigger.lua')
function heroDeadTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                for _, hero in ipairs(player.heroes) do
                    if IsUnitDeadBJ(hero.unit) and hero.status == 'alive' then
                        hero.status = 'dead'
                    end
                end
            end)
        end
    end
end
Debug.endFile()