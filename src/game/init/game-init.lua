Debug.beginFile('game-init.lua')
function initGame()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    initTeams()
    initRect()

    setEnemyBetweenPlayers()
    setAllianceBetweenSpawnPlayers()
    setAllianceBetweenPlayers()
    setAllianceBetweenPlayersAndSpawnPlayers()
    changeColorAndNameSpawnPlayers()
    changeAvailableUnitsForPlayers()
    initCamera()

    createBaseAndTower()
    addWorkers()
    createBuildingsForPlayers()
    createPictures()
    initPanelForAllPlayers()
    initAbilitiesPanel()
end

function createPictures()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do

            if type(player.imageRect) == 'table' then
                for _, image in ipairs(player.imageRect) do
                    local name = GetPlayerName(player.id)
                    local image = CreateImageBJ("playerImg\\" .. name, 256, GetRectCenter(image), 0, 2)
                    SetImageRenderAlways(image, true)
                    ShowImageBJ(true, image)
                end

            else
                local name = GetPlayerName(player.id)
                local image = CreateImageBJ("playerImg\\" .. name, 256, GetRectCenter(player.imageRect), 0, 2)
                SetImageRenderAlways(image, true)
                ShowImageBJ(true, image)
            end
        end
    end
end

function initTeams()
    all_teams = {}

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
                integerColor = getIntegerColorById(GetPlayerId(player.id)),
                spawnPlayerId = player.spawnId,
                i = game_config.playerPosition[nextPosition],
                economy = {
                    income = game_config.economy.startIncomePerSec,
                    incomeForCenter = 0,
                    minePrice = game_config.economy.firstMinePrice,
                    mineLevel = 0,
                    mineTextTag = nil,
                    totalGold = game_config.economy.startGold,
                    roundUp = false
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
                totalKills = 0,
                availableUnits = {},
                availableHeroes = {},
                tier = 'T1',
                food = 0,
                waveNumber = 0,
                heroBuilderCount = 0
            })
            nextPosition = nextPosition + 1
        end
    end
    return initialPlayers
end

function getColorById(playerId)
    if (playerId == 0) then
        return { r = 255, g = 2, b = 2, t = 255 }
    end
    if (playerId == 1) then
        return { r = 0, g = 65, b = 255, t = 255 }
    end
    if (playerId == 2) then
        return { r = 27, g = 229, b = 184, t = 255 }
    end
    if (playerId == 3) then
        return { r = 83, g = 0, b = 128, t = 255 }
    end
    if (playerId == 4) then
        return { r = 255, g = 255, b = 0, t = 255 }
    end
    if (playerId == 5) then
        return { r = 254, g = 137, b = 13, t = 255 }
    end
    if (playerId == 6) then
        return { r = 31, g = 191, b = 0, t = 255 }
    end
    if (playerId == 7) then
        return { r = 228, g = 90, b = 170, t = 255 }
    end
    if (playerId == 8) then
        return { r = 148, g = 149, b = 150, t = 255 }
    end
    if (playerId == 9) then
        return { r = 125, g = 190, b = 241, t = 255 }
    end
end

function getIntegerColorById(playerId)
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
            player.buildRect = regions['curved'][team.i][player.i]['build']
            player.workerRect = regions['curved'][team.i][player.i]['worker']
            player.mineRect = regions['curved'][team.i][player.i]['mine']
            player.mainRect = regions['curved'][team.i][player.i]['main']
            player.laboratoryRect = regions['curved'][team.i][player.i]['laboratory']
            player.spawnRect = regions['curved'][team.i][player.i]['spawn']
            player.shopRect = regions['curved'][team.i][player.i]['shop']
            player.imageRect = regions['curved'][team.i][player.i]['image']
        end
        team.base.baseRect = regions['curved']['team'][team.i]['base']
        team.base.towerRect = regions['curved']['team'][team.i]['tower']
        team.base.addGoldRect = regions['curved']['team'][team.i]['addGold']
    end

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local attackData = regions['curved'][team.i][player.i]['attack']
            if not attackData then
                attackData = regions['curved']['team'][team.i]['attack']
            end
            if not attackData then
                attackData = regions['curved']['global']['attack']
            end

            local directions = { 'right', 'left', 'up', 'down' }
            for i, data in ipairs(attackData) do
                for _, dir in ipairs(directions) do
                    if data[dir] then
                        player.attackPointRect[i] = { rect = data[dir], direction = dir }
                        break
                    end
                end
            end
        end
    end
end

function createBaseAndTower()
    for _, team in ipairs(all_teams) do
        local base = CreateUnit(
                team.base.player,
                FourCC(units_special.base),
                GetRectCenterX(team.base.baseRect),
                GetRectCenterY(team.base.baseRect),
                0
        )
        BlzSetUnitMaxHP(base, game_config.units.baseHP)
        SetUnitLifeBJ(base, game_config.units.baseHP)

        if team.base.towerRect ~= nil then
            local tower = CreateUnit(
                    team.base.player,
                    FourCC(units_special.tower),
                    GetRectCenterX(team.base.towerRect),
                    GetRectCenterY(team.base.towerRect),
                    0
            )
            BlzSetUnitMaxHP(tower, game_config.units.towerHP)
            SetUnitLifeBJ(tower, game_config.units.towerHP)
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