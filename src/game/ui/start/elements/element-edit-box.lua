Debug.beginFile('element-check-box.lua')
function createEditBox(parentPage, text, minValue, maxValue, initValue, action)
    local frameText = BlzCreateFrameByType("TEXT", "TextFrame", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())

    local editBox = BlzCreateFrame("EscMenuEditBoxTemplate", parentPage, 0, 0) --create the box
    BlzFrameSetPoint(editBox, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetSize(editBox, 0.1, 0.03)
    BlzFrameSetText(editBox, initValue)
    BlzFrameSetEnable(editBox, GetLocalPlayer() == getMainPlayer())

    local label = BlzCreateFrame("EscMenuLabelTextTemplate", parentPage, 0, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, editBox, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetText(label, '= ' .. initValue)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, editBox, FRAMEEVENT_EDITBOX_ENTER)
    TriggerAddAction(trig, function()
        local value = extractNumber(BlzGetTriggerFrameText())

        local newValue
        if value ~= nil then
            if value <= minValue then
                newValue = minValue
            elseif value >= maxValue then
                newValue = maxValue
            else
                newValue = value
            end
        else
            newValue = initValue
        end

        if (newValue ~= nil) then
            action(newValue)
            BlzFrameSetText(label, '= ' .. newValue)
        end
    end)
    return frameText
end

function extractNumber(inputString)
    local number = string.match(inputString, "%-?%d+")
    return number and tonumber(number) or nil
end
Debug.endFile()
