Debug.beginFile('hero-new-skill.lua')
function heroNewSkill()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                for _, hero in ipairs(player.heroes) do
                    if hero.status == 'alive' then
                        for i = #hero.newSkills, 1, -1 do
                            SelectHeroSkill(hero.unit, hero.newSkills[i])
                            table.remove(hero.newSkills, i)
                        end
                    end
                end
            end)
        end
    end
end
Debug.endFile()
