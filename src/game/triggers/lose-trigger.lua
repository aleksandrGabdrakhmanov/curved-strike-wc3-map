Debug.beginFile('lose-trigger.lua')
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
                        DestroyGroup(allUnits)

                        local allUnitsSpawn = GetUnitsOfPlayerAll(player.spawnPlayerId)
                        ForGroup(allUnitsSpawn, function()
                            KillUnit(GetEnumUnit())
                        end)
                        DestroyGroup(allUnitsSpawn)
                        DisplayTextToPlayer(player.id, 500, 500, "You lose")
                        team.lose = true
                        CreateFogModifierRectBJ( true, player.id, FOG_OF_WAR_VISIBLE, GetPlayableMapRect() )
                    end
                end)
            end
        end)
        DestroyGroup(group)
    end
end
Debug.endFile()
