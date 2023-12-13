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
            startGold = 5000,
            startIncomePerSec = 5,
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
                    attackPointRect = {},
                    spawnRect = nil
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
        { id = 'h00C', parentId = 'h00A', tier = 1, race = 'human', position = 1, name = 'Footman'},
        { id = 'h004', parentId = 'h00D', tier = 1, race = 'human', position = 2, name = 'Rifleman'},
        { id = 'h008', parentId = 'h00I', tier = 1, race = 'human', position = 3, name = 'Sorceress'},
        { id = 'h003', parentId = 'h00E', tier = 2, race = 'human', position = 4, name = 'Mortar Team'},
        { id = 'h007', parentId = 'h00H', tier = 2, race = 'human', position = 5,  name = 'Priest'},
        { id = 'h006', parentId = 'h00K', tier = 2, race = 'human', position = 6,  name = 'Spellbreaker'},
        { id = 'h000', parentId = 'h00F', tier = 2, race = 'human', position = 7,  name = 'Flying Machine'},
        { id = 'h001', parentId = 'h00G', tier = 2, race = 'human', position = 8,  name = 'Gryphon Rider'},
        { id = 'h002', parentId = 'h00B', tier = 3, race = 'human', position = 9,  name = 'Knight'},
        { id = 'h005', parentId = 'h00J', tier = 3, race = 'human', position = 10,  name = 'Siege Engine'},
        { id = 'h009', parentId = 'h00L', tier = 3, race = 'human', position = 11,  name = 'Dragonhawk Rider'},

        { id = 'h00P', parentId = 'o003', tier = 1, race = 'orc', position = 1,  name = 'Grunt'},
        { id = 'h00Q', parentId = 'o006', tier = 1, race = 'orc', position = 2,  name = 'Headhunter'},
        { id = 'h00T', parentId = 'o00C', tier = 1, race = 'orc', position = 3,  name = 'Shaman'},
        { id = 'h00S', parentId = 'o004', tier = 2, race = 'orc', position = 4,  name = 'Raider'},
        { id = 'h00X', parentId = 'o00B', tier = 2, race = 'orc', position = 5,  name = 'Witch Doctor'},
        { id = 'h00U', parentId = 'o00D', tier = 2, race = 'orc', position = 6,  name = 'Spirit Walker'},
        { id = 'h00R', parentId = 'o008', tier = 2, race = 'orc', position = 7,  name = 'Kodo Beast'},
        { id = 'h00N', parentId = 'o00A', tier = 2, race = 'orc', position = 8,  name = 'Batrider'},
        { id = 'h00V', parentId = 'o005', tier = 3, race = 'orc', position = 9,  name = 'Tauren'},
        { id = 'h00O', parentId = 'o007', tier = 3, race = 'orc', position = 10,  name = 'Demolisher'},
        { id = 'h00W', parentId = 'o009', tier = 3, race = 'orc', position = 11,  name = 'Wind Rider'},
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