Debug.beginFile('debug-trigger.lua')
function debugTrigger()

    local trig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(trig, Player(0),"debug", true)

    TriggerAddAction(trig, function()
        SetPlayerAllianceStateBJ(Player(1), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(2), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(3), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(4), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(5), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(6), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(7), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(8), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(9), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)

        SetPlayerAllianceStateBJ(Player(10), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(11), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(12), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(13), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(14), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(15), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(16), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(17), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(18), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(19), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(20), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)

        SetPlayerAlliance(Player(10), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(11), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(12), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(13), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(14), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(15), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(16), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(17), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(18), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(19), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(20), Player(0), ALLIANCE_SHARED_VISION, TRUE)

        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, 99999)
            end
        end
    end)
end

function debugTriggerGold()

    local trig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(trig, Player(0),"debug-gold", true)

    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, 99999)
            end
        end
    end)
end

function debugTriggerFinish()

    local trig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(trig, Player(0),"finish", true)

    TriggerAddAction(trig, function()
        finishGame(all_teams[1])
    end)
end

function debugTriggerFinish2()

    local trig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(trig, Player(0),"notfinish", true)

    TriggerAddAction(trig, function()
        BlzFrameSetVisible(mainBackdrop, false)
    end)
end
Debug.endFile()