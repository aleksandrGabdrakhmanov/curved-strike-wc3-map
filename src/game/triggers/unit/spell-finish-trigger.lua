Debug.beginFile('spell-finish-trigger.lua')
function spellFinishTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddAction(trig, function()
        moveAfterSpell()
    end)
end

function moveAfterSpell()
    local attackPointRect = getAttackPointRect(GetOwningPlayer(GetTriggerUnit()))
    for _, atPointRect in ipairs(attackPointRect) do
        local label = GetUnitUserData(GetTriggerUnit())
        if IsUnitInRect(atPointRect.rect, GetTriggerUnit()) and (label == atPointRect.label or label == 0) then
            moveByLocation(atPointRect, GetTriggerUnit())
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