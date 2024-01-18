Debug.beginFile('finish-game.lua')
function finishGame()
    mainBackdrop = BlzCreateFrameByType('BACKDROP', 'PreConfigGameModes', BlzGetFrameByName("ConsoleUIBackdrop", 0), "QuestButtonBackdropTemplate", 0)
    BlzFrameSetAbsPoint(mainBackdrop, FRAMEPOINT_CENTER, 0.4, 0.35)
    BlzFrameSetSize(mainBackdrop, 0.9, 0.38)
    BlzFrameSetLevel(mainBackdrop, 99)

    local weightMultiplyForBigFont = 1.5
    local heightFont = 0.02

    local fakeText = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
    BlzFrameSetSize(fakeText, 0.15, 0.01)
    BlzFrameSetText(fakeText, '')
    BlzFrameSetPoint(fakeText, FRAMEPOINT_TOPLEFT, mainBackdrop, FRAMEPOINT_TOPLEFT, 0.02, -0.01)

    local firstColumn = fakeText
    local prevColumn = fakeText
    for teamNumber, team in ipairs(all_teams) do
        local tableInfo = getTableInfo(teamNumber)

        local teamLabel = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
        BlzFrameSetSize(teamLabel, 0.15, 0.02)
        BlzFrameSetText(teamLabel, 'Team ' .. teamNumber)
        BlzFrameSetPoint(teamLabel, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
        firstColumn = teamLabel
        prevColumn = teamLabel

        for i, headerColumn in ipairs(tableInfo.header) do
            if headerColumn.text and headerColumn.isFinish then
                local header = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
                BlzFrameSetSize(header, headerColumn.weight * weightMultiplyForBigFont, heightFont)
                BlzFrameSetText(header, headerColumn.text)
                BlzFrameSetTextAlignment(header, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                if i == 1 then
                    BlzFrameSetPoint(header, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
                    firstColumn = header
                else
                    BlzFrameSetPoint(header, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0, 0)
                end
                prevColumn = header
            end
        end

        for _, row in ipairs(tableInfo.body) do
            local prevColumn
            for j, element in ipairs(row) do
                if element.text and tableInfo.header[j].isFinish then
                    local column = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
                    BlzFrameSetSize(column, tableInfo.header[j].weight * weightMultiplyForBigFont, heightFont)
                    BlzFrameSetTextAlignment(column, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                    BlzFrameSetTextColor(column, element.integerColor)
                    BlzFrameSetText(column, element.text)
                    if j == 1 then
                        BlzFrameSetPoint(column, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
                        firstColumn = column
                    else
                        BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0, 0)
                    end
                    prevColumn = column
                end
            end
        end

    end
end
Debug.endFile()