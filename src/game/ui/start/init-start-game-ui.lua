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
            tooltip = "tooltip",
            defValue = 35,
            value = 35,
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
            tooltip = "tooltip",
            defValue = 0,
            value = 0,
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
            tooltip = "tooltip",
            defValue = 4000,
            value = 4000,
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
            tooltip = "tooltip",
            defValue = 4000,
            value = 4000,
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
            tooltip = "tooltip",
            defValue = 300,
            value = 300,
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
            tooltip = "tooltip",
            defValue = 300,
            value = 300,
            max = 3000,
            min = 60,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.startIncomePerSec = self.value / 60
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Added inc for each mine',
            tooltip = "tooltip",
            defValue = 30,
            value = 30,
            max = 300,
            min = 30,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.incomeBoost = self.value / 60
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Added inc for controlling center',
            tooltip = "tooltip",
            defValue = 30,
            value = 30,
            max = 300,
            min = 0,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.incomeForCenter = self.value / 60
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Price first mine',
            tooltip = "tooltip",
            defValue = 150,
            value = 150,
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
            tooltip = "tooltip",
            defValue = 75,
            value = 75,
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
            tooltip = "tooltip",
            defValue = 125,
            value = 125,
            max = 1500,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.goldByTower = self.value
            end
        },
        -- UNITS
        {
            page = page.UNITS,
            type = elementType.CHECK_BOX,
            text = 'Mirror units',
            tooltip = "tooltip",
            value = false,
            initConfigValue = function(self)
                game_config.units.isUnitsMirror = self.value
            end
        },
        {
            page = page.UNITS,
            type = elementType.SLIDER,
            text = 'Max lifespan of unit in waves',
            tooltip = "tooltip",
            defValue = 2,
            value = 2,
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
            tooltip = "tooltip",
            value = false,
            initConfigValue = function(self)
                game_config.units.isHeroesMirror = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Max heroes',
            tooltip = "tooltip",
            defValue = 3,
            value = 3,
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
            tooltip = "tooltip",
            defValue = 2,
            value = 2,
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
            tooltip = "tooltip",
            defValue = 4,
            value = 4,
            max = 6,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.units.itemCapacity = self.value
            end
        }
    }
end
Debug.endFile()