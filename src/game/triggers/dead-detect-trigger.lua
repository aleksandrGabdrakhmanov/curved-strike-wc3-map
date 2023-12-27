function deadDetectTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trig, function()
        local source = GetKillingUnit()
        if GetUnitTypeId(source) == FourCC(units_special.tower) or GetUnitTypeId(source) == FourCC(units_special.base) then
            return
        end
        local sourcePlayer = GetOwningPlayer(source)
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if sourcePlayer == player.spawnPlayerId then
                    player.totalKills = math.floor(player.totalKills + 1)
                    return
                end
            end
        end
    end)
end