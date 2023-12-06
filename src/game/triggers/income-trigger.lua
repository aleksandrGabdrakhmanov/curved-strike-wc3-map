function incomeTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)
                SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + player.income)
            end
        end
    end)
end