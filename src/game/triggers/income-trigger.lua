Debug.beginFile('income-trigger.lua')
function incomeTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do

                player.economy.roundUp = not player.economy.roundUp

                local _, percent = getUpkeepTypeAndPercent(player)

                local income = (player.economy.income + player.economy.incomeForCenter)/60
                local incomeWithPercent = (income * percent) / 100
                if (incomeWithPercent == 0) then
                    return
                end

                local roundedIncome
                if player.economy.roundUp then
                    roundedIncome = math.ceil(incomeWithPercent)
                else
                    roundedIncome = math.floor(incomeWithPercent)
                end

                addGold(player, roundedIncome)
            end
        end
    end)
end

upkeepType = {
    NO = 'NO',
    LOW = 'LOW',
    HIGH = 'HIGH'
}

function getUpkeepTypeAndPercent(player)

    if game_config.economy.upkeep == true then
        if player.food > 10 and player.food <= 100 then
            return upkeepType.LOW, 80
        elseif player.food > 100 then
            return upkeepType.HIGH, 60
        else
            return upkeepType.NO, 100
        end
    end
    return nil, 100
end

function addGold(player, gold)
    local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)
    player.economy.totalGold = player.economy.totalGold + gold
    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + gold)
end
Debug.endFile()