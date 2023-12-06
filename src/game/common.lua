function calculateDif(buidRect, spawnRect, unit)

    local buidRectX = GetRectCenterX(buidRect)
    local buidRectY = GetRectCenterY(buidRect)

    local spawnRectX = GetRectCenterX(spawnRect)
    local spawnRectY = GetRectCenterY(spawnRect)

    local unitX = GetUnitX(unit)
    local unitY = GetUnitY(unit)
    return spawnRectX - (buidRectX - unitX), spawnRectY - (buidRectY - unitY)
end

--[[function changeAvailableUnitsForPlayers(players, units, isAvailable)
    for _, player in ipairs(players) do
        for _, unit in ipairs(units) do
            SetPlayerUnitAvailableBJ(FourCC(unit.id), isAvailable, player.id)
        end
    end
end]]

function getParentId(searchId)
    for _, unit in pairs(units_for_build) do
        if unit.id == searchId then
            return unit.parentId
        end
    end
    return nil
end