function initGlobalVariables(mode)
    initRegions()
    initDefaultVariables(mode)
end

function initDefaultVariables(mode)

    game_modes = {
        curved = {
            unitRange = 1, -- 100%
            spawnPolicy = {
                interval = 35.00,
                firstDelay = 2
            }
        },
        united = {
            unitRange = 1.5, -- 150%
            spawnPolicy = {
                interval = 40.00,
                firstDelay = 0
            }
        }
    }

    game_config = {
        mode = mode,
        economy = {
            startGold = 300,
            startIncomePerSec = 5,
            firstMinePrice = 300, -- need init. now get from map
            nextMineDiffPrice = 300
        },
        units = {
            range = game_modes[mode].unitRange
        },
        spawnPolicy = game_modes[mode].spawnPolicy,
        spawnInterval = 30
    }
end

function getAllSpawnPlayers(team)
    local spawnPlayer = {}
    for _, player in ipairs(team.players) do
        table.insert(spawnPlayer, player.spawnPlayerId)
    end
    return spawnPlayer
end