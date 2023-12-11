function initGame()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    initRect()
    createBaseAndTower()
    createBuildingsForPlayers()
end

function initRect()

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            player.buildRect = regions[game_config.mode][team.i][player.i]['build']
            player.workerRect = regions[game_config.mode][team.i][player.i]['worker']
            player.mineRect = regions[game_config.mode][team.i][player.i]['mine']
            player.mainRect = regions[game_config.mode][team.i][player.i]['main']
            player.laboratoryRect = regions[game_config.mode][team.i][player.i]['laboratory']
        end
        team.base.baseRect = regions[game_config.mode]['team'][team.i]['base']
        team.base.towerRect = regions[game_config.mode]['team'][team.i]['tower']
    end

    if game_config.mode == 'curved' then
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if player.i ~= 3 then
                    player.attackPointRect = {
                        regions[game_config.mode][team.i][player.i]['spawn'],
                        regions[game_config.mode][team.i][player.i]['attack'][1],
                        regions[game_config.mode]['team'][team.i]['attack'][1],
                        regions[game_config.mode]['team'][team.i]['attack'][2]
                    }
                else
                    player.attackPointRect = {
                        regions[game_config.mode][team.i][player.i]['spawn'],
                        regions[game_config.mode]['team'][team.i]['attack'][2]
                    }
                end
            end
        end
    end

    if game_config.mode == 'united' then
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                player.attackPointRect = {
                    regions[game_config.mode][team.i][player.i]['spawn'],
                    regions[game_config.mode][team.i][player.i]['attack'][1],
                    regions[game_config.mode][team.i][player.i]['attack'][2]
                }
            end
        end
    end
end

function createBaseAndTower()
    for _, team in ipairs(all_teams) do
        CreateUnit(
                team.base.player,
                FourCC(units_special.base),
                GetRectCenterX(team.base.baseRect),
                GetRectCenterY(team.base.baseRect),
                0
        )
        CreateUnit(
                team.base.player,
                FourCC(units_special.tower),
                GetRectCenterX(team.base.towerRect),
                GetRectCenterY(team.base.towerRect),
                0
        )
    end
end

function createBuildingsForPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local unit = CreateUnit(
                    player.id,
                    FourCC(units_special.mine),
                    GetRectCenterX(player.mineRect),
                    GetRectCenterY(player.mineRect),
                    0
            )
            player.economy.mineTextTag = CreateTextTagUnitBJ(text.mineLevel .. player.economy.mineLevel, unit, 0, 10, 204, 204, 0, 0)

            CreateUnit(
                    player.id,
                    FourCC(units_special.main),
                    GetRectCenterX(player.mainRect),
                    GetRectCenterY(player.mainRect),
                    0
            )
            CreateUnit(
                    player.id,
                    FourCC(units_special.laboratory),
                    GetRectCenterX(player.laboratoryRect),
                    GetRectCenterY(player.laboratoryRect),
                    0
            )

        end
    end
end