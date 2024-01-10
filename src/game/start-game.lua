Debug.beginFile('start-game.lua')
function startGame(mode)
    initMain(mode)
    initGameTimer()
    initialUI()
    initTriggers()
end
Debug.endFile()