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

function getUnitsByLevel(level)
    local filtered_ids = {}
    for _, unit in ipairs(all_units_t1) do
        if unit.level == level then
            table.insert(filtered_ids, unit.id)
        end
    end
    return filtered_ids
end

function getParentId(searchId)
    for _, unit in pairs(all_units) do
        if unit.id == searchId then
            return unit.parentId
        end
    end
    return nil
end