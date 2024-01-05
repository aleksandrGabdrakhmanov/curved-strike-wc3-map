Debug.beginFile('kodo-trigger.lua')
function KodoTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddAction(trig, function()
        local order = GetIssuedOrderId()
        if order == 852104 then
            TriggerSleepAction(3)
            immediatelyMoveUnit(GetTriggerUnit())
        end
    end)
end
Debug.endFile()