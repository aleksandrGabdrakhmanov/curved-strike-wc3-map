function winLoseTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == team.base.unitId then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    for _, player in ipairs(team.players) do
                        CustomDefeatBJ(player.id, "lose")
                    end
                    for _, player in ipairs(all_teams[team.base.winTeam].players) do
                        CustomVictoryBJ(player.id, true, true)
                    end
                end)
            end
        end)

    end
end
