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