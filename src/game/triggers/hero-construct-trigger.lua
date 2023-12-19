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
                    CreateUnit(player.id, FourCC(heroes_for_build[1].id), x, y, 270)
                    print("create unit")
                end
            end)
        end
    end
end