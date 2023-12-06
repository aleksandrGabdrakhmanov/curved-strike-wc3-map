function initGlobalVariables()
    initAllTeamsAndPlayers()
    initUnits()
end

function initAllTeamsAndPlayers()
    game_config = {
        economy = {
            startGold = 500,
            startIncomePerSec = 10,
            firstMinePrice = 300, -- need init. now get from map
            nextMineDiffPrice = 300
        },
        spawnInterval = 30
    }
    all_teams = SyncedTable {
        {
            players = SyncedTable {
                {
                    id = Player(4),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_left_up,
                    spawnRect = gg_rct_spawn_left_up,
                    attackPointRect = { gg_rct_spawn_left_up, gg_rct_attack_region_p8, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(2),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_left_middle_up,
                    spawnRect = gg_rct_spawn_left_middle_up,
                    attackPointRect = { gg_rct_spawn_left_middle_up, gg_rct_attack_region_p7, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(0),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_left_middle,
                    spawnRect = gg_rct_spawn_left_middle,
                    attackPointRect = { gg_rct_spawn_left_middle, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(3),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_left_middle_down,
                    spawnRect = gg_rct_spawn_left_middle_down,
                    attackPointRect = { gg_rct_spawn_left_middle_down, gg_rct_attack_region_p9, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(5),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_left_down,
                    spawnRect = gg_rct_spawn_left_down,
                    attackPointRect = { gg_rct_spawn_left_down, gg_rct_attack_region_p10, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                }
            },
            spawnPlayers = SyncedTable { Player(15), Player(16), Player(17), Player(18), Player(19), Player(21), Player(23) },
            base = { player = Player(16), unitId = "ofrt", winTeam = 2 }
        },
        {
            players = SyncedTable {
                {
                    id = Player(8),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_right_up,
                    spawnRect = gg_rct_spawn_right_up,
                    attackPointRect = { gg_rct_spawn_right_up, gg_rct_attack_region_p4, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(6),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_right_middle_up,
                    spawnRect = gg_rct_spawn_right_middle_up,
                    attackPointRect = { gg_rct_spawn_right_middle_up, gg_rct_attack_region_p3, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(1),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_right_middle,
                    spawnRect = gg_rct_spawn_right_middle,
                    attackPointRect = { gg_rct_spawn_right_middle, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(7),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_right_middle_down,
                    spawnRect = gg_rct_spawn_right_middle_down,
                    attackPointRect = { gg_rct_spawn_right_middle_down, gg_rct_attack_region_p5, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(9),
                    income = game_config.economy.startIncomePerSec,
                    minePrice = game_config.economy.firstMinePrice,
                    rect = gg_rct_build_right_down,
                    spawnRect = gg_rct_spawn_right_down,
                    attackPointRect = { gg_rct_spawn_right_down, gg_rct_attack_region_p6, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                }
            },
            spawnPlayers = SyncedTable { Player(10), Player(11), Player(12), Player(13), Player(14), Player(20), Player(22) },
            base = { player = Player(12), unitId = "ofrt", winTeam = 1 }
        }
    }

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

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, anotherPlayer in ipairs(team.players) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player.id, anotherPlayer.id, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer.id, player.id, bj_ALLIANCE_ALLIED_VISION)
                end
            end

        end
    end

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, spawnPlayer in ipairs(team.spawnPlayers) do
                SetPlayerAlliance(spawnPlayer, player.id, ALLIANCE_SHARED_VISION, TRUE)
            end
        end
    end

    all_players = {}
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            table.insert(all_players, player)
        end
    end

end

function initUnits()
    all_units = {
        { id = 'h00C', parentId = 'h00A', level = 1},
        { id = 'h002', parentId = 'h00B', level = 1},
        { id = 'h004', parentId = 'h00D', level = 1},
        { id = 'h003', parentId = 'h00E', level = 1},
        { id = 'h000', parentId = 'h00F', level = 2},
        { id = 'h001', parentId = 'h00G', level = 2},
        { id = 'h007', parentId = 'h00H', level = 2},
        { id = 'h008', parentId = 'h00I', level = 2},
        { id = 'h005', parentId = 'h00J', level = 3},
        { id = 'h006', parentId = 'h00K', level = 3},
        { id = 'h009', parentId = 'h00L', level = 3},
    }
end