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
            startGold = 300,
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
            base = {
                player = Player(12),
                winTeam = 1,
                baseRect = nil,
                towerRect = nil
            }
        }
    }
end

function getAllSpawnPlayers(team)
    local spawnPlayer = {}
    for _, player in ipairs(team.players) do
        table.insert(spawnPlayer, player.spawnPlayerId)
    end
    return spawnPlayer
end



function initUnits()
    units_for_build = {
        { id = 'h00C', parentId = 'h00A', tier = 1, race = 'human', position = 1, name = 'Footman', upgrades = {'Rhde'}},
        { id = 'h004', parentId = 'h00D', tier = 1, race = 'human', position = 2, name = 'Rifleman', upgrades = {'Rhri'}},
        { id = 'h008', parentId = 'h00I', tier = 1, race = 'human', position = 3, name = 'Sorceress', upgrades = {'Rhst'}},
        { id = 'h003', parentId = 'h00E', tier = 2, race = 'human', position = 4, name = 'Mortar Team', upgrades = {'Rhfl', 'Rhfs'}},
        { id = 'h007', parentId = 'h00H', tier = 2, race = 'human', position = 5,  name = 'Priest', upgrades = {'Rhpt'}},
        { id = 'h006', parentId = 'h00K', tier = 2, race = 'human', position = 6,  name = 'Spellbreaker', upgrades = {'Rhss'}},
        { id = 'h000', parentId = 'h00F', tier = 2, race = 'human', position = 7,  name = 'Flying Machine', upgrades = {'Rhgb', 'Rhfc'}},
        { id = 'h009', parentId = 'h00L', tier = 3, race = 'human', position = 8,  name = 'Dragonhawk Rider', upgrades = {'Rhan'}},
        { id = 'h002', parentId = 'h00B', tier = 3, race = 'human', position = 9,  name = 'Knight', upgrades = {'Rhan'}},
        { id = 'h005', parentId = 'h00J', tier = 3, race = 'human', position = 10,  name = 'Siege Engine', upgrades = {'Rhrt'}},
        { id = 'h001', parentId = 'h00G', tier = 2, race = 'human', position = 11,  name = 'Gryphon Rider', upgrades = {'Rhhb'}},

        { id = 'h00P', parentId = 'o003', tier = 1, race = 'orc', position = 1,  name = 'Grunt', upgrades = {'Robs'}},
        { id = 'h00Q', parentId = 'o006', tier = 1, race = 'orc', position = 2,  name = 'Headhunter', upgrades = {'Robk', 'Rotr'}},
        { id = 'h00T', parentId = 'o00C', tier = 1, race = 'orc', position = 3,  name = 'Shaman', upgrades = {'Rost'}},
        { id = 'h00S', parentId = 'o004', tier = 2, race = 'orc', position = 4,  name = 'Raider', upgrades = {'Roen', 'Ropg'}},
        { id = 'h00X', parentId = 'o00B', tier = 2, race = 'orc', position = 5,  name = 'Witch Doctor', upgrades = {'Rowd', 'Rotr'}},
        { id = 'h00U', parentId = 'o00D', tier = 2, race = 'orc', position = 6,  name = 'Spirit Walker', upgrades = {'Rowt'}},
        { id = 'h00N', parentId = 'o00A', tier = 2, race = 'orc', position = 7,  name = 'Batrider', upgrades = {'Rotr'}},
        { id = 'h00R', parentId = 'o008', tier = 2, race = 'orc', position = 8,  name = 'Kodo Beast', upgrades = {'Rwdm'}},
        { id = 'h00V', parentId = 'o005', tier = 3, race = 'orc', position = 9,  name = 'Tauren', upgrades = {'Rows'}},
        { id = 'h00O', parentId = 'o007', tier = 3, race = 'orc', position = 10,  name = 'Demolisher', upgrades = {'Robf'}},
        { id = 'h00W', parentId = 'o009', tier = 3, race = 'orc', position = 11,  name = 'Wind Rider', upgrades = {'Rovs'}},

        { id = 'h014', parentId = 'u001', tier = 1, race = 'undead', position = 1,  name = 'Ghoul', upgrades = {'Rugf'}},
        { id = 'h010', parentId = 'u004', tier = 1, race = 'undead', position = 2,  name = 'Crypt Fiend', upgrades = {'Ruwb', 'Rubu'}},
        { id = 'h00Z', parentId = 'u006', tier = 1, race = 'undead', position = 3,  name = 'Banshee', upgrades = {'Ruba'}},
        { id = 'h017', parentId = 'u008', tier = 2, race = 'undead', position = 4,  name = 'Obsidian Statue', upgrades = {}},
        { id = 'h013', parentId = 'u005', tier = 2, race = 'undead', position = 5,  name = 'Gargoyle', upgrades = {'Rusf'}},
        { id = 'h016', parentId = 'u007', tier = 2, race = 'undead', position = 6,  name = 'Necromancer', upgrades = {'Rusl', 'Rune', 'Rusm'}},
        { id = 'h015', parentId = 'u003', tier = 2, race = 'undead', position = 7,  name = 'Meat Wagon', upgrades = {'Rupc'}},
        { id = 'h018', parentId = 'u000', tier = 2, race = 'undead', position = 8,  name = 'Shade', upgrades = {}},
        { id = 'h00Y', parentId = 'u002', tier = 3, race = 'undead', position = 9,  name = 'Abomination', upgrades = {'Rupc'}},
        { id = 'h019', parentId = 'u00A', tier = 3, race = 'undead', position = 10,  name = 'Destroyer', upgrades = {}},
        { id = 'h012', parentId = 'u009', tier = 3, race = 'undead', position = 11,  name = 'Frost Wyrm', upgrades = {'Rufb'}},

        { id = 'e009', parentId = 'e00C', tier = 1, race = 'elf', position = 1,  name = 'Huntress', upgrades = {'Remg', 'Resc'}},
        { id = 'e000', parentId = 'e00B', tier = 1, race = 'elf', position = 2,  name = 'Archer', upgrades = {'Reib', 'Remk'}},
        { id = 'e004', parentId = 'e00D', tier = 1, race = 'elf', position = 3,  name = 'Dryad', upgrades = {'Resi'}},
        { id = 'e006', parentId = 'e00E', tier = 2, race = 'elf', position = 4,  name = 'Glaive Thower', upgrades = {}},
        { id = 'e007', parentId = 'e00F', tier = 2, race = 'elf', position = 5,  name = 'Hippogryph', upgrades = {}},
        { id = 'e002', parentId = 'e00J', tier = 2, race = 'elf', position = 6,  name = 'Druid of the Claw', upgrades = {'Redc'}},
        { id = 'e003', parentId = 'e00I', tier = 2, race = 'elf', position = 7,  name = 'Druid of the Talon', upgrades = {'Redt'}},
        { id = 'e005', parentId = 'e00L', tier = 2, race = 'elf', position = 8,  name = 'Faerie Dragon', upgrades = {}},
        { id = 'e00A', parentId = 'e00K', tier = 3, race = 'elf', position = 9,  name = 'Mountain Giant', upgrades = {'Rers', 'Rehs'}},
        { id = 'e008', parentId = 'e00G', tier = 3, race = 'elf', position = 10,  name = 'Hippogryph Rider', upgrades = {}},
        { id = 'e001', parentId = 'e00H', tier = 3, race = 'elf', position = 11,  name = 'Chimaera', upgrades = {'Recb'}},
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