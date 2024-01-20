Debug.beginFile('main-start-game.lua')
function startGameUI()
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
    local buttonGeneral, pageGeneral, lastElementGeneral = configPage("General", preConfigGameModes, allPages, 0.02)
    BlzFrameSetPoint(buttonGeneral, FRAMEPOINT_TOPLEFT, preConfigGameModes, FRAMEPOINT_BOTTOMLEFT, 0, 0)

    local buttonEconomy, pageEconomy, lastElementEconomy = configPage("Economy", preConfigGameModes, allPages, 0.02)
    BlzFrameSetPoint(buttonEconomy, FRAMEPOINT_LEFT, buttonGeneral, FRAMEPOINT_RIGHT, -0.005, 0)

    local buttonUnits, pageUnits, lastElementUnits = configPage("Units", preConfigGameModes, allPages, 0.13)
    BlzFrameSetPoint(buttonUnits, FRAMEPOINT_LEFT, buttonEconomy, FRAMEPOINT_RIGHT, -0.005, 0)
    local availableUnitsTextFrame = BlzCreateFrameByType('TEXT', 'availableUnitsTextFrame', pageUnits, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableUnitsTextFrame, 'Available units:')
    BlzFrameSetPoint(availableUnitsTextFrame, FRAMEPOINT_TOPLEFT, pageUnits, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableUnitsTextFrame, units_for_build, 5)
    end
    for _, unit in ipairs(units_for_build) do
        initUnitAvailableButton(unit, availableUnitsTextFrame)
    end

    local buttonHeroes, pageHeroes, lastElementHeroes = configPage("Heroes", preConfigGameModes, allPages, 0.16)
    BlzFrameSetPoint(buttonHeroes, FRAMEPOINT_LEFT, buttonUnits, FRAMEPOINT_RIGHT, -0.005, 0)
    local availableHeroesTextFrame = BlzCreateFrameByType('TEXT', 'availableHeroesTextFrame', pageHeroes, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableHeroesTextFrame, 'Available heroes:')
    BlzFrameSetPoint(availableHeroesTextFrame, FRAMEPOINT_TOPLEFT, pageHeroes, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableHeroesTextFrame, heroes_for_build, 6)
    end
    for _, hero in ipairs(heroes_for_build) do
        initUnitAvailableButton(hero, availableHeroesTextFrame)
    end

    initGameConfig()
    for _, element in ipairs(ui_elements) do
        if element.page == page.GENERAL then
            lastElementGeneral = createElement(element, pageGeneral, lastElementGeneral)
        elseif element.page == page.ECONOMY then
            lastElementEconomy = createElement(element, pageEconomy, lastElementEconomy)
        elseif element.page == page.UNITS then
            lastElementUnits = createElement(element, pageUnits, lastElementUnits)
        elseif element.page == page.HEROES then
            lastElementHeroes = createElement(element, pageHeroes, lastElementHeroes)
        end
    end

    for number, page in ipairs(allPages) do
        if number == 1 then
            BlzFrameSetVisible(page, true)
        else
            BlzFrameSetVisible(page, false)
        end
    end
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
        for _, element in ipairs(ui_elements) do
            element.initConfigValue(element)
        end
        startGame()
    end)

        local selectingText = BlzCreateFrame("GreenText", preConfigGameModes, 0, 0)
        BlzFrameSetParent(selectingText, preConfigGameModes)
        BlzFrameSetText(selectingText, GetPlayerName(getMainPlayer()) .. " is selecting...")
        BlzFrameSetPoint(selectingText, FRAMEPOINT_BOTTOM, preConfigGameModes, FRAMEPOINT_TOP, 0, 0)
end

function createElement(element, page, lastElement)
    if element.type == elementType.SLIDER then
        return createSlider(page, lastElement, element)
    elseif element.type == elementType.EDIT_BOX then
        return createEditBox(page, lastElement, element)
    elseif element.type == elementType.CHECK_BOX then
        return createCheckBox(page, lastElement, element)
    end

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

function configPage(text, parent, allPages, dif)
    local configButton = BlzCreateFrame('ConfigPageButton', parent, 0, 0)
    BlzFrameSetLevel(configButton, 99)
    BlzFrameSetText(configButton, text)
    BlzFrameSetEnable(configButton, GetLocalPlayer() == getMainPlayer())

    local pageFrame = BlzCreateFrame('ConfigPageBackdrop', parent, 0, 0)
    BlzFrameSetPoint(pageFrame, FRAMEPOINT_TOP, parent, FRAMEPOINT_BOTTOM, 0, 0)
    BlzFrameSetSize(pageFrame, ui_params.width, 0.35)
    BlzFrameSetEnable(pageFrame, GetLocalPlayer() == getMainPlayer())
    table.insert(allPages, pageFrame)

    local emptyFrame = BlzCreateFrameByType("FRAME", "", parent, "", 0)
    BlzFrameSetSize(emptyFrame, ui_params.lengthString, 0.001)

    BlzFrameSetPoint(emptyFrame, FRAMEPOINT_TOPLEFT, pageFrame, FRAMEPOINT_TOPLEFT, ui_params.indent, -dif)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, configButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        for _, page in ipairs(allPages) do
            BlzFrameSetVisible(page, false)
        end
        BlzFrameSetVisible(pageFrame, true)
    end)
    return configButton, pageFrame, emptyFrame
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