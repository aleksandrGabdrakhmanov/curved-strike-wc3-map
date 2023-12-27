Debug.beginFile('spawn-trigger.lua')
function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if player.spawnTimer <= 0 then
                    processGroupForSpawn(player)
                    player.spawnTimer = game_config.spawnPolicy.interval * #team.players + game_config.spawnPolicy.dif
                    replaceCell(player)
                end
                player.spawnTimer = player.spawnTimer - 1
            end
        end
    end)
end

function handleUnitSpawn(player, id, x, y, label)
    local parentId = getParentUnitId(('>I4'):pack(id))
    if parentId then
        local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
        SetUnitUserData( unit, label)
        SetUnitAcquireRangeBJ(unit, GetUnitAcquireRange(unit) * game_config.units.range)
    end
end

function handleHeroSpawn(player, unit, x, y, label)
    local unitId = GetUnitTypeId(unit)
    local hero = getHero(player.heroes, unit)
    if hero.status == "new" then
        local unit = CreateUnit(player.spawnPlayerId, FourCC(getHeroUnitId(('>I4'):pack(unitId))), x, y, 270)
        SetUnitAcquireRangeBJ(unit, GetUnitAcquireRange(unit) * game_config.units.range)
        SetUnitUserData( unit, label)
        hero.status = "alive"
        hero.unit = unit
    elseif hero.status == "dead" then
        hero.status = "alive"
        ReviveHeroLoc(hero.unit, Location(x, y), false)
        SetUnitManaPercentBJ(hero.unit, 100)
    end
end

function getHero(heroes, unit)
    for _, hero in ipairs(heroes) do
        if hero.building == unit then
            return hero
        end
    end
    return nil
end

function processGroupForSpawn(player)
    local function processRect(buildRect, spawnRect, label)
        local groupForBuild = GetUnitsInRectAll(buildRect)
        ForGroup(groupForBuild, function()
            local unit = GetEnumUnit()
            local id = GetUnitTypeId(unit)
            local owner = GetOwningPlayer(unit)
            if owner == player.id then
                local x, y = calculateDif(buildRect, spawnRect, unit)
                if isHero(('>I4'):pack(id)) then
                    handleHeroSpawn(player, unit, x, y, label)
                else
                    handleUnitSpawn(player, id, x, y, label)
                end
            end
        end)
        DestroyGroup(groupForBuild)
    end

    if type(player.buildRect) == "table" then
        for i in ipairs(player.buildRect) do
            processRect(player.buildRect[i], player.spawnRect[i], i)
        end
    else
        processRect(player.buildRect, player.spawnRect, 0)
    end
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
Debug.endFile()