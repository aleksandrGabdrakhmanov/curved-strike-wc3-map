Debug.beginFile('spell-finish-trigger.lua')
function spellFinishTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddAction(trig, function()
        immediatelyMoveUnit(GetTriggerUnit())
    end)
end

function immediatelyMoveUnit(unit)
    local attackPointRect = getAttackPointRect(GetOwningPlayer(unit))
    for _, atPointRect in ipairs(attackPointRect) do
        local label = GetUnitUserData(unit)
        if IsUnitInRect(atPointRect.rect, unit) and (label == atPointRect.label or label == 0) then
            moveByLocation(atPointRect, unit)
            return
        end
    end
end

function IsUnitInRect(r, u)
    return GetUnitX(u) > GetRectMinX(r)-32 and GetUnitX(u) < GetRectMaxX(r)+32 and GetUnitY(u) > GetRectMinY(r)-32 and GetUnitY(u) < GetRectMaxY(r)+32
end


function getAttackPointRect(castPlayer)
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if player.spawnPlayerId == castPlayer then
                return player.attackPointRect
            end
        end
    end
end
Debug.endFile()