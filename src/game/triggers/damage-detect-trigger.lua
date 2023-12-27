function damageDetectTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGED)
    TriggerAddAction(trig, function()
        local source = GetEventDamageSource()
        if GetUnitTypeId(source) == FourCC(units_special.tower) or GetUnitTypeId(source) == FourCC(units_special.base) then
            return
        end
        local sourcePlayer = GetOwningPlayer(source)
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if sourcePlayer == player.spawnPlayerId then
                    player.totalDamage = math.floor(player.totalDamage + GetEventDamage())
                    return
                end
            end
        end
    end)
end