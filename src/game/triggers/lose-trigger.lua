Debug.beginFile('lose-trigger.lua')
function loseTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == units_special.base[team.i] then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    finishGame(team)
                end)
            end
        end)
        DestroyGroup(group)
    end
end
Debug.endFile()
