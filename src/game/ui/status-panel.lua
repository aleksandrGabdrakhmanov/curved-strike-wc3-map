Debug.beginFile('status-panel.lua')
function getTableInfo()
    local tableInfo = {}
    tableInfo.header = {
        { text = 'Name', weight = 0.085 },
        { text = 'Wave', weight = 0.03 },
        { text = 'Inc/min', weight = 0.05 },
        { text = 'Gold', weight = 0.045 },
        { text = 'Kills', weight = 0.05 },
        { text = 'Damage', weight = 0.06 },
    }
    tableInfo.body = {}
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            table.insert(tableInfo.body, {
                {
                    text = getClearName(player),
                    color = player.color,
                    isSensitive = false
                },
                {
                    text = player.spawnTimer,
                    color = player.color,
                    isSensitive = false
                },
                {
                    text = getIncome(player),
                    color = player.color,
                    isSensitive = true
                },
                {
                    text = player.economy.totalGold,
                    color = player.color,
                    isSensitive = true
                },
                {
                    text = player.totalKills,
                    color = player.color,
                    isSensitive = false
                },
                {
                    text = player.totalDamage,
                    color = player.color,
                    isSensitive = false
                }
            })
        end
    end
    return tableInfo
end

function getIncome(player)
    if player.economy.incomeForCenter == 0 then
        return player.economy.income * 60
    else
        return player.economy.income * 60 .. '(+' .. player.economy.incomeForCenter * 60 .. ')'
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

                    MultiboardSetTitleText(player.multiboard,
                            'Time: ' .. GetFormattedGameTime() ..'   Wave: ' .. player.spawnTimer .. '   Inc/min: ' .. getIncome(player) .. '   Kills: ' .. player.totalKills)


                    local item = MultiboardGetItem(player.multiboard, row, col - 1)
                    if isPlayerInTeam(playerName, team.players) then
                        isLocalPlayer = true
                    end

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

    local shop = BlzGetFrameByName("TasItemShopUI", 0)
    local parent = BlzFrameGetParent(shop)
    BlzFrameSetLevel(shop,99)
    BlzFrameSetLevel(parent,99)
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local multiboard = CreateMultiboard()
            local multi = BlzGetFrameByName('Multiboard', 0)
            BlzFrameSetParent(multi, BlzGetFrameByName("ConsoleUIBackdrop", 0))
            local parent = BlzFrameGetParent(multi)
            BlzFrameSetLevel(multi,1)
            BlzFrameSetLevel(parent,1)

            MultiboardSetRowCount(multiboard, #tableInfo.body + 1)
            MultiboardSetColumnCount(multiboard, #tableInfo.header)

            for i, header in ipairs(tableInfo.header) do
                local title = MultiboardGetItem(multiboard, 0, i - 1)
                MultiboardSetItemStyle(title, true, false)
                MultiboardSetItemValue(title, header.text)
                MultiboardSetItemWidth(title, header.weight)
                MultiboardReleaseItem(title)
            end

            player.multiboard = multiboard
        end
    end
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if GetLocalPlayer() == player.id then
                MultiboardDisplay(player.multiboard, true)
            end
        end
    end
end
Debug.endFile()

