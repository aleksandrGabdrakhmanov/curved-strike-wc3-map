function statusPanelUpdateTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        updatePanelForAllPlayers()
    end)
end