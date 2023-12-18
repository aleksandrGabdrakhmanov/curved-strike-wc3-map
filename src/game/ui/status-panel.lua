function initPanelForAllPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local myPanel = BlzCreateFrame("CurvedStatusTemplate", BlzGetFrameByName("ConsoleUIBackdrop", 0), 0, 0)
            BlzFrameSetAbsPoint(myPanel, FRAMEPOINT_TOPRIGHT, 0.95, 0.56)
            BlzFrameSetSize(myPanel, 0.2, 0.2)
            BlzFrameSetVisible(myPanel, GetLocalPlayer() == player.id)
            player.statePanel = myPanel
        end
    end
end

