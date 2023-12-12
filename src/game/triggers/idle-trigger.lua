function idleTrigger()

--[[    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddAction(trig, function()
        local unit = GetTriggerUnit()
        print('spell_finish')
        local attackPointX, attackPointY = extractNumbers(BlzGetUnitStringField(unit, UNIT_SF_GROUND_TEXTURE))
        print('x:' .. attackPointY .. " y:" .. attackPointY)

        IssuePointOrderLoc(unit, "attack", Location(attackPointX, attackPointY))
    end)]]


--[[    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig,1.00)
    TriggerAddAction(trig, function()
        local group = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function()
            return GetUnitCurrentOrder(GetFilterUnit()) == String2OrderIdBJ("stand down")
        end))

        ForGroup(group, function()
            local unit = GetEnumUnit()
            print("new command")
            local attackPointX, attackPointY = extractNumbers(BlzGetUnitStringField(unit, UNIT_SF_GROUND_TEXTURE))
            IssuePointOrderLoc(unit, "attack", Location(attackPointX, attackPointY))
        end)
        DestroyGroup(group)

    end)]]

end

function extractNumbers(str)
    local numbers = {}
    for num in string.gmatch(str, "%d+%.?%d*") do
        table.insert(numbers, tonumber(num))
    end
    return numbers[1], numbers[2]
end