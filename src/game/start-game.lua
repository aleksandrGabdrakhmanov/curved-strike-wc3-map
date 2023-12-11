function startGame(mode)
    print("8")
    initMain(mode)
    initialUI()
    initTimers()
    initTriggers()
    setStartCameraPosition()
    --changeAvailableUnitsForPlayers(all_players, all_units, TRUE)
end

function setStartCameraPosition()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            SetCameraPositionForPlayer(player.id, GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect))
        end
    end
end