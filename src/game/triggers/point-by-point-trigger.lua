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
                        local label = GetUnitUserData(unit)
                        local owner = GetOwningPlayer(unit)
                        if owner == player.spawnPlayerId and label == player.attackPointRect[i].label then
                            if GetUnitCurrentOrder(unit) == 0 or
                                    GetUnitCurrentOrder(unit) == 851983 then
                                moveByLocation(player.attackPointRect[i], unit)
                            end
                        end
                    end)
                    DestroyGroup(group)
                end)
            end
        end
    end
end

function moveByLocation(rect, unit)
    local x, y
    if rect.direction == 'right' then
        x = GetRectMaxX(rect.rect) + additionalDir
        y = GetUnitY(unit)
    elseif rect.direction == 'down' then
        x = GetUnitX(unit)
        y = GetRectMinY(rect.rect) - additionalDir
    elseif rect.direction == 'left' then
        x = GetRectMinX(rect.rect) - additionalDir
        y = GetUnitY(unit)
    elseif rect.direction == 'up' then
        x = GetUnitX(unit)
        y = GetRectMaxY(rect.rect) + additionalDir
    end
    IssuePointOrderLoc(unit, "attack", Location(x, y))
end

function containsValue(value, array)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end