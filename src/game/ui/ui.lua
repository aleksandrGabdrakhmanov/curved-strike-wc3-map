function initialUI()
    local fm = BlzGetFrameByName("ConsoleUIBackdrop",0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 2)
end

function createModeUI()
    print("11")
    BlzLoadTOCFile("war3mapimported\\templates.toc")
    popupFrame = BlzCreateFrame("StartGameMenu", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0), 0, 0 )
    BlzFrameSetAbsPoint(popupFrame, FRAMEPOINT_CENTER, 0.4, 0.35)
    BlzFrameSetVisible(popupFrame, GetLocalPlayer() == Player(0))

    buttonCurvedFrame = BlzGetFrameByName("CurvedButton", 0)
    buttonUnionFrame = BlzGetFrameByName("UnitedButton", 0)
end

function hideModeUI()
    BlzFrameSetVisible(popupFrame, FALSE)
end