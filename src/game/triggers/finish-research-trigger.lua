function finishResearchTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_RESEARCH_FINISH )
            TriggerAddAction(trig, function()
                SetPlayerTechResearchedSwap(GetResearched(), GetPlayerTechCountSimple(GetResearched(), player.id), player.spawnPlayerId)
            end)
        end
    end
end