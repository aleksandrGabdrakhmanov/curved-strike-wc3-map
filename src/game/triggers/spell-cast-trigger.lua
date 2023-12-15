function spellCastTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 2.00)
    TriggerAddAction(trig, function()
        local group = GetUnitsOfTypeIdAll(FourCC('u006'))
        ForGroup(group, function()
            local randomUnit = GroupPickRandomUnit(
                    GetUnitsInRangeOfLocMatching(
                            500,
                            GetUnitLoc(GetEnumUnit()),
                            Filter(function()
                                local filterUnit = GetFilterUnit()
                                local ownerFilterUnit = GetOwningPlayer(filterUnit)
                                return getSpawnPlayerIds(GetOwningPlayer(GetEnumUnit()), ownerFilterUnit)
                            end)
                    )
            )
            IssueTargetOrderBJ(GetEnumUnit(), "antimagicshell", randomUnit)
        end)
    end)
end

function getSpawnPlayerIds(player, checkPlayer)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                for _, spawnP in ipairs(team.spawnPlayers) do
                    if spawnP == checkPlayer then
                        return true
                    end
                end
            end
        end
    end
    return false
end