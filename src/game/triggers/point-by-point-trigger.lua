additionalDir = 500
function moveByPointsTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for i = 1, #player.attackPointRect do
                local trig = CreateTrigger()
                TriggerRegisterTimerEventPeriodic(trig, 2.00)
                TriggerAddAction(trig, function()
                    local group = GetUnitsInRectAll(player.attackPointRect[i].rect)
                    ForGroup(group, function ()
                        local unit = GetEnumUnit()
                        local owner = GetOwningPlayer(unit)
                        if owner == player.spawnPlayerId then
                            if GetUnitCurrentOrder(unit) == 0 or
                                    GetUnitCurrentOrder(unit) == 851983 then
                                local x, y
                                if player.attackPointRect[i].direction == 'right' then
                                    x = GetRectMaxX(player.attackPointRect[i].rect) + additionalDir
                                    y = GetUnitY(unit)
                                elseif player.attackPointRect[i].direction == 'down' then
                                    x = GetUnitX(unit)
                                    y = GetRectMinY(player.attackPointRect[i].rect) - additionalDir
                                elseif player.attackPointRect[i].direction == 'left' then
                                    x = GetRectMinX(player.attackPointRect[i].rect) - additionalDir
                                    y = GetUnitY(unit)
                                elseif player.attackPointRect[i].direction == 'up' then
                                    x = GetUnitX(unit)
                                    y = GetRectMaxY(player.attackPointRect[i].rect) + additionalDir
                                end
                                IssuePointOrderLoc(unit, "attack", Location(x, y))
                            end
                        end
                    end)
                    DestroyGroup(group)
                end)
            end
        end
    end
end

function containsValue(value, array)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end