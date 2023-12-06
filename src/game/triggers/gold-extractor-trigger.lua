function goldExtractorTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.mine)
            end))
            TriggerAddAction(trig, function()
                local triggerUnit = GetTriggerUnit()
                RemoveUnit(triggerUnit)
                CreateUnit(player.id, FourCC(units_special.mineUp), GetUnitX(triggerUnit), GetUnitY(triggerUnit),100)
                player.income = player.income + 1

                local group = GetUnitsOfPlayerAndTypeId(player.id, FourCC(units_special.mine))
                player.minePrice = player.minePrice + game_config.economy.nextMineDiffPrice
                ForGroup(group, function()

                    local abilityIntegerId = GetSpellAbilityId()
                    local ability = BlzGetUnitAbility(GetEnumUnit(), abilityIntegerId)
                    BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, player.minePrice)
                end)
                DestroyGroup(group)
            end)
        end
    end
end