function initPlayers()
    setAllianceBetweenSpawnPlayers()
    setAllianceBetweenPlayers()
    setAllianceBetweenPlayersAndSpawnPlayers()
    addWorkers()
    changeAvailableUnitsForPlayers()
    setStartCameraPosition()
end

function setAllianceBetweenSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.spawnPlayers) do
            for _, anotherPlayer in ipairs(team.spawnPlayers) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_ALLIED_VISION)
                end
            end
        end
    end
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
            for _, spawnPlayer in ipairs(team.spawnPlayers) do
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
        end
    end
end

function getRandomUnits(units)
    local groupedUnits = {}
    local randomUnits = {}

    for _, unit in ipairs(units) do
        if not groupedUnits[unit.position] then
            groupedUnits[unit.position] = {}
        end
        table.insert(groupedUnits[unit.position], unit)
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
            SetCameraPositionForPlayer(player.id, GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect))
        end
    end
end