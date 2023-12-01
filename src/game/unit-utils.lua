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