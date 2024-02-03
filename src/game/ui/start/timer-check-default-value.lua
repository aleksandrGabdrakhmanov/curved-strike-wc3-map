Debug.beginFile('init-start-game-ui.lua')
function timerCheckDefaultValue()
    local gameTimer = CreateTimer()
    local red = BlzConvertColor(255, 255, 2, 2)
    local yellow = BlzConvertColor(255, 255, 215, 0)
    TimerStart(gameTimer, 0.5, true, function()
        for _, element in ipairs(ui_elements) do
            if element.value ~= element.defValue then
                if element.label ~= nil then
                    BlzFrameSetTextColor(element.label, red)
                end
                if element.frameText ~= nil then
                    BlzFrameSetTextColor(element.frameText, red)
                end
            else
                if element.label ~= nil then
                    BlzFrameSetTextColor(element.label, yellow)
                end
                if element.frameText ~= nil then
                    BlzFrameSetTextColor(element.frameText, yellow)
                end
            end
        end
    end)
end
Debug.endFile()
