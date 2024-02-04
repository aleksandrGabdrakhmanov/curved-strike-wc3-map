Debug.beginFile('init-start-game-ui.lua')
function timerCheckDefaultValue()
    local gameTimer = CreateTimer()
    local red = BlzConvertColor(255, 255, 2, 2)
    local yellow = BlzConvertColor(255, 255, 215, 0)
    TimerStart(gameTimer, 0.5, true, function()
        elementsCheckDefault(red, yellow)
        unitsCheckDefault(red, yellow, units_for_build, availableUnitsTextFrame)
        unitsCheckDefault(red, yellow, heroes_for_build, availableHeroesTextFrame)
    end)
end

function elementsCheckDefault(red, yellow)
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
end

function unitsCheckDefault(red, yellow, unitArray, labelFrame)
    local isFoundChangedElement = false
    for _, unit in ipairs(unitArray) do
        if unit.active ~= nil and unit.active == false then
            isFoundChangedElement = true
        end
    end
    if isFoundChangedElement == true then
        if labelFrame ~= nil then
            BlzFrameSetTextColor(labelFrame, red)
        end
    else
        if labelFrame ~= nil then
            BlzFrameSetTextColor(labelFrame, yellow)
        end
    end
end

Debug.endFile()
