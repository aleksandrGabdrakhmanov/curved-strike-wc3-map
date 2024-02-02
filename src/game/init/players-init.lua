Debug.beginFile('players-init.lua')
function setAllianceBetweenSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(sumArrayAndElement(getAllSpawnPlayers(team), team.base.player)) do
            for _, anotherPlayer in ipairs(sumArrayAndElement(getAllSpawnPlayers(team), team.base.player)) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_ALLIED_VISION)
                end
            end
        end
    end
end

function setEnemyBetweenPlayers()
    local players = {}
    ForForce(GetPlayersAll(), function()
        table.insert(players, GetEnumPlayer())
    end)

    for _, player in ipairs(players) do
        for _, anotherPlayer in ipairs(players) do
            if player ~= anotherPlayer then
                SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_UNALLIED)
                SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_UNALLIED)
            end
        end
    end

end

function getAllSpawnPlayers(team)
    local spawnPlayer = {}
    for _, player in ipairs(team.players) do
        table.insert(spawnPlayer, player.spawnPlayerId)
    end
    return spawnPlayer
end

function setAllianceBetweenPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            CreateFogModifierRect(player.id, FOG_OF_WAR_VISIBLE, GetPlayableMapRect(), TRUE, TRUE)
            SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, game_config.economy.startGold)
            for _, anotherPlayer in ipairs(team.players) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player.id, anotherPlayer.id, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer.id, player.id, bj_ALLIANCE_ALLIED_VISION)
                end
            end
        end
    end
end

function setAllianceBetweenPlayersAndSpawnPlayers()
    for teamNumber, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, spawnPlayer in ipairs(sumArrayAndElement(getAllSpawnPlayers(team), team.base.player)) do
                SetPlayerName(spawnPlayer, GetPlayerName(player.id))
                SetPlayerColor(spawnPlayer, GetPlayerColor(player.id))
                SetPlayerAlliance(spawnPlayer, player.id, ALLIANCE_SHARED_VISION, TRUE)
                SetPlayerAllianceStateBJ(player.id, spawnPlayer, bj_ALLIANCE_ALLIED_VISION)
                SetPlayerAllianceStateBJ(spawnPlayer, player.id, bj_ALLIANCE_ALLIED_VISION)
            end
        end
        SetPlayerName(team.base.player, 'Team ' .. teamNumber)
        SetPlayerColor(team.base.player, GetPlayerColor(Player(teamNumber - 1)))
    end
end

function sumArrayAndElement(array, element)
    local resultArray = {}
    for i = 1, #array do
        table.insert(resultArray, array[i])
    end
    table.insert(resultArray, element)
    return resultArray
end

function changeColorAndNameSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            SetPlayerName(player.spawnPlayerId, GetPlayerName(player.id))
            SetPlayerColor(player.spawnPlayerId, GetPlayerColor(player.id))
        end
    end
end

function addWorkers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if type(player.workerRect) == "table" then
                for _, rect in ipairs(player.workerRect) do
                    CreateUnit(
                            player.id,
                            FourCC(units_special.builder),
                            GetRectCenterX(rect),
                            GetRectCenterY(rect),
                            0
                    )
                end
            else
                CreateUnit(
                        player.id,
                        FourCC(units_special.builder),
                        GetRectCenterX(player.workerRect),
                        GetRectCenterY(player.workerRect),
                        0
                )
            end
        end
    end
end

function initCamera()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            SetCameraPositionForPlayer(player.id, GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect))
            CreateFogModifierRectBJ( true, player.id, FOG_OF_WAR_VISIBLE, team.base.viewRect )
        end
    end
end

function changeAvailableUnitsForPlayers()

    local isMirror = game_config.units.isUnitsMirror
    local mirrorUnits = {}
    mirrorHeroes = {}
    for _, team in ipairs(all_teams) do
        for playerIndex, player in ipairs(team.players) do
            mirrorHeroes[playerIndex] = {}
            for i = 0, 30 do
                mirrorHeroes[playerIndex][i] = getRandomHeroes(heroes_for_build, 3)
            end
        end
    end

    for _, team in ipairs(all_teams) do
        for playerIndex, player in ipairs(team.players) do
            checkHeroAvailable(player, 0)
            for _, unit in ipairs(units_for_build) do
                SetPlayerUnitAvailableBJ(FourCC(unit.id), FALSE, player.id)
                for _, upgrade in ipairs(unit.upgrades) do
                    SetPlayerTechMaxAllowed(player.id, FourCC(upgrade), 0)
                end
            end

            local randomUnits
            if isMirror and mirrorUnits[playerIndex] then
                randomUnits = mirrorUnits[playerIndex]
            else
                randomUnits = getRandomUnits(units_for_build)
                if isMirror then
                    mirrorUnits[playerIndex] = randomUnits
                end
            end

            for _, unit in ipairs(randomUnits) do
                table.insert(player.availableUnits, unit)
                SetPlayerUnitAvailableBJ(FourCC(unit.id), TRUE, player.id)
            end
            reRollHeroes(player, playerIndex, 0)
        end
    end
end

function reRollHeroes(player, position, heroNumber)

    for _, hero in ipairs(heroes_for_build) do
        SetPlayerUnitAvailableBJ(FourCC(hero.id), FALSE, player.id)
    end

    local threeHeroes
    if game_config.units.isHeroesMirror then
        threeHeroes = mirrorHeroes[position][heroNumber]
    else
        threeHeroes = getRandomHeroes(heroes_for_build, game_config.units.countForSelect)
    end
    for _, hero in ipairs(threeHeroes) do
        SetPlayerUnitAvailableBJ(FourCC(hero.id), TRUE, player.id)
    end
end

function getRandomHeroes(heroes, count)

    local availableHeroes = {}
    for _, hero in ipairs(heroes) do
        if hero.active == true then
            table.insert(availableHeroes, hero)
        end
    end

    local selected = {}
    local result = {}

    count = math.min(count, #availableHeroes)

    while #result < count do
        local index = GetRandomInt(1, #availableHeroes)
        if not selected[index] then
            table.insert(result, availableHeroes[index])
            selected[index] = true
        end
    end

    return result
end

function getRandomUnits(units)
    local groupedUnits = {}
    local randomUnits = {}

    for _, unit in ipairs(units) do
        if not groupedUnits[unit.position] then
            groupedUnits[unit.position] = {}
        end
        if (unit.active == true) then
            table.insert(groupedUnits[unit.position], unit)
        end
    end

    for _, groupedUnit in ipairs(groupedUnits) do
        local randomIndex = GetRandomInt(1, #groupedUnit)
        table.insert(randomUnits, groupedUnit[randomIndex])
    end

    return randomUnits
end
Debug.endFile()
