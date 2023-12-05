function initialUI()
    -- create a TEXT Frame
    local fm = BlzGetFrameByName("ConsoleUIBackdrop",0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    -- Set the current Text, you can use the Warcraft 3 Color Code
    -- pos the frame
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    -- stop this frame from taking control of the mouse input, Might have sideeffects if the TEXT-Frame has an enable Color (but this does not have such).
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 2)
    -- the text is kinda small, but one can not use the FontNative onto TEXT-Frames (nether in V1.31 nor V1.32). Therefore one could scale it.
end