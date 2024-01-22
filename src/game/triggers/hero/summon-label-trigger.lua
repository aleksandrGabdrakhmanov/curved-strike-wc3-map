Debug.beginFile('summon-label-trigger.lua')
function summonLabelTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddAction(trig, function()
        SetUnitUserData(GetSummonedUnit(), GetUnitUserData(GetSummoningUnit()))
        immediatelyMoveUnit(GetSummonedUnit())
    end)
end