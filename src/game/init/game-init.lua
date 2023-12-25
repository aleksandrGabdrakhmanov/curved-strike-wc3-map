function initGame(mode)
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    initTeams(mode)
    initRect()

    setEnemyBetweenPlayers()
    setAllianceBetweenSpawnPlayers()
    setAllianceBetweenPlayers()
    setAllianceBetweenPlayersAndSpawnPlayers()
    changeColorAndNameSpawnPlayers()
    changeAvailableUnitsForPlayers()

    createBaseAndTower()
    addWorkers()
    setStartCameraPosition()
    createBuildingsForPlayers()
    initPanelForAllPlayers()
end

function initTeams(mode)
    all_teams = {}

    if mode == 'united' or mode == 'curved' then
        all_teams[1] = {
            i = 1,
            players = addPlayersInTeam(players_team_left),
            base = {
                player = Player(17),
                winTeam = 2,
                baseRect = nil,
                towerRect = nil
            }
        }
        all_teams[2] = {
            i = 2,
            players = addPlayersInTeam(players_team_right),
            base = {
                player = Player(12),
                winTeam = 1,
                baseRect = nil,
                towerRect = nil
            }
        }
    elseif mode == 'royal' then
        local teamId = 1
        for _, player in ipairs(mergeSequences(players_team_left, players_team_right)) do
            if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
                all_teams[teamId] = {
                    i = teamId,
                    players = addPlayersInTeam({ player }),
                    base = {
                        player = player.spawnId,
                        winTeam = 2,
                        baseRect = nil,
                        towerRect = nil
                    }
                }
                teamId = teamId + 1
            end
        end
    end
end

function mergeSequences(t1, t2)
    local result = {}
    for i = 1, #t1 do
        result[i] = t1[i]
    end
    for i = 1, #t2 do
        result[#t1 + i] = t2[i]
    end
    return result
end

function getMainPlayer()
    for _, player in ipairs(players_team_left) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            return player.id
        end
    end
    for _, player in ipairs(players_team_right) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            return player.id
        end
    end
end

function addPlayersInTeam(players)
    local nextPosition = 1
    local initialPlayers = {}
    for _, player in ipairs(players) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            table.insert(initialPlayers, {
                id = player.id,
                spawnPlayerId = player.spawnId,
                i = game_config.playerPosition[nextPosition],
                economy = {
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    mineLevel = 0,
                    mineTextTag = nil,
                },
                buildRect = nil,
                workerRect = nil,
                mineRect = nil,
                mainRect = nil,
                laboratoryRect = nil,
                attackPointRect = {},
                spawnRect = nil,
                spawnTimer = game_config.playerPosition[nextPosition] * game_config.spawnPolicy.interval + game_config.spawnPolicy.dif,
                heroes = {}
            })
            nextPosition = nextPosition + 1
        end
    end
    return initialPlayers
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
            if not attackData then
                attackData = regions[game_config.mode]['global']['attack']
            end

            local directions = { 'right', 'left', 'up', 'down' }
            for i, data in ipairs(attackData) do
                for _, dir in ipairs(directions) do
                    if data[dir] then
                        if type(data[dir]) == 'table' then
                            if data[dir][1] ~= nil then
                                player.attackPointRect[i] = { rect = data[dir][1], direction = dir, label = 1 }
                            elseif data[dir][2] ~= nil then
                                player.attackPointRect[i] = { rect = data[dir][2], direction = dir, label = 2 }
                            end
                        else
                            player.attackPointRect[i] = { rect = data[dir], direction = dir, label = nil }
                        end
                        break
                    end
                end
            end
        end
    end
end

function createBaseAndTower()
    for _, team in ipairs(all_teams) do
        if type(team.base.baseRect) == "table" then
            for _, rect in ipairs(team.base.baseRect) do
                CreateUnit(
                        team.base.player,
                        FourCC(units_special.base),
                        GetRectCenterX(rect),
                        GetRectCenterY(rect),
                        0
                )
            end
        else
            CreateUnit(
                    team.base.player,
                    FourCC(units_special.base),
                    GetRectCenterX(team.base.baseRect),
                    GetRectCenterY(team.base.baseRect),
                    0
            )
        end

        if team.base.towerRect ~= nil then
            CreateUnit(
                    team.base.player,
                    FourCC(units_special.tower),
                    GetRectCenterX(team.base.towerRect),
                    GetRectCenterY(team.base.towerRect),
                    0
            )
        end
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