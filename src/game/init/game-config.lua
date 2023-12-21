function initGameConfig(mode)
    game_modes = {
        curved = {
            unitRange = 1, -- 100%
            spawnPolicy = {
                interval = 35,
                dif = 0
            },
            playerPosition = { 1, 2, 3, 4, 5 }
        },
        united = {
            unitRange = 1.5, -- 150%
            spawnPolicy = {
                interval = 0,
                dif = 35
            },
            playerPosition = { 3, 4, 2, 1, 5 }
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
        playerPosition = game_modes[mode].playerPosition
    }
end

function initGlobalVariables()
    players_team_left = {
        { id = Player(0), spawnId = Player(17), team = 1 },
        { id = Player(2), spawnId = Player(18), team = 1 },
        { id = Player(3), spawnId = Player(16), team = 1 },
        { id = Player(4), spawnId = Player(19), team = 1 },
        { id = Player(5), spawnId = Player(15), team = 1 }
    }
    players_team_right = {
        { id = Player(1), spawnId = Player(12), team = 2 },
        { id = Player(6), spawnId = Player(13), team = 2 },
        { id = Player(7), spawnId = Player(11), team = 2 },
        { id = Player(8), spawnId = Player(14), team = 2 },
        { id = Player(9), spawnId = Player(10), team = 2 }
    }
    heroes_for_build = {
        { id = 'H011', parentId = 'Hpal', race = 'human', name = 'Paladin' },
        { id = 'H01A', parentId = 'Hamg', race = 'human', name = 'Archmage' },
        { id = 'H01B', parentId = 'Hmkg', race = 'human', name = 'Mountain King' },
        { id = 'H01C', parentId = 'Hblm', race = 'human', name = 'Blood Mage' },

        { id = 'O00E', parentId = 'Obla', race = 'orc', name = 'Blademaster' },
        { id = 'O00F', parentId = 'Ofar', race = 'orc', name = 'Far Seer' },
        { id = 'O00G', parentId = 'Otch', race = 'orc', name = 'Tauren Chieftain' },
        { id = 'O00H', parentId = 'Oshd', race = 'orc', name = 'Shadow Hunter' },

        { id = 'U00B', parentId = 'Udea', race = 'undead', name = 'Death Knight' },
        { id = 'U00C', parentId = 'Ulic', race = 'undead', name = 'Lich' },
        { id = 'U00D', parentId = 'Udre', race = 'undead', name = 'Dreadlord' },
        { id = 'U00E', parentId = 'Ucrl', race = 'undead', name = 'Crypt Lord' },

        { id = 'E00N', parentId = 'Ekee', race = 'elf', name = 'Keeper of the Grove' },
        { id = 'E00O', parentId = 'Emoo', race = 'elf', name = 'Priestess of the Moon' },
        { id = 'E00P', parentId = 'Edem', race = 'elf', name = 'Demon Hunter' },
        { id = 'E00Q', parentId = 'Ewar', race = 'elf', name = 'Warden' },

        { id = 'N000', parentId = 'Nalc', race = 'other', name = 'Alchemist' },
        { id = 'N001', parentId = 'Nngs', race = 'other', name = 'Sea Witch' },
        { id = 'N002', parentId = 'Ntin', race = 'other', name = 'Tinker' },
        { id = 'N003', parentId = 'Nbst', race = 'other', name = 'Beastmaster' },
        { id = 'N004', parentId = 'Npbm', race = 'other', name = 'Brewmaster' },
        { id = 'N005', parentId = 'Nbrn', race = 'other', name = 'Dark Ranger' },
        { id = 'N006', parentId = 'Nfir', race = 'other', name = 'Firelord' },
        { id = 'N007', parentId = 'Nplh', race = 'other', name = 'Pit Lord' }
    }
    units_for_build = {
        { id = 'h00C', parentId = 'h00A', tier = 1, race = 'human', line = 1, position = 1, name = 'Footman', upgrades = {'Rhde'}},
        { id = 'h004', parentId = 'h00D', tier = 1, race = 'human', line = 1, position = 2, name = 'Rifleman', upgrades = {'Rhri'}},
        { id = 'h008', parentId = 'h00I', tier = 1, race = 'human', line = 1, position = 3, name = 'Sorceress', upgrades = {'Rhst'}},
        { id = 'h003', parentId = 'h00E', tier = 2, race = 'human', line = 1, position = 4, name = 'Mortar Team', upgrades = {'Rhfl', 'Rhfs'}},
        { id = 'h007', parentId = 'h00H', tier = 2, race = 'human', line = 1, position = 5,  name = 'Priest', upgrades = {'Rhpt'}},
        { id = 'h006', parentId = 'h00K', tier = 2, race = 'human', line = 1, position = 6,  name = 'Spellbreaker', upgrades = {'Rhss'}},
        { id = 'h000', parentId = 'h00F', tier = 2, race = 'human', line = 1, position = 7,  name = 'Flying Machine', upgrades = {'Rhgb', 'Rhfc'}},
        { id = 'h009', parentId = 'h00L', tier = 3, race = 'human', line = 1, position = 8,  name = 'Dragonhawk Rider', upgrades = {'Rhan'}},
        { id = 'h002', parentId = 'h00B', tier = 3, race = 'human', line = 1, position = 9,  name = 'Knight', upgrades = {'Rhan'}},
        { id = 'h005', parentId = 'h00J', tier = 3, race = 'human', line = 1, position = 10,  name = 'Siege Engine', upgrades = {'Rhrt'}},
        { id = 'h001', parentId = 'h00G', tier = 2, race = 'human', line = 1, position = 11,  name = 'Gryphon Rider', upgrades = {'Rhhb'}},

        { id = 'h00P', parentId = 'o003', tier = 1, race = 'orc', line = 2, position = 1,  name = 'Grunt', upgrades = {'Robs'}},
        { id = 'h00Q', parentId = 'o006', tier = 1, race = 'orc', line = 2, position = 2,  name = 'Headhunter', upgrades = {'Robk', 'Rotr'}},
        { id = 'h00T', parentId = 'o00C', tier = 1, race = 'orc', line = 2, position = 3,  name = 'Shaman', upgrades = {'Rost'}},
        { id = 'h00S', parentId = 'o004', tier = 2, race = 'orc', line = 2, position = 4,  name = 'Raider', upgrades = {'Roen', 'Ropg'}},
        { id = 'h00X', parentId = 'o00B', tier = 2, race = 'orc', line = 2, position = 5,  name = 'Witch Doctor', upgrades = {'Rowd', 'Rotr'}},
        { id = 'h00U', parentId = 'o00D', tier = 2, race = 'orc', line = 2, position = 6,  name = 'Spirit Walker', upgrades = {'Rowt'}},
        { id = 'h00N', parentId = 'o00A', tier = 2, race = 'orc', line = 2, position = 7,  name = 'Batrider', upgrades = {'Rotr'}},
        { id = 'h00R', parentId = 'o008', tier = 2, race = 'orc', line = 2, position = 8,  name = 'Kodo Beast', upgrades = {'Rwdm'}},
        { id = 'h00V', parentId = 'o005', tier = 3, race = 'orc', line = 2, position = 9,  name = 'Tauren', upgrades = {'Rows'}},
        { id = 'h00O', parentId = 'o007', tier = 3, race = 'orc', line = 2, position = 10,  name = 'Demolisher', upgrades = {'Robf'}},
        { id = 'h00W', parentId = 'o009', tier = 3, race = 'orc', line = 2, position = 11,  name = 'Wind Rider', upgrades = {'Rovs'}},

        { id = 'h014', parentId = 'u001', tier = 1, race = 'undead', line = 3, position = 1,  name = 'Ghoul', upgrades = {'Rugf'}},
        { id = 'h010', parentId = 'u004', tier = 1, race = 'undead', line = 3, position = 2,  name = 'Crypt Fiend', upgrades = {'Ruwb', 'Rubu'}},
        { id = 'h00Z', parentId = 'u006', tier = 1, race = 'undead', line = 3, position = 3,  name = 'Banshee', upgrades = {'Ruba'}},
        { id = 'h017', parentId = 'u008', tier = 2, race = 'undead', line = 3, position = 4,  name = 'Obsidian Statue', upgrades = {}},
        { id = 'h013', parentId = 'u005', tier = 2, race = 'undead', line = 3, position = 5,  name = 'Gargoyle', upgrades = {'Rusf'}},
        { id = 'h016', parentId = 'u007', tier = 2, race = 'undead', line = 3, position = 6,  name = 'Necromancer', upgrades = {'Rusl', 'Rune', 'Rusm'}},
        { id = 'h015', parentId = 'u003', tier = 2, race = 'undead', line = 3, position = 7,  name = 'Meat Wagon', upgrades = {'Rupc'}},
        { id = 'h018', parentId = 'u000', tier = 2, race = 'undead', line = 3, position = 8,  name = 'Shade', upgrades = {}},
        { id = 'h00Y', parentId = 'u002', tier = 3, race = 'undead', line = 3, position = 9,  name = 'Abomination', upgrades = {'Rupc'}},
        { id = 'h019', parentId = 'u00A', tier = 3, race = 'undead', line = 3, position = 10,  name = 'Destroyer', upgrades = {}},
        { id = 'h012', parentId = 'u009', tier = 3, race = 'undead', line = 3, position = 11,  name = 'Frost Wyrm', upgrades = {'Rufb'}},

        { id = 'e009', parentId = 'e00C', tier = 1, race = 'elf', line = 4, position = 1,  name = 'Huntress', upgrades = {'Remg', 'Resc'}},
        { id = 'e000', parentId = 'e00B', tier = 1, race = 'elf', line = 4, position = 2,  name = 'Archer', upgrades = {'Reib', 'Remk'}},
        { id = 'e004', parentId = 'e00D', tier = 1, race = 'elf', line = 4, position = 3,  name = 'Dryad', upgrades = {'Resi'}},
        { id = 'e006', parentId = 'e00E', tier = 2, race = 'elf', line = 4, position = 4,  name = 'Glaive Thower', upgrades = {}},
        { id = 'e007', parentId = 'e00F', tier = 2, race = 'elf', line = 4, position = 5,  name = 'Hippogryph', upgrades = {}},
        { id = 'e002', parentId = 'e00J', tier = 2, race = 'elf', line = 4, position = 6,  name = 'Druid of the Claw', upgrades = {'Redc'}},
        { id = 'e003', parentId = 'e00I', tier = 2, race = 'elf', line = 4, position = 7,  name = 'Druid of the Talon', upgrades = {'Redt'}},
        { id = 'e005', parentId = 'e00L', tier = 2, race = 'elf', line = 4, position = 8,  name = 'Faerie Dragon', upgrades = {}},
        { id = 'e00A', parentId = 'e00K', tier = 3, race = 'elf', line = 4, position = 9,  name = 'Mountain Giant', upgrades = {'Rers', 'Rehs'}},
        { id = 'e008', parentId = 'e00G', tier = 3, race = 'elf', line = 4, position = 10,  name = 'Hippogryph Rider', upgrades = {}},
        { id = 'e001', parentId = 'e00H', tier = 3, race = 'elf', line = 4, position = 11,  name = 'Chimaera', upgrades = {'Recb'}},
    }
    units_special = {
        builder = 'o000',
        tower = 'o001',
        base = 'o002',
        mine = 'ugol',
        main = 'htow',
        laboratory = 'nmgv',
        heroBuilder = 'e00M',
        randomHero = 'ncop'
    }
    abilities = {
        mine = 'A000'
    }

    upgrades_special = {
        summonHeroBuilder = 'R000'
    }

    text = {
        mineLevel = "Level: "
    }

    main_race = {
        {id = 'hcas', race = 'human'},
        {id = 'ofrt', race = 'orc'},
        {id = 'unp2', race = 'undead'},
        {id = 'etoe', race = 'elf'}
    }
end