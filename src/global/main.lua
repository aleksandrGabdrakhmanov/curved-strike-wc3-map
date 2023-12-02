OnInit(function()
    print("1")
    math.randomseed(os.time())
    initGlobalVariables()
    initialMap()
    initTriggers()
    changeAvailableUnitsForPlayers(all_players, all_units, TRUE)
    SetPlayerState(Player(0),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(1),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(2),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(3),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(4),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(5),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(6),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(7),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(8),PLAYER_STATE_RESOURCE_GOLD, 30000)
    SetPlayerState(Player(9),PLAYER_STATE_RESOURCE_GOLD, 30000)
end)

function initialMap()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    setVisibility()
end

function setVisibility()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            CreateFogModifierRect(player.id, FOG_OF_WAR_VISIBLE, GetPlayableMapRect(), TRUE, TRUE)
        end
    end
end
