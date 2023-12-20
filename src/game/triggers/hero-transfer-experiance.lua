function heroTransferExp()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                if player.heroes[1].status == 'alive' then
                    local unit = GetHeroXP(player.heroes[1].unit)
                    SetHeroXP(player.heroes[1].building, unit, true)
                end
            end)
        end
    end
end