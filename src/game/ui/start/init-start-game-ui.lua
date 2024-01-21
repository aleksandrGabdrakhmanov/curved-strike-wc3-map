Debug.beginFile('init-start-game-ui.lua')
function initStartGameUI()
    ui_params = {
        lengthString = 0.2,
        widthString = 0.02,
        indent = 0.015,
        width = 0.4,
        betweenElement = 0.028
    }

    elementType = {
        SLIDER = 'slider',
        EDIT_BOX = 'editBox',
        CHECK_BOX = 'checkBox'
    }

    page = {
        GENERAL = 'general',
        ECONOMY = 'economy',
        HEROES = 'heroes',
        UNITS = 'units'
    }

    ui_elements = {
        -- GENERAL
        {
            page = page.GENERAL,
            type = elementType.SLIDER,
            text = 'Wave interval each players',
            tooltip = 'Wave release interval between players. The total interval for each player between their' ..
                    ' turns will be the product of the number of players and the interval.\n\nThe default value of this' ..
                    ' parameter varies depending on the number of players:\n' ..
                    '[1x1] 35 sec * 1 = 35 total\n' ..
                    '[2x2] 35 sec * 2 = 70 total\n' ..
                    '[3x3] 35 sec * 3 = 105 total\n' ..
                    '[4x4] 30 sec * 4 = 120 total\n' ..
                    '[5x5] 25 sec * 4 = 125 total\n',
            defValue = {
                [1] = 35,
                [2] = 35,
                [3] = 35,
                [4] = 35,
                [5] = 35,
                [6] = 35,
                [7] = 30,
                [8] = 30,
                [9] = 25,
                [10] = 25
            },
            max = 120,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.spawnPolicy.interval = self.value
            end
        },
        {
            page = page.GENERAL,
            type = elementType.SLIDER,
            text = 'Wave interval all players',
            tooltip = 'The interval for the next wave after all players have launched waves and a full cycle has passed for the team',
            defValue = 0,
            max = 120,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.spawnPolicy.dif = self.value
            end
        },
        {
            page = page.GENERAL,
            type = elementType.EDIT_BOX,
            text = 'Base HP',
            tooltip = "Maximum health capacity of the team's main base",
            defValue = 4000,
            max = 999999,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.baseHP = self.value
            end
        },
        {
            page = page.GENERAL,
            type = elementType.EDIT_BOX,
            text = 'Tower HP',
            tooltip = "Maximum health capacity of the team's tower",
            defValue = 4000,
            max = 999999,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.towerHP = self.value
            end
        },
        -- ECONOMY
        {
            page = page.ECONOMY,
            type = elementType.EDIT_BOX,
            text = 'Start gold',
            tooltip = "Initial amount of gold with which players start the game",
            defValue = 300,
            max = 999999,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.startGold = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Base income/min',
            tooltip = "Starting amount of income",
            defValue = 300,
            max = 3000,
            min = 0,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.startIncomePerSec = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Added inc for each mine',
            tooltip = "Additional income awarded to the player for each mine upgrade",
            defValue = 30,
            max = 300,
            min = 30,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.incomeBoost = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Added inc for controlling center',
            tooltip = "Additional income for team control of the center.\nThis income is granted to the team that" ..
                    " first crosses the center of the map, until another team crosses the center",
            defValue = 30,
            max = 300,
            min = 0,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.incomeForCenter = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Price first mine',
            tooltip = "Cost of the first upgrade for the mine",
            defValue = 150,
            max = 1500,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.firstMinePrice = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Price diff for each next mine',
            tooltip = "Price increase for each subsequent mine upgrade",
            defValue = 75,
            max = 300,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.nextMineDiffPrice = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Gold for killing the tower',
            tooltip = "Amount of gold awarded to each team member for destroying an enemy tower",
            defValue = 125,
            max = 1500,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.goldByTower = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Gold for killing units',
            tooltip = "Amount of gold earned for killing enemy units, calculated as a percentage of their cost. \n" ..
                    "For example, if the parameter value is 10%, the player receives 10% of the cost of the defeated unit. \n"..
                    "Players do not receive gold for killing summoned units",
            defValue = 0,
            max = 100,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.goldForKill = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.CHECK_BOX,
            text = 'Upkeep',
            tooltip = "No Upkeep (0-50 Food: 100% income)\n" ..
                    "Low Upkeep (51-100 Food: 80% income)\n" ..
                    "High Upkeep (101+ Food: 60% income)",
            defValue = false,
            initConfigValue = function(self)
                game_config.economy.upkeep = self.value
            end
        },
        -- UNITS
        {
            page = page.UNITS,
            type = elementType.CHECK_BOX,
            text = 'Mirror units',
            tooltip = "Distribute identical random units to players of opposing teams in corresponding positions.\n" ..
                    "For example, player 1 from team 1 will have the same set of units as player 1 from team 2, and so on",
            defValue = false,
            initConfigValue = function(self)
                game_config.units.isUnitsMirror = self.value
            end
        },
        {
            page = page.UNITS,
            type = elementType.SLIDER,
            text = 'Max lifespan of unit in waves',
            tooltip = "Number of waves after a unit's deployment, upon which the unit will disappear.\n" ..
                    "For example, if the parameter value is 2, then the unit will vanish after two more waves are" ..
                    " released by the player who owns that unit.",
            defValue = 2,
            max = 15,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.lifetime = self.value
            end
        },
        -- HEROES
        {
            page = page.HEROES,
            type = elementType.CHECK_BOX,
            text = 'Mirror heroes',
            tooltip = "Assign identical random heroes to players of opposing teams in the same positions.\n" ..
                    "For instance, player 1 from team 1 will have the same hero as player 1 from team 2, and so forth",
            defValue = false,
            initConfigValue = function(self)
                game_config.units.isHeroesMirror = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Max heroes',
            tooltip = "Maximum possible number of heroes for each player",
            defValue = 3,
            max = 7,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.units.maxHeroes = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Selectable hero count',
            tooltip = "Number of random heroes available for a player to choose from when summoning each subsequent hero.\n"
            .. " For example, if the parameter value is 3, then upon constructing a hero, the player will have a " ..
                    "choice among 3 randomly generated hero options.",
            defValue = 2,
            max = 11,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.countForSelect = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Item capacity',
            tooltip = "Maximum number of items that a hero can carry",
            defValue = 4,
            max = 6,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.units.itemCapacity = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Start hero level',
            tooltip = "The initial level of the hero after construction.",
            defValue = 1,
            max = 10,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.heroStartLevel = self.value
            end
        }
    }
end
Debug.endFile()