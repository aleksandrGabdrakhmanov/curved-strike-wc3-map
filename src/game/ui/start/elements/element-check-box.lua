Debug.beginFile('element-check-box.lua')
function createCheckBox(parentPage, lastElement, element)

    local label = BlzCreateFrameByType("TEXT", "", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(label, element.text)
    BlzFrameSetSize(label, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(label, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local tooltipFrame, tooltipLabel = createTooltip(parentPage)
    BlzFrameSetTooltip(label, tooltipFrame)
    BlzFrameSetText(tooltipLabel, element.tooltip)

    createCheckBoxFrame(label, parentPage, element)
    return label
end
function createCheckBoxFrame(label, parentPage, element)
    local frameCheckBox
    if element.value == true then
        frameCheckBox = BlzCreateFrame("QuestCheckBoxChecked", parentPage, 0, 0)
    else
        frameCheckBox = BlzCreateFrame("QuestCheckBox2", parentPage, 0, 0)
    end

    BlzFrameSetPoint(frameCheckBox, FRAMEPOINT_LEFT, label, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetScale(frameCheckBox, 1.5)
    BlzFrameSetEnable(frameCheckBox, GetLocalPlayer() == getMainPlayer())
    local trigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_CHECKED)
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    element.frameText = label
    element.checkBox = frameCheckBox
    element.parentPage = parentPage
    TriggerAddAction(trigger, function()
        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
            element.value = true
        else
            element.value = false
        end
    end)
end
Debug.endFile()
