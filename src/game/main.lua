OnInit(function()
    print("106")
    initGlobalVariables()
    initialGame()
    initialPlayers()
    initialUI()
    initTimers()
    initTriggers()
    changeAvailableUnitsForPlayers(all_players, all_units, TRUE)
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
