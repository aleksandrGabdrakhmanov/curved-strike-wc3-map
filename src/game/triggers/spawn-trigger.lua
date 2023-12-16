function spawnTrigger(player)
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, game_config.spawnPolicy.interval)
    TriggerAddAction(trig, function()
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
    end)
end