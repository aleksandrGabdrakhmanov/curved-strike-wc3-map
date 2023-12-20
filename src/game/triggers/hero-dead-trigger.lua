function heroDeadTrigger()
    print("dd")
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.spawnPlayerId, EVENT_PLAYER_UNIT_DEATH)
            TriggerAddAction(trig, function()

                if isParentHero(('>I4'):pack(GetUnitTypeId(GetTriggerUnit()))) then
                    player.heroes[1].status = "dead"
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


