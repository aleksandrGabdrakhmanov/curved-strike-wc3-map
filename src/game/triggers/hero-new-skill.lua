function heroNewSkill()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                if player.heroes[1].status == 'alive' then
                    for i = #player.heroes[1].newSkills, 1, -1 do
                        SelectHeroSkill(player.heroes[1].unit, player.heroes[1].newSkills[i])
                        table.remove(player.heroes[1].newSkills, i)
                    end
                end
            end)
        end
    end
end