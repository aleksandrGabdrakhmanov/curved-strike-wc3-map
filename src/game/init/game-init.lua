Debug.beginFile('game-init.lua')
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
    initCamera()
    createBuildingsForPlayers()
    createPictures()
    initPanelForAllPlayers()
end


function createPictures()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do

            if type(player.imageRect) == 'table' then
                for _, image in ipairs(player.imageRect) do
                    local name = GetPlayerName(player.id)
                    local image = CreateImageBJ("playerImg\\" .. name, 256, GetRectCenter(image), 0, 2)
                    SetImageRenderAlways( image, true )
                    ShowImageBJ( true, image )
                end

            else
                local name = GetPlayerName(player.id)
                local image = CreateImageBJ("playerImg\\" .. name, 256, GetRectCenter(player.imageRect), 0, 2)
                SetImageRenderAlways( image, true )
                ShowImageBJ( true, image )
            end
        end
    end
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

        local playersPosition = {
            [1] = { 1 },
            [2] = { 1, 6 },
            [3] = { 2, 5, 9},
            [4] = { 1, 3, 6, 8},
            [5] = { 1, 3, 5, 7, 9 },
            [6] = { 1, 2, 3, 5, 7, 9 },
            [7] = { 1, 2, 3, 5, 7, 8, 9 },
            [8] = { 1, 2, 3, 4, 5, 7, 8, 9 },
            [9] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 },
            [10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        }
        local currentPosition = playersPosition[getCountPlayers()]

        local positionId = 1
        for _, player in ipairs(mergeSequences(players_team_left, players_team_right)) do
            if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
                all_teams[positionId] = {
                    i = currentPosition[positionId],
                    players = addPlayersInTeam({ player }),
                    base = {
                        player = player.spawnId,
                        winTeam = 2,
                        baseRect = nil,
                        towerRect = nil
                    }
                }
                positionId = positionId + 1
            end
        end
    end
end

function getCountPlayers()
    local countActivePlayer = 0
    for _, player in ipairs(mergeSequences(players_team_left, players_team_right)) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            countActivePlayer = countActivePlayer + 1
        end
    end
    return countActivePlayer
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
                color = getColorById(GetPlayerId(player.id)),
                spawnPlayerId = player.spawnId,
                i = game_config.playerPosition[nextPosition],
                economy = {
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    mineLevel = 0,
                    mineTextTag = nil,
                    totalGold = game_config.economy.startGold,
                },
                buildRect = nil,
                workerRect = nil,
                mineRect = nil,
                mainRect = nil,
                laboratoryRect = nil,
                attackPointRect = {},
                spawnRect = nil,
                shopRect = nil,
                spawnTimer = game_config.playerPosition[nextPosition] * game_config.spawnPolicy.interval + game_config.spawnPolicy.dif,
                heroes = {},
                totalDamage = 0,
                totalKills = 0
            })
            nextPosition = nextPosition + 1
        end
    end
    return initialPlayers
end


function getColorById(playerId)
    if (playerId == 0) then
        return BlzConvertColor(255, 255, 2, 2)
    end
    if (playerId == 1) then
        return BlzConvertColor(255, 0, 65, 255)
    end
    if (playerId == 2) then
        return BlzConvertColor(255, 27, 229, 184)
    end
    if (playerId == 3) then
        return BlzConvertColor(255, 83, 0, 128)
    end
    if (playerId == 4) then
        return BlzConvertColor(255, 255, 255, 0)
    end
    if (playerId == 5) then
        return BlzConvertColor(255, 254, 137, 13)
    end
    if (playerId == 6) then
        return BlzConvertColor(255, 31, 191, 0)
    end
    if (playerId == 7) then
        return BlzConvertColor(255, 228, 90, 170)
    end
    if (playerId == 8) then
        return BlzConvertColor(255, 148, 149, 150)
    end
    if (playerId == 9) then
        return BlzConvertColor(255, 125, 190, 241)
    end
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
            player.shopRect = regions[game_config.mode][team.i][player.i]['shop']
            player.cameraRect = regions[game_config.mode]['camera']
            player.imageRect = regions[game_config.mode][team.i][player.i]['image']
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

            local ability = BlzGetUnitAbility(unit, FourCC(abilities.mine))
            BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, game_config.economy.firstMinePrice)
            BlzSetAbilityRealField(ability, ABILITY_RF_ARF_MISSILE_ARC, game_config.economy.incomeBoost)


            player.economy.mineTextTag = CreateTextTagUnitBJ(getMineTag(player), unit, 0, 10, 204, 204, 0, 0)

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
            CreateUnit(
                    player.id,
                    FourCC(units_special.shop),
                    GetRectCenterX(player.shopRect),
                    GetRectCenterY(player.shopRect),
                    0
            )

        end
    end
end
Debug.endFile()