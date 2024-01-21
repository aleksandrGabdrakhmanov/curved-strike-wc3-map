Debug.beginFile('spawn-trigger.lua')
function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if player.spawnTimer <= 0 then
                    player.waveNumber = player.waveNumber + 1
                    processGroupForSpawn(player)
                    player.spawnTimer = game_config.spawnPolicy.interval * #team.players + game_config.spawnPolicy.dif
                    replaceCell(player)
                end
                player.spawnTimer = player.spawnTimer - 1
            end
        end
    end)
end

function handleUnitSpawn(player, id, x, y)
    local parentId = getParentUnitId(('>I4'):pack(id))
    if parentId then
        local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
        SetUnitUserData(unit, player.waveNumber)
        SetUnitAcquireRangeBJ(unit, GetUnitAcquireRange(unit) * game_config.units.range)
        immediatelyMoveUnit(unit)
    end
end

function handleHeroSpawn(player, unit, x, y)
    local hero = getHero(player.heroes, unit)
    if hero.status == "new" then
        local unit = CreateUnit(player.spawnPlayerId, FourCC(hero.unitConfig.parentId), x, y, 270)
        SetHeroLevel(unit, game_config.units.heroStartLevel, false)
        SetUnitAcquireRangeBJ(unit, GetUnitAcquireRange(unit) * game_config.units.range)
        hero.status = "alive"
        hero.unit = unit
        immediatelyMoveUnit(unit)
    elseif hero.status == "dead" then
        hero.status = "alive"
        ReviveHeroLoc(hero.unit, Location(x, y), false)
        SetUnitManaPercentBJ(hero.unit, 100)
        immediatelyMoveUnit(hero.unit)
    end
    SynchronizeInventory(unit, hero.unit)
end

function SynchronizeInventory(hero1, hero2)
    for slot = 0, 5 do
        local item = UnitItemInSlot(hero1, slot)

        local itemForDelete = UnitItemInSlot(hero2, slot)
        if itemForDelete then
            RemoveItem(itemForDelete)
        end

        if item then
            UnitAddItemToSlotById(hero2, GetItemTypeId(item), slot)
        end
    end
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
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
    local function processRect(buildRect, spawnRect)
        local groupForBuild = GetUnitsInRectAll(buildRect)
        ForGroup(groupForBuild, function()
            local unit = GetEnumUnit()
            local id = GetUnitTypeId(unit)
            local owner = GetOwningPlayer(unit)
            if owner == player.id then
                local x, y = calculateDif(buildRect, spawnRect, unit)
                if isHero(('>I4'):pack(id)) then
                    handleHeroSpawn(player, unit, x, y)
                else
                    handleUnitSpawn(player, id, x, y)
                end
            end
        end)
        DestroyGroup(groupForBuild)
    end

    processRect(player.buildRect, player.spawnRect)
end

function getParentUnitId(searchId)
    for _, unit in pairs(units_for_build) do
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