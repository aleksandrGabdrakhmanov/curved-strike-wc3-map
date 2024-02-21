Debug.beginFile('center-control-trigger.lua')
function centerControlTrigger()
    for _, team in ipairs(all_teams) do
        local trig = CreateTrigger()
        TriggerRegisterEnterRectSimple(trig, team.base.addGoldRect)
        TriggerAddAction(trig, function()
            local unit = GetTriggerUnit()
            local trgPlayer = GetOwningPlayer(unit)
            local isAddGold = false
            for _, player in ipairs(team.players) do
                if (player.spawnPlayerId == trgPlayer or player.id == trgPlayer) then
                    isAddGold = true
                end
            end
            if isAddGold == true then
                for _, player in ipairs(team.players) do
                    player.economy.incomeForCenter = game_config.economy.incomeForCenter
                end

                for _, otherTeam in ipairs(all_teams) do
                    if otherTeam ~= team then
                        for _, player in ipairs(otherTeam.players) do
                            player.economy.incomeForCenter = 0
                        end
                    end
                end
            end
        end)
    end
end
Debug.endFile()
