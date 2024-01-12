Debug.beginFile('hero-research-trigger.lua')
function heroResearchTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
            TriggerAddAction(trig, function()
                if (GetResearched() == FourCC(upgrades_special.summonHeroBuilder)) then
                    CreateUnit(player.id, FourCC(units_special.heroBuilder), GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect), 270)
                    player.heroBuilderCount = player.heroBuilderCount + 1
                    checkHeroAvailable(player, player.heroBuilderCount)
                end
            end)
        end
    end
end

function checkHeroAvailable(player, heroesCount)
    if game_config.units.maxHeroes <= heroesCount then
        SetPlayerTechMaxAllowed(player.id, FourCC(upgrades_special.summonHeroBuilder), 0)
    end
end
Debug.endFile()