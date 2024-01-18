Debug.beginFile('main-start-game.lua')
function startGameUI()
    ui_params = {
        lengthString = 0.2,
        widthString = 0.02,
        indent = 0.015,
        width = 0.4
    }
    ui_config = {
        isUnitsMirror = false,
        isHeroesMirror = false,
        maxHeroes = 3,
        startGold = 300,
        baseIncome = 300,
        incomeBoost = 30,
        firstMinePrice = 150,
        nextMineDiffPrice = 30,
        incomeForCenter = 30,
        goldByTower = 125,
        spawnInterval = 35,
        spawnDif = 0,
        lifetime = 2,
        itemCapacity = 4
    }
    BlzLoadTOCFile("war3mapimported\\templates.toc")

    local preConfigGameModes = BlzCreateFrameByType('BACKDROP', 'PreConfigGameModes', BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "QuestButtonBackdropTemplate", 0)
    BlzFrameSetAbsPoint(preConfigGameModes, FRAMEPOINT_CENTER, 0.4, 0.45)
    BlzFrameSetSize(preConfigGameModes, ui_params.width, 0.08)
    BlzFrameSetEnable(preConfigGameModes, GetLocalPlayer() == getMainPlayer())

    local frameText = BlzCreateFrameByType("TEXT", "MyTextFrame", preConfigGameModes, "EscMenuTitleTextTemplate", 0)
    BlzFrameSetText(frameText, "Pre-configured game modes")
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOP, preConfigGameModes, FRAMEPOINT_TOP, 0, -ui_params.indent)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())

    local allPages = {}
    buttonGeneral, pageGeneral = createPageGeneral(preConfigGameModes, allPages)
    BlzFrameSetPoint(buttonGeneral, FRAMEPOINT_TOPLEFT, preConfigGameModes, FRAMEPOINT_BOTTOMLEFT, 0, 0)

    buttonEconomy = createPageEconomy(preConfigGameModes, allPages)
    BlzFrameSetPoint(buttonEconomy, FRAMEPOINT_LEFT, buttonGeneral, FRAMEPOINT_RIGHT, -0.005, 0)

    buttonUnits = createPageUnits(preConfigGameModes, allPages)
    BlzFrameSetPoint(buttonUnits, FRAMEPOINT_LEFT, buttonEconomy, FRAMEPOINT_RIGHT, -0.005, 0)

    buttonHeroes = createPageHeroes(preConfigGameModes, allPages)
    BlzFrameSetPoint(buttonHeroes, FRAMEPOINT_LEFT, buttonUnits, FRAMEPOINT_RIGHT, -0.005, 0)

    for number, page in ipairs(allPages) do
        if number == 1 then
            BlzFrameSetVisible(page, true)
        else
            BlzFrameSetVisible(page, false)
        end
    end

    local startGameButton = buttonWithAction('START', preConfigGameModes, function()
        if GetTriggerPlayer() == getMainPlayer() then
            BlzFrameSetVisible(preConfigGameModes, FALSE)
            startGame()
        end
    end)
    BlzFrameSetPoint(startGameButton, FRAMEPOINT_BOTTOMRIGHT, pageGeneral, FRAMEPOINT_BOTTOMRIGHT, -ui_params.indent, ui_params.indent)

    local startGameButton = BlzCreateFrame('StartGameButton', preConfigGameModes, 0, 0)
    BlzFrameSetLevel(startGameButton, 99)
    BlzFrameSetText(startGameButton, 'START')
    BlzFrameSetPoint(startGameButton, FRAMEPOINT_BOTTOMRIGHT, pageGeneral, FRAMEPOINT_BOTTOMRIGHT, -ui_params.indent, ui_params.indent)
    BlzFrameSetEnable(startGameButton, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetEnable(startGameButton, GetLocalPlayer() == getMainPlayer())
    local trig1 = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig1, startGameButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig1, function()
        BlzFrameSetVisible(preConfigGameModes, FALSE)
        startGame()
    end)

    local selectingText = BlzCreateFrame("GreenText", preConfigGameModes, 0, 0)
    BlzFrameSetParent(selectingText, preConfigGameModes)
    BlzFrameSetText(selectingText, GetPlayerName(getMainPlayer()) .. " is selecting...")
    BlzFrameSetPoint(selectingText, FRAMEPOINT_BOTTOM, preConfigGameModes, FRAMEPOINT_TOP, 0, 0)
end

function buttonWithAction(text, parentFrame, action)
    local button = BlzCreateFrame('Button', parentFrame, 0, 0)
    BlzFrameSetLevel(button, 99)
    BlzFrameSetText(button, text)
    BlzFrameSetEnable(button, GetLocalPlayer() == getMainPlayer())
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, action)
    return button
end

function configPage(text, parent, allPages)
    local configButton = BlzCreateFrame('ConfigPageButton', parent, 0, 0)
    BlzFrameSetLevel(configButton, 99)
    BlzFrameSetText(configButton, text)
    BlzFrameSetEnable(configButton, GetLocalPlayer() == getMainPlayer())

    local pageFrame = BlzCreateFrameByType('BACKDROP', 'GeneralConfig', parent, "QuestButtonBackdropTemplate", 0)
    BlzFrameSetPoint(pageFrame, FRAMEPOINT_TOP, parent, FRAMEPOINT_BOTTOM, 0, 0)
    BlzFrameSetSize(pageFrame, ui_params.width, 0.35)
    BlzFrameSetEnable(pageFrame, GetLocalPlayer() == getMainPlayer())
    table.insert(allPages, pageFrame)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, configButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        for _, page in ipairs(allPages) do
            BlzFrameSetVisible(page, false)
        end
        BlzFrameSetVisible(pageFrame, true)
    end)
    return configButton, pageFrame
end

function initRaceAvailableButton(race, position, frame, unitContainer, max)
    if position >= max then
        return
    end
    local button = BlzCreateFrame("MyIconButtonTemplate", frame, 0, 0)
    BlzFrameSetPoint(button, FRAMEPOINT_TOPLEFT, frame, FRAMEPOINT_TOPLEFT, 0, -(BlzFrameGetHeight(button) * position) + 0.01)

    local buttonTexture = BlzGetFrameByName("MyButtonBackdropTemplate", 0)
    BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(race.id)), 0, true)

    race.active = true
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        if GetTriggerPlayer() ~= getMainPlayer() then
            return
        end
        if race.active == true then
            race.active = false
            BlzFrameSetTexture(buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(race.id))), 0, true)
            for _, unit in ipairs(unitContainer) do
                if unit.race == race.race then
                    unit.active = false
                    BlzFrameSetTexture(unit.buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(unit.parentId))), 0, true)
                end
            end
        else
            race.active = true
            BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(race.id)), 0, true)
            for _, unit in ipairs(unitContainer) do
                if unit.race == race.race then
                    unit.active = true
                    BlzFrameSetTexture(unit.buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
                end
            end
        end
    end)
end

function initUnitAvailableButton(unit, containerFrame)
    local button = BlzCreateFrame("MyIconButtonTemplate", containerFrame, 0, 0)
    BlzFrameSetPoint(button, FRAMEPOINT_TOPLEFT, containerFrame, FRAMEPOINT_TOPLEFT, (BlzFrameGetWidth(button) * unit.position), -(BlzFrameGetHeight(button) * unit.line) + 0.01)

    local buttonTexture = BlzGetFrameByName("MyButtonBackdropTemplate", 0)
    BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)

    unit.active = true
    unit.buttonTexture = buttonTexture
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        if GetTriggerPlayer() ~= getMainPlayer() then
            return
        end
        if unit.active == true then
            unit.active = false
            BlzFrameSetTexture(buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(unit.parentId))), 0, true)
        else
            unit.active = true
            BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
        end
    end)
end

function replaceTexture(inputString)
    local replacedString = inputString:gsub("ReplaceableTextures\\CommandButtons\\(.-)%.blp", "ReplaceableTextures\\CommandButtonsDisabled\\DIS%1.blp")
    return replacedString
end
Debug.endFile()