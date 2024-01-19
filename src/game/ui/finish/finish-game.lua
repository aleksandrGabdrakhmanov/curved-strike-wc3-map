Debug.beginFile('finish-game.lua')
function finishGame(loseTeam)
    local mainBackdrop = BlzCreateFrame('FinishGameBackdrop', BlzGetFrameByName("ConsoleUIBackdrop", 0), 0, 0)
    BlzFrameSetAbsPoint(mainBackdrop, FRAMEPOINT_CENTER, 0.4, 0.35)
    BlzFrameSetLevel(mainBackdrop, 99)

    local weightMultiplyForBigFont = 1.5
    local heightFont = 0.02

    local fakeText = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
    BlzFrameSetSize(fakeText, 0.15, 0.01)
    BlzFrameSetText(fakeText, '')
    BlzFrameSetPoint(fakeText, FRAMEPOINT_TOPLEFT, mainBackdrop, FRAMEPOINT_TOPLEFT, 0.02, -0.01)

    local firstColumn = fakeText
    local prevColumn = fakeText
    local totalWidth
    local totalRows = 4
    for teamNumber, team in ipairs(all_teams) do
        totalWidth = 0
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
                totalWidth = totalWidth + (headerColumn.weight * weightMultiplyForBigFont)
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
            totalRows = totalRows + 1
            for j, element in ipairs(row) do
                if element.text and tableInfo.header[j].isFinish then
                    local column = BlzCreateFrame("RowTableText", mainBackdrop, 0, 0)
                    if j == 1 then
                        local line = BlzCreateSimpleFrame("FinishGameLine", mainBackdrop, 0)
                        BlzFrameSetPoint(line, FRAMEPOINT_BOTTOMLEFT, column, FRAMEPOINT_BOTTOMLEFT, -0.005, 0.005)
                        BlzFrameSetSize(line,totalWidth, 0.015)
                        BlzFrameSetAlpha(line, 50)

                        local texture = BlzGetFrameByName("FinishGameLineTexture", 0)
                        BlzFrameSetTexture(texture, "war3mapImported\\line.tga", 0, true)
                        BlzFrameSetVertexColor(texture, element.integerColor)
                    end
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
                if element.icon then
                    local frame = BlzCreateFrameByType("BACKDROP", "Any", mainBackdrop, "", 0)
                    BlzFrameSetSize(frame, heightFont, heightFont)
                    BlzFrameSetTexture(frame, element.icon, 0, true)
                    if j == 1 then
                        BlzFrameSetPoint(frame, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
                        firstColumn = column
                    else
                        BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0, 0)
                    end
                    prevColumn = frame
                end
            end
        end
    end

    local mainButton = BlzCreateFrame("ScriptDialogButton", mainBackdrop, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetSize(mainButton, 0.15, 0.04)
    BlzFrameSetPoint(mainButton, FRAMEPOINT_BOTTOMRIGHT, mainBackdrop, FRAMEPOINT_BOTTOMRIGHT, -0.01, 0.01)
    BlzFrameSetText(buttonText, "Exit")
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, mainButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        CustomVictoryBJ(GetTriggerPlayer(), false, true)
    end)

    local victoryOrLosePict = BlzCreateFrameByType("BACKDROP", "Any", mainBackdrop, "", 0)
    BlzFrameSetSize(victoryOrLosePict, 0.14, 0.14)

    if isPlayerIsWinner(loseTeam) then
        BlzFrameSetTexture(victoryOrLosePict, "war3mapImported\\victory1.blp", 0, true)
    else
        BlzFrameSetTexture(victoryOrLosePict, "war3mapImported\\defeat1.blp", 0, true)
    end

    BlzFrameSetPoint(victoryOrLosePict, FRAMEPOINT_BOTTOM, mainButton, FRAMEPOINT_TOP, 0, 0.001)
    BlzFrameSetSize(mainBackdrop, totalWidth + 0.18, 0.35)
end

function isPlayerIsWinner(loseTeam)
    localPlayer = GetLocalPlayer()
    for _, player in ipairs(loseTeam.players) do
        if localPlayer == player.id then
            return false
        end
    end
    return true
end
Debug.endFile()