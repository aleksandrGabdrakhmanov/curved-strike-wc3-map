function initialUI()
    local fm = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 1)
end

function startGameUI()
    BlzLoadTOCFile("war3mapimported\\templates.toc")
    popupFrame = BlzCreateFrame("StartGameMenu", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    BlzFrameSetAbsPoint(popupFrame, FRAMEPOINT_CENTER, 0.4, 0.35)
    local selectingText = BlzGetFrameByName("StartGameMenuModeSelecting", 0)
    BlzFrameSetText(selectingText, GetPlayerName(getMainPlayer()) .. " is selecting...")

    initModeButton("CurvedButton", 'curved')
    initModeButton("UnitedButton", 'united')
    initUnitsAvailableButtons()
end

function initModeButton(buttonName, mode)
    local button = BlzGetFrameByName(buttonName, 0)
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        if GetTriggerPlayer() == getMainPlayer() then
            BlzFrameSetVisible(popupFrame, FALSE)
            startGame(mode)
        end
    end)
end

function initUnitsAvailableButtons()
    for i, mainUnit in ipairs(main_race) do
        initRaceAvailableButton(mainUnit, i)
    end

    for i, unit in ipairs(units_for_build) do
        initUnitAvailableButton(unit, i)
    end
end

function initRaceAvailableButton(race, position)
    local button = BlzCreateFrame("MyIconButtonTemplate", BlzGetFrameByName("StartGameMenuUnits", 0), 0, 0)
    BlzFrameSetPoint(button, FRAMEPOINT_LEFT, BlzGetFrameByName("StartGameMenuUnits", 0), FRAMEPOINT_LEFT, 0.005, -(0.01 + (BlzFrameGetHeight(button) * position)))

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
            for _, unit in ipairs(units_for_build) do
                if unit.race == race.race then
                    unit.active = false
                    BlzFrameSetTexture(unit.buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(unit.parentId))), 0, true)
                end
            end
        else
            race.active = true
            BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(race.id)), 0, true)
            for _, unit in ipairs(units_for_build) do
                if unit.race == race.race then
                    unit.active = true
                    BlzFrameSetTexture(unit.buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
                end
            end
        end
    end)
end

function initUnitAvailableButton(unit)
    local button = BlzCreateFrame("MyIconButtonTemplate", BlzGetFrameByName("StartGameMenuUnits", 0), 0, 0)
    BlzFrameSetPoint(button, FRAMEPOINT_LEFT, BlzGetFrameByName("StartGameMenuUnits", 0), FRAMEPOINT_LEFT, 0.01 + (BlzFrameGetWidth(button) * unit.position), -(0.01 + (BlzFrameGetHeight(button) * unit.line)))

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