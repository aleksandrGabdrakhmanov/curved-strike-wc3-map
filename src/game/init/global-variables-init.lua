function initGlobalVariables(mode)
    initRegions()
    initDefaultVariables(mode)
    initUnits()
end

function initDefaultVariables(mode)
    game_config = {
        mode = mode,
        economy = {
            startGold = 500,
            startIncomePerSec = 10,
            firstMinePrice = 300, -- need init. now get from map
            nextMineDiffPrice = 300
        },
        spawnInterval = 30
    }

    all_teams = {
        {
            i = 1,
            players = {
                {
                    id = Player(4),
                    i = 1,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(2),
                    i = 2,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(0),
                    i = 3,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(3),
                    i = 4,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(5),
                    i = 5,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                }
            },
            spawnPlayers = { Player(15), Player(16), Player(17), Player(18), Player(19), Player(21), Player(23) },
            base = {
                player = Player(16),
                winTeam = 2,
                baseRect = nil,
                towerRect = nil
            }
        },
        {
            i = 2,
            players = {
                {
                    id = Player(8),
                    i = 1,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(6),
                    i = 2,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(1),
                    i = 3,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(7),
                    i = 4,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(9),
                    i = 5,
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = nil,
                    workerRect = nil,
                    mineRect = nil,
                    attackPointRect = {}
                }
            },
            spawnPlayers = { Player(10), Player(11), Player(12), Player(13), Player(14), Player(20), Player(22) },
            base = {
                player = Player(12),
                winTeam = 1,
                baseRect = nil,
                towerRect = nil
            }
        }
    }
end

function initUnits()
    units_for_build = {
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
    units_special = {
        builder = 'o000',
        tower = 'o001',
        base = 'o002',
        mine = 'h00M'
    }
    abilities = {
        mine = 'A000'
    }

    text = {
        mineLevel = "Level: "
    }
end