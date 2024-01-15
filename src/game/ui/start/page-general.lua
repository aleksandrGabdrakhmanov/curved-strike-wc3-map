Debug.beginFile('page-general.lua')
function createPageGeneral(parentFrame, allPages)
    local buttonGeneral, pageGeneral = configPage("General", parentFrame, allPages)

    local spawnIntervalSlider = createSlider(pageGeneral, 'Wave interval each players', 1, 120, ui_config.spawnInterval, 1, function(value)
        ui_config.spawnInterval = value
    end)
    BlzFrameSetPoint(spawnIntervalSlider, FRAMEPOINT_TOPLEFT, pageGeneral, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)

    local spawnDifSlider = createSlider(pageGeneral, 'Wave interval all players', 0, 120, ui_config.spawnDif, 1, function(value)
        ui_config.spawnDif = value
    end)
    BlzFrameSetPoint(spawnDifSlider, FRAMEPOINT_TOPLEFT, spawnIntervalSlider, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)

    return buttonGeneral, pageGeneral
end
Debug.endFile()