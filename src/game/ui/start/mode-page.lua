Debug.beginFile('mode-page.lua')
mode = {
    DIRECT = 'DIRECT',
    DIRECT_ADVANCED = 'DIRECT_ADVANCED',
    UNITED = 'UNITED',
    UNITED_ADVANCED = 'UNITED_ADVANCED',
    HERO_WAR = 'HERO_WAR'
}
ui_modes = {
    {
        id = mode.DIRECT,
        name = 'Direct',
        tooltip = 'Mode from Direct Strike Mix'
    },
    {
        id = mode.DIRECT_ADVANCED,
        name = 'Direct Advanced',
        tooltip = 'Direct Strike with advanced params\n\nChanged params:'
    },
    {
        id = mode.UNITED,
        name = 'United',
        tooltip = 'Units come out at the same time\n\nChanged params:'
    },
    {
        id = mode.UNITED_ADVANCED,
        name = 'United Advanced',
        tooltip = 'Units come out at the same time with advanced params\n\nChanged params:'
    },
    {
        id = mode.HERO_WAR,
        name = 'Heroes war',
        tooltip = 'Only heroes, only hardcore\n\nChanged params:',
        isUnits = false
    }
}
function modePage(relative, parent)

    local modeFrame = BlzCreateFrame('ModePageBackdrop', parent, 0, 0)
    BlzFrameSetPoint(modeFrame, FRAMEPOINT_RIGHT, relative, FRAMEPOINT_LEFT, 0, 0)
    BlzFrameSetSize(modeFrame, 0.18, 0.4)
    BlzFrameSetEnable(modeFrame, GetLocalPlayer() == getMainPlayer())

    local modeText = BlzCreateFrameByType('TEXT', 'availableHeroesTextFrame', parent, 'EscMenuTitleTextTemplate', 0)
    BlzFrameSetText(modeText, 'Pre-set game modes')
    BlzFrameSetPoint(modeText, FRAMEPOINT_TOP, modeFrame, FRAMEPOINT_TOP, 0, -0.01)

    local prev = modeText
    for _, mode in ipairs(ui_modes) do
        prev = addModeButton(prev, modeFrame, mode)
    end
end

function addModeButton(prev, parent, mode)
    local button = BlzCreateFrame("ScriptDialogButton", parent, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetText(buttonText, mode.name)

    BlzFrameSetPoint(button, FRAMEPOINT_TOP, prev, FRAMEPOINT_BOTTOM, 0, -0.01)
    BlzFrameSetSize(button, 0.15, 0.04)
    BlzFrameSetEnable(button, GetLocalPlayer() == getMainPlayer())

    local tooltipFrame, tooltipLabel = createTooltip(parent)

    BlzFrameClearAllPoints(tooltipFrame)
    BlzFrameSetPoint(tooltipFrame, FRAMEPOINT_RIGHT, parent, FRAMEPOINT_LEFT, 0, 0)
    BlzFrameSetTooltip(button, tooltipFrame)

    local tooltip = mode.tooltip
    for _, element in ipairs(ui_elements) do
        if element.defByMode ~= nil then
            for _, iMode in ipairs(element.defByMode) do
                if iMode.mode == mode.id then
                    tooltip = tooltip .. "\n" .. element.text .. ": " .. tostring(iMode.value)
                end
            end
        end
    end
    BlzFrameSetText(tooltipLabel, tooltip)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        for _, element in ipairs(ui_elements) do
            setDefaultForElement(element, mode)
            if mode.isUnits == false then
                setDefaultForActiveUnits(units_for_build, false)
            else
                setDefaultForActiveUnits(units_for_build, true)
            end
            setDefaultForActiveUnits(heroes_for_build, true)
        end
    end)
    return button
end

function setDefaultForActiveUnits(unitsArray, defaultValue)
    for _, unit in ipairs(unitsArray) do
        if defaultValue == true then
            if unit.active == false then
                unit.active = true
                BlzFrameSetTexture(unit.buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
            end
        else
            if unit.active == true then
                unit.active = false
                BlzFrameSetTexture(unit.buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(unit.parentId))), 0, true)
            end
        end
    end
end

function setDefaultForElement(element, mode)

    element.value = element.defValue
    if element.defByMode ~= nil then
        for _, iMode in ipairs(element.defByMode) do
            if iMode.mode == mode.id then
                element.value = iMode.value
            end
        end
    end

    if element.slider ~= nil then
        BlzFrameSetValue(element.slider, element.value)
    end

    if element.label ~= nil then
        BlzFrameSetText(element.label, tostring(element.value))
    end

    if element.editBox ~= nil then
        BlzFrameSetText(element.editBox, element.value)
    end

    if element.checkBox ~= nil then
        if element.value == false then
            BlzDestroyFrame(element.checkBox)
            createCheckBoxFrame(element.frameText, element.parentPage, element)
        else
            BlzDestroyFrame(element.checkBox)
            createCheckBoxFrame(element.frameText, element.parentPage, element)
        end
    end
end
Debug.endFile()
