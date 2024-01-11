Debug.beginFile('tier-detect-trigger.lua')
function tierDetectTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple( trig, player.id, EVENT_PLAYER_UNIT_UPGRADE_FINISH )
            TriggerAddAction(trig, function()
                if (GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.t2)) then
                    player.tier = 'T2'
                end
                if (GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.t3)) then
                    player.tier = 'T3'
                end

            end)
        end
    end
end
Debug.endFile()