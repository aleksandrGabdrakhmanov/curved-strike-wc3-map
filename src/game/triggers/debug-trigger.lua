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
    end)
end