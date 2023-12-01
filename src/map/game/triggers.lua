function initTriggers()
    spawnTrigger()
    moveByPointsTrigger3()
    --debugTriggers()
end


function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 30.00)
    TriggerAddAction(trig, function()
        print('start')

        for _, team in ipairs(all_teams) do

            for _, player in ipairs(team.players) do
                local groupForBuild = GetUnitsInRectAll(player.rect)
                local group = CreateGroup()
                ForGroup(groupForBuild, function ()
                    local id = GetUnitTypeId(GetEnumUnit())
                    local parentId = getParentId(('>I4'):pack(id))
                    if parentId ~= nil then
                        local x, y = calculateDif(player.rect, player.spawnRect, GetEnumUnit())
                        local unit = CreateUnit(getRandomSpawnPlayer(team.spawnPlayers), FourCC(parentId), x, y, 270)

                        local current = BlzGetUnitMaxHP(unit)
                        BlzSetUnitMaxHP(unit, calculatePercentage(current, 20))
                        SetUnitColor(unit, GetPlayerColor(player.id))
                        GroupAddUnit(group, unit)
                    end
                end)

                ForGroup(group, function ()

                    local attackPointX, attackPointY = calculateDif(player.spawnRect, player.attackPointRect[1], GetEnumUnit())

                    IssuePointOrderLoc(GetEnumUnit(), "attack", Location(attackPointX, attackPointY))
                end)

                DestroyGroup(group)
                DestroyGroup(groupForBuild)
            end

        end
    end)
end

function getRandomSpawnPlayer(spawnPlayers)
    local randomIndex = math.random(#spawnPlayers)
    return spawnPlayers[randomIndex]
end

function moveByPointsTrigger3()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do

            for i = 1, #player.attackPointRect - 1 do
                local trig = CreateTrigger()
                TriggerRegisterTimerEventPeriodic(trig, 1.00)
                TriggerAddAction(trig, function()
                    local group = GetUnitsInRectAll(player.attackPointRect[i])
                    ForGroup(group, function ()
                        local unit = GetEnumUnit()
                        local owner = GetOwningPlayer(unit)
                        if containsValue(owner, team.spawnPlayers) then
                            if (GetUnitCurrentOrder(unit) == 0) then
                                local attackPointX, attackPointY = calculateDif(player.attackPointRect[i], player.attackPointRect[i+1], unit)
                                IssuePointOrderLoc(unit, "attack", Location(attackPointX, attackPointY))
                            end
                        end
                    end)
                end)
            end
        end
    end
end

function containsValue(value, array)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

function getRandomDecimal()
    local min = 1
    local max = 20
    local randomNumber = math.random(min, max)
    return randomNumber / 10
end


function calculatePercentage(number, percent)
    return (number * percent) / 100
end

function calculateDif(buidRect, spawnRect, unit)

    local buidRectX = GetRectCenterX(buidRect)
    local buidRectY = GetRectCenterY(buidRect)

    local spawnRectX = GetRectCenterX(spawnRect)
    local spawnRectY = GetRectCenterY(spawnRect)

    local unitX = GetUnitX(unit)
    local unitY = GetUnitY(unit)
    return spawnRectX - (buidRectX - unitX), spawnRectY - (buidRectY - unitY)

end


function debugTriggers()
    SetPlayerAllianceStateBJ(Player(1), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(2), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(3), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(4), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(5), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(6), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(7), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(8), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
    SetPlayerAllianceStateBJ(Player(9), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)

    SetPlayerAlliance(Player(10), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(11), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(12), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(13), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(14), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(15), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(16), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(17), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(18), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(19), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    SetPlayerAlliance(Player(20), Player(0), ALLIANCE_SHARED_VISION, TRUE)
end