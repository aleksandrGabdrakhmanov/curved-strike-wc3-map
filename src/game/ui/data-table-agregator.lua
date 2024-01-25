Debug.beginFile('data-table-agregator.lua')
panelType = {
    FINISH = 'FINISH',
    STATUS = 'STATUS'
}

function getTableInfo(teams, panel)
    local tableInfo = {}
    tableInfo.header = {}
    local addedHeader = {}
    insertHeader(addedHeader, 'Name', tableInfo.header, { text = 'Name', weight = 0.085 })
    insertHeader(addedHeader, 'Wave', tableInfo.header, { text = 'Wave', weight = 0.04 }, panel == panelType.STATUS)
    insertHeader(addedHeader, 'Income', tableInfo.header, { text = 'Inc/min', weight = 0.07 }, panel == panelType.STATUS)
    insertHeader(addedHeader, 'GoldTotal', tableInfo.header, { text = 'Gold total', weight = 0.045 })
    insertHeader(addedHeader, 'GoldKill', tableInfo.header, { text = 'Gold kill', weight = 0.045 }, game_config.economy.goldForKill > 0)
    insertHeader(addedHeader, 'Kills', tableInfo.header, { text = 'Kills', weight = 0.05 })
    insertHeader(addedHeader, 'Damage', tableInfo.header, { text = 'Damage', weight = 0.06 })
    insertHeader(addedHeader, 'Tier', tableInfo.header, { text = 'Tier', weight = 0.04 })
    insertHeader(addedHeader, 'Army', tableInfo.header, { text = 'Army', weight = 0.04 })

    insertHeader(addedHeader, 'Score', tableInfo.header, { text = 'Score', weight = 0.04,
tooltipText = '1 point for each army\n1 point - 100 earned gold\n1 point - 15 kills summon units\n1 point - 10 kills not summon units\n1 point - kill hero\n1 point - 15 damage to tower/base\n5 point for each hero level'
    }, panel == panelType.FINISH)

    insertHeader(addedHeader, 'HeroesIcon1', tableInfo.header, { text = 'Heroes', weight = 0.06 })
    insertHeader(addedHeader, 'HeroesIcon2', tableInfo.header, { })
    insertHeader(addedHeader, 'HeroesIcon3', tableInfo.header, { })
    insertHeader(addedHeader, 'HeroesIcon4', tableInfo.header, { })
    insertHeader(addedHeader, 'HeroesIcon5', tableInfo.header, { })
    insertHeader(addedHeader, 'HeroesIcon6', tableInfo.header, { })
    insertHeader(addedHeader, 'HeroesIcon7', tableInfo.header, { })

    tableInfo.body = {}

    for _, team in ipairs(teams) do
        for _, player in ipairs(team.players) do
            local row = {}

            insertRow(addedHeader, 'Name', row, {
                text = getClearName(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            insertRow(addedHeader, 'Wave', row, {
                text = math.floor(player.spawnTimer),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            insertRow(addedHeader, 'Income', row, {
                text = getIncome(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'GoldTotal', row, {
                text = player.economy.totalGold,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'GoldKill', row, {
                text = player.economy.totalGoldForKills,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'Kills', row, {
                text = player.totalKills,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            insertRow(addedHeader, 'Damage', row, {
                text = player.totalDamage,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            insertRow(addedHeader, 'Tier', row, {
                text = player.tier,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'Army', row, {
                text = player.food,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'Score', row, {
                text = getScore(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon1', row, {
                icon = player.heroes[1] and player.heroes[1].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon2', row, {
                icon = player.heroes[2] and player.heroes[2].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon3', row, {
                icon = player.heroes[3] and player.heroes[3].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon4', row, {
                icon = player.heroes[4] and player.heroes[4].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon5', row, {
                icon = player.heroes[5] and player.heroes[5].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon6', row, {
                icon = player.heroes[6] and player.heroes[6].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            insertRow(addedHeader, 'HeroesIcon7', row, {
                icon = player.heroes[7] and player.heroes[7].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(tableInfo.body, row)
        end
    end
    return tableInfo
end

function getScore(player)
    return math.floor(
            player.food +
            (player.economy.totalGold / 100) +
            (player.totalSummonKills / 15) +
            ((player.totalKills - player.totalSummonKills - player.totalHeroKills) / 10) +
            (player.totalHeroKills) +
            (player.damageToTowerBase / 15) +
            (player.totalHeroLevels * 5)
    )
end

function getScoreForHeroes(player)
    for _, hero in ipairs(player.heroes) do

    end
end

function insertHeader(addedHeader, name, tbl, value, condition)
    if condition == nil then
        condition = true
    end
    if condition == true then
        table.insert(addedHeader, name)
        table.insert(tbl, value)
    end
end

function insertRow(addedHeader, name, tbl, value)
    if isContain(addedHeader, name) then
        table.insert(tbl, value)
    end
end

function getIncome(player)
    if player.economy.incomeForCenter == 0 then
        return math.floor(player.economy.income)
    else
        return math.floor(player.economy.income) .. '(+' .. math.floor(player.economy.incomeForCenter) .. ')'
    end
end

function getClearName(player)
    return string.gsub(GetPlayerName(player.id), "#.*", "")
end
Debug.endFile()