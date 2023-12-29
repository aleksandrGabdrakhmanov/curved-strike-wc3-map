Debug.beginFile('status-panel.lua')
function getTableInfo()
    local tableInfo = {}
    tableInfo.header = {
        { text = 'Name', weight = 0.085 },
        { text = 'Wave', weight = 0.03 },
        { text = 'Inc', weight = 0.03 },
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
                    text = player.economy.income,
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

function getClearName(player)
    return string.gsub(GetPlayerName(player.id), "#.*", "")
end

function updatePanelForAllPlayers()
    local updatedTableInfo = getTableInfo()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local myPanel = player.statePanel
            if myPanel then

                for i, headerColumn in ipairs(updatedTableInfo.header) do
                    local headerFrame = BlzFrameGetChild(myPanel, i - 1)
                    BlzFrameSetText(headerFrame, headerColumn.text)
                end

                local headerCount = #updatedTableInfo.header
                for i, row in ipairs(updatedTableInfo.body) do
                    local isLocalPlayer = false
                    for j, element in ipairs(row) do
                        local bodyIndex = headerCount + ((i - 1) * #row) + (j - 1)
                        local bodyFrame = BlzFrameGetChild(myPanel, bodyIndex)

                        local text = BlzFrameGetText(bodyFrame)

                        if isPlayerInTeam(text, team.players) then
                            isLocalPlayer = true
                        end

                        if isLocalPlayer == true then
                            BlzFrameSetText(bodyFrame, element.text)
                        else
                            if element.isSensitive == true then
                                BlzFrameSetText(bodyFrame, "***")
                            else
                                BlzFrameSetText(bodyFrame, element.text)
                            end
                        end
                    end
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

            local myPanel = BlzCreateFrameByType("BACKDROP", "CurvedStatusTemplateMy", BlzGetFrameByName("ConsoleUIBackdrop", 0), "QuestButtonDisabledBackdropTemplate", 0)

            local shop = BlzGetFrameByName("TasItemShopUI", 0)
            BlzFrameSetAbsPoint(myPanel, FRAMEPOINT_TOPRIGHT, 0.93, 0.56)
            BlzFrameSetLevel(myPanel,1)
            local parent = BlzFrameGetParent(shop)
            BlzFrameSetLevel(shop,2)
            BlzFrameSetLevel(parent,2)


            local totalWeight = 0
            for _, headerColumn in ipairs(tableInfo.header) do
                totalWeight = totalWeight + headerColumn.weight + 0.005
            end
            local totalHeight = #tableInfo.body + 4
            BlzFrameSetSize(myPanel, totalWeight + 0.015, totalHeight * 0.01)
            BlzFrameSetAlpha(myPanel, 220)


            local prevColumn = nil
            for i, headerColumn in ipairs(tableInfo.header) do
                local column = BlzCreateFrameByType('TEXT', 'CurvedStatusHeader', myPanel, 'TeamLabelTextTemplate', 0)
                BlzFrameSetSize(column, headerColumn.weight, 0.02)
                BlzFrameSetText(column, headerColumn.text)
                BlzFrameSetTextAlignment(column, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                if i == 1 then
                    BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, myPanel, FRAMEPOINT_TOPLEFT, 0.01, -0.01)
                else
                    BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0.005, 0)
                end
                prevColumn = column
            end

            for i, row in ipairs(tableInfo.body) do
                local prevColumn = nil
                for j, element in ipairs(row) do
                    local column = BlzCreateFrameByType('TEXT', 'CurvedStatusRow1', myPanel, 'TeamLabelTextTemplate', 0)
                    BlzFrameSetSize(column, tableInfo.header[j].weight, 0.02)
                    BlzFrameSetTextAlignment(column, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                    BlzFrameSetTextColor(column, element.color)
                    if j == 1 then
                        if i == 1 then
                            BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, myPanel, FRAMEPOINT_TOPLEFT, 0.01, -0.03)
                        else
                            BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, myPanel, FRAMEPOINT_TOPLEFT, 0.01, -0.02 - (0.01 * i))
                        end
                    else
                        BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0.005, 0)
                    end
                    prevColumn = column
                end
            end
            BlzFrameSetVisible(myPanel, GetLocalPlayer() == player.id)
            player.statePanel = myPanel
        end
    end
end
Debug.endFile()

