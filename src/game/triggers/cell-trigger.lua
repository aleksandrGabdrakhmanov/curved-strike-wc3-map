Debug.beginFile('cell-trigger.lua')
function cellTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.sell100) or GetSpellAbilityId() == FourCC(abilities.sell75)
            end))
            TriggerAddAction(trig, function()
                local unit = GetSpellAbilityUnit()
                local cost = GetUnitGoldCost(GetUnitTypeId(unit))
                TriggerSleepAction(0.1)
                RemoveUnit(unit)
                local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)

                if GetSpellAbilityId() == FourCC(abilities.sell100) then
                    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + cost)
                else
                    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + math.floor(cost * 0.75))
                end
            end)
        end
    end
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
Debug.endFile()