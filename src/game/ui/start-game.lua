Debug.beginFile('start-game.lua')
function initialUI()
    local fm = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 1)
end

function startGameUI()
    ui_params = {
        indent = 0.015,
        width = 0.4
    }
    ui_config = {
        isUnitsMirror = false,
        isHeroesMirror = false,
        maxHeroes = 3
    }
    BlzLoadTOCFile("war3mapimported\\templates.toc")

    preConfigGameModes = BlzCreateFrameByType('BACKDROP', 'PreConfigGameModes', BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "QuestButtonBackdropTemplate", 0)
    BlzFrameSetAbsPoint(preConfigGameModes, FRAMEPOINT_CENTER, 0.4, 0.45)
    BlzFrameSetSize(preConfigGameModes, ui_params.width, 0.08)

    local frameText = BlzCreateFrameByType("TEXT", "MyTextFrame", preConfigGameModes, "EscMenuTitleTextTemplate", 0)
    BlzFrameSetText(frameText, "Pre-configured game modes")
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOP, preConfigGameModes, FRAMEPOINT_TOP, 0, -ui_params.indent)

    allPages = {}

    local buttonGeneral, pageGeneral = configPage("General")
    BlzFrameSetPoint(buttonGeneral, FRAMEPOINT_TOPLEFT, preConfigGameModes, FRAMEPOINT_BOTTOMLEFT, 0, 0)

    local buttonUnits, pageUnits = configPage("Units")
    BlzFrameSetPoint(buttonUnits, FRAMEPOINT_LEFT, buttonGeneral, FRAMEPOINT_RIGHT, -0.005, 0)
    local availableUnitsTextFrame = BlzCreateFrameByType('TEXT', 'availableUnitsTextFrame', pageUnits, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableUnitsTextFrame, 'Available units:')
    BlzFrameSetPoint(availableUnitsTextFrame, FRAMEPOINT_TOPLEFT, pageUnits, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableUnitsTextFrame, units_for_build, 5)
    end
    for _, unit in ipairs(units_for_build) do
        initUnitAvailableButton(unit, availableUnitsTextFrame)
    end
    local checkBoxUnits = checkBox('Mirror units', pageUnits,
            function() ui_config.isUnitsMirror = true end,
            function() ui_config.isUnitsMirror = false end
    )
    BlzFrameSetPoint(checkBoxUnits, FRAMEPOINT_TOPLEFT, pageUnits, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.17)


    local buttonHeroes, pageHeroes = configPage("Heroes")
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
    local checkBoxHeroes = checkBox('Mirror heroes', pageHeroes,
            function() ui_config.isHeroesMirror = true end,
            function() ui_config.isHeroesMirror = false end
    )
    BlzFrameSetPoint(checkBoxHeroes, FRAMEPOINT_TOPLEFT, pageHeroes, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.2)

    local frameText = BlzCreateFrameByType("TEXT", "TextCountHeroes", pageHeroes, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, "Max heroes")
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOPLEFT, checkBoxHeroes, FRAMEPOINT_BOTTOMLEFT, 0, -0.005)

    local slider = BlzCreateFrame("EscMenuSliderTemplate",  pageHeroes,0,0)
    local label = BlzCreateFrame("EscMenuLabelTextTemplate", slider, 0, 0)
    BlzFrameSetPoint(slider, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0.015, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, slider, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetMinMaxValue(slider, 0, 7)
    BlzFrameSetValue(slider, ui_config.maxHeroes)
    BlzFrameSetStepSize(slider, 1)

    BlzFrameSetText(label, ui_config.maxHeroes)

    local trigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trigger, slider, FRAMEEVENT_SLIDER_VALUE_CHANGED)
    TriggerAddAction(trigger, function()
        ui_config.maxHeroes = BlzGetTriggerFrameValue()
        BlzFrameSetText(label, math.floor(ui_config.maxHeroes))
    end)

    local startGameButton = BlzCreateFrame('StartGameButton', preConfigGameModes, 0, 0)
    BlzFrameSetLevel(startGameButton, 99)
    BlzFrameSetText(startGameButton, 'START')
    BlzFrameSetPoint(startGameButton, FRAMEPOINT_BOTTOMRIGHT, pageGeneral, FRAMEPOINT_BOTTOMRIGHT, -ui_params.indent, ui_params.indent)
    local trig1 = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig1, startGameButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig1, function()
        if GetTriggerPlayer() == getMainPlayer() then
            BlzFrameSetVisible(preConfigGameModes, FALSE)
            startGame()
        end
    end)

    local selectingText = BlzCreateFrame("GreenText", preConfigGameModes, 0, 0)
    BlzFrameSetParent(selectingText, preConfigGameModes)
    BlzFrameSetText(selectingText, GetPlayerName(getMainPlayer()) .. " is selecting...")
    BlzFrameSetPoint(selectingText, FRAMEPOINT_TOP, generalConfig, FRAMEPOINT_BOTTOM, 0, 0)
end


function configPage(text)
    local configButton = BlzCreateFrame('ConfigPageButton', preConfigGameModes, 0, 0)
    BlzFrameSetLevel(configButton, 99)
    BlzFrameSetText(configButton, text)

    local pageFrame = BlzCreateFrameByType('BACKDROP', 'GeneralConfig', preConfigGameModes, "QuestButtonBackdropTemplate", 0)
    BlzFrameSetPoint(pageFrame, FRAMEPOINT_TOP, preConfigGameModes, FRAMEPOINT_BOTTOM, 0, 0)
    BlzFrameSetSize(pageFrame, ui_params.width, 0.35)
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

function checkBox(text, parentFrame, checkedFunc, uncheckedFunc)

    local frameText = BlzCreateFrameByType("TEXT", "MyTextFrame", parentFrame, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, text)

    local frameCheckBox = BlzCreateFrame("QuestCheckBox2",  parentFrame, 0, 0)
    BlzFrameSetPoint(frameCheckBox, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0.005, 0)
    BlzFrameSetScale(frameCheckBox, 1.5)

    local trigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_CHECKED)
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    TriggerAddAction(trigger, function()
        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
            checkedFunc()
        else
            uncheckedFunc()
        end
    end)
    return frameText
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
    BlzFrameSetPoint(button, FRAMEPOINT_TOPLEFT, containerFrame, FRAMEPOINT_TOPLEFT, (BlzFrameGetWidth(button) * unit.position), -(BlzFrameGetHeight(button) * unit.line)+ 0.01)

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