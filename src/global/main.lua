OnInit(function()
    math.randomseed(os.time())
    initGlobalVariables()
    initTriggers()
    changeAvailableUnitsForPlayers(all_players, all_units, TRUE)
end)
