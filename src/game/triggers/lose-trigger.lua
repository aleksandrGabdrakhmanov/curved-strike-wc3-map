function loseTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == units_special.base then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    for _, player in ipairs(team.players) do
                        local allUnits = GetUnitsOfPlayerAll(player.id)
                        ForGroup(allUnits, function()
                            KillUnit(GetEnumUnit())
                        end)
                        CustomDefeatBJ(player.id, "lose")
                        DestroyGroup(allUnits)
                    end
                end)
            end
        end)
        DestroyGroup(group)
    end
end
