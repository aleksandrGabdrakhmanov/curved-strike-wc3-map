OnInit(function()
    print("1")
    math.randomseed(os.time())
    initGlobalVariables()
    initialMap()
    initTriggers()
    changeAvailableUnitsForPlayers(all_players, all_units, TRUE)
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
