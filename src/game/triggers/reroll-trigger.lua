Debug.beginFile('reroll-trigger.lua')
function rerollTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.reroll)
            end))
            TriggerAddAction(trig, function()
                reroll(player)
            end)
        end
    end
end
function reroll(player)
    for _, unit in ipairs(units_for_build) do
        SetPlayerUnitAvailableBJ(FourCC(unit.id), FALSE, player.id)
    end
    local randomUnits = getRandomUnits(units_for_build)
    table.remove(player.availableUnits)
    for _, unit in ipairs(randomUnits) do
        table.insert(player.availableUnits, unit)
        SetPlayerUnitAvailableBJ(FourCC(unit.id), TRUE, player.id)
    end
end
Debug.endFile()
