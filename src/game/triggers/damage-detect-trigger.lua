Debug.beginFile('damage-detect-trigger.lua')
function damageDetectTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGED)
    TriggerAddAction(trig, function()
        local source = GetEventDamageSource()
        if GetUnitTypeId(source) == FourCC(units_special.tower) or GetUnitTypeId(source) == FourCC(units_special.base) then
            return
        end
        local sourcePlayer = GetOwningPlayer(source)
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if sourcePlayer == player.spawnPlayerId then
                    if GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.tower) or GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.base) then
                        player.damageToTowerBase = player.damageToTowerBase + GetEventDamage()
                        return
                    end
                    player.totalDamage = math.floor(player.totalDamage + GetEventDamage())
                    local userData = GetUnitUserData(source)
                    if userData >= START_INDEX_HEROES then
                        for _, hero in ipairs(player.heroes) do
                            if hero.id == userData then
                                hero.damage = math.floor(hero.damage + GetEventDamage())
                            end
                        end
                    end
                    return
                end
            end
        end
    end)
end
Debug.endFile()