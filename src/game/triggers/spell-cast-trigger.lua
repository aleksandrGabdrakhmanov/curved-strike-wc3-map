custom_cast_ai_params = {
    {
        unitId = 'u006',
        order = 'antimagicshell',
        timeout = 2.00
    },
    {
        unitId = 'h00H',
        order = 'innerfire',
        timeout = 5.00
    }
}
function customCastAITrigger()
    for _, castParam in ipairs(custom_cast_ai_params) do
        createTriggerByCastParam(castParam)
    end
end

function createTriggerByCastParam(castParam)
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, castParam.timeout)
    TriggerAddAction(trig, function()
        local group = GetUnitsOfTypeIdAll(FourCC(castParam.unitId))
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
            IssueTargetOrderBJ(GetEnumUnit(), castParam.order, randomUnit)
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