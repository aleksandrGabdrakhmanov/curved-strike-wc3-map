Debug.beginFile('page-economy.lua')
function createPageEconomy(parentFrame, allPages)
    local buttonEconomy, pageEconomy = configPage("Economy", parentFrame, allPages)
    local startGoldEditBox = createEditBox(pageEconomy, 'Start gold', 0, 999999, ui_config.startGold, function(value)
        ui_config.startGold = value
    end)
    BlzFrameSetPoint(startGoldEditBox, FRAMEPOINT_TOPLEFT, pageEconomy, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)

    local baseIncomeSlider = createSlider(pageEconomy, 'Base income/min', 60, 3000, ui_config.baseIncome, 30, function(value)
        ui_config.baseIncome = value
    end)
    BlzFrameSetPoint(baseIncomeSlider, FRAMEPOINT_TOPLEFT, startGoldEditBox, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)

    local incomeForEachMineSlider = createSlider(pageEconomy, 'Added inc for each mine', 30, 300, ui_config.incomeBoost, 30, function(value)
        ui_config.incomeBoost = value
    end)
    BlzFrameSetPoint(incomeForEachMineSlider, FRAMEPOINT_TOPLEFT, baseIncomeSlider, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)
    return buttonEconomy
end
Debug.endFile()