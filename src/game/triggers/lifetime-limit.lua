Debug.beginFile('lifetime-limit.lua')
function lifetimeLimitTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 5.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local allUnits = GetUnitsOfPlayerAll(player.spawnPlayerId)
                ForGroup(allUnits, function()
                    local unit = GetEnumUnit()
                    if not IsUnitType(unit, UNIT_TYPE_DEAD) then
                        local waveNumber = GetUnitUserData(unit)
                        if waveNumber ~= 0 then
                            if (player.waveNumber - waveNumber >= game_config.units.lifetime) then
                                local removeTimer = CreateTimer()
                                local tick = 10
                                local tag = CreateTextTagUnitBJ(tick, unit, 1,  10, 255, 2, 2, 255)
                                TimerStart(removeTimer, 0.5, true, function()
                                    tick = tick - 1
                                    if tick <= 0 then
                                        local effect = AddSpecialEffectLocBJ( GetUnitLoc(unit), "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl" )
                                        BlzSetSpecialEffectScale( effect, ( 0.30 * I2R(GetUnitLevel(unit)) ) )
                                        DestroyEffectBJ( effect )
                                        RemoveUnit(unit)
                                        DestroyTimer(removeTimer)
                                        DestroyTextTag(tag)
                                    else
                                        DestroyTextTag(tag)
                                        tag = CreateTextTagUnitBJ(tick, unit, 1,  10, 255, 2, 2, 255)
                                    end
                                end)
                            end
                        end
                    end
                end)
                DestroyGroup(allUnits)
            end
        end
    end)
end
Debug.endFile()