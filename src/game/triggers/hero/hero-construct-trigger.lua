Debug.beginFile('hero-construct-trigger.lua')
START_INDEX_HEROES = 1000
function heroConstructTrigger()
    heroGlobalId = START_INDEX_HEROES
    for _, team in ipairs(all_teams) do
        for playerIndex, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
            TriggerAddAction(trig, function()
                local unit = GetTriggerUnit()
                if isHero(('>I4'):pack(GetUnitTypeId(unit))) then
                    constructHero(player, playerIndex, unit)
                    if game_config.units.isHeroManualControl == true then
                        handleHeroSpawn(player, unit, GetRectCenterX(player.spawnRect), GetRectCenterY(player.spawnRect))
                        RemoveUnit(unit)
                    end
                else
                    player.food = player.food + getFoodCostUnit(('>I4'):pack(GetUnitTypeId(unit)))
                end
            end)
        end
    end
end

function constructHero(player, playerIndex, unit)
    local group = GetUnitsOfPlayerAndTypeId(player.id, FourCC(units_special.heroBuilder))
    KillUnit(GroupPickRandomUnit(group))
    DestroyGroup(group)
    local unitId = GetUnitTypeId(unit)

    if game_config.units.itemCapacity == 0 then
        UnitRemoveAbility(unit, FourCC(abilities.inventory[6]))
    else
        UnitAddAbility(unit, FourCC(abilities.inventory[game_config.units.itemCapacity]))
    end
    if (game_config.units.heroStartLevel > 1) then
        SetHeroLevel(unit, game_config.units.heroStartLevel, false)
    end
    table.insert(player.heroes, {
        status = "new",
        building = unit,
        name = GetHeroProperName(unit),
        unit = nil,
        id = heroGlobalId,
        newSkills = {},
        unitConfig = getHeroUnitId(('>I4'):pack(unitId)),
        icon = BlzGetAbilityIcon(unitId),
        kills = 0,
        damage = 0
    })
    heroGlobalId = heroGlobalId + 1
    player.food = player.food + 5
    if isDuplicateHero(('>I4'):pack(unitId), player.heroes) == false then
        updateAbilityPanel(player, getHeroUnitId(('>I4'):pack(unitId)))
    end
    reRollHeroes(player, playerIndex, #player.heroes)
end

function isDuplicateHero(unitId, heroes)
    local count = 0
    for _, hero in ipairs(heroes) do
        if unitId == hero.unitConfig.id then
            count = count + 1
        end
    end
    if count > 1 then
        return true
    else
        return false
    end
    end

function getHeroUnitId(searchId)
    for _, unit in pairs(heroes_for_build) do
        if unit.id == searchId then
            return unit
        end
    end
    return nil
end
function getFoodCostUnit(unitId)
    for _, unit in pairs(units_for_build) do
        if unit.id == unitId then
            return unit.food
        end
    end
    return 0
end
Debug.endFile()

