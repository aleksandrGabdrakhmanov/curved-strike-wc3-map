function heroLearnAbility()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_HERO_SKILL )
            TriggerAddAction(trig, function()
                if GetTriggerUnit() == player.heroes[1].building then
                    table.insert(player.heroes[1].newSkills, GetLearnedSkill())
                end
            end)
        end
    end
end