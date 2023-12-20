function heroDeadTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.spawnPlayerId, EVENT_PLAYER_UNIT_DEATH)
            TriggerAddAction(trig, function()
                if isParentHero(('>I4'):pack(GetUnitTypeId(GetTriggerUnit()))) then
                    for _, hero in ipairs(player.heroes) do
                        if hero.unit == GetTriggerUnit() then
                            hero.status = "dead"
                            break
                        end
                    end
                end
            end)
        end
    end
end

function isParentHero(id)
    for _, hero in ipairs(heroes_for_build) do
        if hero.parentId == id then
            return true
        end
    end
    return false
end