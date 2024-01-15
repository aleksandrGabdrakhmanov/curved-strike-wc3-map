Debug.beginFile('element-check-box.lua')
function checkBox(text, parentFrame, checkedFunc, uncheckedFunc)

    local frameText = BlzCreateFrameByType("TEXT", "MyTextFrame", parentFrame, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)

    local frameCheckBox = BlzCreateFrame("QuestCheckBox2", parentFrame, 0, 0)
    BlzFrameSetPoint(frameCheckBox, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
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
Debug.endFile()