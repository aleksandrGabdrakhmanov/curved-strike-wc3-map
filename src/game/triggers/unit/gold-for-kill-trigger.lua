Debug.beginFile('gold-for-kill-trigger.lua')
function goldForKillTrigger()
    if game_config.economy.goldForKill == 0 then
        return
    end

    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trig, function()
        local killerUnit = GetKillingUnit()

        local cost = getBuildingCost(('>I4'):pack(GetUnitTypeId(GetTriggerUnit())))
        if cost > 0 then
            local gold = math.floor((game_config.economy.goldForKill/100) * cost)
            local sourcePlayer = GetOwningPlayer(killerUnit)
            for _, team in ipairs(all_teams) do
                for _, player in ipairs(team.players) do
                    if sourcePlayer == player.spawnPlayerId then
                        player.economy.totalGoldForKills = player.economy.totalGoldForKills + gold
                        addGold(player, gold)
                        return
                    end
                end
            end
        end
    end)
end

function getBuildingCost(id)
    for _, unit in ipairs(units_for_build) do
        if unit.parentId == id then
            return GetUnitGoldCost(FourCC(unit.id))
        end
        if unit.otherForm then
            for _, form in ipairs(unit.otherForm) do
                if form == id then
                    return GetUnitGoldCost(FourCC(unit.id))
                end
            end
        end
    end
    for _, hero in ipairs(heroes_for_build) do
        if hero.parentId == id then
            return game_config.units.heroCost
        end
        if hero.otherForm then
            for _, form in ipairs(hero.otherForm) do
                if form == id then
                    return game_config.units.heroCost
                end
            end
        end
    end
    return 0
end
Debug.endFile()