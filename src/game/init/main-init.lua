Debug.beginFile('main-init.lua')
function initMain(mode)
    initRegions()
    initGameConfig(mode)
    initGame()
end
Debug.endFile()