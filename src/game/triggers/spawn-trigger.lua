function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if player.spawnTimer <= 0 then
                    local groupForBuild = GetUnitsInRectAll(player.buildRect)
                    ForGroup(groupForBuild, function ()
                        local id = GetUnitTypeId(GetEnumUnit())
                        local owner = GetOwningPlayer(GetEnumUnit())
                        if owner == player.id then
                            if isHero(('>I4'):pack(id)) then
                                local parentId = getHeroUnitId(('>I4'):pack(id))
                                if parentId ~= nil then
                                    local x, y = calculateDif(player.buildRect, player.spawnRect, GetEnumUnit())
                                    local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
                                    SetUnitColor(unit, GetPlayerColor(player.id))
                                    SetUnitAcquireRangeBJ( unit, GetUnitAcquireRange(unit) * game_config.units.range )
                                end
                            else
                                local parentId = getParentUnitId(('>I4'):pack(id))
                                if parentId ~= nil then
                                    local x, y = calculateDif(player.buildRect, player.spawnRect, GetEnumUnit())
                                    local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
                                    SetUnitColor(unit, GetPlayerColor(player.id))
                                    SetUnitAcquireRangeBJ( unit, GetUnitAcquireRange(unit) * game_config.units.range )
                                end
                            end
                        end
                    end)
                    DestroyGroup(groupForBuild)
                    player.spawnTimer = game_config.spawnPolicy.interval * #team.players + game_config.spawnPolicy.dif
                end
                player.spawnTimer = player.spawnTimer - 1
                local text = BlzFrameGetChild(player.statePanel, 0)
                BlzFrameSetText(text, "Next wave: " .. player.spawnTimer)
            end
        end
    end)
end

function getParentUnitId(searchId)
    for _, unit in pairs(units_for_build) do
        if unit.id == searchId then
            return unit.parentId
        end
    end
    return nil
end

function getHeroUnitId(searchId)
    for _, unit in pairs(heroes_for_build) do
        if unit.id == searchId then
            return unit.parentId
        end
    end
    return nil
end

function isHero(id)
    for _, hero in ipairs(heroes_for_build) do
        if hero.id == id then
            return true
        end
    end
    return false
end