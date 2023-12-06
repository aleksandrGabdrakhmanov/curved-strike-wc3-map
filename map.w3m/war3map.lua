gg_rct_attack_region_p1 = nil
gg_rct_attack_region_p10 = nil
gg_rct_attack_region_p2 = nil
gg_rct_attack_region_p3 = nil
gg_rct_attack_region_p4 = nil
gg_rct_attack_region_p5 = nil
gg_rct_attack_region_p6 = nil
gg_rct_attack_region_p7 = nil
gg_rct_attack_region_p8 = nil
gg_rct_attack_region_p9 = nil
gg_rct_build_right_middle = nil
gg_rct_build_left_down = nil
gg_rct_build_left_middle = nil
gg_rct_build_right_middle_up = nil
gg_rct_build_right_up = nil
gg_rct_build_right_middle_down = nil
gg_rct_build_right_down = nil
gg_rct_build_left_middle_up = nil
gg_rct_build_left_up = nil
gg_rct_build_left_middle_down = nil
gg_rct_spawn_right_middle = nil
gg_rct_spawn_left_down = nil
gg_rct_spawn_left_middle = nil
gg_rct_spawn_right_middle_up = nil
gg_rct_spawn_right_up = nil
gg_rct_spawn_right_middle_down = nil
gg_rct_spawn_right_down = nil
gg_rct_spawn_left_middle_up = nil
gg_rct_spawn_left_middle_down = nil
gg_rct_attack_region_center_left = nil
gg_rct_attack_region_center_right = nil
gg_rct_spawn_left_up = nil
gg_rct_base_left = nil
gg_rct_base_right = nil
gg_rct_tower_left = nil
gg_rct_tower_right = nil
gg_rct_mine_left_middle = nil
gg_rct_mine_left_middle_down = nil
gg_rct_mine_left_down = nil
gg_rct_mine_left_middle_up = nil
gg_rct_mine_left_up = nil
gg_rct_mine_right_up = nil
gg_rct_mine_right_middle_up = nil
gg_rct_mine_right_middle = nil
gg_rct_mine_right_middle_down = nil
gg_rct_mine_right_down = nil
function InitGlobals()
end

function CreateUnitsForPlayer0()
local p = Player(0)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("o000"), -5952.8, -6236.0, 232.643, FourCC("o000"))
end

function CreateUnitsForPlayer1()
local p = Player(1)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("o000"), -6418.4, -5501.0, 350.782, FourCC("o000"))
end

function CreateUnitsForPlayer2()
local p = Player(2)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("o000"), -6844.0, -5171.5, 118.282, FourCC("o000"))
end

function CreateUnitsForPlayer3()
local p = Player(3)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("o000"), -6391.8, -6863.8, 330.039, FourCC("o000"))
end

function CreateUnitsForPlayer4()
local p = Player(4)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("o000"), -6623.5, -7406.3, 182.049, FourCC("o000"))
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
CreateUnitsForPlayer0()
CreateUnitsForPlayer1()
CreateUnitsForPlayer2()
CreateUnitsForPlayer3()
CreateUnitsForPlayer4()
end

function CreateAllUnits()
CreatePlayerBuildings()
CreatePlayerUnits()
end

function CreateRegions()
local we

gg_rct_attack_region_p1 = Rect(-4032.0, -256.0, -2880.0, 1408.0)
gg_rct_attack_region_p10 = Rect(1600.0, -3584.0, 2752.0, -1920.0)
gg_rct_attack_region_p2 = Rect(3840.0, -256.0, 4992.0, 1408.0)
gg_rct_attack_region_p3 = Rect(-1792.0, 1408.0, -640.0, 3072.0)
gg_rct_attack_region_p4 = Rect(-1792.0, 3072.0, -640.0, 4736.0)
gg_rct_attack_region_p5 = Rect(-1792.0, -1920.0, -640.0, -256.0)
gg_rct_attack_region_p6 = Rect(-1792.0, -3584.0, -640.0, -1920.0)
gg_rct_attack_region_p7 = Rect(1600.0, 1408.0, 2752.0, 3072.0)
gg_rct_attack_region_p8 = Rect(1600.0, 3072.0, 2752.0, 4736.0)
gg_rct_attack_region_p9 = Rect(1600.0, -1920.0, 2752.0, -256.0)
gg_rct_build_right_middle = Rect(6720.0, -256.0, 7872.0, 1408.0)
gg_rct_build_left_down = Rect(-6912.0, -3968.0, -5760.0, -2304.0)
gg_rct_build_left_middle = Rect(-6912.0, -256.0, -5760.0, 1408.0)
gg_rct_build_right_middle_up = Rect(6720.0, 1600.0, 7872.0, 3264.0)
gg_rct_build_right_up = Rect(6720.0, 3456.0, 7872.0, 5120.0)
gg_rct_build_right_middle_down = Rect(6720.0, -2112.0, 7872.0, -448.0)
gg_rct_build_right_down = Rect(6720.0, -3968.0, 7872.0, -2304.0)
gg_rct_build_left_middle_up = Rect(-6912.0, 1600.0, -5760.0, 3264.0)
gg_rct_build_left_up = Rect(-6912.0, 3456.0, -5760.0, 5120.0)
gg_rct_build_left_middle_down = Rect(-6912.0, -2112.0, -5760.0, -448.0)
gg_rct_spawn_right_middle = Rect(4992.0, -256.0, 6144.0, 1408.0)
gg_rct_spawn_left_down = Rect(-5184.0, -3584.0, -4032.0, -1920.0)
gg_rct_spawn_left_middle = Rect(-5184.0, -256.0, -4032.0, 1408.0)
gg_rct_spawn_right_middle_up = Rect(4992.0, 1408.0, 6144.0, 3072.0)
gg_rct_spawn_right_up = Rect(4992.0, 3072.0, 6144.0, 4736.0)
gg_rct_spawn_right_middle_down = Rect(4992.0, -1920.0, 6144.0, -256.0)
gg_rct_spawn_right_down = Rect(4992.0, -3584.0, 6144.0, -1920.0)
gg_rct_spawn_left_middle_up = Rect(-5184.0, 1408.0, -4032.0, 3072.0)
gg_rct_spawn_left_middle_down = Rect(-5184.0, -1920.0, -4032.0, -256.0)
gg_rct_attack_region_center_left = Rect(-1792.0, -256.0, -640.0, 1408.0)
gg_rct_attack_region_center_right = Rect(1600.0, -256.0, 2752.0, 1408.0)
gg_rct_spawn_left_up = Rect(-5184.0, 3072.0, -4032.0, 4736.0)
gg_rct_base_left = Rect(-4000.0, 320.0, -3392.0, 960.0)
gg_rct_base_right = Rect(4352.0, 320.0, 4960.0, 960.0)
gg_rct_tower_left = Rect(-1568.0, 320.0, -960.0, 960.0)
gg_rct_tower_right = Rect(1888.0, 320.0, 2496.0, 960.0)
gg_rct_mine_left_middle = Rect(-7264.0, -256.0, -6912.0, 64.0)
gg_rct_mine_left_middle_down = Rect(-7264.0, -2112.0, -6912.0, -1792.0)
gg_rct_mine_left_down = Rect(-7264.0, -3968.0, -6912.0, -3648.0)
gg_rct_mine_left_middle_up = Rect(-7264.0, 1600.0, -6912.0, 1920.0)
gg_rct_mine_left_up = Rect(-7264.0, 3456.0, -6912.0, 3776.0)
gg_rct_mine_right_up = Rect(7872.0, 3456.0, 8224.0, 3776.0)
gg_rct_mine_right_middle_up = Rect(7872.0, 1600.0, 8224.0, 1920.0)
gg_rct_mine_right_middle = Rect(7872.0, -256.0, 8224.0, 64.0)
gg_rct_mine_right_middle_down = Rect(7872.0, -2112.0, 8224.0, -1792.0)
gg_rct_mine_right_down = Rect(7872.0, -3968.0, 8224.0, -3648.0)
end

--CUSTOM_CODE
if Debug then Debug.beginFile 'TotalInitialization' end
--[[——————————————————————————————————————————————————————
    Total Initialization version 5.3.1
    Created by: Bribe
    Contributors: Eikonium, HerlySQR, Tasyen, Luashine, Forsakn
    Inspiration: Almia, ScorpioT1000, Troll-Brain
    Hosted at: https://github.com/BribeFromTheHive/Lua/blob/master/TotalInitialization.lua
    Debug library hosted at: https://www.hiveworkshop.com/threads/debug-utils-ingame-console-etc.330758/
————————————————————————————————————————————————————————————]]

---Calls the user's initialization function during the map's loading process. The first argument should either be the init function,
---or it should be the string to give the initializer a name (works similarly to a module name/identically to a vJass library name).
---
---To use requirements, call `Require.strict 'LibraryName'` or `Require.optional 'LibraryName'`. Alternatively, the OnInit callback
---function can take the `Require` table as a single parameter: `OnInit(function(import) import.strict 'ThisIsTheSameAsRequire' end)`.
---
-- - `OnInit.global` or just `OnInit` is called after InitGlobals and is the standard point to initialize.
-- - `OnInit.trig` is called after InitCustomTriggers, and is useful for removing hooks that should only apply to GUI events.
-- - `OnInit.map` is the last point in initialization before the loading screen is completed.
-- - `OnInit.final` occurs immediately after the loading screen has disappeared, and the game has started.
---@class OnInit
--
--Simple Initialization without declaring a library name:
---@overload async fun(initCallback: Initializer.Callback)
--
--Advanced initialization with a library name and an optional third argument to signal to Eikonium's DebugUtils that the file has ended.
---@overload async fun(libraryName: string, initCallback: Initializer.Callback, debugLineNum?: integer)
--
--A way to yield your library to allow other libraries in the same initialization sequence to load, then resume once they have loaded.
---@overload async fun(customInitializerName: string)
OnInit = {}

---@alias Initializer.Callback fun(require?: Requirement | {[string]: Requirement}):...?

---@alias Requirement async fun(reqName: string, source?: table): unknown

-- `Require` will yield the calling `OnInit` initialization function until the requirement (referenced as a string) exists. It will check the
-- global API (for example, does 'GlobalRemap' exist) and then check for any named OnInit resources which might use that same string as its name.
--
-- Due to the way Sumneko's syntax highlighter works, the return value will only be linted for defined @class objects (and doesn't work for regular
-- globals like `TimerStart`). I tried to request the functionality here: https://github.com/sumneko/lua-language-server/issues/1792 , however it
-- was closed. Presumably, there are other requests asking for it, but I wouldn't count on it.
--
-- To declare a requirement, use: `Require.strict 'SomeLibrary'` or (if you don't care about the missing linting functionality) `Require 'SomeLibrary'`
--
-- To optionally require something, use any other suffix (such as `.optionally` or `.nonstrict`): `Require.optional 'SomeLibrary'`
--
---@class Require: { [string]: Requirement }
---@overload async fun(reqName: string, source?: table): string
Require = {}
do
    local library = {} --You can change this to false if you don't use `Require` nor the `OnInit.library` API.

    --CONFIGURABLE LEGACY API FUNCTION:
    ---@param _ENV table
    ---@param OnInit any
    local function assignLegacyAPI(_ENV, OnInit)
        OnGlobalInit = OnInit; OnTrigInit = OnInit.trig; OnMapInit = OnInit.map; OnGameStart = OnInit.final              --Global Initialization Lite API
        --OnMainInit = OnInit.main; OnLibraryInit = OnInit.library; OnGameInit = OnInit.final                            --short-lived experimental API
        --onGlobalInit = OnInit; onTriggerInit = OnInit.trig; onInitialization = OnInit.map; onGameStart = OnInit.final  --original Global Initialization API
        --OnTriggerInit = OnInit.trig; OnInitialization = OnInit.map                                                     --Forsakn's Ordered Indices API
    end
    --END CONFIGURABLES

    local _G, rawget, insert =
    _G, rawget, table.insert

    local initFuncQueue = {}

    ---@param name string
    ---@param continue? function
    local function runInitializers(name, continue)
        --print('running:', name, tostring(initFuncQueue[name]))
        if initFuncQueue[name] then
            for _,func in ipairs(initFuncQueue[name]) do
                coroutine.wrap(func)(Require)
            end
            initFuncQueue[name] = nil
        end
        if library then
            library:resume()
        end
        if continue then
            continue()
        end
    end

    local function initEverything()
        ---@param hookName string
        ---@param continue? function
        local function hook(hookName, continue)
            local hookedFunc = rawget(_G, hookName)
            if hookedFunc then
                rawset(_G, hookName,
                        function()
                            hookedFunc()
                            runInitializers(hookName, continue)
                        end
                )
            else
                runInitializers(hookName, continue)
            end
        end

        hook(
                'InitGlobals',
                function()
                    hook(
                            'InitCustomTriggers',
                            function()
                                hook('RunInitializationTriggers')
                            end
                    )
                end
        )

        hook(
                'MarkGameStarted',
                function()
                    if library then
                        for _,func in ipairs(library.queuedInitializerList) do
                            func(nil, true) --run errors for missing requirements.
                        end
                        for _,func in pairs(library.yieldedModuleMatrix) do
                            func(true) --run errors for modules that aren't required.
                        end
                    end
                    OnInit = nil
                    Require = nil
                end
        )
    end

    ---@param initName       string
    ---@param libraryName    string | Initializer.Callback
    ---@param func?          Initializer.Callback
    ---@param debugLineNum?  integer
    ---@param incDebugLevel? boolean
    local function addUserFunc(initName, libraryName, func, debugLineNum, incDebugLevel)
        if not func then
            ---@cast libraryName Initializer.Callback
            func = libraryName
        else
            assert(type(libraryName) == 'string')
            if debugLineNum and Debug then
                Debug.beginFile(libraryName, incDebugLevel and 3 or 2)
                Debug.data.sourceMap[#Debug.data.sourceMap].lastLine = debugLineNum
            end
            if library then
                func = library:create(libraryName, func)
            end
        end
        assert(type(func) == 'function')

        --print('adding user func: ' , initName , libraryName, debugLineNum, incDebugLevel)

        initFuncQueue[initName] = initFuncQueue[initName] or {}
        insert(initFuncQueue[initName], func)

        if initName == 'root' or initName == 'module' then
            runInitializers(initName)
        end
    end

    ---@param name string
    local function createInit(name)
        ---@async
        ---@param libraryName string                --Assign your callback a unique name, allowing other OnInit callbacks can use it as a requirement.
        ---@param userInitFunc Initializer.Callback --Define a function to be called at the chosen point in the initialization process. It can optionally take the `Require` object as a parameter. Its optional return value(s) are passed to a requiring library via the `Require` object (defaults to `true`).
        ---@param debugLineNum? integer             --If the Debug library is present, you can call Debug.getLine() for this parameter (which should coincide with the last line of your script file). This will neatly tie-in with OnInit's built-in Debug library functionality to define a starting line and an ending line for your module.
        ---@overload async fun(userInitFunc: Initializer.Callback)
        return function(libraryName, userInitFunc, debugLineNum)
            addUserFunc(name, libraryName, userInitFunc, debugLineNum)
        end
    end
    OnInit.global = createInit 'InitGlobals'                -- Called after InitGlobals, and is the standard point to initialize.
    OnInit.trig   = createInit 'InitCustomTriggers'         -- Called after InitCustomTriggers, and is useful for removing hooks that should only apply to GUI events.
    OnInit.map    = createInit 'RunInitializationTriggers'  -- Called last in the script's loading screen sequence. Runs after the GUI "Map Initialization" events have run.
    OnInit.final  = createInit 'MarkGameStarted'            -- Called immediately after the loading screen has disappeared, and the game has started.

    do
        ---@param self table
        ---@param libraryNameOrInitFunc function | string
        ---@param userInitFunc function
        ---@param debugLineNum number
        local function __call(
                self,
                libraryNameOrInitFunc,
                userInitFunc,
                debugLineNum
        )
            if userInitFunc or type(libraryNameOrInitFunc) == 'function' then
                addUserFunc(
                        'InitGlobals', --Calling OnInit directly defaults to OnInit.global (AKA OnGlobalInit)
                        libraryNameOrInitFunc,
                        userInitFunc,
                        debugLineNum,
                        true
                )
            elseif library then
                library:declare(libraryNameOrInitFunc) --API handler for OnInit "Custom initializer"
            else
                error(
                        "Bad OnInit args: "..
                                tostring(libraryNameOrInitFunc) .. ", " ..
                                tostring(userInitFunc)
                )
            end
        end
        setmetatable(OnInit --[[@as table]], { __call = __call })
    end

    do --if you don't need the initializers for 'root', 'config' and 'main', you can delete this do...end block.
        local gmt = getmetatable(_G) or
                getmetatable(setmetatable(_G, {}))

        local rawIndex = gmt.__newindex or rawset

        local hookMainAndConfig
        ---@param _G table
        ---@param key string
        ---@param fnOrDiscard unknown
        function hookMainAndConfig(_G, key, fnOrDiscard)
            if key == 'main' or key == 'config' then
                ---@cast fnOrDiscard function
                if key == 'main' then
                    runInitializers 'root'
                end
                rawIndex(_G, key, function()
                    if key == 'config' then
                        fnOrDiscard()
                    elseif gmt.__newindex == hookMainAndConfig then
                        gmt.__newindex = rawIndex --restore the original __newindex if no further hooks on __newindex exist.
                    end
                    runInitializers(key)
                    if key == 'main' then
                        fnOrDiscard()
                    end
                end)
            else
                rawIndex(_G, key, fnOrDiscard)
            end
        end
        gmt.__newindex = hookMainAndConfig
        OnInit.root    = createInit 'root'   -- Runs immediately during the Lua root, but is yieldable (allowing requirements) and pcalled.
        OnInit.config  = createInit 'config' -- Runs when `config` is called. Credit to @Luashine: https://www.hiveworkshop.com/threads/inject-main-config-from-we-trigger-code-like-jasshelper.338201/
        OnInit.main    = createInit 'main'   -- Runs when `main` is called. Idea from @Tasyen: https://www.hiveworkshop.com/threads/global-initialization.317099/post-3374063
    end
    if library then
        library.queuedInitializerList = {}
        library.customDeclarationList = {}
        library.yieldedModuleMatrix   = {}
        library.moduleValueMatrix     = {}

        function library:pack(name, ...)
            self.moduleValueMatrix[name] = table.pack(...)
        end

        function library:resume()
            if self.queuedInitializerList[1] then
                local continue, tempQueue, forceOptional

                ::initLibraries::
                repeat
                    continue=false
                    self.queuedInitializerList, tempQueue =
                    {}, self.queuedInitializerList

                    for _,func in ipairs(tempQueue) do
                        if func(forceOptional) then
                            continue=true --Something was initialized; therefore further systems might be able to initialize.
                        else
                            insert(self.queuedInitializerList, func) --If the queued initializer returns false, that means its requirement wasn't met, so we re-queue it.
                        end
                    end
                until not continue or not self.queuedInitializerList[1]

                if self.customDeclarationList[1] then
                    self.customDeclarationList, tempQueue =
                    {}, self.customDeclarationList
                    for _,func in ipairs(tempQueue) do
                        func() --unfreeze any custom initializers.
                    end
                elseif not forceOptional then
                    forceOptional = true
                else
                    return
                end
                goto initLibraries
            end
        end
        local function declareName(name, initialValue)
            assert(type(name) == 'string')
            assert(library.moduleValueMatrix[name] == nil)
            library.moduleValueMatrix[name] =
            initialValue and { true, n = 1 }
        end
        function library:create(name, userFunc)
            assert(type(userFunc) == 'function')
            declareName(name, false)                --declare itself as a non-loaded library.
            return function()
                self:pack(name, userFunc(Require))  --pack return values to allow multiple values to be communicated.
                if self.moduleValueMatrix[name].n == 0 then
                    self:pack(name, true)           --No values were returned; therefore simply package the value as `true`
                end
            end
        end

        ---@async
        function library:declare(name)
            declareName(name, true)                 --declare itself as a loaded library.

            local co = coroutine.running()

            insert(
                    self.customDeclarationList,
                    function()
                        coroutine.resume(co)
                    end
            )
            coroutine.yield() --yields the calling function until after all currently-queued initializers have run.
        end

        local processRequirement

        ---@async
        function processRequirement(
                optional,
                requirement,
                explicitSource
        )
            if type(optional) == 'string' then
                optional, requirement, explicitSource =
                true, optional, requirement --optional requirement (processed by the __index method)
            else
                optional = false --strict requirement (processed by the __call method)
            end
            local source = explicitSource or _G

            assert(type(source)=='table')
            assert(type(requirement)=='string')

            ::reindex::
            local subSource, subReq =
            requirement:match("([\x25w_]+)\x25.(.+)") --Check if user is requiring using "table.property" syntax
            if subSource and subReq then
                source,
                requirement =
                processRequirement(subSource, source), --If the container is nil, yield until it is not.
                subReq

                if type(source)=='table' then
                    explicitSource = source
                    goto reindex --check for further nested properties ("table.property.subProperty.anyOthers").
                else
                    return --The source table for the requirement wasn't found, so disregard the rest (this only happens with optional requirements).
                end
            end
            local function loadRequirement(unpack)
                local package = rawget(source, requirement) --check if the requirement exists in the host table.
                if not package and not explicitSource then
                    if library.yieldedModuleMatrix[requirement] then
                        library.yieldedModuleMatrix[requirement]() --load module if it exists
                    end
                    package = library.moduleValueMatrix[requirement] --retrieve the return value from the module.
                    if unpack and type(package)=='table' then
                        return table.unpack(package, 1, package.n) --using unpack allows any number of values to be returned by the required library.
                    end
                end
                return package
            end

            local co, loaded

            local function checkReqs(forceOptional, printErrors)
                if not loaded then
                    loaded = loadRequirement()
                    loaded = loaded or optional and
                            (loaded==nil or forceOptional)
                    if loaded then
                        if co then coroutine.resume(co) end --resume only if it was yielded in the first place.
                        return loaded
                    elseif printErrors then
                        coroutine.resume(co, true)
                    end
                end
            end

            if not checkReqs() then --only yield if the requirement doesn't already exist.
                co = coroutine.running()
                insert(library.queuedInitializerList, checkReqs)
                if coroutine.yield() then
                    error("Missing Requirement: "..requirement) --handle the error within the user's function to get an accurate stack trace via the `try` function.
                end
            end

            return loadRequirement(true)
        end

        ---@type Requirement
        function Require.strict(name, explicitSource)
            return processRequirement(nil, name, explicitSource)
        end

        setmetatable(Require --[[@as table]], {
            __call = processRequirement,
            __index = function()
                return processRequirement
            end
        })

        local module  = createInit 'module'

        --- `OnInit.module` will only call the OnInit function if the module is required by another resource, rather than being called at a pre-
        --- specified point in the loading process. It works similarly to Go, in that including modules in your map that are not actually being
        --- required will throw an error message.
        ---@param name          string
        ---@param func          fun(require?: Initializer.Callback):any
        ---@param debugLineNum? integer
        OnInit.module = function(name, func, debugLineNum)
            if func then
                local userFunc = func
                func = function(require)
                    local co = coroutine.running()

                    library.yieldedModuleMatrix[name] =
                    function(failure)
                        library.yieldedModuleMatrix[name] = nil
                        coroutine.resume(co, failure)
                    end

                    if coroutine.yield() then
                        error("Module declared but not required: "..name)
                    end

                    return userFunc(require)
                end
            end
            module(name, func, debugLineNum)
        end
    end

    if assignLegacyAPI then --This block handles legacy code.
        ---Allows packaging multiple requirements into one table and queues the initialization for later.
        ---@deprecated
        ---@param initList string | table
        ---@param userFunc function
        function OnInit.library(initList, userFunc)
            local typeOf = type(initList)

            assert(typeOf=='table' or typeOf=='string')
            assert(type(userFunc) == 'function')

            local function caller(use)
                if typeOf=='string' then
                    use(initList)
                else
                    for _,initName in ipairs(initList) do
                        use(initName)
                    end
                    if initList.optional then
                        for _,initName in ipairs(initList.optional) do
                            use.lazily(initName)
                        end
                    end
                end
            end
            if initList.name then
                OnInit(initList.name, caller)
            else
                OnInit(caller)
            end
        end

        local legacyTable = {}

        assignLegacyAPI(legacyTable, OnInit)

        for key,func in pairs(legacyTable) do
            rawset(_G, key, func)
        end

        OnInit.final(function()
            for key in pairs(legacyTable) do
                rawset(_G, key, nil)
            end
        end)
    end

    initEverything()
end
if Debug then Debug.endFile() end
function calculateDif(buidRect, spawnRect, unit)

    local buidRectX = GetRectCenterX(buidRect)
    local buidRectY = GetRectCenterY(buidRect)

    local spawnRectX = GetRectCenterX(spawnRect)
    local spawnRectY = GetRectCenterY(spawnRect)

    local unitX = GetUnitX(unit)
    local unitY = GetUnitY(unit)
    return spawnRectX - (buidRectX - unitX), spawnRectY - (buidRectY - unitY)
end

--[[function changeAvailableUnitsForPlayers(players, units, isAvailable)
    for _, player in ipairs(players) do
        for _, unit in ipairs(units) do
            SetPlayerUnitAvailableBJ(FourCC(unit.id), isAvailable, player.id)
        end
    end
end]]

function getParentId(searchId)
    for _, unit in pairs(units_for_build) do
        if unit.id == searchId then
            return unit.parentId
        end
    end
    return nil
end
function initGame()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    createBaseAndTower()
    createMines()
end

function createBaseAndTower()
    for _, team in ipairs(all_teams) do
        CreateUnit(
                team.base.player,
                FourCC(units_special.base),
                GetRectCenterX(team.base.baseRect),
                GetRectCenterY(team.base.baseRect),
                0
        )
        CreateUnit(
                team.base.player,
                FourCC(units_special.tower),
                GetRectCenterX(team.base.towerRect),
                GetRectCenterY(team.base.towerRect),
                0
        )
    end
end

function createMines()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local unit = CreateUnit(
                    player.id,
                    FourCC(units_special.mine),
                    GetRectCenterX(player.mineRect),
                    GetRectCenterY(player.mineRect),
                    0
            )
            player.economy.mineTextTag = CreateTextTagUnitBJ(text.mineLevel .. player.economy.mineLevel, unit, 0, 10, 204, 204, 0, 0)
        end
    end
end
function initGlobalVariables()
    initAllTeamsAndPlayers()
    initUnits()
end

function initAllTeamsAndPlayers()
    game_config = {
        economy = {
            startGold = 500,
            startIncomePerSec = 10,
            firstMinePrice = 10, -- need init. now get from map
            nextMineDiffPrice = 20
        },
        spawnInterval = 30
    }
    all_teams = {
        {
            players = {
                {
                    id = Player(4),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_left_up,
                    mineRect = gg_rct_mine_left_up,
                    attackPointRect = { gg_rct_spawn_left_up, gg_rct_attack_region_p8, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(2),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_left_middle_up,
                    mineRect = gg_rct_mine_left_middle_up,
                    attackPointRect = { gg_rct_spawn_left_middle_up, gg_rct_attack_region_p7, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(0),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_left_middle,
                    mineRect = gg_rct_mine_left_middle,
                    attackPointRect = { gg_rct_spawn_left_middle, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(3),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_left_middle_down,
                    mineRect = gg_rct_mine_left_middle_down,
                    attackPointRect = { gg_rct_spawn_left_middle_down, gg_rct_attack_region_p9, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                },
                {
                    id = Player(5),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_left_down,
                    mineRect = gg_rct_mine_left_down,
                    attackPointRect = { gg_rct_spawn_left_down, gg_rct_attack_region_p10, gg_rct_attack_region_center_right, gg_rct_attack_region_p2 }
                }
            },
            spawnPlayers = { Player(15), Player(16), Player(17), Player(18), Player(19), Player(21), Player(23) },
            base = {
                player = Player(16),
                winTeam = 2,
                baseRect = gg_rct_base_left,
                towerRect = gg_rct_tower_left
            }
        },
        {
            players = {
                {
                    id = Player(8),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_right_up,
                    mineRect = gg_rct_mine_right_up,
                    attackPointRect = { gg_rct_spawn_right_up, gg_rct_attack_region_p4, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(6),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_right_middle_up,
                    mineRect = gg_rct_mine_right_middle_up,
                    attackPointRect = { gg_rct_spawn_right_middle_up, gg_rct_attack_region_p3, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(1),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_right_middle,
                    mineRect = gg_rct_mine_right_middle,
                    attackPointRect = { gg_rct_spawn_right_middle, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(7),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_right_middle_down,
                    mineRect = gg_rct_mine_right_middle_down,
                    attackPointRect = { gg_rct_spawn_right_middle_down, gg_rct_attack_region_p5, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                },
                {
                    id = Player(9),
                    economy = {
                        income = game_config.economy.startIncomePerSec,
                        minePrice = game_config.economy.firstMinePrice,
                        mineLevel = 0,
                        mineTextTag = nil,
                    },
                    buildRect = gg_rct_build_right_down,
                    mineRect = gg_rct_mine_right_down,
                    attackPointRect = { gg_rct_spawn_right_down, gg_rct_attack_region_p6, gg_rct_attack_region_center_left, gg_rct_attack_region_p1 }
                }
            },
            spawnPlayers = { Player(10), Player(11), Player(12), Player(13), Player(14), Player(20), Player(22) },
            base = {
                player = Player(12),
                winTeam = 1,
                baseRect = gg_rct_base_right,
                towerRect = gg_rct_tower_right
            }
        }
    }
end

function initUnits()
    units_for_build = {
        { id = 'h00C', parentId = 'h00A', level = 1},
        { id = 'h002', parentId = 'h00B', level = 1},
        { id = 'h004', parentId = 'h00D', level = 1},
        { id = 'h003', parentId = 'h00E', level = 1},
        { id = 'h000', parentId = 'h00F', level = 2},
        { id = 'h001', parentId = 'h00G', level = 2},
        { id = 'h007', parentId = 'h00H', level = 2},
        { id = 'h008', parentId = 'h00I', level = 2},
        { id = 'h005', parentId = 'h00J', level = 3},
        { id = 'h006', parentId = 'h00K', level = 3},
        { id = 'h009', parentId = 'h00L', level = 3},
    }
    units_special = {
        builder = 'o000',
        tower = 'o001',
        base = 'o002',
        mine = 'h00M'
    }
    abilities = {
        mine = 'A000'
    }

    text = {
        mineLevel = "Level: "
    }
end
function initMain()
    initGlobalVariables()
    initGame()
    initPlayers()
end
function initPlayers()
    setAllianceBetweenSpawnPlayers()
    setAllianceBetweenPlayers()
    setAllianceBetweenPlayersAndSpawnPlayers()
    addBuilders()
end

function setAllianceBetweenSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.spawnPlayers) do
            for _, anotherPlayer in ipairs(team.spawnPlayers) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_ALLIED_VISION)
                end
            end
        end
    end
end

function setAllianceBetweenPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            CreateFogModifierRect(player.id, FOG_OF_WAR_VISIBLE, GetPlayableMapRect(), TRUE, TRUE)
            SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, game_config.economy.startGold)
            for _, anotherPlayer in ipairs(team.players) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player.id, anotherPlayer.id, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer.id, player.id, bj_ALLIANCE_ALLIED_VISION)
                end
            end
        end
    end
end

function setAllianceBetweenPlayersAndSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, spawnPlayer in ipairs(team.spawnPlayers) do
                SetPlayerAlliance(spawnPlayer, player.id, ALLIANCE_SHARED_VISION, TRUE)
                SetPlayerAllianceStateBJ(player.id, spawnPlayer, bj_ALLIANCE_ALLIED_VISION)
                SetPlayerAllianceStateBJ(spawnPlayer, player.id, bj_ALLIANCE_ALLIED_VISION)
            end
        end
    end
end

function addBuilders()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            GetRectCenterX(player.buildRect)
            CreateUnit(
                    player.id,
                    FourCC(units_special.builder),
                    GetRectCenterX(player.buildRect),
                    GetRectCenterY(player.buildRect),
                    0
            )
        end
    end
end
OnInit(function()
    print("2")
    initMain()
    initialUI()
    initTimers()
    initTriggers()
    --changeAvailableUnitsForPlayers(all_players, all_units, TRUE)
end)

function initTimers()
    local timer = CreateTimer()
    my_func = 30
    TimerStart(timer,1,true, function()
        BlzFrameSetText(frame, "Next wave:  |cffFF0303" .. my_func .. "|r")
        my_func = my_func - 1
    end)
end
function debugTrigger()

    local trig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(trig, Player(0),"debug", true)

    TriggerAddAction(trig, function()
        SetPlayerAllianceStateBJ(Player(1), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(2), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(3), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(4), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(5), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(6), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(7), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(8), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)
        SetPlayerAllianceStateBJ(Player(9), Player(0), bj_ALLIANCE_ALLIED_ADVUNITS)

        SetPlayerAlliance(Player(10), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(11), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(12), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(13), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(14), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(15), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(16), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(17), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(18), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(19), Player(0), ALLIANCE_SHARED_VISION, TRUE)
        SetPlayerAlliance(Player(20), Player(0), ALLIANCE_SHARED_VISION, TRUE)
    end)
end
function goldExtractorTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.mine)
            end))
            TriggerAddAction(trig, function()
                local abilityIntegerId = GetSpellAbilityId()
                local ability = BlzGetUnitAbility(GetTriggerUnit(), abilityIntegerId)
                player.economy.minePrice = player.economy.minePrice + game_config.economy.nextMineDiffPrice
                player.economy.income = player.economy.income + 1
                player.economy.mineLevel = player.economy.mineLevel + 1
                BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, player.economy.minePrice)

                DestroyTextTag(player.economy.mineTextTag)
                player.economy.mineTextTag = CreateTextTagUnitBJ(text.mineLevel .. player.economy.mineLevel, GetTriggerUnit(), 0, 10, 204, 204, 0, 0)
            end)
        end
    end
end
function incomeTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)
                SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + player.income)
            end
        end
    end)
end
function initTriggers()
    incomeTrigger()
    spawnTrigger()
    moveByPointsTrigger()
    winLoseTrigger()
    goldExtractorTrigger()
    debugTrigger()
end
function moveByPointsTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for i = 1, #player.attackPointRect - 1 do
                local trig = CreateTrigger()
                TriggerRegisterTimerEventPeriodic(trig, 1.00)
                TriggerAddAction(trig, function()
                    local group = GetUnitsInRectAll(player.attackPointRect[i])
                    ForGroup(group, function ()
                        local unit = GetEnumUnit()
                        local owner = GetOwningPlayer(unit)
                        if containsValue(owner, team.spawnPlayers) then
                            if (GetUnitCurrentOrder(unit) == 0) then
                                local attackPointX, attackPointY = calculateDif(player.attackPointRect[i], player.attackPointRect[i+1], unit)
                                IssuePointOrderLoc(unit, "attack", Location(attackPointX, attackPointY))
                            end
                        end
                    end)
                    DestroyGroup(group)
                end)
            end
        end
    end
end

function containsValue(value, array)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end
function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 30.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local groupForBuild = GetUnitsInRectAll(player.buildRect)
                local group = CreateGroup()
                ForGroup(groupForBuild, function ()
                    local id = GetUnitTypeId(GetEnumUnit())
                    local parentId = getParentId(('>I4'):pack(id))
                    if parentId ~= nil then
                        local x, y = calculateDif(player.buildRect, player.attackPointRect[1], GetEnumUnit())
                        local unit = CreateUnit(getRandomSpawnPlayer(team.spawnPlayers), FourCC(parentId), x, y, 270)
                        SetUnitColor(unit, GetPlayerColor(player.id))
                        GroupAddUnit(group, unit)
                    end
                end)
                DestroyGroup(group)
                DestroyGroup(groupForBuild)
            end
            my_func = 30

        end
    end)
end

function getRandomSpawnPlayer(spawnPlayers)
    local randomIndex = math.random(#spawnPlayers)
    return spawnPlayers[randomIndex]
end
function winLoseTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == units_special.base then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    for _, player in ipairs(team.players) do
                        CustomDefeatBJ(player.id, "lose")
                    end
                    for _, player in ipairs(all_teams[team.base.winTeam].players) do
                        CustomVictoryBJ(player.id, true, true)
                    end
                end)
            end
        end)

    end
end

function initialUI()
    local fm = BlzGetFrameByName("ConsoleUIBackdrop",0)
    frame = BlzCreateFrameByType("TEXT", "MyTextFrame", fm, "", 0)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.85, 0.5)
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, 2)
end
--CUSTOM_CODE
function InitCustomPlayerSlots()
SetPlayerStartLocation(Player(0), 0)
ForcePlayerStartLocation(Player(0), 0)
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(0), false)
SetPlayerController(Player(0), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(1), 1)
ForcePlayerStartLocation(Player(1), 1)
SetPlayerColor(Player(1), ConvertPlayerColor(1))
SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(1), false)
SetPlayerController(Player(1), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(2), 2)
ForcePlayerStartLocation(Player(2), 2)
SetPlayerColor(Player(2), ConvertPlayerColor(2))
SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(2), false)
SetPlayerController(Player(2), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(3), 3)
ForcePlayerStartLocation(Player(3), 3)
SetPlayerColor(Player(3), ConvertPlayerColor(3))
SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(3), false)
SetPlayerController(Player(3), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(4), 4)
ForcePlayerStartLocation(Player(4), 4)
SetPlayerColor(Player(4), ConvertPlayerColor(4))
SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(4), false)
SetPlayerController(Player(4), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(5), 5)
ForcePlayerStartLocation(Player(5), 5)
SetPlayerColor(Player(5), ConvertPlayerColor(5))
SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(5), false)
SetPlayerController(Player(5), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(6), 6)
ForcePlayerStartLocation(Player(6), 6)
SetPlayerColor(Player(6), ConvertPlayerColor(6))
SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(6), false)
SetPlayerController(Player(6), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(7), 7)
ForcePlayerStartLocation(Player(7), 7)
SetPlayerColor(Player(7), ConvertPlayerColor(7))
SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(7), false)
SetPlayerController(Player(7), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(8), 8)
ForcePlayerStartLocation(Player(8), 8)
SetPlayerColor(Player(8), ConvertPlayerColor(8))
SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(8), false)
SetPlayerController(Player(8), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(9), 9)
ForcePlayerStartLocation(Player(9), 9)
SetPlayerColor(Player(9), ConvertPlayerColor(9))
SetPlayerRacePreference(Player(9), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(9), false)
SetPlayerController(Player(9), MAP_CONTROL_USER)
end

function InitCustomTeams()
SetPlayerTeam(Player(0), 0)
SetPlayerTeam(Player(2), 0)
SetPlayerTeam(Player(3), 0)
SetPlayerTeam(Player(4), 0)
SetPlayerTeam(Player(5), 0)
SetPlayerTeam(Player(1), 1)
SetPlayerTeam(Player(6), 1)
SetPlayerTeam(Player(7), 1)
SetPlayerTeam(Player(8), 1)
SetPlayerTeam(Player(9), 1)
SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
SetPlayerAllianceStateAllyBJ(Player(1), Player(8), true)
SetPlayerAllianceStateAllyBJ(Player(1), Player(9), true)
SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
SetPlayerAllianceStateAllyBJ(Player(6), Player(7), true)
SetPlayerAllianceStateAllyBJ(Player(6), Player(8), true)
SetPlayerAllianceStateAllyBJ(Player(6), Player(9), true)
SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
SetPlayerAllianceStateAllyBJ(Player(7), Player(6), true)
SetPlayerAllianceStateAllyBJ(Player(7), Player(8), true)
SetPlayerAllianceStateAllyBJ(Player(7), Player(9), true)
SetPlayerAllianceStateAllyBJ(Player(8), Player(1), true)
SetPlayerAllianceStateAllyBJ(Player(8), Player(6), true)
SetPlayerAllianceStateAllyBJ(Player(8), Player(7), true)
SetPlayerAllianceStateAllyBJ(Player(8), Player(9), true)
SetPlayerAllianceStateAllyBJ(Player(9), Player(1), true)
SetPlayerAllianceStateAllyBJ(Player(9), Player(6), true)
SetPlayerAllianceStateAllyBJ(Player(9), Player(7), true)
SetPlayerAllianceStateAllyBJ(Player(9), Player(8), true)
SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
SetPlayerAllianceStateVisionBJ(Player(1), Player(8), true)
SetPlayerAllianceStateVisionBJ(Player(1), Player(9), true)
SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
SetPlayerAllianceStateVisionBJ(Player(6), Player(7), true)
SetPlayerAllianceStateVisionBJ(Player(6), Player(8), true)
SetPlayerAllianceStateVisionBJ(Player(6), Player(9), true)
SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
SetPlayerAllianceStateVisionBJ(Player(7), Player(6), true)
SetPlayerAllianceStateVisionBJ(Player(7), Player(8), true)
SetPlayerAllianceStateVisionBJ(Player(7), Player(9), true)
SetPlayerAllianceStateVisionBJ(Player(8), Player(1), true)
SetPlayerAllianceStateVisionBJ(Player(8), Player(6), true)
SetPlayerAllianceStateVisionBJ(Player(8), Player(7), true)
SetPlayerAllianceStateVisionBJ(Player(8), Player(9), true)
SetPlayerAllianceStateVisionBJ(Player(9), Player(1), true)
SetPlayerAllianceStateVisionBJ(Player(9), Player(6), true)
SetPlayerAllianceStateVisionBJ(Player(9), Player(7), true)
SetPlayerAllianceStateVisionBJ(Player(9), Player(8), true)
end

function InitAllyPriorities()
SetStartLocPrioCount(0, 2)
SetStartLocPrio(0, 0, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 1, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(1, 2)
SetStartLocPrio(1, 0, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 1, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(2, 2)
SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 1, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(3, 2)
SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 1, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(4, 1)
SetStartLocPrio(4, 0, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(5, 1)
SetStartLocPrio(5, 0, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(6, 2)
SetStartLocPrio(6, 0, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 1, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(7, 2)
SetStartLocPrio(7, 0, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 1, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(8, 1)
SetStartLocPrio(8, 0, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(9, 1)
SetStartLocPrio(9, 0, 7, MAP_LOC_PRIO_HIGH)
end

function main()
SetCameraBounds(-11008.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -11776.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 12032.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 11264.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -11008.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 11264.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 12032.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -11776.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("LordaeronSummerDay")
SetAmbientNightSound("LordaeronSummerNight")
SetMapMusic("Music", true, 0)
CreateRegions()
CreateAllUnits()
InitBlizzard()
InitGlobals()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(10)
SetTeams(10)
SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
DefineStartLocation(0, -6336.0, 448.0)
DefineStartLocation(1, 7360.0, 512.0)
DefineStartLocation(2, -6336.0, 2368.0)
DefineStartLocation(3, -6336.0, -1472.0)
DefineStartLocation(4, -6336.0, 4224.0)
DefineStartLocation(5, -6336.0, -3200.0)
DefineStartLocation(6, 7296.0, 2368.0)
DefineStartLocation(7, 7296.0, -1280.0)
DefineStartLocation(8, 7232.0, 4160.0)
DefineStartLocation(9, 7296.0, -3200.0)
InitCustomPlayerSlots()
InitCustomTeams()
InitAllyPriorities()
end

