function heroResearchTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
            TriggerAddAction(trig, function()
                if (GetResearched() == FourCC(upgrades_special.summonHeroBuilder)) then
                    if type(player.workerRect) == "table" then
                        CreateUnit(player.id, FourCC(units_special.heroBuilder), GetRectCenterX(player.workerRect[1]), GetRectCenterY(player.workerRect[1]), 270)
                    else
                        CreateUnit(player.id, FourCC(units_special.heroBuilder), GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect), 270)
                    end
                end
            end)
        end
    end
end