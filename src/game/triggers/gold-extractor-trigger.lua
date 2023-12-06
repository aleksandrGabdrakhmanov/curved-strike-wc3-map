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
                player.minePrice = player.minePrice + game_config.economy.nextMineDiffPrice
                player.income = player.income + 1
                player.mineLevel = player.mineLevel + 1
                BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, player.minePrice)

                DestroyTextTag(player.mineTextTag)
                player.mineTextTag = CreateTextTagUnitBJ("level: " .. player.mineLevel, GetTriggerUnit(), 0, 10, 204, 204, 0, 0)
            end)
        end
    end
end