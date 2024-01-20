Debug.beginFile('element-check-box.lua')
function createCheckBox(parentPage, lastElement, element)

    local checkFrame = BlzCreateFrameByType("TEXT", "", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(checkFrame, element.text)
    BlzFrameSetSize(checkFrame, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(checkFrame, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(checkFrame, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local frameCheckBox = BlzCreateFrame("QuestCheckBox2", parentPage, 0, 0)
    BlzFrameSetPoint(frameCheckBox, FRAMEPOINT_LEFT, checkFrame, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetScale(frameCheckBox, 1.5)
    BlzFrameSetEnable(frameCheckBox, GetLocalPlayer() == getMainPlayer())

    local trigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_CHECKED)
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    TriggerAddAction(trigger, function()
        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
            element.value = true
        else
            element.value = false
        end
    end)
    return checkFrame
end
Debug.endFile()