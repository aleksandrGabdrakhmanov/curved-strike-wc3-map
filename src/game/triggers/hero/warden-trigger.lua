Debug.beginFile('warden-trigger.lua')
function wardenTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGING)
    TriggerAddAction(trig, function()
        local unit = GetTriggerUnit()
        if GetUnitTypeId(unit) == FourCC('Ewar') then
            local rect = getPlayerBuildRect(GetOwningPlayer(unit))
            local livePercent = GetUnitLifePercent(unit)
            if livePercent <= 20 then
                IssuePointOrder(unit, 'blink', GetRectCenterX(rect), GetRectCenterY(rect))
            end
        end
    end)
end

function getPlayerBuildRect(player)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                return p.spawnRect
            end
        end
    end
    return nil
end
Debug.endFile()