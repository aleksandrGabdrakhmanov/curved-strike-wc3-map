Debug.beginFile('hero-learn-ability.lua')
function heroLearnAbility()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_HERO_SKILL)
            TriggerAddAction(trig, function()
                local learnedUnit = GetTriggerUnit()
                local learnedSkill = GetLearnedSkill()
                for _, hero in ipairs(player.heroes) do
                    if learnedUnit == hero.building then
                        table.insert(hero.newSkills, learnedSkill)
                        break
                    end
                end
            end)
        end
    end
end
Debug.endFile()