function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 30.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local groupForBuild = GetUnitsInRectAll(player.buildRect)
                ForGroup(groupForBuild, function ()
                    local id = GetUnitTypeId(GetEnumUnit())
                    local owner = GetOwningPlayer(GetEnumUnit())
                    if owner == player.id then
                        local parentId = getParentId(('>I4'):pack(id))
                        if parentId ~= nil then
                            local x, y = calculateDif(player.buildRect, player.spawnRect, GetEnumUnit())
                            local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
                            SetUnitColor(unit, GetPlayerColor(player.id))
                            RemoveGuardPosition(unit)
                            SetUnitAcquireRangeBJ( unit, GetUnitAcquireRange(unit) * game_config.units.range )
                        end
                    end
                end)
                DestroyGroup(groupForBuild)
            end
            my_func = 30

        end
    end)
end