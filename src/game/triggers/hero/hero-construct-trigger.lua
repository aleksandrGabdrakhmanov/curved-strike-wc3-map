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
                    table.insert(player.heroes, {
                        status = "new",
                        building = GetTriggerUnit(),
                        unit = nil,
                        newSkills = {}
                    })
                    reRollHeroes(player)
                end
            end)
        end
    end
end
Debug.endFile()

