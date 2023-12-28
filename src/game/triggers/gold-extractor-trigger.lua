Debug.beginFile('gold-extractor-trigger.lua')
function goldExtractorTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.mine)
            end))
            TriggerAddAction(trig, function()
                local abilityIntegerId = GetSpellAbilityId()
                local ability = BlzGetUnitAbility(GetTriggerUnit(), abilityIntegerId)
                player.economy.minePrice = player.economy.minePrice + game_config.economy.nextMineDiffPrice
                player.economy.income = player.economy.income + game_config.economy.incomeBoost
                player.economy.mineLevel = player.economy.mineLevel + 1
                BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, player.economy.minePrice)

                SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD) + game_config.economy.nextMineDiffPrice)

                DestroyTextTag(player.economy.mineTextTag)
                player.economy.mineTextTag = CreateTextTagUnitBJ(getMineTag(player), GetTriggerUnit(), 0, 10, 204, 204, 0, 0)
            end)
        end
    end
end

function getMineTag(player)
    return 'Level: ' .. player.economy.mineLevel .. ' (' .. player.economy.income * 60 .. '/m) next: ' .. (player.economy.income + game_config.economy.incomeBoost) * 60 .. '/m'
end

Debug.endFile()