function initPlayers()
    setAllianceBetweenSpawnPlayers()
    setAllianceBetweenPlayers()
    setAllianceBetweenPlayersAndSpawnPlayers()
    addWorkers()
    changeAvailableUnitsForPlayers()
    setStartCameraPosition()
    initPanelForAllPlayers()
end

function setAllianceBetweenSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(getAllSpawnPlayers(team)) do
            for _, anotherPlayer in ipairs(getAllSpawnPlayers(team)) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_ALLIED_VISION)
                end
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
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, spawnPlayer in ipairs(getAllSpawnPlayers(team)) do
                SetPlayerAlliance(spawnPlayer, player.id, ALLIANCE_SHARED_VISION, TRUE)
                SetPlayerAllianceStateBJ(player.id, spawnPlayer, bj_ALLIANCE_ALLIED_VISION)
                SetPlayerAllianceStateBJ(spawnPlayer, player.id, bj_ALLIANCE_ALLIED_VISION)
            end
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

function changeAvailableUnitsForPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, unit in ipairs(units_for_build) do
                SetPlayerUnitAvailableBJ(FourCC(unit.id), FALSE, player.id)
                for _, upgrade in ipairs(unit.upgrades) do
                    SetPlayerTechMaxAllowed(player.id, FourCC(upgrade), 0)
                end
            end
            local randomUnits = getRandomUnits(units_for_build)
            for _, unit in ipairs(randomUnits) do
                SetPlayerUnitAvailableBJ(FourCC(unit.id), TRUE, player.id)
            end


            reRollHeroes(player)
        end
    end
end

function reRollHeroes(player)
    for _, hero in ipairs(heroes_for_build) do
        SetPlayerUnitAvailableBJ(FourCC(hero.id), FALSE, player.id)
    end
    local threeHeroes = getRandomHeroes(heroes_for_build, 3)
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

function setStartCameraPosition()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            SetCameraPositionForPlayer(player.id, GetRectCenterX(player.mainRect), GetRectCenterY(player.mainRect))
        end
    end
end