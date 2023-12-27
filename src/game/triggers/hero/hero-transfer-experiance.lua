Debug.beginFile('hero-transfer-experiance.lua')
function heroTransferExp()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                for _, hero in ipairs(player.heroes) do
                    if hero.status == 'alive' then
                        local unitExp = GetHeroXP(hero.unit)
                        SetHeroXP(hero.building, unitExp, true)
                    end
                end
            end)
        end
    end
end
Debug.endFile()