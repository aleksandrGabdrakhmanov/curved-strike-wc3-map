Debug.beginFile('main-init.lua')
function initMain(mode)
    initRegions()
    initGameConfig(mode)
    initGame(mode)
end
Debug.endFile()