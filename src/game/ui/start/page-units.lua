Debug.beginFile('page-units.lua')
function createPageUnits(parentFrame, allPages)
    local buttonUnits, pageUnits = configPage("Units", parentFrame, allPages)
    local availableUnitsTextFrame = BlzCreateFrameByType('TEXT', 'availableUnitsTextFrame', pageUnits, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableUnitsTextFrame, 'Available units:')
    BlzFrameSetPoint(availableUnitsTextFrame, FRAMEPOINT_TOPLEFT, pageUnits, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableUnitsTextFrame, units_for_build, 5)
    end
    for _, unit in ipairs(units_for_build) do
        initUnitAvailableButton(unit, availableUnitsTextFrame)
    end
    local checkBoxUnits = checkBox('Mirror units', pageUnits,
            function()
                ui_config.isUnitsMirror = true
            end,
            function()
                ui_config.isUnitsMirror = false
            end
    )
    BlzFrameSetPoint(checkBoxUnits, FRAMEPOINT_TOPLEFT, pageUnits, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.17)

    local lifetimeSlider = createSlider(pageUnits, 'Max lifespan of unit in waves', 1, 10, ui_config.lifetime, 1, function(value)
        ui_config.lifetime = value
    end)
    BlzFrameSetPoint(lifetimeSlider, FRAMEPOINT_TOPLEFT, checkBoxUnits, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)

    return buttonUnits
end
Debug.endFile()