function changeAvailableUnitsForPlayers(players, units, isAvailable)
    for _, player in ipairs(players) do
        for _, unit in ipairs(units) do
            SetPlayerUnitAvailableBJ(FourCC(unit.id), isAvailable, player.id)
        end
    end
end
