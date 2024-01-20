Debug.beginFile('element-check-box.lua')
function createEditBox(parentPage, lastElement, element)
    local frameText = BlzCreateFrameByType("TEXT", "TextFrame", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, element.text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local editBox = BlzCreateFrame("EscMenuEditBoxTemplate", parentPage, 0, 0) --create the box
    BlzFrameSetPoint(editBox, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetSize(editBox, 0.1, 0.03)
    BlzFrameSetText(editBox, element.defValue)
    BlzFrameSetEnable(editBox, GetLocalPlayer() == getMainPlayer())

    local label = BlzCreateFrame("EscMenuLabelTextTemplate", parentPage, 0, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, editBox, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetText(label, '= ' .. element.defValue)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, editBox, FRAMEEVENT_EDITBOX_ENTER)
    TriggerAddAction(trig, function()
        local value = extractNumber(BlzGetTriggerFrameText())

        local newValue
        if value ~= nil then
            if value <= element.min then
                newValue = element.min
            elseif value >= element.max then
                newValue = element.max
            else
                newValue = value
            end
        else
            newValue = initValue
        end

        if (newValue ~= nil) then
            element.value = value
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
