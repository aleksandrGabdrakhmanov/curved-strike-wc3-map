function summonTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddAction(trig, function()
        SetUnitUserData(GetSummonedUnit(), GetUnitUserData(GetSummoningUnit()))
    end)
end