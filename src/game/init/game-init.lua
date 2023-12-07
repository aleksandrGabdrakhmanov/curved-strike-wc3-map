function initGame()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    initRect('curved')
    createBaseAndTower()
    createMines()
end

function initRect(mode)

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            player.buildRect = regions[mode][team.i][player.i]['build']
            player.mineRect = regions[mode][team.i][player.i]['mine']
        end
        team.base.baseRect = regions[mode]['team'][team.i]['base']
        team.base.towerRect = regions[mode]['team'][team.i]['tower']
    end

    if mode == 'curved' then
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if player.i ~= 3 then
                    player.attackPointRect = {
                        regions[mode][team.i][player.i]['spawn'],
                        regions[mode][team.i][player.i]['attack'][1],
                        regions[mode]['team'][team.i]['attack'][1],
                        regions[mode]['team'][team.i]['attack'][2]
                    }
                else
                    player.attackPointRect = {
                        regions[mode][team.i][player.i]['spawn'],
                        regions[mode]['team'][team.i]['attack'][2]
                    }
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

function createMines()
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
        end
    end
end