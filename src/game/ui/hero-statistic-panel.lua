Debug.beginFile('hero-statistic-panel.lua')

function heroStatisticPanel()
    local tableInfo = getHeroInfo()
    heroMultiboard = CreateMultiboardBJ( #tableInfo.header, 1, "Heroes statistics" )
    heroMultiboardFrame = BlzGetFrameByName("Multiboard",0)
    heroMultiContainer = BlzGetFrameByName("MultiboardListContainer",0)
    heroMultiBackdrop = BlzGetFrameByName("MultiboardBackdrop",0)
    for i, header in ipairs(tableInfo.header) do
        local title = MultiboardGetItem(heroMultiboard, 0, i - 1)
        if header.text ~= nil then
            MultiboardSetItemStyle(title, true, false)
            MultiboardSetItemValue(title, header.text)
            MultiboardSetItemWidth(title, header.weight)
        else
            MultiboardSetItemStyle(title, false, false)
            MultiboardSetItemWidth(title, 0.0001)
        end
        MultiboardReleaseItem(title)
    end

    BlzFrameClearAllPoints(heroMultiboardFrame)
    BlzFrameSetAbsPoint(heroMultiboardFrame, FRAMEPOINT_LEFT, 0.19,0.55)
    BlzFrameSetVisible(heroMultiboardFrame, true)
    MultiboardMinimize(heroMultiboard, true)
end

function updateStatisticPanel()
    local updatedTableInfo = getHeroInfo()


    local function compareRows(row1, row2)
        return row1[5].text > row2[5].text
    end
    table.sort(updatedTableInfo.body, compareRows)

    MultiboardSetRowCount(heroMultiboard,  #updatedTableInfo.body + 1)
    for row, bodyRow in ipairs(updatedTableInfo.body) do
        for col, cell in ipairs(bodyRow) do

            local item = MultiboardGetItem(heroMultiboard, row, col - 1)

            if (col == 1) then
                MultiboardSetItemStyle(item, true, false)
                MultiboardSetItemValue(item, row)
                MultiboardSetItemWidth(item, updatedTableInfo.header[col].weight)
            elseif (cell.text) then
                MultiboardSetItemStyle(item, true, false)
                MultiboardSetItemValue(item, cell.text)
                MultiboardSetItemValueColor(item, cell.color.r, cell.color.g, cell.color.b, cell.color.t)
                MultiboardSetItemWidth(item, updatedTableInfo.header[col].weight)
            elseif (cell.icon) then
                MultiboardSetItemStyle(item, false, true)
                MultiboardSetItemIcon(item, cell.icon)
                MultiboardSetItemWidth(item, 0.01)
            else
                MultiboardSetItemStyle(item, true, false)
                MultiboardSetItemValue(item, "")
                MultiboardSetItemWidth(item, 0.01)
            end
            MultiboardReleaseItem(item)
        end
    end
end

function getHeroInfo()
    local tableInfo = {}
    tableInfo.header = {}
    table.insert(tableInfo.header, { text = 'P', weight = 0.015})
    table.insert(tableInfo.header, { text = '  ', weight = 0.015})
    table.insert(tableInfo.header, { text = 'Name', weight = 0.09})
    table.insert(tableInfo.header, { text = 'Kills', weight = 0.03})
    table.insert(tableInfo.header, { text = 'Damage', weight = 0.05})
    tableInfo.body = {}
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, hero in ipairs(player.heroes) do
                if hero.damage >= 1 then
                    local row = {}
                    table.insert(row, {})
                    table.insert(row, {
                        icon = hero.icon,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(row, {
                        text = hero.name,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(row, {
                        text = hero.kills,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(row, {
                        text = hero.damage,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(tableInfo.body, row)
                end
            end
        end
    end
    return tableInfo
end
Debug.endFile()