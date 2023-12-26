function moveTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.moveLarge) or
                        GetSpellAbilityId() == FourCC(abilities.moveMedium) or
                        GetSpellAbilityId() == FourCC(abilities.moveSmall)
            end))
            TriggerAddAction(trig, function()
                local location = GetSpellTargetLoc()

                if type(player.buildRect) == "table" then
                    for i in ipairs(player.buildRect) do
                        if isLocationInRectangle(location, player.buildRect[i]) then
                            local unit = GetSpellAbilityUnit()
                            SetUnitPositionLoc(unit, location)
                        end
                    end
                else
                    if isLocationInRectangle(location, player.buildRect) then
                        local unit = GetSpellAbilityUnit()
                        SetUnitPositionLoc(unit, location)
                    end
                end
            end)
        end
    end
end

function isLocationInRectangle(location, rect)
    rectMinX = GetRectMinX(rect)
    rectMinY = GetRectMinY(rect)
    rectMaxX = GetRectMaxX(rect)
    rectMaxY = GetRectMaxY(rect)

    local locX = GetLocationX(location)
    local locY = GetLocationY(location)

    return locX >= rectMinX and locX <= rectMaxX and locY >= rectMinY and locY <= rectMaxY
end

function replaceCell(player)
    if type(player.buildRect) == "table" then
        for i in ipairs(player.buildRect) do
            local group = GetUnitsInRectAll(player.buildRect[i])
            replaceGroupCell(group)
        end
    else
        local group = GetUnitsInRectAll(player.buildRect)
        replaceGroupCell(group)
    end
end

function replaceGroupCell(group)
    ForGroup(group, function()
        local unit = GetEnumUnit()
        local ability = BlzGetUnitAbility(unit, FourCC(abilities.sell100))
        if ability ~= nil then
            UnitAddAbility(unit, FourCC(abilities.sell75))
            UnitRemoveAbilityBJ(FourCC(abilities.sell100), unit)
        end
    end)
    DestroyGroup(group)
end