require 'build-script-unix' {
    game = nil,
    project = '../curved-strike-wc3-map',
    map = 'map.w3m',
    src = {'/src/debug/', '/src/totalInit/','/src/shop/', '/src/game/'},
    run = 'launch_nothing',
    syntaxCheck = false,
    options = {
        language = "ru",
        consoleColor = true,
    }
}