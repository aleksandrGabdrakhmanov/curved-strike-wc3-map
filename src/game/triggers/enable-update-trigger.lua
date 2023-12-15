function enableUpdateTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH, nil)
            TriggerAddAction(trig, function()

                local unit = GetTriggerUnit()
                local id = GetUnitTypeId(unit)
                local upgrades = getUpgradesById(('>I4'):pack(id))

                for _, upgrade in ipairs(upgrades) do
                    SetPlayerTechMaxAllowed(GetTriggerPlayer(), FourCC(upgrade), 3)
                end
            end)
        end
    end
end

function getUpgradesById(id)
    for _, unit in ipairs(units_for_build) do
        if unit.id == id then
            return unit.upgrades
        end
    end
    return {}
end