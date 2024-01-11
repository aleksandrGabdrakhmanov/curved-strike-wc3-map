Debug.beginFile('hero-construct-trigger.lua')
function heroConstructTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
            TriggerAddAction(trig, function()
                if isHero(('>I4'):pack(GetUnitTypeId(GetTriggerUnit()))) then
                    local group = GetUnitsOfPlayerAndTypeId(player.id, FourCC(units_special.heroBuilder))
                    KillUnit(GroupPickRandomUnit(group))
                    DestroyGroup(group)
                    local unitId = GetUnitTypeId(GetTriggerUnit())
                    table.insert(player.heroes, {
                        status = "new",
                        building = GetTriggerUnit(),
                        unit = nil,
                        newSkills = {},
                        unitConfig = getHeroUnitId(('>I4'):pack(unitId)),
                        icon = BlzGetAbilityIcon(unitId)
                    })
                    if isDuplicateHero(('>I4'):pack(unitId), player.heroes) == false then
                        updateAbilityPanel(player, getHeroUnitId(('>I4'):pack(unitId)))
                    end
                    reRollHeroes(player)
                end
            end)
        end
    end
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
Debug.endFile()

