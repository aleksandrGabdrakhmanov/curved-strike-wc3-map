Debug.beginFile('regions-init.lua')
regions = {}
function initRegions()
    for name, value in pairs(_G) do
        if string.sub(name, 1, 7) == "gg_rct_" then
            local parts = split(string.sub(name, 8), "_")

            local currentTable = regions
            for i, part in ipairs(parts) do
                if i == #parts then
                    currentTable[part] = value
                else
                    currentTable[part] = currentTable[part] or {}
                    currentTable = currentTable[part]
                end
            end
        end
    end
end

function split(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        if tonumber(match) then
            table.insert(result, tonumber(match))
        else
            table.insert(result, match)
        end
    end
    return result
end
Debug.endFile()