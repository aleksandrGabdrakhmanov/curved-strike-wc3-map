Debug.beginFile('start-game.lua')
function initAbilitiesPanel()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local buttonAbility = BlzCreateFrameByType("GLUETEXTBUTTON", "MyScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScriptDialogButton", 0)
            BlzFrameSetAbsPoint(buttonAbility, FRAMEPOINT_BOTTOMLEFT, 0.2, 0.13)
            BlzFrameSetSize(buttonAbility, 0.08, 0.03)
            BlzFrameSetText(buttonAbility, "Abilities")
            BlzFrameSetVisible(buttonAbility, GetLocalPlayer() == player.id)

            local panelAbility = BlzCreateFrameByType("BACKDROP", "MyPanelAbility", BlzGetFrameByName("ConsoleUIBackdrop", 0), "QuestButtonBackdropTemplate", 0)
            BlzFrameSetPoint(panelAbility, FRAMEPOINT_BOTTOM, buttonAbility, FRAMEPOINT_TOP, 0, 0)
            BlzFrameSetVisible(panelAbility, false)

            player.unitsWithAbility = 0
            for _, unit in ipairs(player.availableUnits) do
                local isAdded = initButtonForUnit(unit, panelAbility, player, player.unitsWithAbility)
                if isAdded then
                    player.unitsWithAbility = player.unitsWithAbility + 1
                end
            end
            player.unitsWithAbility = player.unitsWithAbility + 1
            player.buttonAbility = buttonAbility
            player.panelAbility = panelAbility
            player.isVisiblePanelAbility = false
            BlzFrameSetSize(player.panelAbility, 0.2, player.unitsWithAbility * 0.025)

            local trigger = CreateTrigger()
            BlzTriggerRegisterFrameEvent(trigger, buttonAbility, FRAMEEVENT_CONTROL_CLICK)
            TriggerAddAction(trigger, function()
                if player.isVisiblePanelAbility then
                    player.isVisiblePanelAbility = false
                    BlzFrameSetVisible(player.panelAbility, player.isVisiblePanelAbility)
                else
                    player.isVisiblePanelAbility = true
                    BlzFrameSetVisible(player.panelAbility, player.isVisiblePanelAbility)
                end
            end)
        end
    end
end

function updateAbilityPanel(player, hero)
    initButtonForUnit(hero, player.panelAbility, player, player.unitsWithAbility)
    player.unitsWithAbility = player.unitsWithAbility + 1
    BlzFrameSetSize(player.panelAbility, 0.2, (player.unitsWithAbility + 1) * 0.025)
end

function initButtonForUnit(unit, containerFrame, player, position)
    if unit.abilities then
        local button = BlzCreateFrame("MyIconButtonTemplate", containerFrame, 0, 0)
        BlzFrameSetPoint(button, FRAMEPOINT_TOPLEFT, containerFrame, FRAMEPOINT_TOPLEFT, 0.01, -(0.01 + (BlzFrameGetHeight(button) * position)))

        local buttonTexture = BlzGetFrameByName("MyButtonBackdropTemplate", 0)
        BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
        for id, ability in ipairs(unit.abilities) do
            local buttonAbility = BlzCreateFrame("MyIconButtonTemplate", containerFrame, 0, 0)
            BlzFrameSetPoint(buttonAbility, FRAMEPOINT_LEFT, button, FRAMEPOINT_RIGHT, BlzFrameGetHeight(button) * (id - 1), 0)

            local buttonTexture = BlzGetFrameByName("MyButtonBackdropTemplate", 0)
            BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(ability.id)), 0, true)
            local trig = CreateTrigger()
            BlzTriggerRegisterFrameEvent(trig, buttonAbility, FRAMEEVENT_CONTROL_CLICK)
            TriggerAddAction(trig, function()
                if ability.active == true or ability.active == nil then
                    ability.active = false
                    BlzFrameSetTexture(buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(ability.id))), 0, true)
                    SetPlayerAbilityAvailable(player.spawnPlayerId, FourCC(ability.id), false)
                else
                    ability.active = true
                    BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(ability.id)), 0, true)
                    SetPlayerAbilityAvailable(player.spawnPlayerId, FourCC(ability.id), true)
                end
            end)
        end
        return true
    end
    return false
end

Debug.endFile()