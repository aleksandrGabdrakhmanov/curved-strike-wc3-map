function heroConstructTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
            TriggerAddAction(trig, function()
                if GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.randomHero) then
                    local x = GetUnitX(GetTriggerUnit())
                    local y = GetUnitY(GetTriggerUnit())
                    KillUnit(GetTriggerUnit())
                    local group = GetUnitsOfPlayerAndTypeId(player.id, FourCC(units_special.heroBuilder))
                    KillUnit(GroupPickRandomUnit(group))
                    DestroyGroup(group)
                    local randomIndex = GetRandomInt(1, #heroes_for_build)
                    local unit = CreateUnit(player.id, FourCC(heroes_for_build[randomIndex].id), x, y, 270)
                    table.insert(player.heroes, {
                        status = "new",
                        building = unit,
                        unit = nil,
                        newSkills = {}
                    })
                end
            end)
        end
    end
end