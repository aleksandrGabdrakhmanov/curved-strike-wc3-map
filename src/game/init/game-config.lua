Debug.beginFile('game-config.lua')
function initGameConfig(mode)
    game_modes = {
        direct = {
            unitRange = 1, -- 100%
            spawnPolicy = {
                interval = 35,
                dif = 0
            },
            economy = {
                startGold = 300,
                startIncomePerSec = 5,
                incomeBoost = 1,
                firstMinePrice = 150,
                nextMineDiffPrice = 150,
                goldByTower = 125,
                incomeForCenter = 1
            },
            playerPosition = { 1, 2, 3, 4, 5 },
            isOpenAllMap = false
        },
        united = {
            unitRange = 1, -- 150%
            spawnPolicy = {
                interval = 4,
                dif = 35
            },
            economy = {
                startGold = 300,
                startIncomePerSec = 5,
                incomeBoost = 1,
                firstMinePrice = 150,
                nextMineDiffPrice = 150,
                goldByTower = 125,
                incomeForCenter = 1
            },
            playerPosition = { 1, 2, 3, 4, 5 },
            isOpenAllMap = false
        }
    }

    game_config = {
        mode = mode,
        economy = game_modes[mode].economy,
        units = {
            range = game_modes[mode].unitRange
        },
        spawnPolicy = game_modes[mode].spawnPolicy,
        playerPosition = game_modes[mode].playerPosition,
        isOpenAllMap = game_modes[mode].isOpenAllMap
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
        { id = 'H011', parentId = 'Hpal', race = 'human', line = 1, position = 1, name = 'Paladin', abilities = { { id = 'AHhb' }, { id = 'AHds' }, { id = 'AHre' }, { id = 'AHad' } } },
        { id = 'H01A', parentId = 'Hamg', race = 'human', line = 1, position = 2, name = 'Archmage', abilities = { { id = 'AHbz' }, { id = 'AHab' }, { id = 'AHwe' }, { id = 'ANto' } } },
        { id = 'H01B', parentId = 'Hmkg', race = 'human', line = 1, position = 3, name = 'Mountain King', abilities = { { id = 'AHtc' }, { id = 'AHtb' }, { id = 'AHbn' }, { id = 'AHav' } } },
        { id = 'H01C', parentId = 'Hblm', race = 'human', line = 1, position = 4, name = 'Blood Mage', abilities = { { id = 'AHfc' }, { id = 'AHbn' }, { id = 'AHdr' }, { id = 'AHpx' } } },

        { id = 'O00E', parentId = 'Obla', race = 'orc', line = 2, position = 1, name = 'Blademaster', abilities = { { id = 'AOwk' }, { id = 'AOcr' }, { id = 'AOmi' }, { id = 'AOww' } } },
        { id = 'O00F', parentId = 'Ofar', race = 'orc', line = 2, position = 2, name = 'Far Seer', abilities = { { id = 'AOfs' }, { id = 'AOsf' }, { id = 'AOcl' }, { id = 'AOeq' } } },
        { id = 'O00G', parentId = 'Otch', race = 'orc', line = 2, position = 3, name = 'Tauren Chieftain', abilities = { { id = 'AOsh' }, { id = 'AOae' }, { id = 'AOre' }, { id = 'AOws' } } },
        { id = 'O00H', parentId = 'Oshd', race = 'orc', line = 2, position = 4, name = 'Shadow Hunter', abilities = { { id = 'AOhw' }, { id = 'AOhx' }, { id = 'AOsw' }, { id = 'AOvd' } } },

        { id = 'U00B', parentId = 'Udea', race = 'undead', line = 3, position = 1, name = 'Death Knight', abilities = { { id = 'AUdc' }, { id = 'AUdp' }, { id = 'AUau' }, { id = 'AUan' } } },
        { id = 'U00C', parentId = 'Ulic', race = 'undead', line = 3, position = 2, name = 'Lich', abilities = { { id = 'AUfn' }, { id = 'AUfu' }, { id = 'AUdr' }, { id = 'AUdd' } } },
        { id = 'U00D', parentId = 'Udre', race = 'undead', line = 3, position = 3, name = 'Dreadlord', abilities = { { id = 'AUav' }, { id = 'AUcs' }, { id = 'AUin' }, { id = 'A001' } } },
        { id = 'U00E', parentId = 'Ucrl', race = 'undead', line = 3, position = 4, name = 'Crypt Lord', abilities = { { id = 'AUim' }, { id = 'AUts' }, { id = 'AUcb' }, { id = 'AUls' } } },

        { id = 'E00N', parentId = 'Ekee', race = 'elf', line = 4, position = 1, name = 'Keeper of the Grove', abilities = { { id = 'AEer' }, { id = 'AEah' }, { id = 'A002' }, { id = 'AEtq' } } },
        { id = 'E00O', parentId = 'Emoo', race = 'elf', line = 4, position = 2, name = 'Priestess of the Moon', abilities = { { id = 'AHfa' }, { id = 'ANsi' }, { id = 'AEar' }, { id = 'AEsf' } } },
        { id = 'E00P', parentId = 'Edem', race = 'elf', line = 4, position = 3, name = 'Demon Hunter', abilities = { { id = 'AEmb' }, { id = 'AEim' }, { id = 'AEev' }, { id = 'AEme' } } },
        { id = 'E00Q', parentId = 'Ewar', race = 'elf', line = 4, position = 4, name = 'Warden', abilities = { { id = 'AEbl' }, { id = 'AEfk' }, { id = 'AEsh' }, { id = 'AEsv' } } },

        { id = 'N000', parentId = 'Nalc', race = 'other', line = 5, position = 1, name = 'Alchemist', abilities = { { id = 'ANhs' }, { id = 'ANab' }, { id = 'ANcr' }, { id = 'ANtm' } } },
        { id = 'N001', parentId = 'Nngs', race = 'other', line = 5, position = 2, name = 'Sea Witch', abilities = { { id = 'ANfl' }, { id = 'ANfa' }, { id = 'ANms' }, { id = 'ANto' } } },
        { id = 'N002', parentId = 'Ntin', race = 'other', line = 5, position = 3, name = 'Tinker', abilities = { { id = 'ANsy' }, { id = 'ANcs' }, { id = 'ANeg' }, { id = 'ANrg' } } },
        { id = 'N003', parentId = 'Nbst', race = 'other', line = 5, position = 4, name = 'Beastmaster', abilities = { { id = 'ANsg' }, { id = 'ANsq' }, { id = 'ANsw' }, { id = 'ANst' } } },
        { id = 'N004', parentId = 'Npbm', race = 'other', line = 5, position = 5, name = 'Brewmaster', abilities = { { id = 'ANbf' }, { id = 'ANdh' }, { id = 'ANdb' }, { id = 'ANef' } } },
        { id = 'N005', parentId = 'Nbrn', race = 'other', line = 5, position = 6, name = 'Dark Ranger', abilities = { { id = 'ANse' }, { id = 'ANba' }, { id = 'ANdr' }, { id = 'ANch' } } },
        { id = 'N006', parentId = 'Nfir', race = 'other', line = 5, position = 7, name = 'Firelord', abilities = { { id = 'ANic' }, { id = 'ANso' }, { id = 'ANlm' }, { id = 'ANvc' } } },
        { id = 'N007', parentId = 'Nplh', race = 'other', line = 5, position = 8, name = 'Pit Lord', abilities = { { id = 'ANrf' }, { id = 'ANht' }, { id = 'ANca' }, { id = 'ANdo' } } }
    }
    units_for_build = {
        { id = 'h00C', parentId = 'h00A', tier = 1, race = 'human', line = 1, position = 1, food = 2, name = 'Footman', upgrades = { 'Rhde' }, abilities = { { id = 'Adef' } } },
        { id = 'h004', parentId = 'h00D', tier = 1, race = 'human', line = 1, position = 2, food = 3, name = 'Rifleman', upgrades = { 'Rhri' } },
        { id = 'h008', parentId = 'h00I', tier = 1, race = 'human', line = 1, position = 3, food = 2, name = 'Sorceress', upgrades = { 'Rhst' }, abilities = { { id = 'Aply' }, { id = 'Aivs' }, { id = 'Aslo' } } },
        { id = 'h003', parentId = 'h00E', tier = 2, race = 'human', line = 1, position = 4, food = 3, name = 'Mortar Team', upgrades = { 'Rhfl', 'Rhfs' } },
        { id = 'h007', parentId = 'h00H', tier = 2, race = 'human', line = 1, position = 5, food = 2, name = 'Priest', upgrades = { 'Rhpt' }, abilities = { { id = 'Ahea' }, { id = 'Ainf' }, { id = 'Adis' } } },
        { id = 'h006', parentId = 'h00K', tier = 2, race = 'human', line = 1, position = 6, food = 3, name = 'Spellbreaker', upgrades = { 'Rhss' } },
        { id = 'h000', parentId = 'h00F', tier = 2, race = 'human', line = 1, position = 7, food = 1, name = 'Flying Machine', upgrades = { 'Rhgb', 'Rhfc' } },
        { id = 'h009', parentId = 'h00L', tier = 3, race = 'human', line = 1, position = 8, food = 3, name = 'Dragonhawk Rider', upgrades = { 'Rhan' } },
        { id = 'h002', parentId = 'h00B', tier = 3, race = 'human', line = 1, position = 9, food = 4, name = 'Knight', upgrades = { 'Rhan' } },
        { id = 'h005', parentId = 'h00J', tier = 3, race = 'human', line = 1, position = 10, food = 3, name = 'Siege Engine', upgrades = { 'Rhrt' } },
        { id = 'h001', parentId = 'h00G', tier = 2, race = 'human', line = 1, position = 11, food = 4, name = 'Gryphon Rider', upgrades = { 'Rhhb' } },

        { id = 'h00P', parentId = 'o003', tier = 1, race = 'orc', line = 2, position = 1, food = 3, name = 'Grunt', upgrades = { 'Robs' } },
        { id = 'h00Q', parentId = 'o006', tier = 1, race = 'orc', line = 2, position = 2, food = 2, name = 'Headhunter', upgrades = { 'Robk', 'Rotr' } },
        { id = 'h00T', parentId = 'o00C', tier = 1, race = 'orc', line = 2, position = 3, food = 2, name = 'Shaman', upgrades = { 'Rost' }, abilities = { { id = 'Ablo' }, { id = 'Alsh' }, { id = 'Aprg' } } },
        { id = 'h00S', parentId = 'o004', tier = 2, race = 'orc', line = 2, position = 4, food = 3, name = 'Raider', upgrades = { 'Roen', 'Ropg' }, abilities = { { id = 'Aens' } } },
        { id = 'h00X', parentId = 'o00B', tier = 2, race = 'orc', line = 2, position = 5, food = 2, name = 'Witch Doctor', upgrades = { 'Rowd', 'Rotr' }, abilities = { { id = 'Aeye' }, { id = 'Ahwd' }, { id = 'Asta' } } },
        { id = 'h00U', parentId = 'o00D', tier = 2, race = 'orc', line = 2, position = 6, food = 3, name = 'Spirit Walker', upgrades = { 'Rowt' }, abilities = { { id = 'Aspl' }, { id = 'Adcn' }, { id = 'Aast' } } },
        { id = 'h00N', parentId = 'o00A', tier = 2, race = 'orc', line = 2, position = 7, food = 2, name = 'Batrider', upgrades = { 'Rotr' } },
        { id = 'h00R', parentId = 'o008', tier = 2, race = 'orc', line = 2, position = 8, food = 4, name = 'Kodo Beast', upgrades = { 'Rwdm' } },
        { id = 'h00V', parentId = 'o005', tier = 3, race = 'orc', line = 2, position = 9, food = 5, name = 'Tauren', upgrades = { 'Rows' } },
        { id = 'h00O', parentId = 'o007', tier = 3, race = 'orc', line = 2, position = 10, food = 4, name = 'Demolisher', upgrades = { 'Robf' } },
        { id = 'h00W', parentId = 'o009', tier = 3, race = 'orc', line = 2, position = 11, food = 4, name = 'Wind Rider', upgrades = { 'Rovs' } },

        { id = 'h014', parentId = 'u001', tier = 1, race = 'undead', line = 3, position = 1, food = 2, name = 'Ghoul', upgrades = { 'Rugf' } },
        { id = 'h010', parentId = 'u004', tier = 1, race = 'undead', line = 3, position = 2, food = 3, name = 'Crypt Fiend', upgrades = { 'Ruwb', 'Rubu' }, abilities = { { id = 'Aweb' }, { id = 'Abur' } } },
        { id = 'h00Z', parentId = 'u006', tier = 1, race = 'undead', line = 3, position = 3, food = 2, name = 'Banshee', upgrades = { 'Ruba' }, abilities = { { id = 'Aams' }, { id = 'Acrs' } } },
        { id = 'h017', parentId = 'u008', tier = 2, race = 'undead', line = 3, position = 4, food = 3, name = 'Obsidian Statue', upgrades = {}, abilities = { { id = 'Arpl' }, { id = 'Arpm' } } },
        { id = 'h013', parentId = 'u005', tier = 2, race = 'undead', line = 3, position = 5, food = 2, name = 'Gargoyle', upgrades = { 'Rusf' }, abilities = { { id = 'Astn' }, { id = 'Aatp' } } },
        { id = 'h016', parentId = 'u007', tier = 2, race = 'undead', line = 3, position = 6, food = 2, name = 'Necromancer', upgrades = { 'Rusl', 'Rune', 'Rusm' }, abilities = { { id = 'Acri' }, { id = 'Arai' }, { id = 'Auhf' } } },
        { id = 'h015', parentId = 'u003', tier = 2, race = 'undead', line = 3, position = 7, food = 4, name = 'Meat Wagon', upgrades = { 'Rupc' } },
        { id = 'h018', parentId = 'u000', tier = 2, race = 'undead', line = 3, position = 8, food = 1, name = 'Shade', upgrades = {} },
        { id = 'h00Y', parentId = 'u002', tier = 3, race = 'undead', line = 3, position = 9, food = 4, name = 'Abomination', upgrades = { 'Rupc' } },
        { id = 'h019', parentId = 'u00A', tier = 3, race = 'undead', line = 3, position = 10, food = 4, name = 'Destroyer', upgrades = {} },
        { id = 'h012', parentId = 'u009', tier = 3, race = 'undead', line = 3, position = 11, food = 7, name = 'Frost Wyrm', upgrades = { 'Rufb' } },

        { id = 'e009', parentId = 'e00C', tier = 1, race = 'elf', line = 4, position = 1, food = 3, name = 'Huntress', upgrades = { 'Remg', 'Resc' } },
        { id = 'e000', parentId = 'e00B', tier = 1, race = 'elf', line = 4, position = 2, food = 2, name = 'Archer', upgrades = { 'Reib', 'Remk' } },
        { id = 'e004', parentId = 'e00D', tier = 1, race = 'elf', line = 4, position = 3, food = 3, name = 'Dryad', upgrades = { 'Resi' } },
        { id = 'e006', parentId = 'e00E', tier = 2, race = 'elf', line = 4, position = 4, food = 3, name = 'Glaive Thower', upgrades = {} },
        { id = 'e007', parentId = 'e00F', tier = 2, race = 'elf', line = 4, position = 5, food = 2, name = 'Hippogryph', upgrades = {} },
        { id = 'e002', parentId = 'e00J', tier = 2, race = 'elf', line = 4, position = 6, food = 4, name = 'Druid of the Claw', upgrades = { 'Redc' }, abilities = { { id = 'Abrf' }, { id = 'Arej' }, { id = 'Aroa' } } },
        { id = 'e003', parentId = 'e00I', tier = 2, race = 'elf', line = 4, position = 7, food = 2, name = 'Druid of the Talon', upgrades = { 'Redt' }, abilities = { { id = 'Acyc' }, { id = 'Arav' }, { id = 'Afae' } } },
        { id = 'e005', parentId = 'e00L', tier = 2, race = 'elf', line = 4, position = 8, food = 2, name = 'Faerie Dragon', upgrades = {}, abilities = { { id = 'Amfl' } } },
        { id = 'e00A', parentId = 'e00K', tier = 3, race = 'elf', line = 4, position = 9, food = 7, name = 'Mountain Giant', upgrades = { 'Rers', 'Rehs' }, abilities = { { id = 'Atau' } } },
        { id = 'e008', parentId = 'e00G', tier = 3, race = 'elf', line = 4, position = 10, food = 4, name = 'Hippogryph Rider', upgrades = {} },
        { id = 'e001', parentId = 'e00H', tier = 3, race = 'elf', line = 4, position = 11, food = 5, name = 'Chimaera', upgrades = { 'Recb' } },
    }
    units_special = {
        builder = 'u00F',
        tower = 'o001',
        base = 'o002',
        mine = 'ugol',
        main = 'htow',
        laboratory = 'nmgv',
        shop = 'ngme',
        heroBuilder = 'e00M',
        randomHero = 'ncop',
        t2 = 'hkee',
        t3 = 'hcas'
    }
    abilities = {
        mine = 'A000',
        sell100 = 'A003',
        sell75 = 'A004',
        moveLarge = 'A007',
        moveMedium = 'A006',
        moveSmall = 'A005'
    }

    upgrades_special = {
        summonHeroBuilder = 'R000'
    }

    main_race = {
        { id = 'hcas', race = 'human' },
        { id = 'ofrt', race = 'orc' },
        { id = 'unp2', race = 'undead' },
        { id = 'etoe', race = 'elf' },
        { id = 'ntav', race = 'other' }
    }
end
Debug.endFile()