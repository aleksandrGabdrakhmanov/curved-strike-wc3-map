Debug.beginFile('page-heroes.lua')
function createPageHeroes(parentFrame, allPages)
    local buttonHeroes, pageHeroes = configPage("Heroes", parentFrame, allPages)
    local availableHeroesTextFrame = BlzCreateFrameByType('TEXT', 'availableHeroesTextFrame', pageHeroes, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableHeroesTextFrame, 'Available heroes:')
    BlzFrameSetPoint(availableHeroesTextFrame, FRAMEPOINT_TOPLEFT, pageHeroes, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableHeroesTextFrame, heroes_for_build, 6)
    end
    for _, hero in ipairs(heroes_for_build) do
        initUnitAvailableButton(hero, availableHeroesTextFrame)
    end
    local checkBoxHeroes = checkBox('Mirror heroes', pageHeroes,
            function()
                ui_config.isHeroesMirror = true
            end,
            function()
                ui_config.isHeroesMirror = false
            end
    )
    BlzFrameSetPoint(checkBoxHeroes, FRAMEPOINT_TOPLEFT, pageHeroes, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.2)

    local sliderMaxHeroes = createSlider(pageHeroes, "Max heroes", 0, 7, ui_config.maxHeroes, 1,
            function(value)
                ui_config.maxHeroes = value
            end)
    BlzFrameSetPoint(sliderMaxHeroes, FRAMEPOINT_TOPLEFT, checkBoxHeroes, FRAMEPOINT_BOTTOMLEFT, 0, -0.005)
    return buttonHeroes
end
Debug.endFile()