function initGlobalVariables()
    initAllTeamsAndPlayers()
    initUnits()
end

function initAllTeamsAndPlayers()
    all_teams = {
        {
            players = {
                { id = Player(0), spawnPlayer = Player(10),rect = gg_rct_build_region_p1, spawnRect = gg_rct_spawn_region_p1, attackPointRect = { gg_rct_attack_region_p1 }},
                { id = Player(2), spawnPlayer = Player(11),rect = gg_rct_build_region_p3, spawnRect = gg_rct_spawn_region_p3, attackPointRect = { gg_rct_attack_region_p3, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 } },
                { id = Player(3), spawnPlayer = Player(12),rect = gg_rct_build_region_p4, spawnRect = gg_rct_spawn_region_p4, attackPointRect = { gg_rct_attack_region_p4, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 } },
                { id = Player(4), spawnPlayer = Player(13),rect = gg_rct_build_region_p5, spawnRect = gg_rct_spawn_region_p5, attackPointRect = { gg_rct_attack_region_p5, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 } },
                { id = Player(5), spawnPlayer = Player(14),rect = gg_rct_build_region_p6, spawnRect = gg_rct_spawn_region_p6, attackPointRect = { gg_rct_attack_region_p6, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 } }
            },
            spawnPlayers = { Player(10), Player(11), Player(12), Player(13), Player(14), Player(20), Player(22) },
            playerWithoutControl = Player(20),
        },
        {
            players = {
                { id = Player(1), spawnPlayer = Player(15),rect = gg_rct_build_region_p2, spawnRect = gg_rct_spawn_region_p2, attackPointRect = { gg_rct_attack_region_p2 } },
                { id = Player(6), spawnPlayer = Player(16),rect = gg_rct_build_region_p7, spawnRect = gg_rct_spawn_region_p7, attackPointRect = { gg_rct_attack_region_p7, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 } },
                { id = Player(7), spawnPlayer = Player(17),rect = gg_rct_build_region_p8, spawnRect = gg_rct_spawn_region_p8, attackPointRect = { gg_rct_attack_region_p8, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 } },
                { id = Player(8), spawnPlayer = Player(18),rect = gg_rct_build_region_p9, spawnRect = gg_rct_spawn_region_p9, attackPointRect = { gg_rct_attack_region_p9, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 } },
                { id = Player(9), spawnPlayer = Player(19),rect = gg_rct_build_region_p10, spawnRect = gg_rct_spawn_region_p10, attackPointRect = { gg_rct_attack_region_p10, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 } }
            },
            spawnPlayers = { Player(15), Player(16), Player(17), Player(18), Player(19), Player(21), Player(23) },
            playerWithoutControl = Player(21),
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