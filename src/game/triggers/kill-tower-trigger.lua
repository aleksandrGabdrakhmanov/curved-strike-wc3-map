Debug.beginFile('kill-tower-trigger.lua')
function killTowerTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == units_special.tower then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    local unit = GetKillingUnit()
                    local player = GetOwningPlayer(unit)
                    for _, otherTeam in ipairs(all_teams) do
                        if otherTeam.base.player == player then
                            for _, player in ipairs(otherTeam.players) do
                                DisplayTextToPlayer(player.id, 100, 200, '+' .. game_config.economy.goldByTower .. ' gold for killing a tower. ')
                                addGold(player, game_config.economy.goldByTower)
                            end
                            return
                        end
                    end
                end)
            end
        end)
        DestroyGroup(group)
    end
end
Debug.endFile()