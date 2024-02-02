Debug.beginFile('dead-detect-trigger.lua')
function deadDetectTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trig, function()
        local source = GetKillingUnit()
        if GetUnitTypeId(source) == FourCC(units_special.tower[1]) or GetUnitTypeId(source) == FourCC(units_special.base[1]) then
            return
        end
        if GetUnitTypeId(source) == FourCC(units_special.tower[2]) or GetUnitTypeId(source) == FourCC(units_special.base[2]) then
            return
        end
        local sourcePlayer = GetOwningPlayer(source)
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if sourcePlayer == player.spawnPlayerId then
                    player.totalKills = math.floor(player.totalKills + 1)
                    if IsUnitType(GetDyingUnit(), UNIT_TYPE_SUMMONED) then
                        player.totalSummonKills = player.totalSummonKills + 1
                    end
                    local userDataDying = GetUnitUserData(GetDyingUnit())
                    if userDataDying >= START_INDEX_HEROES then
                        player.totalHeroKills = player.totalHeroKills + 1
                    end

                    local userData = GetUnitUserData(source)
                    if userData >= START_INDEX_HEROES then
                        for _, hero in ipairs(player.heroes) do
                            if hero.id == userData then
                                hero.kills = hero.kills + 1
                            end
                        end
                    end
                    return
                end
            end
        end
    end)
end

function isHeroOrSummon(id)
    for _, hero in ipairs(heroes_for_build) do
        if hero.id == id then
            return true
        end
    end
    return false
end
Debug.endFile()
