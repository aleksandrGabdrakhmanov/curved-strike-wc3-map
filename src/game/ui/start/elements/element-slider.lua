Debug.beginFile('element-slider.lua')
function createSlider(parentPage, lastElement, element)
    local frameText = BlzCreateFrameByType("TEXT", "TextCountHeroes", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, element.text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local tooltipFrame, tooltipLabel = createTooltip(parentPage)
    BlzFrameSetTooltip(frameText, tooltipFrame)
    BlzFrameSetText(tooltipLabel, element.tooltip)

    local slider = BlzCreateFrame("EscMenuSliderTemplate", parentPage, 0, 0)
    BlzFrameSetPoint(slider, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetMinMaxValue(slider, element.min, element.max)
    BlzFrameSetValue(slider, element.defValue)
    BlzFrameSetStepSize(slider, element.step)
    BlzFrameSetEnable(slider, GetLocalPlayer() == getMainPlayer())

    local label = BlzCreateFrame("EscMenuLabelTextTemplate", slider, 0, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, slider, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetText(label, element.defValue)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())

    local sliderTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(sliderTrigger, slider, FRAMEEVENT_SLIDER_VALUE_CHANGED)
    TriggerAddAction(sliderTrigger, function()
        local value = BlzGetTriggerFrameValue()
        element.value = value
        BlzFrameSetText(label, math.floor(value))
    end)
    return frameText
end
Debug.endFile()