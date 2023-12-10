function initialUI()
    local fm = BlzGetFrameByName("ConsoleUIBackdrop",0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 2)
end

function createModeUI()
    modeMainFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    BlzFrameSetAbsPoint(modeMainFrame, FRAMEPOINT_CENTER, 0.4, 0.35)
    BlzFrameSetSize(modeMainFrame, 0.3, 0.35)
    BlzFrameSetVisible(modeMainFrame, GetLocalPlayer() == Player(0))

    buttonCurvedFrame = BlzCreateFrameByType("GLUETEXTBUTTON", "MyScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScriptDialogButton", 0)
    BlzFrameSetPoint(buttonCurvedFrame, FRAMEPOINT_CENTER, modeMainFrame, FRAMEPOINT_CENTER, 0, 0.02)
    BlzFrameSetText(buttonCurvedFrame, "CURVED")
    BlzFrameSetVisible(buttonCurvedFrame, GetLocalPlayer() == Player(0))

    buttonUnionFrame = BlzCreateFrameByType("GLUETEXTBUTTON", "MyScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScriptDialogButton", 0)
    BlzFrameSetPoint(buttonUnionFrame, FRAMEPOINT_CENTER, modeMainFrame, FRAMEPOINT_CENTER, 0, -0.02)
    BlzFrameSetText(buttonUnionFrame, "UNITED")
    BlzFrameSetVisible(buttonUnionFrame, GetLocalPlayer() == Player(0))
end

function hideModeUI()
    BlzFrameSetVisible(modeMainFrame, FALSE)
    BlzFrameSetVisible(buttonCurvedFrame, FALSE)
    BlzFrameSetVisible(buttonUnionFrame, FALSE)
end