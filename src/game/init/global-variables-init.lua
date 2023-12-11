function initGlobalVariables(mode)
    initRegions()
    initDefaultVariables(mode)
    initUnits()
end

function initDefaultVariables(mode)

    game_modes = {
        curved = {
            unitRange = 1 -- 100%
        },
        united = {
            unitRange = 1.5 -- 150%
        }
    }


    game_config = {
        mode = mode,
        economy = {
            startGold = 500,
            startIncomePerSec = 10,
            firstMinePrice = 300, -- need init. now get from map
            nextMineDiffPrice = 300
        },
        units = {
            range = game_modes[mode].unitRange
        },
        spawnInterval = 30
    }

    all_teams = {
        {
            i = 1,
            players = {
                {
                    id = Player(4),
                    spawnPlayerId = Player(19),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(2),
                    spawnPlayerId = Player(18),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(0),
                    spawnPlayerId = Player(17),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(3),
                    spawnPlayerId = Player(16),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(5),
                    spawnPlayerId = Player(15),
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
                    mainRect = nil,
                    laboratoryRect = nil,
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
                    spawnPlayerId = Player(14),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(6),
                    spawnPlayerId = Player(13),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(1),
                    spawnPlayerId = Player(12),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(7),
                    spawnPlayerId = Player(11),
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
                    mainRect = nil,
                    laboratoryRect = nil,
                    attackPointRect = {}
                },
                {
                    id = Player(9),
                    spawnPlayerId = Player(10),
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
                    mainRect = nil,
                    laboratoryRect = nil,
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
        mine = 'ugol',
        main = 'htow',
        laboratory = 'nmgv'
    }
    abilities = {
        mine = 'A000'
    }

    text = {
        mineLevel = "Level: "
    }
end