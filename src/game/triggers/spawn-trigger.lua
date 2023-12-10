function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 30.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local groupForBuild = GetUnitsInRectAll(player.buildRect)
                local group = CreateGroup()
                ForGroup(groupForBuild, function ()
                    local id = GetUnitTypeId(GetEnumUnit())
                    local owner = GetOwningPlayer(GetEnumUnit())
                    if owner == player.id then
                        local parentId = getParentId(('>I4'):pack(id))
                        if parentId ~= nil then
                            local x, y = calculateDif(player.buildRect, player.attackPointRect[1], GetEnumUnit())
                            local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
                            SetUnitColor(unit, GetPlayerColor(player.id))
                            GroupAddUnit(group, unit)
                        end
                    end
                end)
                DestroyGroup(group)
                DestroyGroup(groupForBuild)
            end
            my_func = 30

        end
    end)
end

function getRandomSpawnPlayer(spawnPlayers)
    local randomIndex = math.random(#spawnPlayers)
    return spawnPlayers[randomIndex]
end