Debug.beginFile('element-slider.lua')
function createSlider(parentPage, text, minValue, maxValue, initValue, step, func)
    local frameText = BlzCreateFrameByType("TEXT", "TextCountHeroes", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())

    local slider = BlzCreateFrame("EscMenuSliderTemplate", parentPage, 0, 0)
    BlzFrameSetPoint(slider, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetMinMaxValue(slider, minValue, maxValue)
    BlzFrameSetValue(slider, initValue)
    BlzFrameSetStepSize(slider, step)
    BlzFrameSetEnable(slider, GetLocalPlayer() == getMainPlayer())

    local label = BlzCreateFrame("EscMenuLabelTextTemplate", slider, 0, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, slider, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetText(label, initValue)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())

    local sliderTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(sliderTrigger, slider, FRAMEEVENT_SLIDER_VALUE_CHANGED)
    TriggerAddAction(sliderTrigger, function()
        local value = BlzGetTriggerFrameValue()
        func(value)
        BlzFrameSetText(label, math.floor(value))
    end)
    return frameText
end
Debug.endFile()