OnInit(function()
    print("106")
    initGlobalVariables()
    initialGame()
    initialPlayers()
    initialUI()
    initTriggers()
    changeAvailableUnitsForPlayers(all_players, all_units, TRUE)

    local timer = CreateTimer()
    my_func = 30
    TimerStart(timer,1,true, function()
        BlzFrameSetText(frame, "Next wave:  |cffFF0303" .. my_func .. "|r")
        my_func = my_func - 1
    end)
end)

function initialGame()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
end

function initialPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            CreateFogModifierRect(player.id, FOG_OF_WAR_VISIBLE, GetPlayableMapRect(), TRUE, TRUE)
            SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, game_config.startGold)
        end
    end
end

function initialUI()
    -- create a TEXT Frame
    local fm = BlzGetFrameByName("ConsoleUIBackdrop",0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    -- Set the current Text, you can use the Warcraft 3 Color Code
    -- pos the frame
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    -- stop this frame from taking control of the mouse input, Might have sideeffects if the TEXT-Frame has an enable Color (but this does not have such).
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 2)
    -- the text is kinda small, but one can not use the FontNative onto TEXT-Frames (nether in V1.31 nor V1.32). Therefore one could scale it.
end
