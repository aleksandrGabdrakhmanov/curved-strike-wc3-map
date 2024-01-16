Debug.beginFile('spell-cast-trigger.lua')
custom_cast_ai_params = {
    {
        unitId = 'u006',
        order = 'antimagicshell',
        radius = 500,
        timeout = 2.00,
        condition = {
            target = 'ally'
        }
    },
    {
        unitId = 'h00H',
        order = 'innerfire',
        radius = 500,
        timeout = 5.00,
        condition = {
            target = 'ally'
        }
    },
    {
        unitId = 'h00I',
        order = 'invisibility',
        radius = 500,
        timeout = 1.00,
        condition = {
            target = 'ally',
            livePercent = 20
        }
    },
    {
        unitId = 'e00J',
        order = 'rejuvination',
        radius = 500,
        timeout = 2.00,
        condition = {
            target = 'ally',
            livePercent = 90
        }
    },
    {
        unitId = 'e00J',
        order = 'bearform',
        radius = 500,
        timeout = 2.00,
        condition = {
            target = 'itself',
            livePercent = 75
        }
    },
    {
        unitId = 'e00I',
        order = 'revanform',
        radius = 900,
        timeout = 2.00,
        condition = {
            target = 'enemy'
        }
    },
    {
        unitId = 'e00I',
        order = 'cyclone',
        radius = 500,
        timeout = 2.00,
        condition = {
            target = 'enemy'
        }
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

            if castParam.condition.target == 'ally' or castParam.condition.target == 'enemy' then
                local unitsGroup = GetUnitsInRangeOfLocMatching(
                        castParam.radius,
                        GetUnitLoc(GetEnumUnit()),
                        Filter(function()
                            local filterUnit = GetFilterUnit()
                            if castParam.condition then
                                if castParam.condition.livePercent then
                                    local livePercent = GetUnitLifePercent(filterUnit)
                                    if castParam.condition.livePercent <= livePercent then
                                        return false
                                    end
                                end
                            end
                            local ownerFilterUnit = GetOwningPlayer(filterUnit)

                            if castParam.condition.target == 'ally' then
                                return isPlayerAlly(GetOwningPlayer(GetEnumUnit()), ownerFilterUnit)
                            elseif castParam.condition.target == 'enemy' then
                                return isPlayerEnemy(GetOwningPlayer(GetEnumUnit()), ownerFilterUnit)
                            end
                        end)
                )

                if CountUnitsInGroup(unitsGroup) >= 1 then
                    local randomUnit = GroupPickRandomUnit(unitsGroup)
                    IssueTargetOrderBJ(GetEnumUnit(), castParam.order, randomUnit)
                end
                DestroyGroup(unitsGroup)
            elseif castParam.condition.target == 'itself' then
                if castParam.condition then
                    if castParam.condition.livePercent then
                        local livePercent = GetUnitLifePercent(GetEnumUnit())
                        if castParam.condition.livePercent >= livePercent then
                            IssueImmediateOrder(GetEnumUnit(), castParam.order)
                        end
                    end
                end
            end

        end)
    end)
end

function isPlayerAlly(player, checkPlayer)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                for _, spawnP in ipairs(getAllSpawnPlayers(team)) do
                    if spawnP == checkPlayer then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function isPlayerEnemy(player, checkPlayer)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                for _, teamOther in ipairs(all_teams) do
                    if (teamOther ~= team) then
                        for _, spawnP in ipairs(getAllSpawnPlayers(teamOther)) do
                            if spawnP == checkPlayer then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end
Debug.endFile()