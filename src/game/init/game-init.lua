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
            player.spawnRect = regions[game_config.mode][team.i][player.i]['spawn']
        end
        team.base.baseRect = regions[game_config.mode]['team'][team.i]['base']
        team.base.towerRect = regions[game_config.mode]['team'][team.i]['tower']
    end

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local attackData = regions[game_config.mode][team.i][player.i]['attack']
            if not attackData then
                attackData = regions[game_config.mode]['team'][team.i]['attack']
            end

            local directions = {'right', 'left', 'up', 'down'}
            for i, data in ipairs(attackData) do
                for _, dir in ipairs(directions) do
                    if data[dir] then
                        player.attackPointRect[i] = {rect = data[dir], direction = dir}
                        break
                    end
                end
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