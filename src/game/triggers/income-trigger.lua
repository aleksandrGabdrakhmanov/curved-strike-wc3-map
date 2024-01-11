Debug.beginFile('income-trigger.lua')
function incomeTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do

                player.economy.roundUp = not player.economy.roundUp

                local income = player.economy.income + player.economy.incomeForCenter
                local roundedIncome

                if player.economy.roundUp then
                    roundedIncome = math.ceil(income)
                else
                    roundedIncome = math.floor(income)
                end

                addGold(player, roundedIncome)
            end
        end
    end)
end

function addGold(player, gold)
    local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)
    player.economy.totalGold = player.economy.totalGold + gold
    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + gold)
end
Debug.endFile()