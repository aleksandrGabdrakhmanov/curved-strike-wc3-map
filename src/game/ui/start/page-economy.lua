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

    local incomeForCenterControl = createSlider(pageEconomy, 'Added inc for controlling center', 0, 300, ui_config.incomeForCenter, 30, function(value)
        ui_config.incomeForCenter = value
    end)
    BlzFrameSetPoint(incomeForCenterControl, FRAMEPOINT_TOPLEFT, incomeForEachMineSlider, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)

    local firstMinePriceSlider = createSlider(pageEconomy, 'Price first mine', 1, 1500, ui_config.firstMinePrice, 1, function(value)
        ui_config.firstMinePrice = value
    end)
    BlzFrameSetPoint(firstMinePriceSlider, FRAMEPOINT_TOPLEFT, incomeForCenterControl, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)

    local nextMinePriceSlider = createSlider(pageEconomy, 'Price diff for each next mine', 1, 300, ui_config.nextMineDiffPrice, 1, function(value)
        ui_config.nextMineDiffPrice = value
    end)
    BlzFrameSetPoint(nextMinePriceSlider, FRAMEPOINT_TOPLEFT, firstMinePriceSlider, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)

    local goldByTowerSlider = createSlider(pageEconomy, 'Gold for killing the tower', 0, 1500, ui_config.goldByTower, 1, function(value)
        ui_config.goldByTower = value
    end)
    BlzFrameSetPoint(goldByTowerSlider, FRAMEPOINT_TOPLEFT, nextMinePriceSlider, FRAMEPOINT_BOTTOMLEFT, 0, -0.01)
    return buttonEconomy
end
Debug.endFile()