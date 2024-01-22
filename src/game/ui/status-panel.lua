Debug.beginFile('status-panel.lua')
function getTableInfo(teamId)
    local tableInfo = {}
    tableInfo.header = {}
    table.insert(tableInfo.header, { text = 'Name', weight = 0.085, isFinish = true })
    table.insert(tableInfo.header, { text = 'Wave', weight = 0.04 })
    table.insert(tableInfo.header, { text = 'Inc/min', weight = 0.07 })
    table.insert(tableInfo.header, { text = 'Gold total', weight = 0.045, isFinish = true })

    if game_config.economy.goldForKill > 0 then
        table.insert(tableInfo.header, { text = 'Gold kill', weight = 0.045, isFinish = true })
    end

    table.insert(tableInfo.header, { text = 'Kills', weight = 0.05, isFinish = true })
    table.insert(tableInfo.header, { text = 'Damage', weight = 0.06, isFinish = true })
    table.insert(tableInfo.header, { text = 'Tier', weight = 0.04, isFinish = true })
    table.insert(tableInfo.header, { text = 'Army', weight = 0.04, isFinish = true })
    table.insert(tableInfo.header, { text = 'Heroes', weight = 0.06, isFinish = true })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    tableInfo.body = {}

    local teams
    if teamId then
        teams = { all_teams[teamId] }
    else
        teams = all_teams
    end

    for _, team in ipairs(teams) do
        for _, player in ipairs(team.players) do
            local row = {}
            table.insert(row, {
                text = getClearName(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = math.floor(player.spawnTimer),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = getIncome(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                text = player.economy.totalGold,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })

            if game_config.economy.goldForKill  > 0 then
                table.insert(row, {
                    text = player.economy.totalGoldForKills,
                    color = player.color,
                    integerColor = player.integerColor,
                    isSensitive = true
                })
            end

            table.insert(row, {
                text = player.totalKills,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = player.totalDamage,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = player.tier,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                text = player.food,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[1] and player.heroes[1].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[2] and player.heroes[2].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[3] and player.heroes[3].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[4] and player.heroes[4].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[5] and player.heroes[5].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[6] and player.heroes[6].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[7] and player.heroes[7].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(tableInfo.body, row)
        end
    end
    return tableInfo
end

function getIncome(player)
    if player.economy.incomeForCenter == 0 then
        return math.floor(player.economy.income)
    else
        return math.floor(player.economy.income) .. '(+' .. math.floor(player.economy.incomeForCenter) .. ')'
    end
end

function getClearName(player)
    return string.gsub(GetPlayerName(player.id), "#.*", "")
end

function updatePanelForAllPlayers()
    local updatedTableInfo = getTableInfo()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for row, bodyRow in ipairs(updatedTableInfo.body) do
                local isLocalPlayer = false
                local playerName = bodyRow[1].text
                for col, cell in ipairs(bodyRow) do

                    local title = 'Time: ' .. GetFormattedGameTime() .. '   Wave: ' .. math.floor(player.spawnTimer) .. '   Inc/min: ' .. getIncome(player) .. '   Kills: ' .. player.totalKills

                    local upkeep, _ = getUpkeepTypeAndPercent(player)

                    if upkeep then
                        local upkeepFrame = BlzGetFrameByName("ResourceBarUpkeepText", 0)
                        BlzFrameSetText(upkeepFrame, "alga")
                        local upkeepText
                        if upkeep == upkeepType.NO then
                            upkeepText = '  |cff00ff00No Upkeep|r'
                        elseif upkeep == upkeepType.LOW then
                            upkeepText = '  |cffffff00Low Upkeep(80)|r'
                        elseif upkeep == upkeepType.HIGH then
                            upkeepText = '  |cffff0000High Upkeep(60)|r'
                        end
                        title = title .. upkeepText

                    end

                    MultiboardSetTitleText(player.multiboard, title)

                    local item = MultiboardGetItem(player.multiboard, row, col - 1)
                    if isPlayerInTeam(playerName, team.players) then
                        isLocalPlayer = true
                    end

                    if (cell.text) then
                        MultiboardSetItemStyle(item, true, false)
                        if isLocalPlayer == true then
                            MultiboardSetItemValue(item, cell.text)
                        else
                            if cell.isSensitive == true then
                                MultiboardSetItemValue(item, "***")
                            else
                                MultiboardSetItemValue(item, cell.text)
                            end
                        end
                        MultiboardSetItemValueColor(item, cell.color.r, cell.color.g, cell.color.b, cell.color.t)
                        MultiboardSetItemWidth(item, updatedTableInfo.header[col].weight)
                    elseif (cell.icon) then
                        MultiboardSetItemStyle(item, false, true)
                        if isLocalPlayer == true then
                            MultiboardSetItemIcon(item, cell.icon)
                            MultiboardSetItemWidth(item, 0.01)
                        else
                            if cell.isSensitive == true then
                                MultiboardSetItemStyle(item, true, false)
                                MultiboardSetItemValue(item, "")
                                MultiboardSetItemWidth(item, 0.01)
                            else
                                MultiboardSetItemIcon(item, cell.icon)
                                MultiboardSetItemWidth(item, 0.01)
                            end
                        end
                    else
                        MultiboardSetItemStyle(item, true, false)
                        MultiboardSetItemValue(item, "")
                        MultiboardSetItemWidth(item, 0.01)
                    end
                    MultiboardReleaseItem(item)
                end
            end
        end
    end
end

function isPlayerInTeam(text, players)
    for _, player in ipairs(players) do
        if text == getClearName(player) then
            return true
        end
    end
    return false
end

function initPanelForAllPlayers()
    local tableInfo = getTableInfo()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            player.multiboard = CreateMultiboardBJ( #tableInfo.header, #tableInfo.body + 1, "Board1" )
            local multiFrame = BlzGetFrameByName("Multiboard",0)
            player.multiFrame = multiFrame

            for i, header in ipairs(tableInfo.header) do
                local title = MultiboardGetItem(player.multiboard, 0, i - 1)
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
        end
    end
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if GetLocalPlayer() == player.id then
                BlzFrameSetVisible(player.multiFrame, true)
            end
        end
    end
end
Debug.endFile()

