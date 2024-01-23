gg_rct_curved_team_1_attack_1_right = nil
gg_rct_curved_1_1_build = nil
gg_rct_curved_1_1_main = nil
gg_rct_curved_1_1_mine = nil
gg_rct_curved_1_1_spawn = nil
gg_rct_curved_1_1_worker = nil
gg_rct_curved_1_2_build = nil
gg_rct_curved_1_2_main = nil
gg_rct_curved_1_2_mine = nil
gg_rct_curved_1_2_spawn = nil
gg_rct_curved_1_2_worker = nil
gg_rct_curved_1_3_build = nil
gg_rct_curved_1_3_main = nil
gg_rct_curved_1_3_mine = nil
gg_rct_curved_1_3_spawn = nil
gg_rct_curved_1_3_worker = nil
gg_rct_curved_1_4_build = nil
gg_rct_curved_1_4_main = nil
gg_rct_curved_1_4_mine = nil
gg_rct_curved_1_4_spawn = nil
gg_rct_curved_1_4_worker = nil
gg_rct_curved_1_5_build = nil
gg_rct_curved_1_5_main = nil
gg_rct_curved_1_5_mine = nil
gg_rct_curved_1_5_spawn = nil
gg_rct_curved_1_5_worker = nil
gg_rct_curved_2_1_build = nil
gg_rct_curved_2_1_main = nil
gg_rct_curved_2_1_mine = nil
gg_rct_curved_2_1_spawn = nil
gg_rct_curved_2_1_worker = nil
gg_rct_curved_2_2_build = nil
gg_rct_curved_2_2_main = nil
gg_rct_curved_2_2_mine = nil
gg_rct_curved_2_2_spawn = nil
gg_rct_curved_2_2_worker = nil
gg_rct_curved_2_3_build = nil
gg_rct_curved_2_3_main = nil
gg_rct_curved_2_3_mine = nil
gg_rct_curved_2_3_spawn = nil
gg_rct_curved_2_3_worker = nil
gg_rct_curved_2_4_build = nil
gg_rct_curved_2_4_main = nil
gg_rct_curved_2_4_mine = nil
gg_rct_curved_2_4_spawn = nil
gg_rct_curved_2_4_worker = nil
gg_rct_curved_2_5_build = nil
gg_rct_curved_2_5_main = nil
gg_rct_curved_2_5_mine = nil
gg_rct_curved_2_5_spawn = nil
gg_rct_curved_2_5_worker = nil
gg_rct_curved_team_1_base = nil
gg_rct_curved_team_1_tower = nil
gg_rct_curved_team_2_base = nil
gg_rct_curved_team_2_tower = nil
gg_rct_curved_1_1_laboratory = nil
gg_rct_curved_1_2_laboratory = nil
gg_rct_curved_1_3_laboratory = nil
gg_rct_curved_1_4_laboratory = nil
gg_rct_curved_1_5_laboratory = nil
gg_rct_curved_2_1_laboratory = nil
gg_rct_curved_2_2_laboratory = nil
gg_rct_curved_2_3_laboratory = nil
gg_rct_curved_2_4_laboratory = nil
gg_rct_curved_2_5_laboratory = nil
gg_rct_curved_team_2_attack_1_left = nil
gg_rct_curved_1_1_shop = nil
gg_rct_curved_1_2_shop = nil
gg_rct_curved_1_3_shop = nil
gg_rct_curved_1_4_shop = nil
gg_rct_curved_1_5_shop = nil
gg_rct_curved_2_1_shop = nil
gg_rct_curved_2_2_shop = nil
gg_rct_curved_2_3_shop = nil
gg_rct_curved_2_4_shop = nil
gg_rct_curved_2_5_shop = nil
gg_rct_curved_1_1_image = nil
gg_rct_curved_1_2_image = nil
gg_rct_curved_1_3_image = nil
gg_rct_curved_1_4_image = nil
gg_rct_curved_1_5_image = nil
gg_rct_curved_2_1_image = nil
gg_rct_curved_2_2_image = nil
gg_rct_curved_2_3_image = nil
gg_rct_curved_2_4_image = nil
gg_rct_curved_2_5_image = nil
gg_rct_curved_team_1_addGold = nil
gg_rct_curved_team_2_addGold = nil
function InitGlobals()
end

-- After Loading string.pack & string.unpack stop working. Hence one nils them for the save.
do
    local real = InitBlizzard
    function InitBlizzard()
        real()

        -- enable the next line as soon blizzard fixed the bug in current version
        --if GetLocalizedString("REFORGED") ~= "REFORGED" then return end

        local tim  = CreateTimer()
        local trig   = CreateTrigger()
        TriggerRegisterGameEvent(trig, EVENT_GAME_SAVE)
        TriggerAddAction(trig, function()
            local backup =  string.pack
            local backup2 =  string.unpack
            string.pack = nil
            string.unpack = nil
--            print("saved")
            TimerStart(tim, 0, false, function()
                string.pack = backup
                string.unpack = backup2
--            print("backup")
            end)
        end)
        
        local trig2   = CreateTrigger()
        TriggerRegisterGameEvent(trig2, EVENT_GAME_LOADED)
        TriggerAddAction(trig2, function()
            -- prevent restoring the backups when the game is loaded
            PauseTimer(tim)
--            print("Loaded")
        end)

    end
end
 
-- in 1.31 and upto 1.32.9 PTR (when I wrote this). Frames are not correctly saved and loaded, breaking the game.
-- This runs all functions added to it with a 0s delay after the game was loaded.
FrameLoader = {
    OnLoadTimer = function ()
        for _,v in ipairs(FrameLoader) do v() end

    end
    ,OnLoadAction = function()
        TimerStart(FrameLoader.Timer, 0, false, FrameLoader.OnLoadTimer)
     end
}
function FrameLoaderAdd(func)
    if not FrameLoader.Timer then
        FrameLoader.Trigger = CreateTrigger()
        FrameLoader.Timer = CreateTimer()
        TriggerRegisterGameEvent(FrameLoader.Trigger, EVENT_GAME_LOADED)
        TriggerAddAction(FrameLoader.Trigger, FrameLoader.OnLoadAction)
    end
    table.insert(FrameLoader, func)
end
--  function IsRightClick(player)
-- is that currently a right click. Was created for the useage in Frames MOUSE_UP
-- does not work during Paused Game
do
    local real = InitBlizzard
    local data = __jarray(false)
    local frameTrigger
    function IsRightClick(player)
        return data[player]
    end
    local realPause = PauseGame
    local function frameInit()
        BlzTriggerRegisterFrameEvent(frameTrigger, BlzGetFrameByName("PauseButton", 0), FRAMEEVENT_CONTROL_CLICK)
    end
    local function PauseGame(flag)
        realPause()
        -- when the game is paused reset the lastClick Flag. This has to be done because EVENT_PLAYER_MOUSE_UP does not trigger during Pause
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do data[Player(i)] = false end
    end
    function InitBlizzard()
        real()
        frameTrigger = CreateTrigger()
        local trigger = CreateTrigger()
        for i = 0, bj_MAX_PLAYERS - 1 do
            local player = Player(i)
            TriggerRegisterPlayerEvent(trigger, player, EVENT_PLAYER_MOUSE_UP)
        end
        
        TriggerAddAction(trigger, function()
            data[GetTriggerPlayer()] = GetHandleId(BlzGetTriggerPlayerMouseButton()) == GetHandleId(MOUSE_BUTTON_TYPE_RIGHT)
        end)
        TriggerAddAction(frameTrigger, function()
            -- when the game is paused reset the lastClick Flag. This has to be done because EVENT_PLAYER_MOUSE_UP does not trigger during Pause
            for i = 0, bj_MAX_PLAYER_SLOTS - 1 do data[Player(i)] = false end
        end)
        if FrameLoaderAdd then FrameLoaderAdd(frameInit) end
    end

end
do
    local realFunc = InitBlizzard
    function InitBlizzard()
        realFunc()
        SoundNoLumber = {}
        SoundNoGold = {}
        SoundNoGold[RACE_HUMAN] = CreateSound("Sound\\Interface\\Warning\\Human\\KnightNoGold1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoGold[RACE_HUMAN], "NoGoldHuman")
        SetSoundDuration(SoundNoGold[RACE_HUMAN], 1618)
        SoundNoLumber[RACE_HUMAN] = CreateSound("Sound\\Interface\\Warning\\Human\\KnightNoLumber1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoLumber[RACE_HUMAN], "NoLumberHuman")
        SetSoundDuration(SoundNoLumber[RACE_HUMAN], 1903)
        local raceNaga = ConvertRace(11)
        SoundNoGold[raceNaga] = CreateSound("Sound\\Interface\\Warning\\Naga\\NagaNoGold1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoGold[raceNaga], "NoGoldNaga")
        SetSoundDuration(SoundNoGold[raceNaga], 2690)
        SoundNoLumber[raceNaga] = CreateSound("Sound\\Interface\\Warning\\Naga\\NagaNoLumber1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoLumber[raceNaga], "NoLumberNaga")
        SetSoundDuration(SoundNoLumber[raceNaga], 2011)
        SoundNoGold[RACE_ORC] = CreateSound("Sound\\Interface\\Warning\\Orc\\GruntNoGold1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoGold[RACE_ORC], "NoGoldOrc")
        SetSoundDuration(SoundNoGold[RACE_ORC], 1450)
        SoundNoLumber[RACE_ORC] = CreateSound("Sound\\Interface\\Warning\\Orc\\GruntNoLumber1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoLumber[RACE_ORC], "NoLumberOrc")
        SetSoundDuration(SoundNoLumber[RACE_ORC], 1219)
        SoundNoGold[RACE_NIGHTELF] = CreateSound("Sound\\Interface\\Warning\\NightElf\\SentinelNoGold1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoGold[RACE_NIGHTELF], "NoGoldNightElf")
        SetSoundDuration(SoundNoGold[RACE_NIGHTELF], 1229)
        SoundNoLumber[RACE_NIGHTELF] = CreateSound("Sound\\Interface\\Warning\\NightElf\\SentinelNoLumber1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoLumber[RACE_NIGHTELF], "NoLumberNightElf")
        SetSoundDuration(SoundNoLumber[RACE_NIGHTELF], 1454)
        SoundNoGold[RACE_UNDEAD] = CreateSound("Sound\\Interface\\Warning\\Undead\\NecromancerNoGold1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoGold[RACE_UNDEAD], "NoGoldUndead")
        SetSoundDuration(SoundNoGold[RACE_UNDEAD], 2005)
        SoundNoLumber[RACE_UNDEAD] = CreateSound("Sound\\Interface\\Warning\\Undead\\NecromancerNoLumber1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(SoundNoLumber[RACE_UNDEAD], "NoLumberUndead")
        SetSoundDuration(SoundNoLumber[RACE_UNDEAD], 2005)
    end
end
function CreateSimpleTooltip(frame, text)
    -- this FRAME is important when the Box is outside of 4:3 it can be limited to 4:3.
    local toolTipParent = BlzCreateFrameByType("FRAME", "", frame, "", 0)
    local toolTipBox = BlzCreateFrame("EscMenuControlBackdropTemplate", toolTipParent, 0, 0)
    local toolTip = BlzCreateFrame("TasButtonTextTemplate", toolTipBox, 0, 0)
    BlzFrameSetPoint(toolTip, FRAMEPOINT_BOTTOM, frame, FRAMEPOINT_TOP, 0, 0.008)
    BlzFrameSetPoint(toolTipBox, FRAMEPOINT_TOPLEFT, toolTip, FRAMEPOINT_TOPLEFT, -0.008, 0.008)
    BlzFrameSetPoint(toolTipBox, FRAMEPOINT_BOTTOMRIGHT, toolTip, FRAMEPOINT_BOTTOMRIGHT, 0.008, -0.008)
    BlzFrameSetText(toolTip, text)
    BlzFrameSetTooltip(frame, toolTipParent)
    return toolTip
end
-- a small snipet that allows to get the last data of the item stacking event.
-- function GetItemStackingEventData()
-- returns Trigger exeCount, item gaining charges, charges gained, item providing charges
-- the Trigger exeCount allows to know, if an event happened at all.
-- Before adding the item get the current count, add the item and request again, if the count differs a stacking happened
do
    local realFunc = InitBlizzard
    local trigger, itemSource, itemTarget, charges

    function GetItemStackingEventData()
        return GetTriggerExecCount(trigger), itemTarget, charges, itemSource
    end
    UsesReforgedItemStacking = false
    function InitBlizzard()
        realFunc()
        if GetLocalizedString("REFORGED") ~= "REFORGED" then
            trigger = CreateTrigger()
            TriggerAddAction(trigger, function()
                itemTarget = BlzGetStackingItemTarget()
                itemSource = BlzGetStackingItemSource()
                charges = GetItemCharges(BlzGetStackingItemTarget()) - BlzGetStackingItemTargetPreviousCharges()
            end)
            TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_STACK_ITEM)
            
            -- try to evoke it now!
            local unit = CreateUnit(Player(bj_ALLIANCE_NEUTRAL), FourCC("Hpal"), 0, 0, 0)
            UnitAddAbility(unit, FourCC("AInv"))
            local i1 = UnitAddItemById(unit, FourCC("pghe"))
            local i2 = UnitAddItemById(unit, FourCC("pghe"))

            RemoveUnit(unit)
            RemoveItem(i2)
            RemoveItem(i1)
            unit = nil
            i1 = nil
            i2 = nil

            -- remember the result
            UsesReforgedItemStacking = GetTriggerExecCount(trigger) > 0
            -- if it was not evoked destroy the trigger
            if not UsesReforgedItemStacking then
                DestroyTrigger(trigger)
            end
        end
    end
end
-- Simple version, does not allow to create one fusionItem by multiple ways.
TasItemFusion = {
    Fusions = {Count = 0}, -- possible fusions that can be done
    UsedIn = {}, -- allows to find Fusions from a Mat
    BuiltWay = {}, -- find Fusions from the result
    Player = {}
}
for index = 0, GetBJMaxPlayerSlots() - 1 do TasItemFusion.Player[Player(index)] = {UseAble = {Count = 0, ByType = {}}} end
function TasItemFusionAdd(result, ...)
    if type(result) == "string" then result = FourCC(result) end
    local object = {Result = result, Mats = {}}
    TasItemFusion.Fusions.Count = TasItemFusion.Fusions.Count + 1
    TasItemFusion.Fusions[TasItemFusion.Fusions.Count] = object
    TasItemFusion.BuiltWay[result] = object    

    for index, value in ipairs({...}) do
        if type(value) == "string" then value = FourCC(value) end
        table.insert(object.Mats, value)
        if not TasItemFusion.UsedIn[value] then 
            TasItemFusion.UsedIn[value] = {}
        end
        if not TasItemFusion.UsedIn[value][object] then
            TasItemFusion.UsedIn[value][object] = true
            table.insert(TasItemFusion.UsedIn[value], object)
        end
        TasItemGetCost(value)
    end
    TasItemGetCost(result)
end

function TasItemFusionGetUseableItems(player, units, checkOwner)
    -- give the units which inventory is useable
    local useable = TasItemFusion.Player[player].UseAble
    local unit, item
    useable.ByType = __jarray(0)
    useable.Count = 0
    ForGroup(units, function()
        unit = GetEnumUnit()
        for index = 0, 5 do
            item = UnitItemInSlot(unit, index)
            if item and (not checkOwner or (GetItemPlayer(item) == player or GetItemPlayer(item) == Player(PLAYER_NEUTRAL_PASSIVE))) then
                useable.Count = useable.Count + 1
                useable[useable.Count] = item
                useable.ByType[GetItemTypeId(item)] = useable.ByType[GetItemTypeId(item)] + 1
            end
        end
    end)
    return useable
end

-- returns a list of material that can be used for result.
function TasItemFusionGetUseableMaterial(useAble, result, list, quick)
    if not list then list = {Count = 0} end
    if type(result) == "string" then result = FourCC(result) end
    local found, item
    for index, value in ipairs(TasItemFusion.BuiltWay[result].Mats) do
        --print(index, GetObjectName(value))
        found = false
        -- in quick mode the items itself do not matter, only the itemCodes. Mostly used for displaying things without removing the items.
        if quick then
            if useable.ByType[value] > list[value] then
                list[value] = list[value] + 1
                list.Count = list.Count + 1
                list[list.Count] = value
                found = true
            end
        else
            for i = 1, useAble.Count do 
                item = useAble[i]
                if GetItemTypeId(item) == value and not list[item] then
                    list[item] = true
                    list.Count = list.Count + 1
                    list[list.Count] = item
                    found = true
                    break
                end
            end
        end
        if not found and TasItemFusion.BuiltWay[value] then
            TasItemFusionGetUseableMaterial(useAble, value, list, quick)
        end
    end
    return list
end

-- returns the total gold cost and the used material from useAble
function TasItemFusionCalc(useAble, result, quick)
    if type(result) == "string" then result = FourCC(result) end
    -- find all useable fusion material
    local list = TasItemFusionGetUseableMaterial(useAble, result, quick)
    local gold, lumber = TasItemGetCost(result)
    local gold2, lumber2
    -- reduce total gold cost by the useables
    for _, item in ipairs(list) do
        -- in quick mode the items itself do not matter, only the itemCodes
        if quick then
            gold2, lumber2 = TasItemGetCost(item)
        else
            gold2, lumber2 = TasItemGetCost(GetItemTypeId(item))
        end
        gold = gold - gold2
        lumber = lumber - lumber2
    end
    return gold, lumber, list
end


-- returns a table of the material missing
-- call it that way TasItemFusionGetMissingMaterial(useAble, result)
function TasItemFusionGetMissingMaterial(useAble, result, used, missing)
    if not used then used = {Count = 0} end
    if not missing then missing = {Count = 0} end
    if type(result) == "string" then result = FourCC(result) end
    local found, item
    for index, value in ipairs(TasItemFusion.BuiltWay[result].Mats) do
        --print(index, GetObjectName(value))
        found = false
        for i = 1, useAble.Count do 
            item = useAble[i]
            if GetItemTypeId(item) == value and not used[item] then
                used[item] = true
                used.Count = used.Count + 1
                used[used.Count] = item
                found = true
                break
            end
        end
        if not found and not missing[value] then
            missing.Count = missing.Count + 1
            missing[missing.Count] = value
            missing[value] = true
            if TasItemFusion.BuiltWay[value] then
                TasItemFusionGetMissingMaterial(useAble, value, used, missing)
            end
        end
    end
    return missing
end
-- function TasItemCaclCost(...)
-- calculates the gold and lumbercost of given itemCodes, also accpets strings and a bunch of strings.
-- this will created the items, trigger buy item events + no target order events

-- function TasItemGetCost(itemCode)
-- returns the gold and lumber cost of that item
-- gold, lumber = TasItemGetCost(itemCode)

-- function TasItemCalcDestroy()
do
    local realFunc = InitBlizzard
    function InitBlizzard()
        realFunc()
        local shopOwner = Player(bj_PLAYER_NEUTRAL_EXTRA)
        local shop = CreateUnit(shopOwner, FourCC('nmrk'), 700, -2000, 0)
        local shopRect = Rect(0 , 0, 1000, 1000)
        --print(GetHandleId(shop))
        MoveRectTo(shopRect, GetUnitX(shop), GetUnitY(shop))
        UnitAddAbility(shop, FourCC('AInv'))
        ShowUnit(shop, false)
        IssueNeutralTargetOrder(shopOwner, shop, "smart", shop)

        local TasItemData = {
          --Counter = 0,
          Test = {Counter = 0}
       }
       function TasItemCalcDestroy()
            EnumItemsInRect(shopRect, nil, function()
                RemoveItem(GetEnumItem())
            end)
            ShowUnit(shop, true)
            RemoveUnit(shop)
            RemoveRect(shopRect)
            TasItemData.Test = nil
        end
       local function Start()
          --print("Start", GetObjectName(TasItemData.Test[1]))
            local itemCode = TasItemData.Test[1]
            AddItemToStock(shop, itemCode, 1, 1)
            SetPlayerState(shopOwner, PLAYER_STATE_RESOURCE_GOLD, 99999999)
            SetPlayerState(shopOwner, PLAYER_STATE_RESOURCE_LUMBER, 99999999)
            local gold = GetPlayerState(shopOwner, PLAYER_STATE_RESOURCE_GOLD)
            local lumber = GetPlayerState(shopOwner, PLAYER_STATE_RESOURCE_LUMBER)
            IssueNeutralImmediateOrderById(shopOwner, shop, itemCode)
            local item = CreateItem(itemCode, 0, 0)
            TasItemData[itemCode] = {
                Gold = gold - GetPlayerState(shopOwner, PLAYER_STATE_RESOURCE_GOLD),
                Lumber = lumber - GetPlayerState(shopOwner, PLAYER_STATE_RESOURCE_LUMBER),
                Charge = GetItemCharges(item)
            }
            RemoveItem(item)
            item = nil
            RemoveItemFromStock(shop, itemCode)
            -- testing order does not matter much, simple reindex
            TasItemData.Test[1] = TasItemData.Test[TasItemData.Test.Counter]
            TasItemData.Test.Counter = TasItemData.Test.Counter - 1
            
            if TasItemData.Test.Counter > 0 then
                Start()
            end
            EnumItemsInRect(shopRect, nil, function()
                RemoveItem(GetEnumItem())
            end)
       end
       
        function TasItemCaclCost(...)
            local item
            for index, itemCode in ipairs({...}) do
                if type(itemCode) == "string" then itemCode = FourCC(itemCode) end
                -- if there is already data for that itemcode, skip it
                if not TasItemData[itemCode] then
                    -- is this a valid itemCode? Create it, if that fails skip testing it
                    item = CreateItem(itemCode, 0, 0)
                    if GetHandleId(item) > 0 then
                        RemoveItem(item)
                        TasItemData.Test.Counter = TasItemData.Test.Counter + 1
                        TasItemData.Test[TasItemData.Test.Counter] = itemCode
                    end
                end
            end
            if TasItemData.Test.Counter > 0 then Start() end
            item = nil
        end
        
        function TasItemGetCost(itemCode)
            if type(itemCode) == "string" then itemCode = FourCC(itemCode) end
            if not TasItemData[itemCode] then TasItemCaclCost(itemCode) end
            if TasItemData[itemCode] then 
                return TasItemData[itemCode].Gold, TasItemData[itemCode].Lumber, TasItemData[itemCode].Charge
            else
                return 0, 0, 0
            end
        end
    end
end

--[[
    ToggleIconButton 1.3 (TIS) by Tasyen

function CreateToggleIconButton(parent, valueOn, text, textureOn[, mode, textureOff, textOff])
 create an IconButton that swaps between 2 states. (0 and valueOn, visualy shown by textureOff/textureOn)
 the IconButton starts with 0 & textureOff
 textureOff is automatically calced when it is nil
 mode should be 0, 1 or - 1 when not set it is 0. see ToggleIconButton.MODE_DEFAULT
 You can add an Action function with object.Action = function(object, player, enabled)
 If you use Textures with Transparency one has to object.Blend = true, otherwise it is displayed wrongly
 when the mode is -1 then the function will only run for the clicking Player. object is the active ToggleIconButtonTable and player the clicking player.
 returns the table, returnValue.Button is the ButtonFrame

function ToggleIconButtonSetValue(object, player[, enable])
 can be used to set the current value to x (true, false) or to toggle the current value(nil)
 will not call the object's Action.

function ToggleIconButtonGetValue(object, player)
--]]

ToggleIconButton = {
    DefaultSizeX = 0.024,
    DefaultSizeY = 0.024,
}
ToggleIconButton.MODE_DEFAULT = 0 -- the visual is local only.
ToggleIconButton.MODE_SHARED = 1 -- is the same for all players.
ToggleIconButton.MODE_LOCAL = -1 -- Visual and Action are for the clicking player only


function ToggleIconButton.GetKey(object, player)
    if object.Mode == ToggleIconButton.MODE_SHARED then
        return 0
    else
        return player
    end
end

function ToggleIconButtonSetValue(object, player, enable)
    local key = ToggleIconButton.GetKey(object, player)
    -- wana toggle?
    if enable == nil then
        --currently off?
        object.Value[key] = not object.Value[key]
    -- specific state
    else
        object.Value[key] = enable
    end

    -- update visual
    if object.Mode == ToggleIconButton.MODE_SHARED or GetLocalPlayer() == player then
        if not object.Value[key] then
            BlzFrameSetTexture(object.Icon, object.TextureOff, 0, object.Blend)
            BlzFrameSetTexture(object.IconPushed, object.TextureOff, 0, object.Blend)
            BlzFrameSetText(object.ToolTip, object.TextOff)
        else
            BlzFrameSetTexture(object.Icon, object.Texture, 0, object.Blend)
            BlzFrameSetTexture(object.IconPushed, object.Texture, 0, object.Blend)
            BlzFrameSetText(object.ToolTip, object.Text)
        end
    end
end

function ToggleIconButtonGetValue(object, player)
    if object.Value[ToggleIconButton.GetKey(object, player)] then
        return object.ValueOn
    else
        return 0
    end
end

function getDisabledIcon(icon)
    --ReplaceableTextures\CommandButtons\BTNHeroPaladin.tga -> ReplaceableTextures\CommandButtonsDisabled\DISBTNHeroPaladin.tga
    return string.gsub(icon , "CommandButtons\\BTN", "CommandButtonsDisabled\\DISBTN")
end


function CreateToggleIconButton(parent, valueOn, text, textureOn, mode, textureOff, textOff)
    if not textureOff then textureOff = getDisabledIcon(textureOn) end
    if not textOff then textOff = text end
    if not mode then mode = ToggleIconButton.MODE_DEFAULT end

    if not ToggleIconButton.Trigger then
        ToggleIconButton.Sound = CreateSound("Sound\\Interface\\MouseClick1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(ToggleIconButton.Sound, "InterfaceClick")
        SetSoundDuration(ToggleIconButton.Sound, 239)
        BlzLoadTOCFile("war3mapImported\\Templates.toc")
        ToggleIconButton.Trigger = CreateTrigger()
        ToggleIconButton.TriggerAction = TriggerAddAction(ToggleIconButton.Trigger, function()
            xpcall(function()
            local frame = BlzGetTriggerFrame()
            local object = ToggleIconButton[frame]
            local player = GetTriggerPlayer()
            --StartSoundForPlayerBJ(player, ToggleIconButton.Sound)
            --ToggleIconButtonSetValue(object, GetTriggerPlayer(), object.Value ~= object.ValueOn)
            ToggleIconButtonSetValue(object, player)
            if object.Action and (object.Mode ~= ToggleIconButton.MODE_LOCAL or GetLocalPlayer() == player) then object.Action(object, player, ToggleIconButtonGetValue(object, player) == object.ValueOn) end
            -- remove focus
            BlzFrameSetEnable(frame, false)
            BlzFrameSetEnable(frame, true)
            end, print)
        end)
    end
    
    local frame = BlzCreateFrame("TasItemShopCatButton", parent, 0, 0)
    local backdrop = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
    local backdropPush = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
    BlzFrameSetSize(frame, ToggleIconButton.DefaultSizeX, ToggleIconButton.DefaultSizeY)
    BlzFrameSetTexture(backdrop, textureOff, 0, false)
    BlzFrameSetTexture(backdropPush, textureOff, 0, false)
    
    BlzTriggerRegisterFrameEvent(ToggleIconButton.Trigger, frame, FRAMEEVENT_CONTROL_CLICK)

    local object = {
        Button = frame,
        Icon = backdrop,
        IconPushed = backdropPush,
        Mode = mode,
        Value = __jarray(false),
        ValueOn = valueOn,
        Texture = textureOn,
        TextureOff = textureOff,
        Text = text,
        TextOff = textOff,
        ToolTip = CreateSimpleTooltip(frame, textOff)
    }

    ToggleIconButton[frame] = object
    
    return object
end

--[[
    ToggleIconButtonGroup 1.4 (TIS) by Tasyen
uses ToggleIconButton by Tasyen

ToggleIconButtonGroup is a addon for ToggleIconButton. It combines multiple ones into a shared entity, the values for Buttons used in ToggleIconButtonGroup should be unique power2.

function CreateToggleIconButtonGroup(multiSelection, action, ...)
    create a Group with action happening when any button is toggled considering the sharedRules set by the individual buttons.
    multiSelection(false) unselect others before setting x, can also be changed later with groupObject.MultiSelection[player] = true/false.
    A ToggleIconButton inside a ToggleIconButtonGroup can not have a custom Action, because it is used by the ToggleIconButtonGroup, but the Group also supports an Action.
    afer action you can give any amount of ToggleIconButtonTables
    The actionfunction provides this args function(groupObject, buttonObject, player, groupValue)

function ToggleIconButtonGroupGetValue(groupObject, player)
function ToggleIconButtonGroupAddButton(groupObject, buttonObject)
function ToggleIconButtonGroupSetModeButton(groupObject[, buttonObject])
    define a ToggleIconButton as multiSelection mode toggle, this uses the Buttons ToggleIconButton Action.
function ToggleIconButtonGroupModeButton(groupObject, parent)
    Creates a default ModeButton for groupObject
    Returns the buttonObject of the new ModeButton
    The new Button still has to be placed
function ToggleIconButtonGroupClearButton(groupObject[, parent, iconPath])
    When the group does not have a Clear Button, then this creates a BUTTON that clears selection when clicked.
    Returns the clear Button-Frame of the group.
    The Button has to be placed after it is created.
function ToggleIconButtonGroupClear(groupObject, player)

--]]

ToggleIconButtonGroup = {}
ToggleIconButtonGroup.Action = function(object, player, enabled)
    local groupObject = object.Group
    if not groupObject.MultiSelection[player] then
        
        local oldValue = ToggleIconButtonGroupGetValue(groupObject, player)
        ToggleIconButtonGroupClear(groupObject, player)
        if enabled or oldValue ~= 0 then
            ToggleIconButtonSetValue(object, player, true)
        end
    end
    groupObject.Action(groupObject, object, player, ToggleIconButtonGroupGetValue(groupObject, player))
end


ToggleIconButtonGroup.ActionMode = function(object, player, enabled)
    object.Group.MultiSelection[player] = enabled
end

function ToggleIconButtonGroupClear(groupObject, player)
    for index, value in ipairs(groupObject) do
        ToggleIconButtonSetValue(value, player, false)
    end
end

function ToggleIconButtonGroupGetValue(groupObject, player)
    local returnValue = 0
    for index, value in ipairs(groupObject) do
        returnValue = returnValue + ToggleIconButtonGetValue(value, player)
    end
    return returnValue
end

function ToggleIconButtonGroupAddButton(groupObject, buttonObject)
    table.insert(groupObject, buttonObject)
    buttonObject.Action = ToggleIconButtonGroup.Action
    buttonObject.Group = groupObject
    BlzTriggerRegisterFrameEvent(ToggleIconButtonGroup.RightClick, buttonObject.Button, FRAMEEVENT_MOUSE_UP)
end

function ToggleIconButtonGroupSetModeButton(groupObject, buttonObject)
    groupObject.ModeButton = buttonObject
    buttonObject.Action = ToggleIconButtonGroup.ActionMode
    buttonObject.Group = groupObject
    return buttonObject    
end

function ToggleIconButtonGroupModeButton(groupObject, parent)
    if groupObject.ModeButton then return groupObject.ModeButton end
    if not parent then parent = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0) end
    local buttonObject = ToggleIconButtonGroupSetModeButton(groupObject, CreateToggleIconButton(parent, 1, "MultiSelection", "ui\\widgets\\battlenet\\bnet-mainmenu-customteam-up", nil, "UI\\Widgets\\Glues\\GlueScreen-ROC-EditionButton-up", "SingleSelection"))
    -- start with multiselection mode enabled?
    for index = 0, bj_MAX_PLAYERS - 1 do ToggleIconButtonSetValue(groupObject.ModeButton, Player(index), groupObject.MultiSelection[Player(index)]) end
    return buttonObject
end


function ToggleIconButtonGroupClearButton(groupObject, parent, iconPath)
    -- only one clearButton
    if not groupObject.ClearButton then
        -- default optional values
        if not parent then parent = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0) end
        if not iconPath then iconPath = "ReplaceableTextures\\CommandButtons\\BTNCancel" end

        local button = BlzCreateFrame("TasItemShopCatButton", parent, 0, 0)
        local buttonIcon = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
        local buttonIconPushed = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
        BlzFrameSetSize(button, ToggleIconButton.DefaultSizeX, ToggleIconButton.DefaultSizeY)
        BlzFrameSetTexture(buttonIcon, "ReplaceableTextures\\CommandButtons\\BTNCancel", 0, false)
        BlzFrameSetTexture(buttonIconPushed, "ReplaceableTextures\\CommandButtons\\BTNCancel", 0, false)
        CreateSimpleTooltip(button, "Clear")
        ToggleIconButtonGroup[button] = groupObject
        groupObject.ClearButton = button
        groupObject.ClearButtonIcon = buttonIcon
        if not ToggleIconButtonGroup.ClearTrigger then
            ToggleIconButtonGroup.ClearTrigger = CreateTrigger()
            ToggleIconButtonGroup.ClearTriggerAction = TriggerAddAction(ToggleIconButtonGroup.ClearTrigger, function()
                local button = BlzGetTriggerFrame()
                local groupObject = ToggleIconButtonGroup[button]
                local player = GetTriggerPlayer()
                ToggleIconButtonGroupClear(groupObject, player)
                -- remove focus
                BlzFrameSetEnable(button, false)
                BlzFrameSetEnable(button, true)
                groupObject.Action(groupObject, nil, player, ToggleIconButtonGroupGetValue(groupObject, player))
            end)
        end
        BlzTriggerRegisterFrameEvent(ToggleIconButtonGroup.ClearTrigger, button, FRAMEEVENT_CONTROL_CLICK)
        return button
    else
        return groupObject.ClearButton
    end
end

function CreateToggleIconButtonGroup(multiSelection, action, ...)
    if not ToggleIconButtonGroup.RightClick then
        ToggleIconButtonGroup.RightClick = CreateTrigger()
        TriggerAddAction(ToggleIconButtonGroup.RightClick, function()
            local player = GetTriggerPlayer()
            local frame = BlzGetTriggerFrame()
            if IsRightClick(player) then
                local buttonObject = ToggleIconButton[frame]
                local groupObject = buttonObject.Group
                StartSoundForPlayerBJ(player, ToggleIconButton.Sound)
                ToggleIconButtonGroupClear(groupObject, player)
                ToggleIconButtonSetValue(buttonObject, player, true)
                groupObject.Action(groupObject, buttonObject, player, ToggleIconButtonGroupGetValue(groupObject, player))
            end
        end)
    end
    local object = {MultiSelection = __jarray(multiSelection), Action = action}
    for index, value in ipairs({...})  do ToggleIconButtonGroupAddButton(object, value) end
    return object
end

--[[
TasButtonList10b by Tasyen

function CreateTasButtonListEx(buttonName, cols, rows, parent, buttonAction[, rightClickAction, updateAction, searchAction, filterAction, asyncButtonAction, asyncRightClickAction, colGap, rowGap])
 create a new List
 parent is the container of this Frame it will attach itself to its TOP.
 buttonAction is the function that executes when an option is clicked. args: (clickedData, buttonListObject, dataIndex)
 rightClickAction is the function that executes when an option is rightClicked. args: (clickedData, buttonListObject, dataIndex)
 when your data are object Editor object-RawCodes (but not buffs) then updateAction & searchAction use a default one handling them.
 updateAction runs for each Button and is used to set the diplayed content. args:(frameObject, data)
    frameObject.Button
    frameObject.ToolTipFrame
    frameObject.ToolTipFrameIcon
    frameObject.ToolTipFrameName
    frameObject.ToolTipFrameSeperator
    frameObject.ToolTipFrameText

    frameObject.Icon
    frameObject.Text
    frameObject.IconGold
    frameObject.TextGold
    frameObject.IconLumber
    frameObject.TextLumber
    TasButtonList[frameObject] => buttonListObject

    data is one entry of the TasButtonLists Data-Array.

 searchAction is a function that returns true if the current data matches the searchText. Args: (data, searchedText, buttonListObject)
 filterAction is meant to be used when one wants an addtional non text based filtering, with returning true allowing data or false rejecting it. Args: (data, buttonListObject, isTextSearching)
 searchAction , udateAction & filterAction are async this functions should not do anything that alters the game state/flow.
function CreateTasButtonList(buttonCount, parent, buttonAction[, updateAction, searchAction, filterAction])
    wrapper for CreateTasButtonListEx, 1 col, buttonCount rows.
function CreateTasButtonListV2(rowCount, parent, buttonAction[, updateAction, searchAction, filterAction])
    wrapper for CreateTasButtonListEx, 2 Buttons each Row, takes more Height then the other Versions
function CreateTasButtonListV3(rowCount, parent, buttonAction[, updateAction, searchAction, filterAction])
    wrapper for CreateTasButtonListEx, 3 Buttons each Row, only Icon, and Costs

function TasButtonListClearData(buttonListObject[, player])
    remove all data
function TasButtonListRemoveData(buttonListObject, data[, player])
    search for data and remove it
function TasButtonListAddData(buttonListObject, data[, player])
    add data for one Button
function TasButtonListCopyData(writeObject, readObject[, player])
    writeObject uses the same data as readObject and calls UpdateButtonList.
    The copier writeObject still has an own filtering and searching.
function UpdateTasButtonList(buttonListObject)
    update the displayed Content should be done after Data was added or removed was used.
TasButtonListSearch(buttonListObject[, text])
    The buttonList will search it's data for the given text, if nil is given as text it will search for what the user currently has in its box.
    This will also update the buttonList
--]]

TasButtonList = {}

do
    local function reload()
        BlzLoadTOCFile("war3mapimported\\TasButtonList.toc")
    end
    local realFunc = InitBlizzard
    function InitBlizzard()
        realFunc()
        reload()
        if FrameLoaderAdd then FrameLoaderAdd(reload) end

        TasButtonList.SyncTrigger = CreateTrigger()
        TasButtonList.SyncTriggerAction = TriggerAddAction(TasButtonList.SyncTrigger, function()
            xpcall(function()
            local buttonListObject = TasButtonList[BlzGetTriggerFrame()]
            local dataIndex = math.tointeger(BlzGetTriggerFrameValue())

            if buttonListObject.ButtonAction then
                -- call the wanted action, 1 the current Data
                buttonListObject.ButtonAction(buttonListObject.Data[GetTriggerPlayer()][dataIndex], buttonListObject, dataIndex)
            end
            UpdateTasButtonList(buttonListObject)
            end,print)
        end)

        TasButtonList.SyncTriggerRightClick = CreateTrigger()
        TasButtonList.SyncTriggerRightClickAction = TriggerAddAction(TasButtonList.SyncTriggerRightClick, function()
            xpcall(function()
            local buttonListObject = TasButtonList[BlzGetTriggerFrame()]
            local dataIndex = math.tointeger(BlzGetTriggerFrameValue())

            if buttonListObject.RightClickAction then
                -- call the wanted action, 1 the current Data
                buttonListObject.RightClickAction(buttonListObject.Data[GetTriggerPlayer()][dataIndex], buttonListObject, dataIndex)
            end
            UpdateTasButtonList(buttonListObject)
            end,print)
        end)

        TasButtonList.RightClickSound = CreateSound("Sound\\Interface\\MouseClick1.wav", false, false, false, 10, 10, "")
        SetSoundParamsFromLabel(TasButtonList.RightClickSound, "InterfaceClick")
        SetSoundDuration(TasButtonList.RightClickSound, 239)

        -- handles the clicking
        TasButtonList.ButtonTrigger = CreateTrigger()
        TasButtonList.ButtonTriggerAction = TriggerAddAction(TasButtonList.ButtonTrigger, function()
            local frame = BlzGetTriggerFrame()
            local buttonIndex = TasButtonList[frame].Index
            local buttonListObject = TasButtonList[TasButtonList[frame]]
            local dataIndex = buttonListObject.DataFiltered[buttonListObject.ViewPoint + buttonIndex]
            BlzFrameSetEnable(frame, false)
            BlzFrameSetEnable(frame, true)
            if GetLocalPlayer() == GetTriggerPlayer() then
                if buttonListObject.AsyncButtonAction then
                    buttonListObject.AsyncButtonAction(buttonListObject, buttonListObject.Data[GetLocalPlayer()][R2I(dataIndex)], frame)
                end
                BlzFrameSetValue(buttonListObject.SyncFrame, dataIndex)
            end
        end)

        -- handles the clicking
        TasButtonList.ButtonTriggerRightClick = CreateTrigger()
        TasButtonList.ButtonTriggerRightClickAction = TriggerAddAction(TasButtonList.ButtonTriggerRightClick, function()
            local frame = BlzGetTriggerFrame()
            local buttonIndex = TasButtonList[frame].Index
            local buttonListObject = TasButtonList[TasButtonList[frame]]
            local dataIndex = buttonListObject.DataFiltered[buttonListObject.ViewPoint + buttonIndex]
            if IsRightClick(GetTriggerPlayer()) and GetLocalPlayer() == GetTriggerPlayer() then
                if buttonListObject.AsyncRightClickAction then
                    buttonListObject.AsyncRightClickAction(buttonListObject, buttonListObject.Data[GetLocalPlayer()][R2I(dataIndex)], frame)
                end
                StartSound(TasButtonList.RightClickSound)
                BlzFrameSetValue(buttonListObject.SyncFrameRightClick, dataIndex)
            end
        end)

        TasButtonList.SearchTrigger = CreateTrigger()
        TasButtonList.SearchTriggerAction = TriggerAddAction(TasButtonList.SearchTrigger, function()
            TasButtonListSearch(TasButtonList[BlzGetTriggerFrame()], BlzFrameGetText(BlzGetTriggerFrame()))
        end)

        -- scrolling while pointing on Buttons
        TasButtonList.ButtonScrollTrigger = CreateTrigger()
        TasButtonList.ButtonScrollTriggerAction = TriggerAddAction(TasButtonList.ButtonScrollTrigger, function()
            local buttonListObject = TasButtonList[TasButtonList[BlzGetTriggerFrame()]]
            local frame = buttonListObject.Slider
            if GetLocalPlayer() == GetTriggerPlayer() then
                if BlzGetTriggerFrameValue() > 0 then
                    BlzFrameSetValue(frame, BlzFrameGetValue(frame) + buttonListObject.SliderStep)
                else
                    BlzFrameSetValue(frame, BlzFrameGetValue(frame) - buttonListObject.SliderStep)
                end
            end
        end)

        -- scrolling while pointing on slider aswell as calling
        TasButtonList.SliderTrigger = CreateTrigger()
        TasButtonList.SliderTriggerAction = TriggerAddAction(TasButtonList.SliderTrigger, function()
            local buttonListObject = TasButtonList[BlzGetTriggerFrame()]
            local frame = BlzGetTriggerFrame()
            if GetLocalPlayer() == GetTriggerPlayer() then
                if BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_WHEEL then
                    if BlzGetTriggerFrameValue() > 0 then
                        BlzFrameSetValue(frame, BlzFrameGetValue(frame) + buttonListObject.SliderStep)
                    else
                        BlzFrameSetValue(frame, BlzFrameGetValue(frame) - buttonListObject.SliderStep)
                    end
                else
                    -- when there is enough data use viewPoint. the Viewpoint is reduced from the data to make top being top.
                    if buttonListObject.DataFiltered.Count > buttonListObject.Frames.Count then
                        buttonListObject.ViewPoint = buttonListObject.DataFiltered.Count - math.tointeger(BlzGetTriggerFrameValue())
                    else
                        buttonListObject.ViewPoint = 0
                    end
                    UpdateTasButtonList(buttonListObject)
                end
                if buttonListObject.SliderText then
                    local min = math.tointeger(buttonListObject.DataFiltered.Count - BlzFrameGetValue(frame))
                    local max = math.tointeger(buttonListObject.DataFiltered.Count - buttonListObject.Frames.Count)
                    BlzFrameSetText(buttonListObject.SliderText, min .. "/" .. max )
                end
            end
        end)
    end
end
--runs once for each button shown
function UpdateTasButtonListDefaultObject(frameObject, data)
    BlzFrameSetTexture(frameObject.Icon, BlzGetAbilityIcon(data), 0, false)
    BlzFrameSetText(frameObject.Text, GetObjectName(data))

    BlzFrameSetTexture(frameObject.ToolTipFrameIcon, BlzGetAbilityIcon(data), 0, false)
    BlzFrameSetText(frameObject.ToolTipFrameName, GetObjectName(data))      
--        frameObject.ToolTipFrameSeperator
    BlzFrameSetText(frameObject.ToolTipFrameText, BlzGetAbilityExtendedTooltip(data, 0))

    if not IsUnitIdType(data, UNIT_TYPE_HERO) then
        local lumber = GetUnitWoodCost(data)
        local gold = GetUnitGoldCost(data)
        if GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD) >= gold then
            BlzFrameSetText(frameObject.TextGold, GetUnitGoldCost(data))
        else
            BlzFrameSetText(frameObject.TextGold, "|cffff2010"..GetUnitGoldCost(data))
        end    
        
        if GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER) >= lumber then
            BlzFrameSetText(frameObject.TextLumber, GetUnitWoodCost(data))
        else
            BlzFrameSetText(frameObject.TextLumber, "|cffff2010"..GetUnitWoodCost(data))
        end
    else
        BlzFrameSetText(frameObject.TextLumber, 0)
        BlzFrameSetText(frameObject.TextGold, 0)
    end
end

function SearchTasButtonListDefaultObject(data, searchedText, buttonListObject)
    --return BlzGetAbilityTooltip(data, 0)
    --return GetObjectName(data, 0)
    --return string.find(GetObjectName(data), searchedText)
    return string.find(string.lower(GetObjectName(data)), string.lower(searchedText))
end

-- update the shown content
function UpdateTasButtonList(buttonListObject)
    xpcall(function()
    local data = buttonListObject.Data[GetLocalPlayer()]
    BlzFrameSetVisible(buttonListObject.Slider, buttonListObject.DataFiltered.Count > buttonListObject.Frames.Count)
    for int = 1, buttonListObject.Frames.Count do
        local frameObject = buttonListObject.Frames[int]
        if buttonListObject.DataFiltered.Count >= int  then
            buttonListObject.UpdateAction(frameObject, data[buttonListObject.DataFiltered[int + buttonListObject.ViewPoint]])
            BlzFrameSetVisible(frameObject.Button, true)
        else
            BlzFrameSetVisible(frameObject.Button, false)
        end
    end
end, print)
end

-- for backwards compatibility rightClickAction is the last argument
function InitTasButtonListObject(parent, buttonAction, updateAction, searchAction, filterAction, rightClickAction, asyncButtonAction, asyncRightClickAction)
    local object = {
        Data = {}, --an array each slot is the user data
        DataFiltered = {Count = 0}, -- indexes of Data fitting the current search
        ViewPoint = 0,
        Frames = {},
        Parent = parent
    }
    for index = 0, bj_MAX_PLAYER_SLOTS - 1 do
        object.Data[Player(index)] = {Count = 0}
    end
    object.ButtonAction = buttonAction --call this inside the SyncAction after a button is clicked
    object.RightClickAction = rightClickAction -- this inside a SyncAction when the button is right clicked.
    object.UpdateAction = updateAction --function defining how to display stuff (async)
    object.SearchAction = searchAction --function to return the searched Text (async)
    object.FilterAction = filterAction --
    object.AsyncButtonAction = asyncButtonAction -- happens in the clicking event inside a LocalPlayer Block
    object.AsyncRightClickAction = asyncRightClickAction -- happens in the clicking event inside a LocalPlayer Block
    if not updateAction then object.UpdateAction = UpdateTasButtonListDefaultObject end
    if not searchAction then object.SearchAction = SearchTasButtonListDefaultObject end
    table.insert(TasButtonList, object) --index to TasButtonList
    TasButtonList[object] = #TasButtonList -- TasButtonList to Index

    object.SyncFrame = BlzCreateFrameByType("SLIDER", "", parent, "", 0)
    BlzFrameSetMinMaxValue(object.SyncFrame, 0, 9999999)
    BlzFrameSetStepSize(object.SyncFrame, 1.0)
    BlzTriggerRegisterFrameEvent(TasButtonList.SyncTrigger, object.SyncFrame, FRAMEEVENT_SLIDER_VALUE_CHANGED)
    BlzFrameSetVisible(object.SyncFrame, false)
    TasButtonList[object.SyncFrame] = object

    object.SyncFrameRightClick = BlzCreateFrameByType("SLIDER", "", parent, "", 0)
    BlzFrameSetMinMaxValue(object.SyncFrameRightClick, 0, 9999999)
    BlzFrameSetStepSize(object.SyncFrameRightClick, 1.0)
    BlzTriggerRegisterFrameEvent(TasButtonList.SyncTriggerRightClick, object.SyncFrameRightClick, FRAMEEVENT_SLIDER_VALUE_CHANGED)
    BlzFrameSetVisible(object.SyncFrameRightClick, false)
    TasButtonList[object.SyncFrameRightClick] = object

    object.InputFrame = BlzCreateFrame("TasEditBox", parent, 0, 0)
    BlzTriggerRegisterFrameEvent(TasButtonList.SearchTrigger, object.InputFrame, FRAMEEVENT_EDITBOX_TEXT_CHANGED)
    BlzFrameSetPoint(object.InputFrame, FRAMEPOINT_TOPRIGHT, parent, FRAMEPOINT_TOPRIGHT, 0, 0)
    TasButtonList[object.InputFrame] = object

    return object
end

function InitTasButtonListSlider(object, stepSize, rowCount, colGap, rowGap)
    object.Slider = BlzCreateFrameByType("SLIDER", "FrameListSlider", object.Parent, "QuestMainListScrollBar", 0)
    TasButtonList[object.Slider] = object -- the slider nows the TasButtonListobject
    object.SliderStep = stepSize
    BlzFrameSetStepSize(object.Slider, stepSize)
    BlzFrameClearAllPoints(object.Slider)
    BlzFrameSetVisible(object.Slider, true)
    BlzFrameSetMinMaxValue(object.Slider, 0, 0)
    BlzFrameSetPoint(object.Slider, FRAMEPOINT_TOPLEFT, object.Frames[stepSize].Button, FRAMEPOINT_TOPRIGHT, 0, 0)
    BlzFrameSetSize(object.Slider, 0.012, BlzFrameGetHeight(object.Frames[1].Button) * rowCount +  rowGap * (rowCount - 1))
    BlzTriggerRegisterFrameEvent(TasButtonList.SliderTrigger, object.Slider , FRAMEEVENT_SLIDER_VALUE_CHANGED)
    BlzTriggerRegisterFrameEvent(TasButtonList.SliderTrigger, object.Slider , FRAMEEVENT_MOUSE_WHEEL)

    
    if CreateSimpleTooltip then
        object.SliderText = CreateSimpleTooltip(object.Slider, "1000/1000")
        BlzFrameClearAllPoints(object.SliderText)
        BlzFrameSetPoint(object.SliderText, FRAMEPOINT_BOTTOMRIGHT, object.Slider, FRAMEPOINT_TOPLEFT, 0, 0)
    end 
end

function TasButtonListAddDataEx(buttonListObject, data, player)
    local oData = buttonListObject.Data[player]
    local oDataFil = buttonListObject.DataFiltered
    
    oData.Count = oData.Count + 1
    oData[oData.Count] = data
    if GetLocalPlayer() == player then
        -- filterData is a local thing
        oDataFil.Count = oDataFil.Count + 1
        oDataFil[oDataFil.Count] = oData.Count
        BlzFrameSetMinMaxValue(buttonListObject.Slider, buttonListObject.Frames.Count, oDataFil.Count)
    end
end

function TasButtonListAddData(buttonListObject, data, player)
    if player and type(player) == "userdata" then
        TasButtonListAddDataEx(buttonListObject, data, player)
    else
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            TasButtonListAddDataEx(buttonListObject, data, Player(i))
        end
    end
end

function TasButtonListRemoveDataEx(buttonListObject, data, player)
    local oData = buttonListObject.Data[player]
    for index = 1, oData.Count do 
        value = oData[index]
        if value == data then
            oData[index] = oData[oData.Count]
            oData.Count = oData.Count - 1
            break
        end
    end
    if GetLocalPlayer() == player then
        BlzFrameSetMinMaxValue(buttonListObject.Slider, buttonListObject.Frames.Count, oData.Count)
    end
end

function TasButtonListRemoveData(buttonListObject, data, player)
    if player and type(player) == "userdata" then
        TasButtonListRemoveDataEx(buttonListObject, data, player)
    else
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            TasButtonListRemoveDataEx(buttonListObject, data, Player(i))
        end
    end
end

function TasButtonListClearDataEx(buttonListObject, player)
    buttonListObject.Data[player].Count = 0
    if GetLocalPlayer() == player then
        buttonListObject.DataFiltered.Count = 0
        BlzFrameSetMinMaxValue(buttonListObject.Slider, 0, 0)
    end
end

function TasButtonListClearData(buttonListObject, player)
    if player and type(player) == "userdata" then
        TasButtonListClearDataEx(buttonListObject, player)
    else
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            TasButtonListClearDataEx(buttonListObject, Player(i))
        end
    end
end

function TasButtonListCopyDataEx(writeObject, readObject, player)
    writeObject.Data[player] = readObject.Data[player]
    for index = 1, readObject.DataFiltered.Count do writeObject.DataFiltered[index] = readObject.DataFiltered[index] end
    writeObject.DataFiltered.Count = readObject.DataFiltered.Count
    if GetLocalPlayer() == player then
        BlzFrameSetMinMaxValue(writeObject.Slider, writeObject.Frames.Count, writeObject.Data[player].Count)
        BlzFrameSetValue(writeObject.Slider,999999)
    end
    
end

function TasButtonListCopyData(writeObject, readObject, player)
    if player and type(player) == "userdata" then
        TasButtonListCopyDataEx(writeObject, readObject, player)
    else
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            TasButtonListCopyDataEx(writeObject, readObject, Player(i))
        end
    end
end

function TasButtonListSearch(buttonListObject, text)
    if not text then text = BlzFrameGetText(buttonListObject.InputFrame) end
    local filteredData = buttonListObject.DataFiltered
    local oData = buttonListObject.Data[GetLocalPlayer()]
    local value
    if GetLocalPlayer() == GetTriggerPlayer() then
        filteredData.Count = 0
        if text ~= "" then
            for index = 1, oData.Count do 
                value = oData[index]
                if buttonListObject.SearchAction(value, text, buttonListObject) and (not buttonListObject.FilterAction or buttonListObject.FilterAction(value, buttonListObject, true)) then
                    filteredData.Count = filteredData.Count + 1
                    filteredData[filteredData.Count] = index
                end
            end
            
        else
            for index = 1, oData.Count do 
                value = oData[index]
                if not buttonListObject.FilterAction or buttonListObject.FilterAction(value, buttonListObject, false) then
                    filteredData.Count = filteredData.Count + 1
                    filteredData[filteredData.Count] = index
                end
            end
        end
        --table.sort(filteredData, function(a, b) return GetObjectName(buttonListObject.Data[a]) < GetObjectName(buttonListObject.Data[b]) end  )
        --update Slider, with that also update
        BlzFrameSetMinMaxValue(buttonListObject.Slider, buttonListObject.Frames.Count, math.max(filteredData.Count,0))
        BlzFrameSetValue(buttonListObject.Slider, 999999)
        
    end
end

-- demo Creators
function CreateTasButtonTooltip(frameObject, parent)       
    -- create an empty FRAME parent for the box BACKDROP, otherwise it can happen that it gets limited to the 4:3 Screen.
    frameObject.ToolTipFrameFrame = BlzCreateFrame("TasButtonListTooltipBoxFrame", frameObject.Button, 0, 0)
    frameObject.ToolTipFrame = BlzGetFrameByName("TasButtonListTooltipBox", 0)
    frameObject.ToolTipFrameIcon = BlzGetFrameByName("TasButtonListTooltipIcon", 0)
    frameObject.ToolTipFrameName = BlzGetFrameByName("TasButtonListTooltipName", 0)
    frameObject.ToolTipFrameSeperator = BlzGetFrameByName("TasButtonListTooltipSeperator", 0)
    frameObject.ToolTipFrameText = BlzGetFrameByName("TasButtonListTooltipText", 0)    
    BlzFrameSetPoint(frameObject.ToolTipFrameText, FRAMEPOINT_TOPRIGHT, parent, FRAMEPOINT_TOPLEFT, -0.001, -0.052)
    BlzFrameSetPoint(frameObject.ToolTipFrame, FRAMEPOINT_TOPLEFT, frameObject.ToolTipFrameIcon, FRAMEPOINT_TOPLEFT, -0.005, 0.005)
    BlzFrameSetPoint(frameObject.ToolTipFrame, FRAMEPOINT_BOTTOMRIGHT, frameObject.ToolTipFrameText, FRAMEPOINT_BOTTOMRIGHT, 0.005, -0.005)
    BlzFrameSetTooltip(frameObject.Button, frameObject.ToolTipFrameFrame)
end

function CreateTasButtonListEx(buttonName, cols, rows, parent, buttonAction, rightClickAction, updateAction, searchAction, filterAction, asyncButtonAction, asyncRightClickAction, colGap, rowGap)
    if not rowGap then rowGap = 0.0 end
    if not colGap then colGap = 0.0 end
    local buttonCount = rows*cols
    local object = InitTasButtonListObject(parent, buttonAction, updateAction, searchAction, filterAction, rightClickAction, asyncButtonAction, asyncRightClickAction)
    object.Frames.Count = buttonCount
    local rowRemain = cols
    for int = 1, buttonCount do
        local frameObject = {}
        frameObject.Index = int
        frameObject.Button = BlzCreateFrame(buttonName, parent, 0, 0)
        if GetHandleId(frameObject.Button) == 0 then print("TasButtonList - Error - can't create Button:", buttonName) end
        CreateTasButtonTooltip(frameObject, parent)

        frameObject.Icon = BlzGetFrameByName("TasButtonIcon", 0)
        frameObject.Text = BlzGetFrameByName("TasButtonText", 0)
        frameObject.IconGold = BlzGetFrameByName("TasButtonIconGold", 0)
        frameObject.TextGold = BlzGetFrameByName("TasButtonTextGold", 0)
        frameObject.IconLumber = BlzGetFrameByName("TasButtonIconLumber", 0)
        frameObject.TextLumber = BlzGetFrameByName("TasButtonTextLumber", 0)
        TasButtonList[frameObject.Button] = frameObject
        TasButtonList[frameObject] = object
        object.Frames[int] = frameObject
        BlzTriggerRegisterFrameEvent(TasButtonList.ButtonTrigger, frameObject.Button, FRAMEEVENT_CONTROL_CLICK)
        BlzTriggerRegisterFrameEvent(TasButtonList.ButtonTriggerRightClick, frameObject.Button, FRAMEEVENT_MOUSE_UP)
        BlzTriggerRegisterFrameEvent(TasButtonList.ButtonScrollTrigger, frameObject.Button, FRAMEEVENT_MOUSE_WHEEL)
        
        if int > 1 then 
            if rowRemain == 0 then
                BlzFrameSetPoint(frameObject.Button, FRAMEPOINT_TOP, object.Frames[int - cols].Button, FRAMEPOINT_BOTTOM, 0, -rowGap)
                rowRemain = cols
            else
                BlzFrameSetPoint(frameObject.Button, FRAMEPOINT_LEFT, object.Frames[int - 1].Button, FRAMEPOINT_RIGHT, colGap, 0)
            end
        else
            --print(-BlzFrameGetWidth(frameObject.Button)*cols - colGap*(cols-1))
            BlzFrameSetPoint(frameObject.Button, FRAMEPOINT_TOPRIGHT, object.InputFrame, FRAMEPOINT_BOTTOMRIGHT, -BlzFrameGetWidth(frameObject.Button)*cols - colGap*(cols-1), 0)
        end
        rowRemain = rowRemain - 1
    end
    InitTasButtonListSlider(object, cols, rows, colGap, rowGap)

    return object
end

function CreateTasButtonList(buttonCount, parent, buttonAction, updateAction, searchAction, filterAction)
    return CreateTasButtonListEx("TasButton", 1, buttonCount, parent, buttonAction, nil, updateAction, searchAction, filterAction)
end

function CreateTasButtonListV2(rowCount, parent, buttonAction, updateAction, searchAction, filterAction)
    return CreateTasButtonListEx("TasButtonSmall", 2, rowCount, parent, buttonAction, nil, updateAction, searchAction, filterAction)
end

function CreateTasButtonListV3(rowCount, parent, buttonAction, updateAction, searchAction, filterAction)
    return CreateTasButtonListEx("TasButtonGrid", 3, rowCount, parent, buttonAction, nil, updateAction, searchAction, filterAction)
end
--[[ TasItemShopV4g by Tasyen
TasItemSetCategory(itemCode, category)
TasItemShopAdd(itemCode, category)
TasItemShopAddCategory(icon, text)
 define a new Category, should be done before the UI is created.
 Returns the value of the new category
TasItemShopUIShow(player, shop, shopperGroup[, mainShoper])
    TasItemShopUIShow(player) hides the shop for player
    shopperGroup are all units providing items, if you use nil the current shoppergroup remains intact. When giving something else the group contains only mainShoper.
    mainShoper is the unit consider for haggel and gains the items. If you gave a group then you can skip mainShoper then a random is taken.
    with player and shop the shoppers are kept but the shop updates.
    Beaware that this System does only update on user input it will not check distance/live or anything.
TasItemShopUIShowSimple(player, shop, mainShoper)
TasItemShopCreateShop(unitCode, whiteList, goldFactor, lumberFactor, goldFunction, lumberFunction)
TasItemShopAddShop(unitCode, ...)
 adds data for that specific shop
TasItemShopGoldFactor(unitCode, factor, ...)
    sets the goldFactor for that shop to the given data
TasItemShopLumberFactor(unitCode, factor, ...)
    lumberFactor ^^
TasItemShopAddHaggleSkill(skill, goldBase[, lumberBase, goldAdd, lumberAdd])
    adds a new Skill which will affect the costs in TasItemShop.
TasItemShopUI.SetQuickLink(player, itemCode)
    add/remove itemCode from quickLink for player
TasItemShopUI.ClearQuickLink(player)
--]]
TasItemShopUI = {
    TempTable =  {},
    QuickLinkKeyActive = __jarray(false),
    Undo = {},
    Shops = {},
    Frames = {},
    Selected = __jarray(0),
    SelectedCategory = 0,
    SelectedItem = {},
    MarkedItemCodes = {},
    QuickLink = {},
    Categories = {
        Value = __jarray(0),
        -- should only have 31 or less
        -- it is more practically to use function TasItemShopAddCategory(icon, text) inside UserInit()
        -- Icon path, tooltip Text (tries to localize)
    }
}

do
    -- A list of items buyable, you could just smack in all your buyAble TasItems here.
    -- Or use TasItemShopAdd(itemCode, category) inside local function UserInit()
    -- This List is used by shops without custom data or by BlackList Shops

    local Haggle_Skills = {
        -- skill, GoldBase, Lumberbase, GoldAdd, LumberAdd
        -- add is added per Level of that skill to Base. The current Cost is than multiplied by that Factor.
        --{FourCC('A000'), 0.8, 0.8, 0.0, 0.0}
    }

    -- position of the custom UI
    -- it can leave the 4:3 Screen but you should checkout the start of function TasItemShopUI.Create
    local xPos = 0.0
    local yPos = -0.04
    local posPoint = FRAMEPOINT_TOPRIGHT
    local posScreenRelative = true --(true) repos to the screenSize, when the resolution mode changes the box will move further in/out when using a right or Left point.
    -- It is advised to posScreenRelative = false when posPoint does not include Left or Right
    -- with posScreenRelative = false xPos and yPos are abs coords, to which posPoint of the Shop UI is placed to.

    -- position of Item toolTips, this does not affect the tooltips for Categories or Users.
    -- comment out toolTipPosPointParent, if you want a specific position on screen.
    -- with toolTipPosPoint & toolTipPosPointParent are toolTipPosX & toolTipPosY relative offsets.
    -- The position is a bit wierd, the position is not the box but the Extended Tooltip Text, the Header has a height of ~0.052.

    local toolTipPosX = 0.0
    local toolTipPosY = -0.052
    local toolTipPosPoint = FRAMEPOINT_TOPRIGHT
    local toolTipPosPointParent = FRAMEPOINT_BOTTOMRIGHT
    local toolTipSizeX = 0.2 -- only content
    local toolTipSizeXBig = 0.3 -- only content
    local toolTipLimitBig = 300 -- When a TooltipText Contains this amount or more of Chars it will use toolTipSizeXBig

    -- this can be used to change the visual ("EscMenuControlBackdropTemplate") ("TasItemShopRaceBackdrop")
    local boxFrameName = "TasItemShopRaceBackdrop"
    local boxButtonListFrameName = "EscMenuControlBackdropTemplate"
    local boxRefFrameName = "EscMenuControlBackdropTemplate"
    local boxCatFrameName = "EscMenuControlBackdropTemplate"
    local boxUndoFrameName = "TasItemShopRaceBackdrop"
    local boxDefuseFrameName = "TasItemShopRaceBackdrop"
    local buttonListHighLightFrameName = "TasItemShopSelectedHighlight"
    local boxFrameBorderGap = 0.0065
    local boxButtonListBorderGap = 0.0065 -- does nothing right now
    local boxRefBorderGap = 0.0065
    local boxCatBorderGap = 0.0055
    local boxUndoBorderGap = 0.0045
    local boxDefuseBorderGap = 0.0045
    local boxSellBorderGap = 0.0045
    local buttonListButtonGapCol = 0.001
    local buttonListButtonGapRow = 0.005
    -- material control
    local flexibleShop = false -- (true) can sell items not added to the shop. This includes items reached over RefButtons and material for autocompletion. I don't know that item, but your description is enough. I craft it, no problem.
    local sharedItems = false -- (false) can only fuse material owned by neutral passive (default) or oneself. The code handling that is in TasItemFusion.
    local canProviderGetItem = true -- (true) when the mainShopper's inventory is full, try to give the other matieral provider the item
    local canUndo = true -- (true) There is an Undo Button which allows to Revert BuyActions done in this shopping. A shopping ends when the UI is closed, changing current shop counts as closed.
    local canDefuse = false -- (true) There is a Defuse Button which allows to defuse FusionItems hold.
    local DefuseButtonIcon = "ReplaceableTextures\\CommandButtons\\BTNdemolish"
    local DefuseButtonIconDisabled = getDisabledIcon(DefuseButtonIcon)
    local canSellItems = true -- (true)
    local SellFactor = 0.75
    local SellUsesCostModifier = true
    local SellButtonIcon = "ReplaceableTextures\\CommandButtons\\BTNReturnGoods"
    local SellButtonIconDisabled = getDisabledIcon(SellButtonIcon)

    local MainUserTexture = "ui\\widgets\\console\\human\\commandbutton\\human-multipleselection-border"
    local MainItemTexture = "ui\\widgets\\console\\human\\commandbutton\\human-multipleselection-border"

    local shopRange = 4000 -- the max distance between shop and Shoper, this can be overwritten by shopObject.Range.
    local updateTime = 0.4 -- how many seconds pass before a new update is applied. update: search new shopers, validat current shopers and update UI.
    -- Titel-text in the reference Boxes
    local textUpgrades = "COLON_UPGRADE" --tries to localize on creation
    local textMats = "SCORESCREEN_TAB3"
    local textInventory = "INVENTORY"
    local textUser = "USER"
    local textCanNotBuyPrefix = "Can not buy: "
    local textCanNotBuySufix = "OUTOFSTOCKTOOLTIP"
    local textNoValidShopper = "No valid Shoper"
    local textUndo = "Undo: "
    local textUnBuyable = "xxxxxxx"
    local textDefuse = "Defuse:"
    local textSell = "Sell:"
    local textQuickLink = "ShortCuts:"
    local categoryModeTextAnd = "ui\\widgets\\battlenet\\bnet-mainmenu-friends-disabled"
    local categoryModeTextOr = "Or"
    local categoryModeIconOr = "ui\\widgets\\battlenet\\bnet-mainmenu-friends-up"
    local categoryModeIconAnd = "And"

    local quickLinkKey = OSKEY_LSHIFT  -- nil will prevent the user from changing shortcuts. can also be commented out
    -- how many refButtons, refButtons have pages, if needed.
    -- A feature is disabled with a counter smaller than 1.
    local refButtonCountMats = 0 -- materialRefs.
    local refButtonCountUp = 0 -- possible upgrades of the current Selected
    local refButtonCountInv = 6 -- inventory items, this system allows an unitgroup to provide items, if you don't use that feature only upto 6 makes sense.
    local refButtonCountUser = 6 -- References to the shopping Units/material provider.
    local refButtonCountQuickLink = 0 -- User SelectAble Shortcuts
    local refButtonSize = 0.02
    local refButtonGap = 0.003
    local refButtonPageSize = 0.012
    local refButtonPageRotate = true --(true) swap to first page when going above last page, and swap to last page when going down first Page
    local refButtonPageUp = "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp"
    local refButtonPageDown = "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown"
    local refButtonBoxSizeY = 0.047

    -- LayoutType alters the position of buttons
    -- (0) the buy button is at the bottom between buttonList and buybutton the refBoxes are placed
    -- (1) the buy button is below the buttonList below it are the refButtons
    -- (2) the buy button is below the buttonList, the RefButtons are at the bottom outside of the Box
    -- (3) the buy button is below the buttonList, the RefButtons are left outside of the Box they are also from top to bottom
    local LayoutType = 0


    -- (true) right clicking an refInventoryButton in the UI will sell the item
    -- (false) right clicking it will buy it again.
    local inventoryRightClickSell = true
    local inventoryShowMainOnly = true --(false) show all items currently useable

    local userButtonOrder = false -- (true) Creates any UnitTargetOrder Event enables right clicking Units in the world to swap main shoppers.
    local doubleClickTimeOut = 2.0 -- amount of seconds a doppleclick inside the Buttonlist counts as Buying

    -- model displayed when buy request was started.
    --local spriteModel = "UI\\Feedback\\GoldCredit\\GoldCredit.mdl" -- in 1.31 the coins are black only.
    --local spriteModel = "Abilities\\Weapons\\RockBoltMissile\\RockBoltMissile.mdl"
    --local spriteModel = "Abilities\\Weapons\\BansheeMissile\\BansheeMissile.mdl"
    --local spriteModel = "Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl"
    local spriteModel = "war3mapImported\\BansheeMissile.mdx" --by abfal, (no sound).
    local spriteScale = 0.0006 -- The scale has to fit the used model. if you use non-UI models use a low scale, 0.001 or below.
    local spriteAnimationIndex = 1 -- 1 = death animation

    local buttonListRows = 5
    -- buttonListCols has a strong impact on the xSize of this UI. make sure that refButtons of one type fit into this.
    local buttonListCols = 3

    -- this will not change the size of the Buttons, nor the space the text can take
    -- true = Show
    -- false = hide
    local buttonListShowGold = true
    local buttonListShowLumber = true
    local buyButtonShowGold = true
    local buyButtonShowLumber = true

    -- which button is used inside the ButtonList? Enable one block and disable the other one

    local buttonListButtonName = "TasButtonSmall"
    local buttonListButtonSizeX = 0.1
    local buttonListButtonSizeY = 0.0325

    -- "TasButtonGrid" are smaller, they don't show the names in the list
    --local buttonListButtonName = "TasButtonGrid"
    --local buttonListButtonSizeX = 0.064
    --local buttonListButtonSizeY = 0.0265

    --local buttonListButtonName = "TasButton"
    --local buttonListButtonSizeX = 0.2
    --local buttonListButtonSizeY = 0.0265

    local categoryButtonSize = 0.019

    -- This runs right before the actually UI is created.
    -- this is a good place to add items, categories, fusions shops etc.
    local function UserInit()
        -- this can all be done in GUI aswell, enable the next Line or remove all Text of this function if you only want to use GUI
        --if true then return end

        -- define Categories: Icon, Text
        -- the Categories are displayed in the order added.
        -- it is a good idea to save the returned Value in a local to make the category setup later much easier to understand.
        -- you can only have 31 categories
        local catDmg = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNSteelMelee", "COLON_DAMAGE")
        local catArmor = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpOne", "COLON_ARMOR")
        local catStr = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower", "STRENGTH")
        local catAgi = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility", "AGILITY")
        local catInt = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence", "INTELLECT")
        local catLife = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNPeriapt", "Life")
        local catLifeReg = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNRegenerate", "LifeRegeneration")
        local catMana = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNPendantOfMana", "Mana")
        local catManaReg = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNSobiMask", "ManaRegeneration")
        local catOrb = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNOrbOfDarkness", "Orb")
        local catAura = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNLionHorn", "Aura")
        local catActive = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNStaffOfSilence", "Active")
        --local catPower = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNControlMagic", "SpellPower")
        --local catCooldown = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne", "Cooldown")
        local catAtkSpeed = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne", "Attackspeed")
        local catMress = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNRunedBracers", "Magic-Resistence")
        --local catConsum = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNPotionGreenSmall", "ConsumAble")
        local catMoveSpeed = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed", "COLON_MOVE_SPEED")
        --local catCrit = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNCriticalStrike", "Crit")
        local catLifeSteal = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNVampiricAura", "Lifesteal")
        local catEvade = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNEvasion", "Evasion")

        -- setup custom shops
        -- custom Shops are optional.
        -- They can have a White or Blacklist of items they can(n't) sell and have a fixed cost modifier for Gold, Lumber aswell as a function for more dynamic things for Gold and Lumber.
        local shopObject
        -- 'n000' can only sell this items (this items don't have to be in the pool of items)
        shopObject = TasItemShopAddShop('n000', 'hlst', 'mnst', 'pghe', 'pgma', 'pnvu', 'pres', 'ankh', 'stwp', 'shas')
        -- enable WhiteListMode
        shopObject.Mode = true
        -- 'n001' can't sell this items (from the default pool of items)
        shopObject = TasItemShopAddShop('n001', 'hlst', 'mnst', 'pghe', 'pgma', 'pnvu', 'pres', 'ankh', 'stwp', 'shas')
        -- enable BlackListMode
        shopObject.Mode = false
        -- create an shopObject for 'ngme', has to pay 20more than normal, beaware that this can be overwritten by GUI Example
        shopObject = TasItemShopCreateShop('ngme', false, 1, 1
        -- custom gold Cost function
        ,function(itemCode, cost, client, shop) return cost end
        -- custom lumber Cost function
        ,function(itemCode, cost, client, shop) return cost end
        )
        --'I002' crown +100 was never added to the database but this shop can craft/sell it.
        shopObject = TasItemShopAddShop('n002', 'ckng', 'I001', 'I002', 'arsh')
        shopObject.Mode = true


        -- Define skills/Buffs that change the costs in the shop
        -- cursed Units have to pay +25
        TasItemShopAddHaggleSkill(FourCC('Bcrs'), 1.25, 1.25)

        -- define item Categories
        -- uses the locals from earlier.
        -- An item can have multiple categories just add them together like this: catStr + catAgi + catInt

        TasItemSetCategory('afac', catDmg + catAura)
        TasItemSetCategory('spsh', catMress)
        TasItemSetCategory('ajen', catAtkSpeed + catMoveSpeed + catAura)
        TasItemSetCategory('bgst', catStr)
        TasItemSetCategory('belv', catAgi)
        TasItemSetCategory('cnob', catStr + catAgi + catInt)
        TasItemSetCategory('ratc', catDmg)
        TasItemSetCategory('clfm', catDmg + catActive)
        TasItemSetCategory('gcel', catAtkSpeed)
        TasItemSetCategory('hval', catStr + catAgi)
        TasItemSetCategory('hcun', catAgi + catInt)
        TasItemSetCategory('rhth', catLife)
        TasItemSetCategory('kpin', catManaReg + catAura)
        TasItemSetCategory('lgdh', catLifeReg + catMoveSpeed + catAura)
        TasItemSetCategory('mcou', catStr + catInt)
        TasItemSetCategory('odef', catDmg + catOrb)
        TasItemSetCategory('pmna', catMana)
        TasItemSetCategory('rde3', catArmor)
        TasItemSetCategory('rlif', catLifeReg)
        TasItemSetCategory('ciri', catInt)
        TasItemSetCategory('brac', catMress)
        TasItemSetCategory('sbch', catLifeSteal + catAura)
        TasItemSetCategory('rwiz', catManaReg)
        TasItemSetCategory('evtl', catEvade)
        TasItemSetCategory('lhst', catArmor + catAura)
        TasItemSetCategory('ward', catDmg + catAura)
        TasItemSetCategory('desc', catActive)
        TasItemSetCategory('gemt', catActive)
        TasItemSetCategory('ocor', catDmg + catOrb)
        TasItemSetCategory('ofir', catDmg + catOrb)
        TasItemSetCategory('oli2', catDmg + catOrb)
        TasItemSetCategory('oslo', catDmg + catOrb)
        TasItemSetCategory('oven', catDmg + catOrb)
    end
    local function GetParent()
        local parent
        if TasItemShopUI.IsReforged then
            parent = BlzGetFrameByName("ConsoleUIBackdrop", 0)
        else
            CreateLeaderboardBJ(bj_FORCE_ALL_PLAYERS, "title")
            parent = BlzGetFrameByName("Leaderboard", 0)
            BlzFrameSetSize(parent, 0, 0)
            BlzFrameSetVisible(BlzGetFrameByName("LeaderboardBackdrop", 0), false)
            BlzFrameSetVisible(BlzGetFrameByName("LeaderboardTitle", 0), false)
        end
        return parent
    end
    local function IsValidShopper(player, shop, unit, range)
        if not IsUnitOwnedByPlayer(unit, player) then
            --print("IsUnitOwnedByPlayer")
            return false
        end
        if UnitInventorySize(unit) < 1 then
            --print("UnitInventorySize")
            return false
        end
        if IsUnitType(unit, UNIT_TYPE_DEAD) then
            --print("UNIT_TYPE_DEAD")
            return false
        end
        if IsUnitPaused(unit) then
            --print("IsUnitPaused")
            return false
        end
        if IsUnitHidden(unit) then
            --print("IsUnitHidden")
            return false
        end
        if IsUnitIllusion(unit) then
            --print("IsUnitIllusion")
            return false
        end
        if not IsUnitInRange(shop, unit, range) then
            --print("not IsUnitInRange")
            return false
        end
        return true
    end
    local function CostModifier(gold, lumber, itemCode, buyer, shop, shopObject)
        -- this function is called for each Button that shows costs in the shop UI and right before buying the item.
        -- Beaware that this function is also called in a async manner -> no sideeffects or state changes.
        -- buyer got the Haggling skill?
        local level, skill
        for i, v in ipairs(Haggle_Skills) do
            skill = v[1]
            level = GetUnitAbilityLevel(buyer, skill)
            if level > 0 then
                gold = gold * (v[2] + v[4]*level)
                lumber = lumber * (v[3] + v[5]*level)
            end
        end

        if shopObject then
            gold = gold * shopObject.GoldFactor[itemCode]
            lumber = lumber * shopObject.LumberFactor[itemCode]
            if shopObject.Gold then
                gold = shopObject.Gold(itemCode, gold, buyer, shop)
            end
            if shopObject.Lumber then
                lumber = shopObject.Lumber(itemCode, lumber, buyer, shop)
            end

        end
        return math.floor(gold), math.floor(lumber)
    end
    local function GetItemSellCosts(unit, shop, item)
        local itemCode = GetItemTypeId(item)
        local gold, lumber, charges = TasItemGetCost(itemCode)
        gold = gold * SellFactor
        lumber = lumber * SellFactor
        if SellUsesCostModifier then
            gold, lumber = CostModifier(gold, lumber, itemCode, unit, shop, TasItemShopUI.Shops[GetUnitTypeId(shop)])
        end
        if charges > 0 then
            gold = GetItemCharges(item)*gold/charges
            lumber = GetItemCharges(item)*lumber/charges
        end
        return math.floor(gold), math.floor(lumber), charges
    end
    --
    -- system start, touch on your own concern
    --
    -- the unique power2 Values used for categories, shifted by 1
    local CategoryValue = {1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824}
    local function ShowSprite(frame, player)
        if player and GetLocalPlayer() ~= player then return end
        BlzFrameSetVisible(TasItemShopUI.Frames.SpriteParent, true)
        BlzFrameSetModel(TasItemShopUI.Frames.Sprite, spriteModel, 0)
        BlzFrameSetSpriteAnimate(TasItemShopUI.Frames.Sprite, spriteAnimationIndex, 0)
        BlzFrameSetPoint(TasItemShopUI.Frames.Sprite, FRAMEPOINT_CENTER, frame, FRAMEPOINT_CENTER, 0, 0)
    end
    local TasItemCategory = __jarray(0)
    function TasItemSetCategory(itemCode, category)
        if type(itemCode) == "string" then itemCode = FourCC(itemCode) end
        TasItemCategory[itemCode] = category
    end
    function TasItemShopAdd(itemCode, category)
        if type(itemCode) == "string" then itemCode = FourCC(itemCode) end
        TasItemSetCategory(itemCode, category)
        table.insert(BUY_ABLE_ITEMS, itemCode)
        TasItemCaclCost(itemCode)
        if bj_gameStarted then

        end
    end
    function TasItemShopAddHaggleSkill(skill, goldBase, lumberBase, goldAdd, lumberAdd)
        if not goldAdd then goldAdd = 0 end
        if not lumberAdd then lumberAdd = 0 end
        if not lumberBase then lumberBase = 1 end
        table.insert(Haggle_Skills, {skill, goldBase, lumberBase, goldAdd, lumberAdd})
    end
    function TasItemShopAddCategory(icon, text)
        if #TasItemShopUI.Categories >= #CategoryValue then print("To many Categories!! new category", text, icon) end
        table.insert(TasItemShopUI.Categories, {icon, text})
        return CategoryValue[#TasItemShopUI.Categories]
    end
    function TasItemShopCreateShop(unitCode, whiteList, goldFactor, lumberFactor, goldFunction, lumberFunction)
        if type(unitCode) == "string" then unitCode = FourCC(unitCode) end
        local shopObject = TasItemShopUI.Shops[unitCode]
        if not shopObject then
            if not goldFactor then goldFactor = 1.0 end
            if not lumberFactor then lumberFactor = 1.0 end
            shopObject = {Mode = whiteList, GoldFactor = __jarray(goldFactor), LumberFactor = __jarray(lumberFactor), Gold = goldFunction, Lumber = lumberFunction}
            TasItemShopUI.Shops[unitCode] = shopObject
        end

        return shopObject
    end
    TasItemShopCreateShopSimple = TasItemShopCreateShop
    function TasItemShopAddShop(unitCode, ...)
        local shopObject = TasItemShopCreateShop(unitCode)
        for i, v in ipairs({...}) do
            if type(v) == "string" then v = FourCC(v) end
            TasItemCaclCost(v)
            shopObject[v] = true
            --print(GetObjectName(v))
            table.insert(shopObject, v)
        end
        return shopObject
    end
    function TasItemShopGoldFactor(unitCode, factor, ...)
        local shopObject = TasItemShopCreateShop(unitCode)
        for i, v in ipairs({...}) do
            if type(v) == "string" then v = FourCC(v) end
            shopObject.GoldFactor[v] = factor
            --print(GetObjectName(v))
        end
        return shopObject
    end
    function TasItemShopLumberFactor(unitCode, factor, ...)
        local shopObject = TasItemShopCreateShop(unitCode)
        for i, v in ipairs({...}) do
            if type(v) == "string" then v = FourCC(v) end
            shopObject.LumberFactor[v] = factor
            --print(GetObjectName(v))
        end
        return shopObject
    end



    local real = MarkGameStarted
    local Shoper = {}
    local DoubleClickStamp = 0
    local ShoperMain = {}
    local CurrentShop = {}
    local LocalShopObject
    local CurrentOffSetInventory = __jarray(0)
    local CurrentOffSetMaterial = __jarray(0)
    local CurrentOffSetUpgrade = __jarray(0)
    local CurrentOffSetUser = __jarray(0)
    local CurrentOffSetQuickLink = __jarray(0)
    local xSize -- Size of the total Box
    local ySize -- this is autocalced

    function TasItemShopUI.ClearQuickLink(player)
        -- have that data already?
        for i = #TasItemShopUI.QuickLink[player], 1, -1 do
            TasItemShopUI.QuickLink[player][TasItemShopUI.QuickLink[player][i]] = nil
            TasItemShopUI.QuickLink[player][i] = nil
        end
    end

    function TasItemShopUI.SetQuickLink(player, itemCode)
        -- request to calc the itemCode costs, this is done in case it was not added to the shop
        TasItemCaclCost(itemCode)
        -- have that data already?
        if TasItemShopUI.QuickLink[player][itemCode] then
            for i, v in ipairs(TasItemShopUI.QuickLink[player]) do
                if v == itemCode then
                    table.remove(TasItemShopUI.QuickLink[player], i)
                    TasItemShopUI.QuickLink[player][itemCode] = false
                    -- reset offset when falling out of Page 2
                    if #TasItemShopUI.QuickLink[player] <= refButtonCountQuickLink then
                        CurrentOffSetQuickLink[player] = 0
                    end
                    break
                end
            end
        else
            -- no, add it
            table.insert(TasItemShopUI.QuickLink[player], itemCode)
            TasItemShopUI.QuickLink[player][itemCode] = true
        end
    end

    local function CanBuyItem(itemCode, shopObject, player)
        if shopObject then
            -- do not allow this itemCode or do exclude this itemCode => disallow
            if (not shopObject[itemCode] and shopObject.Mode) or (shopObject[itemCode] and not shopObject.Mode)  then
                return false
            end
            -- allow this for this shop?
            if shopObject[itemCode] and shopObject.Mode then
                return true
            end
        end
        return BUY_ABLE_ITEMS.Marker[player][itemCode]
    end
    local function AllMatsProvided(player, itemCode, shopObject)
        local missing = {}
        local count = 0
        for i, v in ipairs(TasItemFusionGetMissingMaterial(TasItemFusion.Player[player].UseAble, itemCode)) do
            if not CanBuyItem(v, shopObject, player) then
                count = count + 1
                missing[count] = v
            end
        end
        return missing
    end


    local function updateItemFrame(frameObject, data, showGold, showLumber)

        if frameObject.HighLight ~= nil then
            BlzFrameSetVisible(frameObject.HighLight, TasItemShopUI.MarkedItemCodes[data])
        end
        if showGold == nil then
            showGold = buttonListShowGold
            showLumber = buttonListShowLumber
        end
        BlzFrameSetTexture(frameObject.Icon, BlzGetAbilityIcon(data), 0, false)
        BlzFrameSetText(frameObject.Text, GetObjectName(data))

        BlzFrameSetTexture(frameObject.ToolTipFrameIcon, BlzGetAbilityIcon(data), 0, false)
        BlzFrameSetText(frameObject.ToolTipFrameName, GetObjectName(data))
        --        frameObject.ToolTipFrameSeperator
        BlzFrameSetText(frameObject.ToolTipFrameText, BlzGetAbilityExtendedTooltip(data, 0))

        if string.len(BlzGetAbilityExtendedTooltip(data, 0)) >= toolTipLimitBig then
            BlzFrameSetSize(frameObject.ToolTipFrameText, toolTipSizeXBig, 0)
        else
            BlzFrameSetSize(frameObject.ToolTipFrameText, toolTipSizeX, 0)
        end


        if showGold or showLumber then
            local gold, lumber
            if TasItemFusion.BuiltWay[data] then
                gold, lumber = TasItemFusionCalc(TasItemFusion.Player[GetLocalPlayer()].UseAble, data, nil, true)
            else
                gold, lumber = TasItemGetCost(data)
            end
            gold, lumber = CostModifier(gold, lumber, data, ShoperMain[GetLocalPlayer()], CurrentShop[GetLocalPlayer()], LocalShopObject)
            BlzFrameSetVisible(frameObject.TextGold, showGold)
            BlzFrameSetVisible(frameObject.IconGold, showGold)
            if showGold then
                if GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD) >= gold then
                    BlzFrameSetText(frameObject.TextGold, string.format( "%.0f", gold))
                else
                    BlzFrameSetText(frameObject.TextGold, "|cffff2010"..string.format( "%.0f", gold))
                end
            else
                -- this is done to reduce the taken size
                BlzFrameSetText(frameObject.TextGold, "0")
            end

            BlzFrameSetVisible(frameObject.TextLumber, showLumber)
            BlzFrameSetVisible(frameObject.IconLumber, showLumber)
            if showLumber then
                if GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER) >= lumber then
                    BlzFrameSetText(frameObject.TextLumber, string.format( "%.0f", lumber))
                else
                    BlzFrameSetText(frameObject.TextLumber, "|cffff2010"..string.format( "%.0f", lumber))
                end
            else
                BlzFrameSetText(frameObject.TextLumber, "0")
            end
        else
            BlzFrameSetVisible(frameObject.TextLumber, false)
            BlzFrameSetVisible(frameObject.IconLumber, false)
            BlzFrameSetVisible(frameObject.TextGold, false)
            BlzFrameSetVisible(frameObject.IconGold, false)
        end

    end
    local function updateUndoButton(data, actionName)
        BlzFrameSetTexture(TasItemShopUI.Frames.UndoButtonIcon, BlzGetAbilityIcon(data), 0, false)
        BlzFrameSetTexture(TasItemShopUI.Frames.UndoButtonIconPushed, BlzGetAbilityIcon(data), 0, false)
        BlzFrameSetText(TasItemShopUI.Frames.UndoText, GetLocalizedString(textUndo).. actionName .. "\n" .. GetObjectName(data))
    end

    local function GiveItem(unit, item, undo)
        local itemCode = GetItemTypeId(item)
        local oldCharges = GetItemCharges(item)
        -- when there are no charges, just give the item
        if oldCharges <= 0 then
            UnitAddItem(unit, item)
        else
            -- the item could be stacked.
            -- request triggerCount of the Itemstacking trigger, then give the item.
            local oldDataCount = GetItemStackingEventData()
            UnitAddItem(unit, item)
            if undo then
                -- with undo, request the data again. If the counter is different -> a reforged item stacking event happend
                local newDataCount, stackedItem, chargeChange = GetItemStackingEventData()

                if newDataCount ~= oldDataCount then
                    undo.StackChargesGainer = stackedItem
                    undo.StackCharges = chargeChange
                    -- no built in stacking event, but the user might have a custom stacking.
                elseif GetItemCharges(item) < oldCharges then
                    for i = 0, bj_MAX_INVENTORY - 1 do
                        if GetItemTypeId(UnitItemInSlot(unit, i)) == itemCode then
                            undo.StackChargesGainer = UnitItemInSlot(unit, i)
                            undo.StackCharges = oldCharges - GetItemCharges(item)
                        end
                    end
                end
            end
        end
    end
    local function GiveItemGroup(player, item, undo)
        SetItemPlayer(item, player)
        GiveItem(ShoperMain[player], item, undo)
        -- other units can get the item when the mainShopper can not hold it?
        -- Check if item still exists and mainshopper does not have it.
        if canProviderGetItem and GetHandleId(item) > 0 and not UnitHasItem(ShoperMain[player], item)  then
            -- loop all mat provider try to give it to each, when that succeds finished.
            local found = false
            for i = 0, BlzGroupGetSize(Shoper[player]) - 1, 1 do
                local unit = BlzGroupUnitAt(Shoper[player], i)
                GiveItem(unit, item, undo)
                if GetHandleId(item) == 0 or UnitHasItem(unit, item) then
                    found = true
                    if canUndo then
                        table.insert(undo.ResultItem, {item, unit})
                    end
                    break
                end
            end
            if not found and canUndo then
                table.insert(undo.ResultItem, {item})
            end
        else
            if canUndo then
                table.insert(undo.ResultItem, {item, ShoperMain[player]})
            end
        end

    end
    local function BuyItem(player, itemCode)

        xpcall( function()
            --print(GetPlayerName(player), "Wana Buy", GetObjectName(itemCode), "with", GetUnitName(ShoperMain[player]))
            if BlzGroupGetSize(Shoper[player]) == 0 then
                if GetLocalPlayer() == player then
                    print(GetLocalizedString(textNoValidShopper))
                end
                return
            end
            local gold, lumber, items
            local shopObject = TasItemShopUI.Shops[GetUnitTypeId(CurrentShop[player])]
            -- can not buy this?
            if not flexibleShop and not CanBuyItem(itemCode, shopObject, player) then
                if GetLocalPlayer() == player then print(GetObjectName(itemCode), GetLocalizedString(textCanNotBuySufix)) end
                return
            end

            if TasItemFusion.BuiltWay[itemCode] then
                gold, lumber, items = TasItemFusionCalc(TasItemFusion.Player[player].UseAble, itemCode)
            else
                gold, lumber = TasItemGetCost(itemCode)
            end

            gold, lumber = CostModifier(gold, lumber, itemCode,  ShoperMain[player], CurrentShop[player], shopObject)

            -- only items buyable in the shop can be replaced by Gold? Also ignore non fusion items.
            if not flexibleShop and TasItemFusion.BuiltWay[itemCode] then
                local missingItemCode = AllMatsProvided(player, itemCode, shopObject)
                if #missingItemCode > 0 then
                    if GetLocalPlayer() == player then print(GetLocalizedString(textCanNotBuyPrefix), GetObjectName(itemCode)) for i, v in ipairs(missingItemCode) do print(GetObjectName(v), GetLocalizedString(textCanNotBuySufix)) end end
                    return
                end
            end

            if GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) >= gold then
                if GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) >= lumber then
                    local undo
                    if canUndo then
                        local units = {}
                        undo = {ResultItem = {}, Result = itemCode, Gold = gold, Lumber = lumber, Items = {}, ActionName = "Buy"}
                        table.insert(TasItemShopUI.Undo[player], undo)
                        for i = 0, BlzGroupGetSize(Shoper[player]) - 1, 1 do
                            units[i + 1] = BlzGroupUnitAt(Shoper[player], i)
                        end
                        local owner
                        if items then
                            for _,v in ipairs(items) do
                                for _,u in ipairs(units) do
                                    if UnitHasItem(u, v) then
                                        owner = u
                                        break
                                    end
                                end
                                --table.insert(undo.Items, {GetItemTypeId(v), owner})
                                --RemoveItem(v)
                                table.insert(undo.Items, {v, owner})
                                --print(GetItemName(v), GetHandleId(v))
                                UnitRemoveItem(owner, v)
                                SetItemVisible(v, false)
                            end
                        end
                        if GetLocalPlayer() == player then
                            BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, true)
                            updateUndoButton(undo.Result, undo.ActionName)
                        end
                    else
                        if items then
                            for _,v in ipairs(items) do
                                RemoveItem(v)
                            end
                        end
                    end
                    AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_GOLD, -gold)
                    AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_LUMBER, -lumber)
                    local newItem = CreateItem(itemCode, GetUnitX(ShoperMain[player]), GetUnitY(ShoperMain[player]))
                    GiveItemGroup(player, newItem, undo)

                    --CreateItem(itemCode, GetPlayerStartLocationX(player), GetPlayerStartLocationY(player))
                    TasItemShopUIShow(player, CurrentShop[player])
                elseif not GetSoundIsPlaying(SoundNoLumber[GetPlayerRace(player)]) then
                    StartSoundForPlayerBJ(player, SoundNoLumber[GetPlayerRace(player)])
                end
            elseif not GetSoundIsPlaying(SoundNoGold[GetPlayerRace(player)]) then
                StartSoundForPlayerBJ(player, SoundNoGold[GetPlayerRace(player)])
            end
        end, print)
    end

    local function SellItem(player, item)
        xpcall(function()
            local wasSelectedItem = (item == TasItemShopUI.SelectedItem[player])
            if not item then return end
            local itemCode = GetItemTypeId(item)

            local gold, lumber, charges = GetItemSellCosts(ShoperMain[player], CurrentShop[player], item)

            AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_GOLD, gold)
            AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_LUMBER, lumber)
            if canUndo then
                undo = {ResultItem = {}, Result = itemCode, Gold = -gold, Lumber = -lumber, Items = {}, ActionName = "Sell"}
                table.insert(TasItemShopUI.Undo[player], undo)
                for i = 0, BlzGroupGetSize(Shoper[player]) - 1, 1 do
                    owner = BlzGroupUnitAt(Shoper[player], i)
                    if UnitHasItem(owner, item) then
                        UnitRemoveItem(owner, item)
                        SetItemVisible(item, false)
                        undo.Items[1] = {item, owner}
                        break
                    end
                end

                if GetLocalPlayer() == player then
                    BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, true)
                    updateUndoButton(undo.Result, undo.ActionName)
                end
            else
                RemoveItem(item)
            end

            if wasSelectedItem then
                if GetLocalPlayer() == player then
                    BlzFrameSetEnable(TasItemShopUI.Frames.SellButton, false)
                    --BlzFrameSetVisible(TasItemShopUI.Frames.BoxSell, false)
                end
                TasItemShopUI.SelectedItem[player] = nil
            end
        end, print)
    end
    local function updateRefButton(frameObject, data, unit, updateBroken)
        if data and data > 0 then
            BlzFrameSetVisible(frameObject.Button, true)
            BlzFrameSetTexture(frameObject.Icon, BlzGetAbilityIcon(data), 0, false)
            BlzFrameSetTexture(frameObject.IconPushed, BlzGetAbilityIcon(data), 0, false)
            BlzFrameSetTexture(frameObject.ToolTipFrameIcon, BlzGetAbilityIcon(data), 0, false)
            if frameObject.ToolTipFrameName then
                BlzFrameSetText(frameObject.ToolTipFrameName, GetObjectName(data))
                BlzFrameSetText(frameObject.ToolTipFrameText, BlzGetAbilityExtendedTooltip(data, 0))
                if string.len(BlzGetAbilityExtendedTooltip(data, 0)) >= toolTipLimitBig then
                    BlzFrameSetSize(frameObject.ToolTipFrameText, toolTipSizeXBig, 0)
                else
                    BlzFrameSetSize(frameObject.ToolTipFrameText, toolTipSizeX, 0)
                end
            else
                BlzFrameSetText(frameObject.ToolTipFrameText, GetObjectName(data))
            end

            if unit ~= nil and IsUnitType(unit, UNIT_TYPE_HERO) then
                BlzFrameSetText(frameObject.ToolTipFrameText, BlzFrameGetText(frameObject.ToolTipFrameText) .. "\n" .. GetHeroProperName(unit))
            end
            if updateBroken then
                BlzFrameSetVisible(frameObject.IconBroken, not CanBuyItem(data, LocalShopObject, GetLocalPlayer()))
            end
        else
            BlzFrameSetVisible(frameObject.Button, false)
        end
    end
    local function updateRefButtons(dataTable, parent, refButtons, offSet, updateBroken)
        local count, valid, data, dataSize
        local validCounter = 0
        BlzFrameSetVisible(parent, true)
        BlzFrameSetText(refButtons.PageText, math.floor(offSet/#refButtons) + 1)
        if type(dataTable) == "table" then
            if dataTable.Count then
                count = dataTable.Count
            else
                count = #dataTable
            end
            for index, frameObject in ipairs(refButtons) do
                valid = index + offSet <= count
                if valid then
                    validCounter = validCounter + 1
                    data = dataTable[index + offSet]
                    if type(data) == "table" then data = data.Result
                    elseif type(data) == "userdata" and string.sub(tostring(data),1,5) =="item:" then
                        BlzFrameSetVisible(frameObject.IconDone, data == TasItemShopUI.SelectedItem[GetLocalPlayer()])
                        data = GetItemTypeId(data)
                    end
                    updateRefButton(frameObject, data, nil, updateBroken)
                else
                    updateRefButton(frameObject, 0)
                end
            end
        elseif type(dataTable) == "userdata" and string.sub(tostring(dataTable),1,6) =="group:" then
            count = BlzGroupGetSize(dataTable)
            local data2
            for index, frameObject in ipairs(refButtons) do
                valid = index + offSet <= count
                if valid then
                    validCounter = validCounter + 1
                end
                data = BlzGroupUnitAt(dataTable, index + offSet - 1)
                data2 = GetUnitTypeId(data)
                updateRefButton(frameObject, data2, data)
            end
        end
        BlzFrameSetVisible(refButtons.Page, count > #refButtons)
        return validCounter
    end

    local function updateHaveMats(player, data)
        local itemCounter = __jarray(0)
        local mat
        local useable = TasItemFusion.Player[player].UseAble
        local offset = CurrentOffSetMaterial[player]
        for index, frameObject in ipairs(TasItemShopUI.Frames.Material) do
            if BlzFrameIsVisible(frameObject.Button) then
                mat = TasItemFusion.BuiltWay[data].Mats[index + offset]
                itemCounter[mat] = itemCounter[mat] + 1
                BlzFrameSetVisible(frameObject.IconDone, itemCounter[mat] <= useable.ByType[mat])
                BlzFrameSetVisible(frameObject.IconBroken, not BlzFrameIsVisible(frameObject.IconDone) and not CanBuyItem(mat, LocalShopObject, player))
            end
        end
    end
    local function updateOverLayMainSelected(player)
        local offset = CurrentOffSetUser[player]
        for index, frameObject in ipairs(TasItemShopUI.Frames.User) do
            BlzFrameSetVisible(frameObject.IconDone, BlzFrameIsVisible(frameObject.Button) and ShoperMain[player] == BlzGroupUnitAt(Shoper[player], index - 1 + offset))
        end
    end

    local function setSelected(player, data)
        local oldData = TasItemShopUI.Selected[player]
        TasItemShopUI.Selected[player] = data
        -- Reset RefPage only when a new data is selected
        if oldData ~= data then
            CurrentOffSetUpgrade[player] = 0
            CurrentOffSetMaterial[player] = 0
            TasItemShopUI.SelectedItem[player] = nil
            if player == GetLocalPlayer() then
                if canDefuse then BlzFrameSetEnable(TasItemShopUI.Frames.DefuseButton, false) end
                if canSellItems then BlzFrameSetEnable(TasItemShopUI.Frames.SellButton, false) end
            end
        end
        if player == GetLocalPlayer() then
            TasItemShopUI.MarkedItemCodes[oldData] = false
            TasItemShopUI.MarkedItemCodes[data] = true
            if refButtonCountUp > 0 then
                if TasItemFusion.UsedIn[data] then
                    updateRefButtons(TasItemFusion.UsedIn[data], TasItemShopUI.Frames.BoxUpgrades, TasItemShopUI.Frames.Upgrades, CurrentOffSetUpgrade[player], true)
                else
                    BlzFrameSetVisible(TasItemShopUI.Frames.BoxUpgrades, false)
                end
            end
            if refButtonCountMats > 0 then
                if TasItemFusion.BuiltWay[data] then
                    updateRefButtons(TasItemFusion.BuiltWay[data].Mats, TasItemShopUI.Frames.BoxMaterial, TasItemShopUI.Frames.Material, CurrentOffSetMaterial[player])
                    updateHaveMats(player, data)
                else
                    BlzFrameSetVisible(TasItemShopUI.Frames.BoxMaterial, false)
                end
            end
            if refButtonCountInv > 0 then
                if not inventoryShowMainOnly then
                    if TasItemFusion.Player[player].UseAble.Count > 0 then
                        updateRefButtons(TasItemFusion.Player[player].UseAble, TasItemShopUI.Frames.BoxInventory, TasItemShopUI.Frames.Inventory, CurrentOffSetInventory[player])
                    else
                        BlzFrameSetVisible(TasItemShopUI.Frames.BoxInventory, false)
                    end
                else
                    TasItemShopUI.TempTable.Count = bj_MAX_INVENTORY
                    for i = 0, bj_MAX_INVENTORY - 1 do
                        TasItemShopUI.TempTable[i + 1] = UnitItemInSlot(ShoperMain[player], i)
                    end
                    updateRefButtons(TasItemShopUI.TempTable, TasItemShopUI.Frames.BoxInventory, TasItemShopUI.Frames.Inventory, CurrentOffSetInventory[player])
                    BlzFrameSetVisible(TasItemShopUI.Frames.BoxInventory, true)
                end
            end
            if refButtonCountQuickLink > 0 then
                updateRefButtons(TasItemShopUI.QuickLink[player], TasItemShopUI.Frames.BoxQuickLink, TasItemShopUI.Frames.QuickLink, CurrentOffSetQuickLink[player], true)
            end
            if refButtonCountUser > 0 then
                updateRefButtons(Shoper[player], TasItemShopUI.Frames.BoxUser, TasItemShopUI.Frames.User, CurrentOffSetUser[player])
                updateOverLayMainSelected(player)
            end


            updateItemFrame(TasItemShopUI.Frames.Current, data, buyButtonShowGold, buyButtonShowLumber)
            if not flexibleShop and (not CanBuyItem(data, LocalShopObject, GetLocalPlayer()) or (TasItemFusion.BuiltWay[data] and #AllMatsProvided(player, data, LocalShopObject) > 0)) then
                BlzFrameSetText(TasItemShopUI.Frames.Current.TextGold, GetLocalizedString(textUnBuyable))
                BlzFrameSetText(TasItemShopUI.Frames.Current.TextLumber, GetLocalizedString(textUnBuyable))
            end
        end
    end

    local function setSelectedItem(player, item)
        TasItemShopUI.SelectedItem[player] = item
        if item ~= nil then
            local itemCode = GetItemTypeId(item)
            local gold, lumber, charges
            if GetLocalPlayer() == player then
                if canDefuse then
                    BlzFrameSetText(TasItemShopUI.Frames.DefuseText, GetLocalizedString(textDefuse).."\n"..BlzGetAbilityTooltip(itemCode, 0))
                    BlzFrameSetEnable(TasItemShopUI.Frames.DefuseButton, TasItemFusion.BuiltWay[itemCode] ~=nil)
                end

                if canSellItems then
                    BlzFrameSetEnable(TasItemShopUI.Frames.SellButton, true)
                    --BlzFrameSetVisible(TasItemShopUI.Frames.BoxSell, true)
                    gold, lumber, charges = GetItemSellCosts(ShoperMain[player], CurrentShop[player], item)
                    BlzFrameSetText(TasItemShopUI.Frames.SellText, GetLocalizedString(textSell) .. " " .. GetItemName(item) .. "\n" .. GetLocalizedString("GOLD") .. " " .. gold .. "\n"..GetLocalizedString("LUMBER") .." " .. lumber)
                end
            end
        end
    end
    function TasItemShopUI.Create()
        BlzLoadTOCFile("war3mapImported\\Templates.toc")
        BlzLoadTOCFile("war3mapImported\\TasItemShop.toc")

        local frames, parent, object, currentObject, frame
        parent = GetParent()

        if posScreenRelative then
            frame = BlzCreateFrameByType("FRAME", "Fullscreen", parent, "", 0)
            BlzFrameSetVisible(frame, false)
            BlzFrameSetSize(frame, 0.8, 0.6)
            BlzFrameSetAbsPoint(frame, FRAMEPOINT_BOTTOM, 0.4, 0)
            TasItemShopUI.Frames.Fullscreen = frame
        end

        xSize = 0.02 + buttonListCols*buttonListButtonSizeX + buttonListButtonGapCol * (buttonListCols - 1)
        --ySize = 0.1285 + buttonListRows*buttonListButtonSizeY + refButtonBoxSizeY
        ySize = 0.0815 + buttonListRows*buttonListButtonSizeY + buttonListButtonGapRow * (buttonListRows - 1)

        -- super
        TasItemShopUI.Frames.ParentSuper = BlzCreateFrameByType("FRAME", "TasItemShopUI", parent, "", 0)
        BlzFrameSetSize(TasItemShopUI.Frames.ParentSuper, 0.001, 0.001)

        parent = BlzCreateFrameByType("BUTTON", "TasItemShopUI", TasItemShopUI.Frames.ParentSuper, "", 0)
        BlzFrameSetSize(parent, xSize, ySize)
        BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerScrollParent, parent, FRAMEEVENT_MOUSE_WHEEL)
        BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, parent, FRAMEEVENT_CONTROL_CLICK)
        if posScreenRelative then
            BlzFrameSetPoint(parent, posPoint, TasItemShopUI.Frames.Fullscreen, posPoint, xPos, yPos)
        else
            BlzFrameSetAbsPoint(parent, posPoint, xPos, yPos)
        end

        TasItemShopUI.Frames.ParentSuperUI = parent


        frame = BlzCreateFrame(boxFrameName, parent, 0, 0)
        BlzFrameSetAllPoints(frame, parent)
        TasItemShopUI.Frames.BoxSuper = frame

        -- round down, boxSize - 2times gap to border / buttonSize + gap between buttons
        local buttonsInRow = math.floor(0.0 + ((xSize - (boxCatBorderGap)*2)/(categoryButtonSize + 0.003)))
        -- round up
        local rows = math.ceil(0.0+ (#TasItemShopUI.Categories/buttonsInRow))
        --print(#TasItemShopUI.Categories, buttonsInRow, rows)
        ySize = ySize + rows * categoryButtonSize
        -- ButtonList
        parent = BlzCreateFrame(boxButtonListFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
        BlzFrameSetPoint(parent, FRAMEPOINT_TOPRIGHT, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_TOPRIGHT, 0, 0)
        -- baseSizeY = 0.0455
        BlzFrameSetSize(parent, xSize, 0.0455 + buttonListRows*buttonListButtonSizeY + rows * categoryButtonSize + buttonListButtonGapRow * (buttonListRows - 1))
        --ySize = 0.1285 + buttonListRows*buttonListButtonSizeY + refButtonBoxSizeY
        object = CreateTasButtonListEx(buttonListButtonName, buttonListCols, buttonListRows, parent,
                function(clickedData, buttonListObject, dataIndex)
                    local player = GetTriggerPlayer()

                    if player == GetLocalPlayer() then
                        local time = os.clock()
                        if TasItemShopUI.Selected[player] == clickedData and time - DoubleClickStamp <= doubleClickTimeOut then
                            -- finish the timer, so the player has to do 2 clicks again to trigger a DoubleClick
                            DoubleClickStamp = 0
                            BlzFrameClick(TasItemShopUI.Frames.Current.Button)
                        else
                            DoubleClickStamp = time
                        end
                    end
                    if TasItemShopUI.QuickLinkKeyActive[player] then
                        TasItemShopUI.SetQuickLink(player, clickedData)
                    end

                    setSelected(player, clickedData)

                end
        ,function(clickedData, buttonListObject, dataIndex) BuyItem(GetTriggerPlayer(), clickedData) end
        ,updateItemFrame
        ,function(data, searchedText, buttonListObject)
                    --return string.find(GetObjectName(data), searchedText)
                    return string.find(string.lower(GetObjectName(data)), string.lower(searchedText))
                    --return string.find(string.lower(BlzGetAbilityExtendedTooltip(data, 0)), string.lower(searchedText))
                end
        ,function(data, buttonListObject, isTextSearching)
                    local selected = TasItemShopUI.Categories.Value[GetLocalPlayer()]
                    if ToggleIconButtonGetValue(TasItemShopUI.ModeObject, GetLocalPlayer()) == 0 then
                        return selected == 0 or BlzBitAnd(TasItemCategory[data], selected) >= selected
                    else
                        return selected == 0 or BlzBitAnd(TasItemCategory[data], selected) > 0
                    end
                end
        --async Left Click
        ,function(buttonListObject, data, frame)
                end
        --async Rigth Click
        ,function(buttonListObject, data, frame)
                    ShowSprite(frame, GetLocalPlayer())
                end
        ,buttonListButtonGapCol
        ,buttonListButtonGapRow
        )
        TasItemShopUI.ButtonList = object
        TasItemShopUI.Frames.BoxButtonList = parent

        for i, frameObject in ipairs(object.Frames) do
            if buttonListHighLightFrameName then
                frameObject.HighLight = BlzCreateFrame(buttonListHighLightFrameName, frameObject.Button, 0, 0)
                BlzFrameSetAllPoints(frameObject.HighLight, frameObject.Button)
                BlzFrameSetVisible(frameObject.HighLight, false)
            end

        end


        -- category
        frame = BlzCreateFrame(boxCatFrameName, parent, 0, 0)
        BlzFrameSetPoint(frame, FRAMEPOINT_TOPRIGHT, TasItemShopUI.ButtonList.InputFrame, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
        BlzFrameSetSize(frame, xSize, 0.0135 + rows * categoryButtonSize)
        TasItemShopUI.Frames.BoxCategory = frame
        parent = frame
        frames = {}
        local groupObject = CreateToggleIconButtonGroup(true, function(groupObject, buttonObject, player, groupValue)
            TasItemShopUI.Categories.Value[player] = groupValue
            TasButtonListSearch(TasItemShopUI.ButtonList)
        end)
        ToggleIconButton.DefaultSizeX = categoryButtonSize
        ToggleIconButton.DefaultSizeY = categoryButtonSize
        --frame = ToggleIconButtonGroupModeButton(groupObject, parent).Button
        local clearButton = ToggleIconButtonGroupClearButton(groupObject, parent)
        --BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_TOPLEFT, boxFrameBorderGap, -boxFrameBorderGap)
        BlzFrameSetPoint(clearButton, FRAMEPOINT_TOPLEFT, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_TOPLEFT, boxFrameBorderGap, -boxFrameBorderGap)
        BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearButton, clearButton, FRAMEEVENT_CONTROL_CLICK)
        BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, clearButton, FRAMEEVENT_CONTROL_CLICK)

        local modeObject = CreateToggleIconButton(parent, 1, GetLocalizedString(categoryModeTextOr), categoryModeIconOr, 0, GetLocalizedString(categoryModeTextAnd), categoryModeIconAnd)
        BlzFrameSetPoint(modeObject.Button, FRAMEPOINT_BOTTOMLEFT, clearButton, FRAMEPOINT_BOTTOMRIGHT, 0.003, 0)
        modeObject.Action = function()
            if GetTriggerPlayer() == GetLocalPlayer() then
                TasButtonListSearch(TasItemShopUI.ButtonList)
            end
        end
        TasItemShopUI.ModeObject = modeObject


        for index, value in ipairs(TasItemShopUI.Categories) do
            frames[index] = CreateToggleIconButton(parent, CategoryValue[index], GetLocalizedString(value[2]), value[1])
            if index == 1 then
                BlzFrameSetPoint(frames[index].Button, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_TOPLEFT, boxCatBorderGap, -boxCatBorderGap)
            else
                BlzFrameSetPoint(frames[index].Button, FRAMEPOINT_TOPLEFT, frames[index - 1].Button, FRAMEPOINT_TOPRIGHT, 0.003, 0)
            end
            ToggleIconButtonGroupAddButton(groupObject, frames[index])
        end

        for index = 2, rows, 1 do
            --    print((index-1)*buttonsInRow + 1, "->", (index-2)*buttonsInRow + 1)
            BlzFrameSetPoint(frames[(index-1)*buttonsInRow + 1].Button, FRAMEPOINT_TOPLEFT, frames[(index-2)*buttonsInRow + 1].Button, FRAMEPOINT_BOTTOMLEFT, 0, -0.001)
        end

        frame = TasItemShopUI.ButtonList.Frames[1].Button
        BlzFrameClearAllPoints(frame)
        BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, TasItemShopUI.Frames.BoxCategory, FRAMEPOINT_BOTTOMLEFT, 0.0045, 0)


        if toolTipPosY and toolTipPosX then
            for i, v in ipairs(TasItemShopUI.ButtonList.Frames) do
                BlzFrameClearAllPoints(v.ToolTipFrameText)
                if toolTipPosPointParent then
                    BlzFrameSetPoint(v.ToolTipFrameText, toolTipPosPoint, v.Button, toolTipPosPointParent, toolTipPosX, toolTipPosY)
                else
                    BlzFrameSetAbsPoint(v.ToolTipFrameText, toolTipPosPoint, toolTipPosX, toolTipPosY)
                end
            end
        end


        local function CreateRefButtons(amount, parent, textFrame, trigger, haveTooltip)
            frames = {}
            for index = 1, amount do
                frames[index] = {
                    Button = BlzCreateFrame("TasItemShopRefButton", parent, 0, 0),
                }
                frame = frames[index].Button
                BlzFrameSetText(frame, index)
                frames[index].Icon = BlzGetFrameByName("TasItemShopRefButtonBackdrop", 0)
                frames[index].IconPushed = BlzGetFrameByName("TasItemShopRefButtonBackdropPushed", 0)
                frames[index].IconDone = BlzGetFrameByName("TasItemShopRefButtonBackdropBackdrop", 0)
                frames[index].IconBroken = BlzGetFrameByName("TasItemShopRefButtonBackdropBackdrop2", 0)
                BlzFrameSetSize(frame, refButtonSize, refButtonSize)

                BlzFrameSetVisible(frames[index].IconDone, false)
                BlzFrameSetVisible(frames[index].IconBroken, false)
                if haveTooltip then
                    CreateTasButtonTooltip(frames[index], TasItemShopUI.Frames.BoxSuper)

                    if toolTipPosY and toolTipPosX then
                        BlzFrameClearAllPoints(frames[index].ToolTipFrameText)
                        if toolTipPosPointParent then
                            BlzFrameSetPoint(frames[index].ToolTipFrameText, toolTipPosPoint, frames[index].Button, toolTipPosPointParent, toolTipPosX, toolTipPosY)
                        else
                            BlzFrameSetAbsPoint(frames[index].ToolTipFrameText, toolTipPosPoint, toolTipPosX, toolTipPosY)
                        end
                    end
                end
                if index == 1 then
                    BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, textFrame, FRAMEPOINT_BOTTOMLEFT, 0.0, -0.003)
                    --elseif index == 5 then
                    -- BlzFrameSetPoint(frame, FRAMEPOINT_BOTTOMLEFT, frames[index - 4].Button, FRAMEPOINT_TOPLEFT, 0, 0.003)
                else
                    BlzFrameSetPoint(frame, FRAMEPOINT_BOTTOMLEFT, frames[index - 1].Button, FRAMEPOINT_BOTTOMRIGHT, refButtonGap, 0)
                end

                BlzTriggerRegisterFrameEvent(trigger, frame, FRAMEEVENT_CONTROL_CLICK)
                BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, frame, FRAMEEVENT_CONTROL_CLICK)

                BlzTriggerRegisterFrameEvent(trigger, frame, FRAMEEVENT_MOUSE_UP)

            end
            return frames
        end
        local function MakeRefButtonsCol(box, textFrame, frames)
            BlzFrameClearAllPoints(box)
            BlzFrameClearAllPoints(frames.PageDown)
            BlzFrameSetPoint(frames.PageDown, FRAMEPOINT_TOPRIGHT, textFrame, FRAMEPOINT_BOTTOMRIGHT, 0.0, -refButtonGap)
            for i, v in ipairs(frames) do

                BlzFrameClearAllPoints(v.Button)
                if i == 1 then
                    BlzFrameSetPoint(v.Button, FRAMEPOINT_TOP, box, FRAMEPOINT_TOP, 0.0, -BlzFrameGetHeight(textFrame) - refButtonPageSize -refButtonGap*2 -boxFrameBorderGap)
                else
                    BlzFrameSetPoint(v.Button, FRAMEPOINT_TOPLEFT, frames[i - 1].Button, FRAMEPOINT_BOTTOMLEFT, 0, -refButtonGap)
                end
            end
            BlzFrameSetSize(box, BlzFrameGetWidth(textFrame) + boxFrameBorderGap*2 , (refButtonSize + refButtonGap)*#frames + refButtonPageSize + boxFrameBorderGap*2)
        end
        local function CreateRefPage(parent, textFrame, trigger, pageSize, refButtons)
            frames = {}

            frames[1] = BlzCreateFrameByType("FRAME", "TasItemShopUIPageControl", parent, "", 0)
            frames[2] = BlzCreateFrame("TasItemShopCatButton", frames[1], 0, 0)
            frames[3] = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
            frames[4] = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
            frames[5] = BlzCreateFrame("TasItemShopCatButton", frames[1], 0, 0)
            frames[6] = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
            frames[7] = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
            frames[8] = BlzCreateFrame("TasButtonTextTemplate", frames[1], 0, 0)
            BlzFrameSetText(frames[8], "00")
            BlzFrameSetSize(frames[2], refButtonPageSize, refButtonPageSize)
            BlzFrameSetSize(frames[5], refButtonPageSize, refButtonPageSize)
            BlzTriggerRegisterFrameEvent(trigger, frames[2], FRAMEEVENT_CONTROL_CLICK)
            BlzTriggerRegisterFrameEvent(trigger, frames[2], FRAMEEVENT_MOUSE_UP)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, frames[2], FRAMEEVENT_CONTROL_CLICK)
            BlzTriggerRegisterFrameEvent(trigger, frames[5], FRAMEEVENT_CONTROL_CLICK)
            BlzTriggerRegisterFrameEvent(trigger, frames[5], FRAMEEVENT_MOUSE_UP)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, frames[5], FRAMEEVENT_CONTROL_CLICK)
            BlzFrameSetTexture(frames[3], refButtonPageUp, 0, false)
            BlzFrameSetTexture(frames[4], refButtonPageUp, 0, false)
            BlzFrameSetTexture(frames[6], refButtonPageDown, 0, false)
            BlzFrameSetTexture(frames[7], refButtonPageDown, 0, false)

            --BlzFrameSetPoint(frames[2], FRAMEPOINT_TOPLEFT, textFrame, FRAMEPOINT_TOPRIGHT, 0.003, 0)
            --BlzFrameSetPoint(frames[8], FRAMEPOINT_TOPLEFT, frames[2], FRAMEPOINT_TOPRIGHT, 0.003, 0)
            --BlzFrameSetPoint(frames[5], FRAMEPOINT_TOPLEFT, frames[8], FRAMEPOINT_TOPRIGHT, 0.003, 0)

            BlzFrameSetPoint(frames[2], FRAMEPOINT_TOPRIGHT, frames[8], FRAMEPOINT_TOPLEFT, -0.003, 0)
            BlzFrameSetPoint(frames[8], FRAMEPOINT_TOPRIGHT, frames[5], FRAMEPOINT_TOPLEFT, -0.003, 0)
            BlzFrameSetPoint(frames[5], FRAMEPOINT_TOPRIGHT, parent, FRAMEPOINT_TOPRIGHT, -boxFrameBorderGap, -boxFrameBorderGap)

            --BlzFrameSetPoint(frames[2], FRAMEPOINT_TOPLEFT, textFrame, FRAMEPOINT_BOTTOMLEFT, 0, -0.003)
            --BlzFrameSetPoint(frames[8], FRAMEPOINT_TOPLEFT, textFrame, FRAMEPOINT_TOPRIGHT, 0.003, 0)
            --BlzFrameSetPoint(frames[5], FRAMEPOINT_TOPLEFT, frames[2], FRAMEPOINT_BOTTOMLEFT, 0, -0.003)


            --CreateTasButtonTooltip(frames[index], TasItemShopUI.Frames.BoxSuper)
            TasItemShopUI.Frames[frames[2]] = pageSize
            TasItemShopUI.Frames[frames[5]] = -pageSize

            refButtons.Page = frames[1]
            refButtons.PageUp = frames[2]
            refButtons.PageDown = frames[5]
            refButtons.PageText = frames[8]
            return frames
        end
        local refRows = {}

        local function PlaceRefButtonBox(box)
            BlzFrameClearAllPoints(box)
            if #refRows == 0 then
                BlzFrameSetPoint(box, FRAMEPOINT_TOPRIGHT, TasItemShopUI.Frames.BoxButtonList, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
                refRows[1] = {xSize - BlzFrameGetWidth(box), box}
                ySize = ySize + refButtonBoxSizeY
                BlzFrameSetSize(TasItemShopUI.Frames.ParentSuperUI, xSize, ySize)
                return #refRows
            else
                local found = false
                for i, v in ipairs(refRows) do
                    if v[1] - BlzFrameGetWidth(box) >= 0 then
                        found = true
                        BlzFrameSetPoint(box, FRAMEPOINT_TOPRIGHT, v[#v], FRAMEPOINT_TOPLEFT, 0, 0)
                        table.insert(v, box)
                        v[1] = v[1] - BlzFrameGetWidth(box)
                        return i
                    end
                end
                if not found then
                    BlzFrameSetPoint(box, FRAMEPOINT_TOPRIGHT, refRows[#refRows][2], FRAMEPOINT_BOTTOMRIGHT, 0, 0)
                    table.insert(refRows, {xSize - BlzFrameGetWidth(box), box})
                    ySize = ySize + refButtonBoxSizeY
                    BlzFrameSetSize(TasItemShopUI.Frames.ParentSuperUI, xSize, ySize)
                    return #refRows
                end
            end

        end

        local function PlaceRefButtonBoxCol(box)

            if #refRows == 0 then
                BlzFrameSetPoint(box, FRAMEPOINT_TOPRIGHT, TasItemShopUI.Frames.ParentSuperUI, FRAMEPOINT_TOPLEFT, 0, 0)
                refRows[1] = {ySize - BlzFrameGetHeight(box), box}
                return #refRows
            else
                local found = false
                for i, v in ipairs(refRows) do
                    if v[1] - BlzFrameGetHeight(box) >= 0 then
                        found = true
                        BlzFrameSetPoint(box, FRAMEPOINT_TOPRIGHT, v[#v], FRAMEPOINT_BOTTOMRIGHT, 0, 0)
                        table.insert(v, box)

                        v[1] = v[1] - BlzFrameGetHeight(box)
                        return i
                        --break
                    end
                end
                if not found then
                    BlzFrameSetPoint(box, FRAMEPOINT_TOPRIGHT, refRows[#refRows][2], FRAMEPOINT_TOPLEFT, 0, 0)
                    table.insert(refRows, {ySize - BlzFrameGetHeight(box), box})
                    return #refRows
                end
            end
        end


        -- built from
        if refButtonCountMats > 0 then
            parent = BlzCreateFrame(boxRefFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, (refButtonSize + refButtonGap)*refButtonCountMats + boxFrameBorderGap*2, refButtonBoxSizeY)
            local row = PlaceRefButtonBox(parent)
            TasItemShopUI.Frames.BoxMaterial = parent

            frame = BlzCreateFrame("TasButtonTextTemplate", parent, 0, 0)
            BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_TOPLEFT, boxRefBorderGap, -boxRefBorderGap)
            BlzFrameSetText(frame, GetLocalizedString(textMats))
            TasItemShopUI.Frames.MaterialText = frame

            TasItemShopUI.Frames.Material = CreateRefButtons(refButtonCountMats, parent, frame, TasItemShopUI.TriggerMaterial, true)

            CreateRefPage(parent, TasItemShopUI.Frames.MaterialText, TasItemShopUI.TriggerMaterialPage, refButtonCountMats, TasItemShopUI.Frames.Material)
        end

        -- possible upgrades
        if refButtonCountUp > 0 then
            parent = BlzCreateFrame(boxRefFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, (refButtonSize + refButtonGap)*refButtonCountUp + boxFrameBorderGap*2, refButtonBoxSizeY)
            local row = PlaceRefButtonBox(parent)
            TasItemShopUI.Frames.BoxUpgrades = parent

            frame = BlzCreateFrame("TasButtonTextTemplate", parent, 0, 0)
            BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_TOPLEFT, boxRefBorderGap, -boxRefBorderGap)
            BlzFrameSetText(frame, GetLocalizedString(textUpgrades))
            TasItemShopUI.Frames.UpgradesText = frame

            TasItemShopUI.Frames.Upgrades = CreateRefButtons(refButtonCountUp, parent, frame, TasItemShopUI.TriggerUpgrade, true)

            CreateRefPage(parent, TasItemShopUI.Frames.UpgradesText, TasItemShopUI.TriggerUpgradePage, refButtonCountUp, TasItemShopUI.Frames.Upgrades)
        end

        -- ShortCuts
        if refButtonCountQuickLink > 0 then
            parent = BlzCreateFrame(boxRefFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, (refButtonSize + refButtonGap)*refButtonCountQuickLink + boxFrameBorderGap*2, refButtonBoxSizeY)
            local row = PlaceRefButtonBox(parent)
            TasItemShopUI.Frames.BoxQuickLink = parent

            frame = BlzCreateFrame("TasButtonTextTemplate", parent, 0, 0)
            BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_TOPLEFT, boxRefBorderGap, -boxRefBorderGap)
            BlzFrameSetText(frame, GetLocalizedString(textQuickLink))
            TasItemShopUI.Frames.QuickLinkText = frame

            TasItemShopUI.Frames.QuickLinkHighLight = BlzCreateFrame(buttonListHighLightFrameName, parent, 0, 0)
            BlzFrameSetAllPoints(TasItemShopUI.Frames.QuickLinkHighLight, parent)
            BlzFrameSetVisible(TasItemShopUI.Frames.QuickLinkHighLight, false)

            TasItemShopUI.Frames.QuickLink = CreateRefButtons(refButtonCountQuickLink, parent, frame, TasItemShopUI.TriggerQuickLink, true)

            CreateRefPage(parent, TasItemShopUI.Frames.QuickLinkText, TasItemShopUI.TriggerQuickLinkPage, refButtonCountQuickLink, TasItemShopUI.Frames.QuickLink)
        end

        -- Inventory
        if refButtonCountInv > 0 then
            parent = BlzCreateFrame(boxRefFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, (refButtonSize + refButtonGap)*refButtonCountInv + boxFrameBorderGap*2, refButtonBoxSizeY)
            local row = PlaceRefButtonBox(parent)

            TasItemShopUI.Frames.BoxInventory = parent

            frame = BlzCreateFrame("TasButtonTextTemplate", parent, 0, 0)
            BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_TOPLEFT, boxRefBorderGap, -boxRefBorderGap)
            BlzFrameSetText(frame, GetLocalizedString(textInventory))
            TasItemShopUI.Frames.InventoryText = frame

            TasItemShopUI.Frames.Inventory = CreateRefButtons(refButtonCountInv, parent, frame, TasItemShopUI.TriggerInventory, true)

            for i, v in ipairs(TasItemShopUI.Frames.Inventory) do
                BlzFrameSetTexture(v.IconDone, MainItemTexture, 0, true)
            end

            CreateRefPage(parent, TasItemShopUI.Frames.InventoryText, TasItemShopUI.TriggerInventoryPage, refButtonCountInv, TasItemShopUI.Frames.Inventory)
        end

        -- User
        if refButtonCountUser > 0 then
            parent = BlzCreateFrame(boxRefFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, (refButtonSize + refButtonGap)*refButtonCountUser + boxFrameBorderGap*2, refButtonBoxSizeY)

            PlaceRefButtonBox(parent)
            if refBoxUserPos then
                PlaceRefButtonBoxFree(parent, refBoxUserPos, refBoxUserRelative, refBoxUserPosRelative, refBoxUserX, refBoxUserY, refBoxUserDirection)
            else

            end
            TasItemShopUI.Frames.BoxUser = parent

            frame = BlzCreateFrame("TasButtonTextTemplate", parent, 0, 0)
            BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_TOPLEFT, boxRefBorderGap, -boxRefBorderGap)
            BlzFrameSetText(frame, GetLocalizedString(textUser))
            TasItemShopUI.Frames.UserText = frame
            TasItemShopUI.Frames.User = CreateRefButtons(refButtonCountUser, parent, frame, TasItemShopUI.TriggerUser, false)


            for i, v in ipairs(TasItemShopUI.Frames.User) do
                BlzFrameSetTexture(v.IconDone, MainUserTexture, 0, true)
                v.ToolTipFrameText = CreateSimpleTooltip(v.Button, "User")
            end

            CreateRefPage(parent, TasItemShopUI.Frames.UserText, TasItemShopUI.TriggerUserPage, refButtonCountUser, TasItemShopUI.Frames.User)
        end

        local frameObject = {}
        frameObject.Index = int

        frameObject.Button = BlzCreateFrame("TasButton", TasItemShopUI.Frames.BoxSuper, 0, 0)
        CreateTasButtonTooltip(frameObject, TasItemShopUI.Frames.BoxSuper)

        frameObject.Icon = BlzGetFrameByName("TasButtonIcon", 0)
        frameObject.Text = BlzGetFrameByName("TasButtonText", 0)
        frameObject.IconGold = BlzGetFrameByName("TasButtonIconGold", 0)
        frameObject.TextGold = BlzGetFrameByName("TasButtonTextGold", 0)
        frameObject.IconLumber = BlzGetFrameByName("TasButtonIconLumber", 0)
        frameObject.TextLumber = BlzGetFrameByName("TasButtonTextLumber", 0)
        BlzFrameSetPoint(frameObject.Button, FRAMEPOINT_BOTTOM, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_BOTTOM, 0, boxFrameBorderGap)
        TasItemShopUI.Frames.Current = frameObject
        currentObject = frameObject
        BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerBuy, currentObject.Button, FRAMEEVENT_CONTROL_CLICK)
        BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, currentObject.Button, FRAMEEVENT_CONTROL_CLICK)


        frame = BlzCreateFrame("TasButtonTextTemplate", TasItemShopUI.Frames.BoxSuper, 0, 0)
        BlzFrameSetPoint(frame, FRAMEPOINT_BOTTOMRIGHT, TasItemShopUI.ButtonList.InputFrame, FRAMEPOINT_BOTTOMLEFT, -boxFrameBorderGap, 0)
        BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, modeObject.Button, FRAMEPOINT_TOPRIGHT, boxFrameBorderGap, 0)
        BlzFrameSetTextAlignment(frame, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)
        BlzFrameSetText(frame, "Name")
        TasItemShopUI.Frames.TitelText = frame

        BlzFrameClearAllPoints(currentObject.ToolTipFrameText)
        if toolTipPosPointParent then
            BlzFrameSetPoint(currentObject.ToolTipFrameText, toolTipPosPoint, currentObject.Button, toolTipPosPointParent, toolTipPosX, toolTipPosY)
        else
            BlzFrameSetAbsPoint(currentObject.ToolTipFrameText, toolTipPosPoint, toolTipPosX, toolTipPosY)
        end

        if canUndo then
            parent = BlzCreateFrame(boxUndoFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, refButtonSize + boxUndoBorderGap*2, refButtonSize + boxUndoBorderGap*2)
            BlzFrameSetPoint(parent, FRAMEPOINT_BOTTOMLEFT, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_BOTTOMLEFT, 0.00, 0.00)
            TasItemShopUI.Frames.BoxUndo = parent
            TasItemShopUI.Frames.UndoButton = BlzCreateFrame("TasItemShopCatButton", parent, 0, 0)
            TasItemShopUI.Frames.UndoButtonIcon = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
            TasItemShopUI.Frames.UndoButtonIconPushed = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
            TasItemShopUI.Frames.UndoText = CreateSimpleTooltip(TasItemShopUI.Frames.UndoButton, textUndo)

            frame = TasItemShopUI.Frames.UndoButton
            BlzFrameSetSize(frame, refButtonSize, refButtonSize)
            BlzFrameSetPoint(frame, FRAMEPOINT_CENTER, parent, FRAMEPOINT_CENTER, 0, 0)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerUndo, frame, FRAMEEVENT_CONTROL_CLICK)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, frame, FRAMEEVENT_CONTROL_CLICK)
            BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, false)
        end

        if canDefuse then
            parent = BlzCreateFrame(boxDefuseFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, refButtonSize + boxDefuseBorderGap*2, refButtonSize + boxDefuseBorderGap*2)
            BlzFrameSetPoint(parent, FRAMEPOINT_BOTTOMRIGHT, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_BOTTOMRIGHT, 0.00, 0.00)
            TasItemShopUI.Frames.BoxDefuse = parent
            TasItemShopUI.Frames.DefuseButton = BlzCreateFrame("TasItemShopCatButton", parent, 0, 0)
            TasItemShopUI.Frames.DefuseButtonIcon = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
            TasItemShopUI.Frames.DefuseButtonIconPushed = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
            TasItemShopUI.Frames.DefuseButtonIconDisabled = BlzGetFrameByName("TasItemShopCatButtonBackdropDisabled", 0)
            TasItemShopUI.Frames.DefuseText = CreateSimpleTooltip(TasItemShopUI.Frames.DefuseButton, textDefuse)

            BlzFrameSetTexture(TasItemShopUI.Frames.DefuseButtonIcon, DefuseButtonIcon, 0, false)
            BlzFrameSetTexture(TasItemShopUI.Frames.DefuseButtonIconPushed, DefuseButtonIcon, 0, false)
            BlzFrameSetTexture(TasItemShopUI.Frames.DefuseButtonIconDisabled, DefuseButtonIconDisabled, 0, false)
            frame = TasItemShopUI.Frames.DefuseButton
            BlzFrameSetSize(frame, refButtonSize, refButtonSize)
            BlzFrameSetPoint(frame, FRAMEPOINT_CENTER, parent, FRAMEPOINT_CENTER, 0, 0)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerDefuse, frame, FRAMEEVENT_CONTROL_CLICK)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, frame, FRAMEEVENT_CONTROL_CLICK)
            --BlzFrameSetVisible(TasItemShopUI.Frames.BoxDefuse, false)
            BlzFrameSetEnable(TasItemShopUI.Frames.DefuseButton, false)

            BlzFrameClearAllPoints(TasItemShopUI.Frames.DefuseText)
            BlzFrameSetPoint(TasItemShopUI.Frames.DefuseText, FRAMEPOINT_BOTTOMRIGHT, TasItemShopUI.Frames.DefuseButton, FRAMEPOINT_TOPRIGHT, 0, 0.008)
        end
        if canSellItems then
            parent = BlzCreateFrame(boxDefuseFrameName, TasItemShopUI.Frames.BoxSuper, 0, 0)
            BlzFrameSetSize(parent, refButtonSize + boxSellBorderGap*2, refButtonSize + boxSellBorderGap*2)
            if canDefuse then
                BlzFrameSetPoint(parent, FRAMEPOINT_BOTTOMRIGHT, TasItemShopUI.Frames.BoxDefuse, FRAMEPOINT_BOTTOMLEFT, 0.00, 0.00)
            else
                BlzFrameSetPoint(parent, FRAMEPOINT_BOTTOMRIGHT, TasItemShopUI.Frames.BoxSuper, FRAMEPOINT_BOTTOMRIGHT, 0.00, 0.00)
            end

            TasItemShopUI.Frames.BoxSell = parent
            TasItemShopUI.Frames.SellButton = BlzCreateFrame("TasItemShopCatButton", parent, 0, 0)
            TasItemShopUI.Frames.SellButtonIcon = BlzGetFrameByName("TasItemShopCatButtonBackdrop", 0)
            TasItemShopUI.Frames.SellButtonIconDisabled = BlzGetFrameByName("TasItemShopCatButtonBackdropDisabled", 0)
            TasItemShopUI.Frames.SellButtonIconPushed = BlzGetFrameByName("TasItemShopCatButtonBackdropPushed", 0)
            TasItemShopUI.Frames.SellText = CreateSimpleTooltip(TasItemShopUI.Frames.SellButton, textSell)

            BlzFrameSetTexture(TasItemShopUI.Frames.SellButtonIcon, SellButtonIcon, 0, false)
            BlzFrameSetTexture(TasItemShopUI.Frames.SellButtonIconPushed, SellButtonIcon, 0, false)
            BlzFrameSetTexture(TasItemShopUI.Frames.SellButtonIconDisabled, SellButtonIconDisabled, 0, false)
            frame = TasItemShopUI.Frames.SellButton
            BlzFrameSetSize(frame, refButtonSize, refButtonSize)
            BlzFrameSetPoint(frame, FRAMEPOINT_CENTER, parent, FRAMEPOINT_CENTER, 0, 0)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerSell, frame, FRAMEEVENT_CONTROL_CLICK)
            BlzTriggerRegisterFrameEvent(TasItemShopUI.TriggerClearFocus, frame, FRAMEEVENT_CONTROL_CLICK)
            BlzFrameSetEnable(TasItemShopUI.Frames.SellButton, false)

            BlzFrameClearAllPoints(TasItemShopUI.Frames.SellText)
            BlzFrameSetPoint(TasItemShopUI.Frames.SellText, FRAMEPOINT_BOTTOMRIGHT, TasItemShopUI.Frames.SellButton, FRAMEPOINT_TOPRIGHT, 0, 0.008)
        end


        parent = BlzCreateFrameByType("BUTTON", "TasRightClickSpriteParent", TasItemShopUI.Frames.BoxSuper, "", 0)
        BlzFrameSetLevel(parent, 99)
        frame = BlzCreateFrameByType("SPRITE", "TasRightClickSprite", parent, "", 0)
        BlzFrameSetSize(frame, refButtonSize, refButtonSize)
        BlzFrameSetScale(frame, spriteScale)
        BlzFrameSetModel(frame, spriteModel, 0)
        BlzFrameSetVisible(parent, false)
        TasItemShopUI.Frames.SpriteParent = parent
        TasItemShopUI.Frames.Sprite = frame
        if LayoutType == 1 then

        elseif LayoutType == 2 then
            ySize = ySize - refButtonBoxSizeY*#refRows
            BlzFrameSetSize(TasItemShopUI.Frames.ParentSuperUI, xSize, ySize)
            BlzFrameSetPoint(refRows[1][2], FRAMEPOINT_TOPRIGHT, TasItemShopUI.Frames.ParentSuperUI, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
        elseif LayoutType == 3 then
            ySize = ySize - refButtonBoxSizeY*#refRows
            BlzFrameSetSize(TasItemShopUI.Frames.ParentSuperUI, xSize, ySize)
            BlzFrameSetPoint(refRows[1][2], FRAMEPOINT_TOPRIGHT, TasItemShopUI.Frames.ParentSuperUI, FRAMEPOINT_BOTTOMRIGHT, 0, 0)


            --MakeRefButtonsCol(box, textFrame, frames)
            MakeRefButtonsCol(TasItemShopUI.Frames.BoxUser, TasItemShopUI.Frames.UserText, TasItemShopUI.Frames.User)
            MakeRefButtonsCol(TasItemShopUI.Frames.BoxInventory, TasItemShopUI.Frames.InventoryText, TasItemShopUI.Frames.Inventory)
            MakeRefButtonsCol(TasItemShopUI.Frames.BoxMaterial, TasItemShopUI.Frames.MaterialText, TasItemShopUI.Frames.Material)
            MakeRefButtonsCol(TasItemShopUI.Frames.BoxUpgrades, TasItemShopUI.Frames.UpgradesText, TasItemShopUI.Frames.Upgrades)

            refRows = {}
            PlaceRefButtonBoxCol(TasItemShopUI.Frames.BoxUser)
            PlaceRefButtonBoxCol(TasItemShopUI.Frames.BoxInventory)
            PlaceRefButtonBoxCol(TasItemShopUI.Frames.BoxMaterial)
            PlaceRefButtonBoxCol(TasItemShopUI.Frames.BoxUpgrades)


        end
        BlzFrameSetSize(TasItemShopUI.Frames.ParentSuperUI, xSize, ySize)
        BlzFrameSetVisible(TasItemShopUI.Frames.ParentSuper, false)
    end

    function TasItemShopUIShow(player, shop, shopperGroup, mainShoper)
        xpcall(function()
            local flag = (shop ~=nil)

            if player == GetLocalPlayer() then
                BlzFrameSetVisible(TasItemShopUI.Frames.ParentSuper, flag)
                if flag then
                    BlzFrameSetVisible(BlzFrameGetParent(TasItemShopUI.Frames.ParentSuper), true)
                end
            end

            if flag then
                local oldShop = CurrentShop[player]
                local isNewShopType = GetUnitTypeId(oldShop) ~= GetUnitTypeId(shop)
                CurrentShop[player] = shop

                if mainShoper then
                    ShoperMain[player] = mainShoper
                elseif shopperGroup then
                    ShoperMain[player] = FirstOfGroup(shopperGroup)
                end
                if shopperGroup then
                    GroupClear(Shoper[player])
                    -- when a group was given
                    if string.sub(tostring(shopperGroup), 1, 6) == "group:" then
                        BlzGroupAddGroupFast(shopperGroup, Shoper[player])
                    end
                end

                GroupAddUnit(Shoper[player], mainShoper)

                local oldSize = TasItemFusion.Player[player].UseAble.Count
                TasItemFusionGetUseableItems(player, Shoper[player], not sharedItems)

                if oldSize ~= TasItemFusion.Player[player].UseAble.Count then

                    CurrentOffSetInventory[player] = 0
                end
                if isNewShopType then
                    -- has to unmark buyAble
                    local buttonList = TasItemShopUI.ButtonList
                    local shopObject = TasItemShopUI.Shops[GetUnitTypeId(shop)]
                    BUY_ABLE_ITEMS.Marker[player] = {}

                    TasButtonListClearData(buttonList, player)
                    -- has custom Shop Data?
                    if shopObject then
                        -- WhiteListMode?
                        if shopObject.Mode then
                            for i, v in ipairs(shopObject) do
                                TasButtonListAddData(buttonList, v, player)
                                BUY_ABLE_ITEMS.Marker[player][v] = true
                            end
                        else
                            -- BlackListMode
                            for i, v in ipairs(BUY_ABLE_ITEMS) do
                                if type(v) == "string" then
                                    if not shopObject[FourCC(v)] then
                                        TasButtonListAddData(buttonList, FourCC(v), player)
                                        BUY_ABLE_ITEMS.Marker[player][FourCC(v)] = true
                                    end
                                elseif type(v) == "number" then
                                    if not shopObject[v] then
                                        TasButtonListAddData(buttonList, v, player)
                                        BUY_ABLE_ITEMS.Marker[player][v] = true
                                    end
                                end
                            end
                        end
                    else
                        -- none custom Shop, add all data.
                        for i, v in ipairs(BUY_ABLE_ITEMS) do
                            if type(v) == "string" then
                                BUY_ABLE_ITEMS.Marker[player][FourCC(v)] = true
                                TasButtonListAddData(buttonList, FourCC(v), player)
                            elseif type(v) == "number" then
                                TasButtonListAddData(buttonList, v, player)
                                BUY_ABLE_ITEMS.Marker[player][v] = true
                            end
                        end
                    end
                end
                if GetLocalPlayer() == player then
                    if IsUnitType(ShoperMain[player], UNIT_TYPE_HERO) then
                        BlzFrameSetText(TasItemShopUI.Frames.TitelText, GetUnitName(shop) .. " - ".. GetHeroProperName(ShoperMain[player]))
                    else
                        BlzFrameSetText(TasItemShopUI.Frames.TitelText, GetUnitName(shop) .. " - ".. GetUnitName(ShoperMain[player]))
                    end

                    LocalShopObject = TasItemShopUI.Shops[GetUnitTypeId(shop)]
                    if isNewShopType then
                        TasButtonListSearch(TasItemShopUI.ButtonList)
                    end
                end
                UpdateTasButtonList(TasItemShopUI.ButtonList)
                setSelected(player, TasItemShopUI.Selected[player])
                setSelectedItem(player, TasItemShopUI.SelectedItem[player])
            else
                CurrentShop[player] = nil
                if canUndo then
                    -- loop the undo of that player from last to first
                    for i = #TasItemShopUI.Undo[player], 1, -1 do
                        -- remove all used material
                        for _,v in ipairs(TasItemShopUI.Undo[player][i].Items) do
                            SetItemVisible(v[1], true)
                            RemoveItem(v[1])
                        end

                        TasItemShopUI.Undo[player][i].ResultItem = nil
                        TasItemShopUI.Undo[player][i].StackChargesGainer = nil
                        TasItemShopUI.Undo[player][i] = nil
                    end
                    if GetLocalPlayer() == player then
                        BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, false)
                    end

                end
            end
        end, print)
    end


    function TasItemShopUIShowSimple(player, shop, mainShoper)
        TasItemShopUIShow(player, shop, nil, mainShoper)
    end
    local function RefButtonPageChange(current, add, min, max, player)
        local size = math.abs(add)
        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            current = current + add
            if not refButtonPageRotate then
                if current < min then
                    current = min
                end
                if current >= max then
                    current = max - add
                end
            else
                if add > 0 then
                    if current >= max then
                        current = min
                    end
                else
                    if current < min then
                        local remain = ModuloInteger(max, size)
                        -- last page is incomplete?
                        if remain > 0 then
                            current = max - remain
                        else
                            current = max - size
                        end
                    end
                end
            end
        elseif IsRightClick(player) then
            StartSoundForPlayerBJ(player, ToggleIconButton.Sound)
            -- right clicks jump to the first or last Page
            if add > 0 then
                current = max - size
            else
                current = min
            end
        end

        return current
    end
    local function RefButtonAction(itemCode)
        local player = GetTriggerPlayer()
        local frame = BlzGetTriggerFrame()

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            -- print(GetPlayerName(player), "Clicked Material", index)
            setSelected(player, itemCode)
        else
            if IsRightClick(player) then
                ShowSprite(frame, player)
                StartSoundForPlayerBJ(player, ToggleIconButton.Sound)
                BuyItem(player, itemCode)
            end
        end
    end
    function MarkGameStarted()
        real()
        xpcall(function()
            TasItemShopUI.IsReforged = (GetLocalizedString("REFORGED") ~= "REFORGED")
            local function CreateTriggerEx(action)
                local trigger = CreateTrigger()
                TriggerAddAction(trigger, action)
                return trigger
            end

            TasItemShopUI.TriggerClearButton = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                if player == GetLocalPlayer() then
                    BlzFrameSetText(TasItemShopUI.ButtonList.InputFrame, "")
                end
            end)

            TasItemShopUI.TriggerClearFocus = CreateTriggerEx(function()
                local frame = BlzGetTriggerFrame()
                if GetTriggerPlayer() == GetLocalPlayer() then
                    BlzFrameSetEnable(frame, false)
                    BlzFrameSetEnable(frame, true)
                end
                frame = nil
            end)

            TasItemShopUI.TriggerBuy = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local itemCode = TasItemShopUI.Selected[player]
                ShowSprite(BlzGetTriggerFrame(), player)
                BuyItem(player, itemCode)
            end)

            TasItemShopUI.TriggerMaterial = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local itemCode = TasItemShopUI.Selected[player]
                local index = tonumber(BlzFrameGetText(BlzGetTriggerFrame())) + CurrentOffSetMaterial[player]
                RefButtonAction(TasItemFusion.BuiltWay[itemCode].Mats[index])

            end)

            TasItemShopUI.TriggerMaterialPage = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local itemCode = TasItemShopUI.Selected[player]
                local max = #TasItemFusion.BuiltWay[itemCode].Mats
                local min = 0
                local add = TasItemShopUI.Frames[BlzGetTriggerFrame()]

                CurrentOffSetMaterial[player] = RefButtonPageChange(CurrentOffSetMaterial[player], add, min, max, player)
                if GetLocalPlayer() == player then
                    updateRefButtons(TasItemFusion.BuiltWay[itemCode].Mats, TasItemShopUI.Frames.BoxMaterial, TasItemShopUI.Frames.Material, CurrentOffSetMaterial[player])
                    updateHaveMats(player, itemCode)
                end
            end)

            TasItemShopUI.TriggerUpgrade = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local itemCode = TasItemShopUI.Selected[player]
                local index = tonumber(BlzFrameGetText(BlzGetTriggerFrame())) + CurrentOffSetUpgrade[player]
                RefButtonAction(TasItemFusion.UsedIn[itemCode][index].Result)
            end)



            TasItemShopUI.TriggerUpgradePage = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local itemCode = TasItemShopUI.Selected[player]
                local max = #TasItemFusion.UsedIn[itemCode]
                local min = 0
                local add = TasItemShopUI.Frames[BlzGetTriggerFrame()]

                CurrentOffSetUpgrade[player] = RefButtonPageChange(CurrentOffSetUpgrade[player], add, min, max, player)
                if GetLocalPlayer() == player then
                    updateRefButtons(TasItemFusion.UsedIn[itemCode], TasItemShopUI.Frames.BoxUpgrades, TasItemShopUI.Frames.Upgrades, CurrentOffSetUpgrade[player])
                end
            end)

            TasItemShopUI.TriggerQuickLink = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local index = tonumber(BlzFrameGetText(BlzGetTriggerFrame())) + CurrentOffSetQuickLink[player]
                local itemCode = TasItemShopUI.QuickLink[player][index]
                if TasItemShopUI.QuickLinkKeyActive[player] and BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
                    TasItemShopUI.SetQuickLink(player, itemCode)
                else
                    RefButtonAction(itemCode)
                end

            end)

            TasItemShopUI.TriggerQuickLinkPage = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local max = #TasItemShopUI.QuickLink[player]
                local min = 0
                local add = TasItemShopUI.Frames[BlzGetTriggerFrame()]

                CurrentOffSetQuickLink[player] = RefButtonPageChange(CurrentOffSetQuickLink[player], add, min, max, player)
                if GetLocalPlayer() == player then
                    updateRefButtons(TasItemShopUI.QuickLink[player], TasItemShopUI.Frames.BoxQuickLink, TasItemShopUI.Frames.QuickLink, CurrentOffSetQuickLink[player])
                end
            end)

            TasItemShopUI.TriggerInventory = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local frame = BlzGetTriggerFrame()
                local index = tonumber(BlzFrameGetText(frame)) + CurrentOffSetInventory[player]
                local item
                if inventoryShowMainOnly then
                    -- warcraft inventory starts with 0 but button indexes with 1
                    item = UnitItemInSlot(ShoperMain[player], index - 1)
                else
                    item = TasItemFusion.Player[player].UseAble[index]
                end
                local itemCode = GetItemTypeId(item)

                -- prevent a possible desync when the inventory item was not given to TasItemCost yet. TasItemCost creates and destroys an item when a new type is given.
                TasItemCaclCost(itemCode)

                if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
                    -- print(GetPlayerName(player), "Clicked Material", index)
                    setSelected(player, itemCode)
                    setSelectedItem(player, item)
                else
                    if IsRightClick(player) then
                        ShowSprite(frame, player)
                        StartSoundForPlayerBJ(player, ToggleIconButton.Sound)
                        if canSellItems and inventoryRightClickSell then
                            SellItem(player, item)
                        else
                            BuyItem(player, itemCode)
                            setSelectedItem(player, item)
                        end
                    end
                end

            end)

            TasItemShopUI.TriggerInventoryPage = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local max = TasItemFusion.Player[player].UseAble.Count
                local min = 0
                local add = TasItemShopUI.Frames[BlzGetTriggerFrame()]

                CurrentOffSetInventory[player] = RefButtonPageChange(CurrentOffSetInventory[player], add, min, max, player)

                if GetLocalPlayer() == player then
                    updateRefButtons(TasItemFusion.Player[player].UseAble, TasItemShopUI.Frames.BoxInventory, TasItemShopUI.Frames.Inventory, CurrentOffSetInventory[player])
                end

            end)



            TasItemShopUI.TriggerUndo = CreateTriggerEx(function()

                xpcall(function()
                    local player = GetTriggerPlayer()
                    if #TasItemShopUI.Undo[player] < 1 then return end
                    local undo = table.remove(TasItemShopUI.Undo[player])

                    --print("Use Undo:",#TasItemShopUI.Undo[player] + 1, GetObjectName(undo.Result))
                    AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_GOLD, undo.Gold)
                    AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_LUMBER, undo.Lumber)

                    -- find the result and destroy it, this assumes that the shoper Group not changed since the buying
                    for i, v in ipairs(undo.ResultItem) do RemoveItem(v[1]) undo.ResultItem[i][1] = nil end

                    if undo.StackChargesGainer then
                        SetItemCharges(undo.StackChargesGainer, GetItemCharges(undo.StackChargesGainer) - undo.StackCharges)
                        undo.StackChargesGainer = nil
                    end
                    -- show the used material and give them back
                    for i,v in ipairs(undo.Items) do
                        SetItemVisible(v[1], true)
                        UnitAddItem(v[2], v[1])
                    end
                    TasItemShopUIShow(player, CurrentShop[player])
                    if GetLocalPlayer() == player then

                        if #TasItemShopUI.Undo[GetLocalPlayer()] > 0 then
                            BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, true)
                            updateUndoButton(TasItemShopUI.Undo[player][#TasItemShopUI.Undo[player]].Result, TasItemShopUI.Undo[player][#TasItemShopUI.Undo[player]].ActionName)
                        else
                            BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, false)
                        end
                    end
                end, print)
            end)

            TasItemShopUI.TriggerSell = CreateTriggerEx(function()
                SellItem(GetTriggerPlayer(), TasItemShopUI.SelectedItem[GetTriggerPlayer()])
            end)

            TasItemShopUI.TriggerDefuse = CreateTriggerEx(function()

                xpcall(function()

                    local player = GetTriggerPlayer()
                    if not TasItemShopUI.SelectedItem[player] then return end
                    local item = TasItemShopUI.SelectedItem[player]
                    local itemCode = GetItemTypeId(item)
                    TasItemShopUI.SelectedItem[player] = nil

                    local gold, lumber = TasItemGetCost(itemCode)
                    local gold2, lumber2
                    for i, v in ipairs(TasItemFusion.BuiltWay[itemCode].Mats) do
                        gold2, lumber2 = TasItemGetCost(v)
                        gold = gold - gold2
                        lumber = lumber - lumber2
                    end

                    AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_GOLD, gold)
                    AdjustPlayerStateSimpleBJ(player, PLAYER_STATE_RESOURCE_LUMBER, lumber)
                    local undo
                    if canUndo then
                        undo = {ResultItem = {}, Result = itemCode, Gold = -gold, Lumber = -lumber, Items = {}, ActionName = GetLocalizedString(textDefuse)}
                        table.insert(TasItemShopUI.Undo[player], undo)
                        for i = 0, BlzGroupGetSize(Shoper[player]) - 1, 1 do
                            owner = BlzGroupUnitAt(Shoper[player], i)
                            if UnitHasItem(owner, item) then
                                UnitRemoveItem(owner, item)
                                SetItemVisible(item, false)
                                undo.Items[1] = {item, owner}
                                break
                            end
                        end

                        if GetLocalPlayer() == player then
                            BlzFrameSetVisible(TasItemShopUI.Frames.BoxUndo, true)
                            updateUndoButton(undo.Result, GetLocalizedString(textDefuse))
                        end
                    else
                        RemoveItem(item)
                    end

                    for i, v in ipairs(TasItemFusion.BuiltWay[itemCode].Mats) do
                        item = CreateItem(v, GetUnitX(ShoperMain[player]), GetUnitY(ShoperMain[player]))
                        GiveItemGroup(player, item, undo)
                    end

                    if GetLocalPlayer() == player then
                        --BlzFrameSetVisible(TasItemShopUI.Frames.BoxDefuse, false)
                        BlzFrameSetEnable(TasItemShopUI.Frames.DefuseButton, false)
                    end
                end, print)
            end)

            local tempGroup = CreateGroup()
            local function ShopSelectionAction(player, shop, target)
                xpcall(function()
                    -- is a registered shop UnitType?
                    if TasItemShopUI.Shops[GetUnitTypeId(shop)] then
                        local range = TasItemShopUI.Shops[GetUnitTypeId(shop)].Range
                        if not range then range = shopRange end
                        GroupEnumUnitsInRange(tempGroup, GetUnitX(shop), GetUnitY(shop), range + 400, nil)
                        -- remove unallowed shoppers

                        ForGroup(tempGroup, function()
                            if not IsValidShopper(player, shop, GetEnumUnit(), range) then
                                GroupRemoveUnit(tempGroup, GetEnumUnit())
                            end
                        end)
                        if not target and IsUnitInGroup(ShoperMain[player], tempGroup) then
                            target = ShoperMain[player]
                        end

                        TasItemShopUIShow(player, shop, tempGroup, target)
                        -- no, end shopping!
                    elseif CurrentShop[player] then
                        TasItemShopUIShow(player)
                    end
                end, print)
            end
            TasItemShopUI.TriggerSelect = CreateTriggerEx(function()
                ShopSelectionAction(GetTriggerPlayer(), GetTriggerUnit())
            end)
            TriggerRegisterAnyUnitEventBJ(TasItemShopUI.TriggerSelect, EVENT_PLAYER_UNIT_SELECTED)

            if userButtonOrder then
                TasItemShopUI.TriggerOrder = CreateTriggerEx(function()
                    if TasItemShopUI.Shops[GetUnitTypeId(GetTriggerUnit())] then
                        ShopSelectionAction(GetOwningPlayer(GetOrderTargetUnit()), GetTriggerUnit(), GetOrderTargetUnit())
                    end
                end)
                TriggerRegisterAnyUnitEventBJ(TasItemShopUI.TriggerOrder, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
            end

            TasItemShopUI.TriggerUser = CreateTriggerEx(function()
                local frame = BlzGetTriggerFrame()
                local player = GetTriggerPlayer()
                local index = tonumber(BlzFrameGetText(BlzGetTriggerFrame())) + CurrentOffSetUser[player]
                local unit = BlzGroupUnitAt(Shoper[player], index - 1)

                if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
                    if not userButtonOrder then
                        ShopSelectionAction(player, CurrentShop[player], unit)
                    end
                    IssueNeutralTargetOrder(player, CurrentShop[player], "smart", unit)
                else
                    if IsRightClick(player) then
                        SelectUnitForPlayerSingle(unit, player)
                    end
                end
            end)

            TasItemShopUI.TriggerUserPage = CreateTriggerEx(function()
                local player = GetTriggerPlayer()
                local max = BlzGroupGetSize(Shoper[player])
                local min = 0
                local add = TasItemShopUI.Frames[BlzGetTriggerFrame()]
                CurrentOffSetUser[player] = RefButtonPageChange(CurrentOffSetUser[player], add, min, max, player)

                if GetLocalPlayer() == player then
                    updateRefButtons(Shoper[player], TasItemShopUI.Frames.BoxUser, TasItemShopUI.Frames.User, CurrentOffSetUser[player])
                    updateOverLayMainSelected(player)
                end

            end)

            TasItemShopUI.TriggerESC = CreateTriggerEx(function()
                TasItemShopUIShow(GetTriggerPlayer())
            end)

            TasItemShopUI.TriggerScrollParent = CreateTriggerEx(function()
                local frame = TasItemShopUI.ButtonList.Slider
                if GetLocalPlayer() == GetTriggerPlayer() then
                    if BlzGetTriggerFrameValue() > 0 then
                        BlzFrameSetValue(frame, BlzFrameGetValue(frame) + TasItemShopUI.ButtonList.SliderStep)
                    else
                        BlzFrameSetValue(frame, BlzFrameGetValue(frame) - TasItemShopUI.ButtonList.SliderStep)
                    end
                end
            end)

            TasItemShopUI.TriggerCategoryMode = CreateTriggerEx(function()
                if GetTriggerPlayer() == GetLocalPlayer() then
                    TasButtonListSearch(TasItemShopUI.ButtonList)
                end
            end)

            TasItemShopUI.TriggerPressShift = CreateTriggerEx(function()
                --print("Hold Shift")
                TasItemShopUI.QuickLinkKeyActive[GetTriggerPlayer()] = true
                if refButtonCountQuickLink > 0 and GetTriggerPlayer() == GetLocalPlayer() then
                    BlzFrameSetVisible(TasItemShopUI.Frames.QuickLinkHighLight, true)
                end
            end)
            TasItemShopUI.TriggerReleaseShift = CreateTriggerEx(function()
                --print("Release Shift")
                TasItemShopUI.QuickLinkKeyActive[GetTriggerPlayer()] = false
                if refButtonCountQuickLink > 0 and GetTriggerPlayer() == GetLocalPlayer() then
                    BlzFrameSetVisible(TasItemShopUI.Frames.QuickLinkHighLight, false)
                end
            end)


            local tempUnits = {Count = 0}
            TimerStart(CreateTimer(), updateTime, true, function()
                --  xpcall(function()
                if posScreenRelative then
                    --credits to ScrewTheTrees(Fred) & Niklas
                    BlzFrameSetSize(TasItemShopUI.Frames.Fullscreen, BlzGetLocalClientWidth()/BlzGetLocalClientHeight()*0.6, 0.6)
                end
                local player, unit
                for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
                    player = Player(i)

                    if CurrentShop[player] then
                        ShopSelectionAction(player, CurrentShop[player])
                    end
                end
                --end, print)
            end)
            --call the function handling custom User setup
            xpcall(UserInit, print)
            --precalc any added Item
            for i = 1, #BUY_ABLE_ITEMS do
                -- if type(BUY_ABLE_ITEMS[i]) == "string" then BUY_ABLE_ITEMS[i] = FourCC(BUY_ABLE_ITEMS[i]) end
                TasItemCaclCost(BUY_ABLE_ITEMS[i])
            end


            local player
            BUY_ABLE_ITEMS.Marker = {}
            for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
                player = Player(i)
                Shoper[player] = CreateGroup()
                TasItemShopUI.Undo[player] = {}
                BUY_ABLE_ITEMS.Marker[player] = {}
                TriggerRegisterPlayerEventEndCinematic(TasItemShopUI.TriggerESC, player)
                TasItemShopUI.QuickLink[player] = {}
                if quickLinkKey then
                    --"none"(0), "shift"(1), "control"(2), "alt"(4) and "META"(8) (windows key)
                    --1 + 2 + 4 + 8 = 15
                    for meta = 0, 15 do
                        BlzTriggerRegisterPlayerKeyEvent(TasItemShopUI.TriggerPressShift, player, quickLinkKey, meta, true)
                        BlzTriggerRegisterPlayerKeyEvent(TasItemShopUI.TriggerReleaseShift, player, quickLinkKey, meta, false)
                    end
                end
            end

            TasItemShopUI.Create()
            -- Frame related code actions are not saved/Loaded, probably repeat them after Loading the game
            if FrameLoaderAdd then FrameLoaderAdd(TasItemShopUI.Create) end

        end, print)
    end

end

function CreateRegions()
local we

gg_rct_curved_team_1_attack_1_right = Rect(-12672.0, 3552.0, -2464.0, 8992.0)
gg_rct_curved_1_1_build = Rect(-14400.0, 9152.0, -13248.0, 10816.0)
gg_rct_curved_1_1_main = Rect(-14912.0, 9664.0, -14400.0, 10176.0)
gg_rct_curved_1_1_mine = Rect(-14912.0, 9152.0, -14400.0, 9664.0)
gg_rct_curved_1_1_spawn = Rect(-12672.0, 5440.0, -11520.0, 7104.0)
gg_rct_curved_1_1_worker = Rect(-14400.0, 9152.0, -13248.0, 10816.0)
gg_rct_curved_1_2_build = Rect(-14400.0, 7296.0, -13248.0, 8960.0)
gg_rct_curved_1_2_main = Rect(-14912.0, 7808.0, -14400.0, 8320.0)
gg_rct_curved_1_2_mine = Rect(-14912.0, 7296.0, -14400.0, 7808.0)
gg_rct_curved_1_2_spawn = Rect(-12672.0, 5440.0, -11520.0, 7104.0)
gg_rct_curved_1_2_worker = Rect(-14400.0, 7296.0, -13248.0, 8960.0)
gg_rct_curved_1_3_build = Rect(-14400.0, 5440.0, -13248.0, 7104.0)
gg_rct_curved_1_3_main = Rect(-14912.0, 5952.0, -14400.0, 6464.0)
gg_rct_curved_1_3_mine = Rect(-14912.0, 5440.0, -14400.0, 5952.0)
gg_rct_curved_1_3_spawn = Rect(-12672.0, 5440.0, -11520.0, 7104.0)
gg_rct_curved_1_3_worker = Rect(-14400.0, 5440.0, -13248.0, 7104.0)
gg_rct_curved_1_4_build = Rect(-14400.0, 3584.0, -13248.0, 5248.0)
gg_rct_curved_1_4_main = Rect(-14912.0, 4096.0, -14400.0, 4608.0)
gg_rct_curved_1_4_mine = Rect(-14912.0, 3584.0, -14400.0, 4096.0)
gg_rct_curved_1_4_spawn = Rect(-12672.0, 5440.0, -11520.0, 7104.0)
gg_rct_curved_1_4_worker = Rect(-14400.0, 3584.0, -13248.0, 5248.0)
gg_rct_curved_1_5_build = Rect(-14400.0, 1728.0, -13248.0, 3392.0)
gg_rct_curved_1_5_main = Rect(-14912.0, 2240.0, -14400.0, 2752.0)
gg_rct_curved_1_5_mine = Rect(-14912.0, 1728.0, -14400.0, 2240.0)
gg_rct_curved_1_5_spawn = Rect(-12672.0, 5440.0, -11520.0, 7104.0)
gg_rct_curved_1_5_worker = Rect(-14400.0, 1728.0, -13248.0, 3392.0)
gg_rct_curved_2_1_build = Rect(-768.0, 9152.0, 384.0, 10816.0)
gg_rct_curved_2_1_main = Rect(384.0, 9664.0, 896.0, 10176.0)
gg_rct_curved_2_1_mine = Rect(384.0, 9152.0, 896.0, 9664.0)
gg_rct_curved_2_1_spawn = Rect(-2496.0, 5440.0, -1344.0, 7104.0)
gg_rct_curved_2_1_worker = Rect(-768.0, 9152.0, 384.0, 10816.0)
gg_rct_curved_2_2_build = Rect(-768.0, 7296.0, 384.0, 8960.0)
gg_rct_curved_2_2_main = Rect(384.0, 7808.0, 896.0, 8320.0)
gg_rct_curved_2_2_mine = Rect(384.0, 7296.0, 896.0, 7808.0)
gg_rct_curved_2_2_spawn = Rect(-2496.0, 5440.0, -1344.0, 7104.0)
gg_rct_curved_2_2_worker = Rect(-768.0, 7296.0, 384.0, 8960.0)
gg_rct_curved_2_3_build = Rect(-768.0, 5440.0, 384.0, 7104.0)
gg_rct_curved_2_3_main = Rect(384.0, 5952.0, 896.0, 6464.0)
gg_rct_curved_2_3_mine = Rect(384.0, 5440.0, 896.0, 5952.0)
gg_rct_curved_2_3_spawn = Rect(-2496.0, 5440.0, -1344.0, 7104.0)
gg_rct_curved_2_3_worker = Rect(-768.0, 5440.0, 384.0, 7104.0)
gg_rct_curved_2_4_build = Rect(-768.0, 3584.0, 384.0, 5248.0)
gg_rct_curved_2_4_main = Rect(384.0, 4096.0, 896.0, 4608.0)
gg_rct_curved_2_4_mine = Rect(384.0, 3584.0, 896.0, 4096.0)
gg_rct_curved_2_4_spawn = Rect(-2496.0, 5440.0, -1344.0, 7104.0)
gg_rct_curved_2_4_worker = Rect(-768.0, 3584.0, 384.0, 5248.0)
gg_rct_curved_2_5_build = Rect(-768.0, 1728.0, 384.0, 3392.0)
gg_rct_curved_2_5_main = Rect(384.0, 2240.0, 896.0, 2752.0)
gg_rct_curved_2_5_mine = Rect(384.0, 1728.0, 896.0, 2240.0)
gg_rct_curved_2_5_spawn = Rect(-2496.0, 5440.0, -1344.0, 7104.0)
gg_rct_curved_2_5_worker = Rect(-768.0, 1728.0, 384.0, 3392.0)
gg_rct_curved_team_1_base = Rect(-11488.0, 5952.0, -10880.0, 6592.0)
gg_rct_curved_team_1_tower = Rect(-9536.0, 6016.0, -9024.0, 6528.0)
gg_rct_curved_team_2_base = Rect(-3104.0, 5952.0, -2496.0, 6592.0)
gg_rct_curved_team_2_tower = Rect(-4928.0, 6016.0, -4416.0, 6528.0)
gg_rct_curved_1_1_laboratory = Rect(-14912.0, 10176.0, -14400.0, 10688.0)
gg_rct_curved_1_2_laboratory = Rect(-14912.0, 8320.0, -14400.0, 8832.0)
gg_rct_curved_1_3_laboratory = Rect(-14912.0, 6464.0, -14400.0, 6976.0)
gg_rct_curved_1_4_laboratory = Rect(-14912.0, 4608.0, -14400.0, 5120.0)
gg_rct_curved_1_5_laboratory = Rect(-14912.0, 2752.0, -14400.0, 3264.0)
gg_rct_curved_2_1_laboratory = Rect(384.0, 10176.0, 896.0, 10688.0)
gg_rct_curved_2_2_laboratory = Rect(384.0, 8320.0, 896.0, 8832.0)
gg_rct_curved_2_3_laboratory = Rect(384.0, 6464.0, 896.0, 6976.0)
gg_rct_curved_2_4_laboratory = Rect(384.0, 4608.0, 896.0, 5120.0)
gg_rct_curved_2_5_laboratory = Rect(384.0, 2752.0, 896.0, 3264.0)
gg_rct_curved_team_2_attack_1_left = Rect(-11552.0, 3552.0, -1344.0, 8992.0)
gg_rct_curved_1_1_shop = Rect(-15424.0, 9664.0, -14912.0, 10176.0)
gg_rct_curved_1_2_shop = Rect(-15424.0, 7808.0, -14912.0, 8320.0)
gg_rct_curved_1_3_shop = Rect(-15424.0, 5952.0, -14912.0, 6464.0)
gg_rct_curved_1_4_shop = Rect(-15424.0, 4096.0, -14912.0, 4608.0)
gg_rct_curved_1_5_shop = Rect(-15424.0, 2240.0, -14912.0, 2752.0)
gg_rct_curved_2_1_shop = Rect(896.0, 9664.0, 1408.0, 10176.0)
gg_rct_curved_2_2_shop = Rect(896.0, 7808.0, 1408.0, 8320.0)
gg_rct_curved_2_3_shop = Rect(896.0, 5952.0, 1408.0, 6464.0)
gg_rct_curved_2_4_shop = Rect(896.0, 4096.0, 1408.0, 4608.0)
gg_rct_curved_2_5_shop = Rect(896.0, 2240.0, 1408.0, 2752.0)
gg_rct_curved_1_1_image = Rect(-10848.0, 6688.0, -10624.0, 6912.0)
gg_rct_curved_1_2_image = Rect(-10848.0, 6432.0, -10624.0, 6656.0)
gg_rct_curved_1_3_image = Rect(-10848.0, 6176.0, -10624.0, 6400.0)
gg_rct_curved_1_4_image = Rect(-10848.0, 5920.0, -10624.0, 6144.0)
gg_rct_curved_1_5_image = Rect(-10848.0, 5664.0, -10624.0, 5888.0)
gg_rct_curved_2_1_image = Rect(-3456.0, 6656.0, -3232.0, 6880.0)
gg_rct_curved_2_2_image = Rect(-3456.0, 6400.0, -3232.0, 6624.0)
gg_rct_curved_2_3_image = Rect(-3456.0, 6144.0, -3232.0, 6368.0)
gg_rct_curved_2_4_image = Rect(-3456.0, 5888.0, -3232.0, 6112.0)
gg_rct_curved_2_5_image = Rect(-3456.0, 5632.0, -3232.0, 5856.0)
gg_rct_curved_team_1_addGold = Rect(-7008.0, 3552.0, -2464.0, 8992.0)
gg_rct_curved_team_2_addGold = Rect(-11552.0, 3552.0, -7008.0, 8992.0)
end

--CUSTOM_CODE
do
    Debug = {}
    function Debug.beginFile(fileName, depth, lastLine)
    end
    function Debug.endFile(depth)
    end
end
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
Debug.beginFile('common.lua')
function calculateDif(buidRect, spawnRect, unit)

    local buidRectX = GetRectCenterX(buidRect)
    local buidRectY = GetRectCenterY(buidRect)

    local spawnRectX = GetRectCenterX(spawnRect)
    local spawnRectY = GetRectCenterY(spawnRect)

    local unitX = GetUnitX(unit)
    local unitY = GetUnitY(unit)
    return spawnRectX - (buidRectX - unitX), spawnRectY - (buidRectY - unitY)
end
Debug.endFile()
Debug.beginFile('game-config.lua')
function initGameConfig()
    game_config = {
        economy = {
            startGold = nil,
            startIncomePerSec = nil,
            incomeBoost = nil,
            firstMinePrice = nil,
            nextMineDiffPrice = nil,
            goldByTower = nil,
            incomeForCenter = nil,
            goldForKill = nil,
            upkeep = nil
        },
        units = {
            range = 1,
            lifetime = nil,
            isUnitsMirror = nil,
            isHeroesMirror = nil,
            maxHeroes = nil,
            itemCapacity = nil,
            baseHP = nil,
            towerHP = nil,
            countForSelect = nil,
            heroCost = 500,
            heroStartLevel = nil
        },
        spawnPolicy = {
            interval = nil,
            dif = nil
        },
        playerPosition = { 1, 2, 3, 4, 5 },
        isOpenAllMap = false,
        playersCount = getPlayersCount()
    }

    local count = 0
    for i = 0, 9 do
        if (GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
            count = count + 1
        end
    end

end

function getPlayersCount()
    local count = 0
    for i = 0, 9 do
        if (GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
            count = count + 1
        end
    end
    return count
end

function initGlobalVariables()
    players_team_left = {
        { id = Player(0), spawnId = Player(17), team = 1 },
        { id = Player(2), spawnId = Player(18), team = 1 },
        { id = Player(3), spawnId = Player(16), team = 1 },
        { id = Player(4), spawnId = Player(19), team = 1 },
        { id = Player(5), spawnId = Player(15), team = 1 }
    }
    players_team_right = {
        { id = Player(1), spawnId = Player(12), team = 2 },
        { id = Player(6), spawnId = Player(13), team = 2 },
        { id = Player(7), spawnId = Player(11), team = 2 },
        { id = Player(8), spawnId = Player(14), team = 2 },
        { id = Player(9), spawnId = Player(10), team = 2 }
    }
    heroes_for_build = {
        { id = 'H011', parentId = 'Hpal', race = 'human', line = 1, position = 1, name = 'Paladin', abilities = { { id = 'AHhb' }, { id = 'AHds' }, { id = 'AHre' }, { id = 'AHad' } } },
        { id = 'H01A', parentId = 'Hamg', race = 'human', line = 1, position = 2, name = 'Archmage', abilities = { { id = 'AHbz' }, { id = 'AHab' }, { id = 'AHwe' }, { id = 'ANto' } } },
        { id = 'H01B', parentId = 'Hmkg', race = 'human', line = 1, position = 3, name = 'Mountain King', abilities = { { id = 'AHtc' }, { id = 'AHtb' }, { id = 'AHbn' }, { id = 'AHav' } } },
        { id = 'H01C', parentId = 'Hblm', race = 'human', line = 1, position = 4, name = 'Blood Mage', abilities = { { id = 'AHfc' }, { id = 'AHbn' }, { id = 'AHdr' }, { id = 'AHpx' } } },

        { id = 'O00E', parentId = 'Obla', race = 'orc', line = 2, position = 1, name = 'Blademaster', abilities = { { id = 'AOwk' }, { id = 'AOcr' }, { id = 'AOmi' }, { id = 'AOww' } } },
        { id = 'O00F', parentId = 'Ofar', race = 'orc', line = 2, position = 2, name = 'Far Seer', abilities = { { id = 'AOfs' }, { id = 'AOsf' }, { id = 'AOcl' }, { id = 'AOeq' } } },
        { id = 'O00G', parentId = 'Otch', race = 'orc', line = 2, position = 3, name = 'Tauren Chieftain', abilities = { { id = 'AOsh' }, { id = 'AOae' }, { id = 'AOre' }, { id = 'AOws' } } },
        { id = 'O00H', parentId = 'Oshd', race = 'orc', line = 2, position = 4, name = 'Shadow Hunter', abilities = { { id = 'AOhw' }, { id = 'AOhx' }, { id = 'AOsw' }, { id = 'AOvd' } } },

        { id = 'U00B', parentId = 'Udea', race = 'undead', line = 3, position = 1, name = 'Death Knight', abilities = { { id = 'AUdc' }, { id = 'AUdp' }, { id = 'AUau' }, { id = 'AUan' } } },
        { id = 'U00C', parentId = 'Ulic', race = 'undead', line = 3, position = 2, name = 'Lich', abilities = { { id = 'AUfn' }, { id = 'AUfu' }, { id = 'AUdr' }, { id = 'AUdd' } } },
        { id = 'U00D', parentId = 'Udre', race = 'undead', line = 3, position = 3, name = 'Dreadlord', abilities = { { id = 'AUav' }, { id = 'AUcs' }, { id = 'AUin' }, { id = 'A001' } } },
        { id = 'U00E', parentId = 'Ucrl', race = 'undead', line = 3, position = 4, name = 'Crypt Lord', abilities = { { id = 'AUim' }, { id = 'AUts' }, { id = 'AUcb' }, { id = 'AUls' } } },

        { id = 'E00N', parentId = 'Ekee', race = 'elf', line = 4, position = 1, name = 'Keeper of the Grove', abilities = { { id = 'AEer' }, { id = 'AEah' }, { id = 'A002' }, { id = 'AEtq' } } },
        { id = 'E00O', parentId = 'Emoo', race = 'elf', line = 4, position = 2, name = 'Priestess of the Moon', abilities = { { id = 'AHfa' }, { id = 'ANsi' }, { id = 'AEar' }, { id = 'AEsf' } } },
        { id = 'E00P', parentId = 'Edem', race = 'elf', line = 4, position = 3, name = 'Demon Hunter', abilities = { { id = 'AEmb' }, { id = 'AEim' }, { id = 'AEev' }, { id = 'AEme' } }, otherForm = {'Edmm'} },
        { id = 'E00Q', parentId = 'Ewar', race = 'elf', line = 4, position = 4, name = 'Warden', abilities = { { id = 'AEbl' }, { id = 'AEfk' }, { id = 'AEsh' }, { id = 'AEsv' } } },

        { id = 'N000', parentId = 'Nalc', race = 'other', line = 5, position = 1, name = 'Alchemist', abilities = { { id = 'ANhs' }, { id = 'ANab' }, { id = 'ANcr' }, { id = 'ANtm' } }, otherForm = {'Nalm', 'Nal2', 'Nal3'}},
        { id = 'N001', parentId = 'Nngs', race = 'other', line = 5, position = 2, name = 'Sea Witch', abilities = { { id = 'ANfl' }, { id = 'ANfa' }, { id = 'ANms' }, { id = 'ANto' } } },
        { id = 'N002', parentId = 'Ntin', race = 'other', line = 5, position = 3, name = 'Tinker', abilities = { { id = 'ANsy' }, { id = 'ANcs' }, { id = 'ANeg' }, { id = 'ANrg' } }, otherForm = {'Nrob'} },
        { id = 'N003', parentId = 'Nbst', race = 'other', line = 5, position = 4, name = 'Beastmaster', abilities = { { id = 'ANsg' }, { id = 'ANsq' }, { id = 'ANsw' }, { id = 'ANst' } } },
        { id = 'N004', parentId = 'Npbm', race = 'other', line = 5, position = 5, name = 'Brewmaster', abilities = { { id = 'ANbf' }, { id = 'ANdh' }, { id = 'ANdb' }, { id = 'ANef' } } },
        { id = 'N005', parentId = 'Nbrn', race = 'other', line = 5, position = 6, name = 'Dark Ranger', abilities = { { id = 'ANse' }, { id = 'ANba' }, { id = 'ANdr' }, { id = 'ANch' } } },
        { id = 'N006', parentId = 'Nfir', race = 'other', line = 5, position = 7, name = 'Firelord', abilities = { { id = 'ANic' }, { id = 'ANso' }, { id = 'ANlm' }, { id = 'ANvc' } } },
        { id = 'N007', parentId = 'Nplh', race = 'other', line = 5, position = 8, name = 'Pit Lord', abilities = { { id = 'ANrf' }, { id = 'ANht' }, { id = 'ANca' }, { id = 'ANdo' } } }
    }
    units_for_build = {
        { id = 'h00C', parentId = 'h00A', tier = 1, race = 'human', line = 1, position = 1, food = 2, name = 'Footman', upgrades = { 'Rhde' }, abilities = { { id = 'Adef' } } },
        { id = 'h004', parentId = 'h00D', tier = 1, race = 'human', line = 1, position = 2, food = 3, name = 'Rifleman', upgrades = { 'Rhri' } },
        { id = 'h008', parentId = 'h00I', tier = 1, race = 'human', line = 1, position = 3, food = 2, name = 'Sorceress', upgrades = { 'Rhst' }, abilities = { { id = 'Aply' }, { id = 'Aivs' }, { id = 'Aslo' } } },
        { id = 'h003', parentId = 'h00E', tier = 2, race = 'human', line = 1, position = 4, food = 3, name = 'Mortar Team', upgrades = { 'Rhfl', 'Rhfs' } },
        { id = 'h007', parentId = 'h00H', tier = 2, race = 'human', line = 1, position = 5, food = 2, name = 'Priest', upgrades = { 'Rhpt' }, abilities = { { id = 'Ahea' }, { id = 'Ainf' }, { id = 'Adis' } } },
        { id = 'h006', parentId = 'h00K', tier = 2, race = 'human', line = 1, position = 6, food = 3, name = 'Spellbreaker', upgrades = { 'Rhss' } },
        { id = 'h000', parentId = 'h00F', tier = 2, race = 'human', line = 1, position = 7, food = 1, name = 'Flying Machine', upgrades = { 'Rhgb', 'Rhfc' } },
        { id = 'h009', parentId = 'h00L', tier = 3, race = 'human', line = 1, position = 8, food = 3, name = 'Dragonhawk Rider', upgrades = { 'Rhan' } },
        { id = 'h002', parentId = 'h00B', tier = 3, race = 'human', line = 1, position = 9, food = 4, name = 'Knight', upgrades = { 'Rhan' } },
        { id = 'h005', parentId = 'h00J', tier = 3, race = 'human', line = 1, position = 10, food = 3, name = 'Siege Engine', upgrades = { 'Rhrt' }, otherForm = {'hrtt'} },
        { id = 'h001', parentId = 'h00G', tier = 2, race = 'human', line = 1, position = 11, food = 4, name = 'Gryphon Rider', upgrades = { 'Rhhb', 'Rhan' } },

        { id = 'h00P', parentId = 'o003', tier = 1, race = 'orc', line = 2, position = 1, food = 3, name = 'Grunt', upgrades = { 'Robs' } },
        { id = 'h00Q', parentId = 'o006', tier = 1, race = 'orc', line = 2, position = 2, food = 2, name = 'Headhunter', upgrades = { 'Robk', 'Rotr' }, otherForm = {'otbk'} },
        { id = 'h00T', parentId = 'o00C', tier = 1, race = 'orc', line = 2, position = 3, food = 2, name = 'Shaman', upgrades = { 'Rost' }, abilities = { { id = 'Ablo' }, { id = 'Alsh' }, { id = 'Aprg' } } },
        { id = 'h00S', parentId = 'o004', tier = 2, race = 'orc', line = 2, position = 4, food = 3, name = 'Raider', upgrades = { 'Roen', 'Ropg' }, abilities = { { id = 'Aens' } } },
        { id = 'h00X', parentId = 'o00B', tier = 2, race = 'orc', line = 2, position = 5, food = 2, name = 'Witch Doctor', upgrades = { 'Rowd', 'Rotr' }, abilities = { { id = 'Aeye' }, { id = 'Ahwd' }, { id = 'Asta' } } },
        { id = 'h00U', parentId = 'o00D', tier = 2, race = 'orc', line = 2, position = 6, food = 3, name = 'Spirit Walker', upgrades = { 'Rowt' }, abilities = { { id = 'Aspl' }, { id = 'Adcn' }, { id = 'Aast' } }, otherForm = {'ospm'} },
        { id = 'h00N', parentId = 'o00A', tier = 2, race = 'orc', line = 2, position = 7, food = 2, name = 'Batrider', upgrades = { 'Rotr' } },
        { id = 'h00R', parentId = 'o008', tier = 2, race = 'orc', line = 2, position = 8, food = 4, name = 'Kodo Beast', upgrades = { 'Rwdm' } },
        { id = 'h00V', parentId = 'o005', tier = 3, race = 'orc', line = 2, position = 9, food = 5, name = 'Tauren', upgrades = { 'Rows' } },
        { id = 'h00O', parentId = 'o007', tier = 3, race = 'orc', line = 2, position = 10, food = 4, name = 'Demolisher', upgrades = { 'Robf' } },
        { id = 'h00W', parentId = 'o009', tier = 3, race = 'orc', line = 2, position = 11, food = 4, name = 'Wind Rider', upgrades = { 'Rovs' } },

        { id = 'h014', parentId = 'u001', tier = 1, race = 'undead', line = 3, position = 1, food = 2, name = 'Ghoul', upgrades = { 'Rugf' } },
        { id = 'h010', parentId = 'u004', tier = 1, race = 'undead', line = 3, position = 2, food = 3, name = 'Crypt Fiend', upgrades = { 'Ruwb', 'Rubu' }, abilities = { { id = 'Aweb' }, { id = 'Abur' } }, otherForm = {'ucrm'} },
        { id = 'h00Z', parentId = 'u006', tier = 1, race = 'undead', line = 3, position = 3, food = 2, name = 'Banshee', upgrades = { 'Ruba' }, abilities = { { id = 'Aams' }, { id = 'Acrs' }, { id = 'Aps2' } } },
        { id = 'h017', parentId = 'u008', tier = 2, race = 'undead', line = 3, position = 4, food = 3, name = 'Obsidian Statue', upgrades = {}, abilities = { { id = 'Arpl' }, { id = 'Arpm' } } },
        { id = 'h013', parentId = 'u005', tier = 2, race = 'undead', line = 3, position = 5, food = 2, name = 'Gargoyle', upgrades = { 'Rusf' }, abilities = { { id = 'Astn' }, { id = 'Aatp' } }, otherForm = {'ugrm'} },
        { id = 'h016', parentId = 'u007', tier = 2, race = 'undead', line = 3, position = 6, food = 2, name = 'Necromancer', upgrades = { 'Rusl', 'Rune', 'Rusm' }, abilities = { { id = 'Acri' }, { id = 'Arai' }, { id = 'Auhf' } } },
        { id = 'h015', parentId = 'u003', tier = 2, race = 'undead', line = 3, position = 7, food = 4, name = 'Meat Wagon', upgrades = { 'Rupc' } },
        { id = 'h018', parentId = 'u000', tier = 2, race = 'undead', line = 3, position = 8, food = 1, name = 'Shade', upgrades = {} },
        { id = 'h00Y', parentId = 'u002', tier = 3, race = 'undead', line = 3, position = 9, food = 4, name = 'Abomination', upgrades = { 'Rupc' } },
        { id = 'h019', parentId = 'u00A', tier = 3, race = 'undead', line = 3, position = 10, food = 4, name = 'Destroyer', upgrades = {} },
        { id = 'h012', parentId = 'u009', tier = 3, race = 'undead', line = 3, position = 11, food = 7, name = 'Frost Wyrm', upgrades = { 'Rufb' } },

        { id = 'e009', parentId = 'e00C', tier = 1, race = 'elf', line = 4, position = 1, food = 3, name = 'Huntress', upgrades = { 'Remg', 'Resc' } },
        { id = 'e000', parentId = 'e00B', tier = 1, race = 'elf', line = 4, position = 2, food = 2, name = 'Archer', upgrades = { 'Reib', 'Remk' } },
        { id = 'e004', parentId = 'e00D', tier = 1, race = 'elf', line = 4, position = 3, food = 3, name = 'Dryad', upgrades = { 'Resi' } },
        { id = 'e006', parentId = 'e00E', tier = 2, race = 'elf', line = 4, position = 4, food = 3, name = 'Glaive Thower', upgrades = {} },
        { id = 'e007', parentId = 'e00F', tier = 2, race = 'elf', line = 4, position = 5, food = 2, name = 'Hippogryph', upgrades = {} },
        { id = 'e002', parentId = 'e00J', tier = 2, race = 'elf', line = 4, position = 6, food = 4, name = 'Druid of the Claw', upgrades = { 'Redc' }, abilities = { { id = 'Abrf' }, { id = 'Arej' }, { id = 'Aroa' } }, otherForm = {'edcm'} },
        { id = 'e003', parentId = 'e00I', tier = 2, race = 'elf', line = 4, position = 7, food = 2, name = 'Druid of the Talon', upgrades = { 'Redt' }, abilities = { { id = 'Acyc' }, { id = 'Arav' }, { id = 'Afae' } }, otherForm = {'edtm'} },
        { id = 'e005', parentId = 'e00L', tier = 2, race = 'elf', line = 4, position = 8, food = 2, name = 'Faerie Dragon', upgrades = {}, abilities = { { id = 'Amfl' } } },
        { id = 'e00A', parentId = 'e00K', tier = 3, race = 'elf', line = 4, position = 9, food = 7, name = 'Mountain Giant', upgrades = { 'Rers', 'Rehs' }, abilities = { { id = 'Atau' } } },
        { id = 'e008', parentId = 'e00G', tier = 3, race = 'elf', line = 4, position = 10, food = 4, name = 'Hippogryph Rider', upgrades = {} },
        { id = 'e001', parentId = 'e00H', tier = 3, race = 'elf', line = 4, position = 11, food = 5, name = 'Chimaera', upgrades = { 'Recb' } },
    }
    units_special = {
        builder = 'u00F',
        tower = 'o001',
        base = 'o002',
        mine = 'ugol',
        main = 'htow',
        laboratory = 'nmgv',
        shop = 'ngme',
        heroBuilder = 'e00M',
        randomHero = 'ncop',
        t2 = 'hkee',
        t3 = 'hcas'
    }
    abilities = {
        mine = 'A000',
        sell100 = 'A003',
        sell75 = 'A004',
        moveLarge = 'A007',
        moveMedium = 'A006',
        moveSmall = 'A005',
        inventory = {
            [1] = 'A00F',
            [2] = 'A00E',
            [3] = 'A00D',
            [4] = 'A00C',
            [5] = 'A00B',
            [6] = 'AInv',
        }
    }

    upgrades_special = {
        summonHeroBuilder = 'R000'
    }

    main_race = {
        { id = 'hcas', race = 'human' },
        { id = 'ofrt', race = 'orc' },
        { id = 'unp2', race = 'undead' },
        { id = 'etoe', race = 'elf' },
        { id = 'ntav', race = 'other' }
    }
end
Debug.endFile()
Debug.beginFile('game-init.lua')
function initGame()
    UseTimeOfDayBJ(false)
    SetTimeOfDay(12)
    initTeams()
    initRect()

    setEnemyBetweenPlayers()
    setAllianceBetweenSpawnPlayers()
    setAllianceBetweenPlayers()
    setAllianceBetweenPlayersAndSpawnPlayers()
    changeColorAndNameSpawnPlayers()
    changeAvailableUnitsForPlayers()
    initCamera()

    createBaseAndTower()
    addWorkers()
    createBuildingsForPlayers()
    createPictures()
    initPanelForAllPlayers()
    initAbilitiesPanel()
    heroStatisticPanel()
end

function createPictures()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do

            if type(player.imageRect) == 'table' then
                for _, image in ipairs(player.imageRect) do
                    local name = GetPlayerName(player.id)
                    local image = CreateImageBJ("playerImg\\" .. name, 256, GetRectCenter(image), 0, 2)
                    SetImageRenderAlways(image, true)
                    ShowImageBJ(true, image)
                end

            else
                local name = GetPlayerName(player.id)
                local image = CreateImageBJ("playerImg\\" .. name, 256, GetRectCenter(player.imageRect), 0, 2)
                SetImageRenderAlways(image, true)
                ShowImageBJ(true, image)
            end
        end
    end
end

function initTeams()
    all_teams = {}

    all_teams[1] = {
        i = 1,
        players = addPlayersInTeam(players_team_left),
        base = {
            player = Player(17),
            winTeam = 2,
            baseRect = nil,
            towerRect = nil
        }
    }
    all_teams[2] = {
        i = 2,
        players = addPlayersInTeam(players_team_right),
        base = {
            player = Player(12),
            winTeam = 1,
            baseRect = nil,
            towerRect = nil
        }
    }
    all_teams[1].base.player = Player(20)
    all_teams[2].base.player = Player(21)
end

function getCountPlayers()
    local countActivePlayer = 0
    for _, player in ipairs(mergeSequences(players_team_left, players_team_right)) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            countActivePlayer = countActivePlayer + 1
        end
    end
    return countActivePlayer
end

function mergeSequences(t1, t2)
    local result = {}
    for i = 1, #t1 do
        result[i] = t1[i]
    end
    for i = 1, #t2 do
        result[#t1 + i] = t2[i]
    end
    return result
end

function getMainPlayer()
    for _, player in ipairs(players_team_left) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            return player.id
        end
    end
    for _, player in ipairs(players_team_right) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            return player.id
        end
    end
end

function addPlayersInTeam(players)
    local nextPosition = 1
    local initialPlayers = {}
    for _, player in ipairs(players) do
        if (GetPlayerSlotState(player.id) == PLAYER_SLOT_STATE_PLAYING) then
            table.insert(initialPlayers, {
                id = player.id,
                color = getColorById(GetPlayerId(player.id)),
                integerColor = getIntegerColorById(GetPlayerId(player.id)),
                spawnPlayerId = player.spawnId,
                i = game_config.playerPosition[nextPosition],
                economy = {
                    income = game_config.economy.startIncomePerSec,
                    incomeForCenter = 0,
                    minePrice = game_config.economy.firstMinePrice,
                    mineLevel = 0,
                    mineTextTag = nil,
                    totalGold = game_config.economy.startGold,
                    totalGoldForKills = 0,
                    roundUp = false
                },
                buildRect = nil,
                workerRect = nil,
                mineRect = nil,
                mainRect = nil,
                laboratoryRect = nil,
                attackPointRect = {},
                spawnRect = nil,
                shopRect = nil,
                spawnTimer = game_config.playerPosition[nextPosition] * game_config.spawnPolicy.interval + game_config.spawnPolicy.dif,
                heroes = {},
                totalDamage = 0,
                totalKills = 0,
                availableUnits = {},
                availableHeroes = {},
                tier = 'T1',
                food = 0,
                waveNumber = 0,
                heroBuilderCount = 0
            })
            nextPosition = nextPosition + 1
        end
    end
    return initialPlayers
end

function getColorById(playerId)
    if (playerId == 0) then
        return { r = 255, g = 2, b = 2, t = 255 }
    end
    if (playerId == 1) then
        return { r = 0, g = 65, b = 255, t = 255 }
    end
    if (playerId == 2) then
        return { r = 27, g = 229, b = 184, t = 255 }
    end
    if (playerId == 3) then
        return { r = 83, g = 0, b = 128, t = 255 }
    end
    if (playerId == 4) then
        return { r = 255, g = 255, b = 0, t = 255 }
    end
    if (playerId == 5) then
        return { r = 254, g = 137, b = 13, t = 255 }
    end
    if (playerId == 6) then
        return { r = 31, g = 191, b = 0, t = 255 }
    end
    if (playerId == 7) then
        return { r = 228, g = 90, b = 170, t = 255 }
    end
    if (playerId == 8) then
        return { r = 148, g = 149, b = 150, t = 255 }
    end
    if (playerId == 9) then
        return { r = 125, g = 190, b = 241, t = 255 }
    end
end

function getIntegerColorById(playerId)
    if (playerId == 0) then
        return BlzConvertColor(255, 255, 2, 2)
    end
    if (playerId == 1) then
        return BlzConvertColor(255, 0, 65, 255)
    end
    if (playerId == 2) then
        return BlzConvertColor(255, 27, 229, 184)
    end
    if (playerId == 3) then
        return BlzConvertColor(255, 83, 0, 128)
    end
    if (playerId == 4) then
        return BlzConvertColor(255, 255, 255, 0)
    end
    if (playerId == 5) then
        return BlzConvertColor(255, 254, 137, 13)
    end
    if (playerId == 6) then
        return BlzConvertColor(255, 31, 191, 0)
    end
    if (playerId == 7) then
        return BlzConvertColor(255, 228, 90, 170)
    end
    if (playerId == 8) then
        return BlzConvertColor(255, 148, 149, 150)
    end
    if (playerId == 9) then
        return BlzConvertColor(255, 125, 190, 241)
    end
end

function initRect()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            player.buildRect = regions['curved'][team.i][player.i]['build']
            player.workerRect = regions['curved'][team.i][player.i]['worker']
            player.mineRect = regions['curved'][team.i][player.i]['mine']
            player.mainRect = regions['curved'][team.i][player.i]['main']
            player.laboratoryRect = regions['curved'][team.i][player.i]['laboratory']
            player.spawnRect = regions['curved'][team.i][player.i]['spawn']
            player.shopRect = regions['curved'][team.i][player.i]['shop']
            player.imageRect = regions['curved'][team.i][player.i]['image']
        end
        team.base.baseRect = regions['curved']['team'][team.i]['base']
        team.base.towerRect = regions['curved']['team'][team.i]['tower']
        team.base.addGoldRect = regions['curved']['team'][team.i]['addGold']
    end

    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local attackData = regions['curved'][team.i][player.i]['attack']
            if not attackData then
                attackData = regions['curved']['team'][team.i]['attack']
            end
            if not attackData then
                attackData = regions['curved']['global']['attack']
            end

            local directions = { 'right', 'left', 'up', 'down' }
            for i, data in ipairs(attackData) do
                for _, dir in ipairs(directions) do
                    if data[dir] then
                        player.attackPointRect[i] = { rect = data[dir], direction = dir }
                        break
                    end
                end
            end
        end
    end
end

function createBaseAndTower()
    for _, team in ipairs(all_teams) do
        local base = CreateUnit(
                team.base.player,
                FourCC(units_special.base),
                GetRectCenterX(team.base.baseRect),
                GetRectCenterY(team.base.baseRect),
                0
        )
        BlzSetUnitMaxHP(base, game_config.units.baseHP)
        SetUnitLifeBJ(base, game_config.units.baseHP)

        if team.base.towerRect ~= nil then
            local tower = CreateUnit(
                    team.base.player,
                    FourCC(units_special.tower),
                    GetRectCenterX(team.base.towerRect),
                    GetRectCenterY(team.base.towerRect),
                    0
            )
            BlzSetUnitMaxHP(tower, game_config.units.towerHP)
            SetUnitLifeBJ(tower, game_config.units.towerHP)
        end
    end
end

function createBuildingsForPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local unit = CreateUnit(
                    player.id,
                    FourCC(units_special.mine),
                    GetRectCenterX(player.mineRect),
                    GetRectCenterY(player.mineRect),
                    0
            )

            local ability = BlzGetUnitAbility(unit, FourCC(abilities.mine))
            BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, game_config.economy.firstMinePrice)
            BlzSetAbilityRealField(ability, ABILITY_RF_ARF_MISSILE_ARC, game_config.economy.incomeBoost)

            player.economy.mineTextTag = CreateTextTagUnitBJ(getMineTag(player), unit, 0, 10, 204, 204, 0, 0)

            CreateUnit(
                    player.id,
                    FourCC(units_special.main),
                    GetRectCenterX(player.mainRect),
                    GetRectCenterY(player.mainRect),
                    0
            )
            CreateUnit(
                    player.id,
                    FourCC(units_special.laboratory),
                    GetRectCenterX(player.laboratoryRect),
                    GetRectCenterY(player.laboratoryRect),
                    0
            )
            CreateUnit(
                    player.id,
                    FourCC(units_special.shop),
                    GetRectCenterX(player.shopRect),
                    GetRectCenterY(player.shopRect),
                    0
            )

        end
    end
end
Debug.endFile()
Debug.beginFile('main-init.lua')
function initMain()
    initRegions()
    initGame()
end
Debug.endFile()
Debug.beginFile('players-init.lua')
function setAllianceBetweenSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(sumArrayAndElement(getAllSpawnPlayers(team), team.base.player)) do
            for _, anotherPlayer in ipairs(sumArrayAndElement(getAllSpawnPlayers(team), team.base.player)) do
                if player ~= anotherPlayer then
                    SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_ALLIED_VISION)
                    SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_ALLIED_VISION)
                end
            end
        end
    end
end

function setEnemyBetweenPlayers()
    local players = {}
    ForForce(GetPlayersAll(), function()
        table.insert(players, GetEnumPlayer())
    end)

    for _, player in ipairs(players) do
        for _, anotherPlayer in ipairs(players) do
            if player ~= anotherPlayer then
                SetPlayerAllianceStateBJ(player, anotherPlayer, bj_ALLIANCE_UNALLIED)
                SetPlayerAllianceStateBJ(anotherPlayer, player, bj_ALLIANCE_UNALLIED)
            end
        end
    end

end

function getAllSpawnPlayers(team)
    local spawnPlayer = {}
    for _, player in ipairs(team.players) do
        table.insert(spawnPlayer, player.spawnPlayerId)
    end
    return spawnPlayer
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
    for teamNumber, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, spawnPlayer in ipairs(sumArrayAndElement(getAllSpawnPlayers(team), team.base.player)) do
                SetPlayerName(spawnPlayer, GetPlayerName(player.id))
                SetPlayerColor(spawnPlayer, GetPlayerColor(player.id))
                SetPlayerAlliance(spawnPlayer, player.id, ALLIANCE_SHARED_VISION, TRUE)
                SetPlayerAllianceStateBJ(player.id, spawnPlayer, bj_ALLIANCE_ALLIED_VISION)
                SetPlayerAllianceStateBJ(spawnPlayer, player.id, bj_ALLIANCE_ALLIED_VISION)
            end
        end
        SetPlayerName(team.base.player, 'Team ' .. teamNumber)
        SetPlayerColor(team.base.player, GetPlayerColor(Player(teamNumber - 1)))
    end
end

function sumArrayAndElement(array, element)
    local resultArray = {}
    for i = 1, #array do
        table.insert(resultArray, array[i])
    end
    table.insert(resultArray, element)
    return resultArray
end

function changeColorAndNameSpawnPlayers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            SetPlayerName(player.spawnPlayerId, GetPlayerName(player.id))
            SetPlayerColor(player.spawnPlayerId, GetPlayerColor(player.id))
        end
    end
end

function addWorkers()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if type(player.workerRect) == "table" then
                for _, rect in ipairs(player.workerRect) do
                    CreateUnit(
                            player.id,
                            FourCC(units_special.builder),
                            GetRectCenterX(rect),
                            GetRectCenterY(rect),
                            0
                    )
                end
            else
                CreateUnit(
                        player.id,
                        FourCC(units_special.builder),
                        GetRectCenterX(player.workerRect),
                        GetRectCenterY(player.workerRect),
                        0
                )
            end
        end
    end
end

function initCamera()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            SetCameraPositionForPlayer(player.id, GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect))
        end
    end
end

function changeAvailableUnitsForPlayers()

    local isMirror = game_config.units.isUnitsMirror
    local mirrorUnits = {}
    mirrorHeroes = {}
    for _, team in ipairs(all_teams) do
        for playerIndex, player in ipairs(team.players) do
            mirrorHeroes[playerIndex] = {}
            for i = 0, 30 do
                mirrorHeroes[playerIndex][i] = getRandomHeroes(heroes_for_build, 3)
            end
        end
    end

    for _, team in ipairs(all_teams) do
        for playerIndex, player in ipairs(team.players) do
            checkHeroAvailable(player, 0)
            for _, unit in ipairs(units_for_build) do
                SetPlayerUnitAvailableBJ(FourCC(unit.id), FALSE, player.id)
                for _, upgrade in ipairs(unit.upgrades) do
                    SetPlayerTechMaxAllowed(player.id, FourCC(upgrade), 0)
                end
            end

            local randomUnits
            if isMirror and mirrorUnits[playerIndex] then
                randomUnits = mirrorUnits[playerIndex]
            else
                randomUnits = getRandomUnits(units_for_build)
                if isMirror then
                    mirrorUnits[playerIndex] = randomUnits
                end
            end

            for _, unit in ipairs(randomUnits) do
                table.insert(player.availableUnits, unit)
                SetPlayerUnitAvailableBJ(FourCC(unit.id), TRUE, player.id)
            end
            reRollHeroes(player, playerIndex, 0)
        end
    end
end

function reRollHeroes(player, position, heroNumber)

    for _, hero in ipairs(heroes_for_build) do
        SetPlayerUnitAvailableBJ(FourCC(hero.id), FALSE, player.id)
    end

    local threeHeroes
    if game_config.units.isHeroesMirror then
        threeHeroes = mirrorHeroes[position][heroNumber]
    else
        threeHeroes = getRandomHeroes(heroes_for_build, game_config.units.countForSelect)
    end
    for _, hero in ipairs(threeHeroes) do
        SetPlayerUnitAvailableBJ(FourCC(hero.id), TRUE, player.id)
    end
end

function getRandomHeroes(heroes, count)

    local availableHeroes = {}
    for _, hero in ipairs(heroes) do
        if hero.active == true then
            table.insert(availableHeroes, hero)
        end
    end

    local selected = {}
    local result = {}

    count = math.min(count, #availableHeroes)

    while #result < count do
        local index = GetRandomInt(1, #availableHeroes)
        if not selected[index] then
            table.insert(result, availableHeroes[index])
            selected[index] = true
        end
    end

    return result
end

function getRandomUnits(units)
    local groupedUnits = {}
    local randomUnits = {}

    for _, unit in ipairs(units) do
        if not groupedUnits[unit.position] then
            groupedUnits[unit.position] = {}
        end
        if (unit.active == true) then
            table.insert(groupedUnits[unit.position], unit)
        end
    end

    for _, groupedUnit in ipairs(groupedUnits) do
        local randomIndex = GetRandomInt(1, #groupedUnit)
        table.insert(randomUnits, groupedUnit[randomIndex])
    end

    return randomUnits
end
Debug.endFile()
Debug.beginFile('regions-init.lua')
regions = {}
function initRegions()
    for name, value in pairs(_G) do
        if string.sub(name, 1, 7) == "gg_rct_" then
            local parts = split(string.sub(name, 8), "_")

            local currentTable = regions
            for i, part in ipairs(parts) do
                if i == #parts then
                    currentTable[part] = value
                else
                    currentTable[part] = currentTable[part] or {}
                    currentTable = currentTable[part]
                end
            end
        end
    end
end

function split(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        if tonumber(match) then
            table.insert(result, tonumber(match))
        else
            table.insert(result, match)
        end
    end
    return result
end
Debug.endFile()
Debug.beginFile('main.lua')
OnInit(function()
    initGlobalVariables()
    initStartGameUI()
    startGameUI()
    configShop()
end)
Debug.endFile()

Debug.beginFile('shop-config.lua')
function configShop()
    BUY_ABLE_ITEMS = {
        'afac',
        'spsh',
        'ajen',
        'bgst',
        'belv',
        'cnob',
        'ratc',
        'clfm',
        'gcel',
        'hval',
        'hcun',
        'rhth',
        'kpin',
        'lgdh',
        'mcou',
        'odef',
        'pmna',
        'rde3',
        'rlif',
        'ciri',
        'brac',
        'sbch',
        'rwiz',
        'evtl',
        'lhst',
        'ward',
        'desc',
        'gemt',
        'ocor',
        'ofir',
        'oli2',
        'oslo',
        'oven'
    }
end
Debug.endFile()
Debug.beginFile('start-game.lua')
function startGame()
    initMain()
    initGameTimer()
    initTriggers()
end
Debug.endFile()
Debug.beginFile('game-time-timer.lua')
function initGameTimer()
    totalGameSeconds = 0
    local gameTimer = CreateTimer()
    TimerStart(gameTimer, 1.0, true, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if GetLocalPlayer() == player.id then
                    BlzFrameSetVisible(player.multiFrame, true)
                end
            end
        end
        totalGameSeconds = totalGameSeconds + 1
    end)
end

function GetFormattedGameTime()
    local hours = math.floor(totalGameSeconds / 3600)
    local mins = math.floor((totalGameSeconds % 3600) / 60)
    local secs = totalGameSeconds % 60

    if hours > 0 then
        return string.format("%d:%02d:%02d", hours, mins, secs)
    elseif mins > 0 then
        return string.format("%02d:%02d", mins, secs)
    else
        return string.format("%02d", secs)
    end
end
Debug.endFile()

Debug.beginFile('center-control-trigger.lua')
function centerControlTrigger()
    for _, team in ipairs(all_teams) do
        local trig = CreateTrigger()
        TriggerRegisterEnterRectSimple(trig, team.base.addGoldRect)
        TriggerAddAction(trig, function()
            local unit = GetTriggerUnit()
            local trgPlayer = GetOwningPlayer(unit)
            local isAddGold = false
            for _, player in ipairs(team.players) do
                if (player.spawnPlayerId == trgPlayer) then
                    isAddGold = true
                end
            end
            if isAddGold == true then
                for _, player in ipairs(team.players) do
                    player.economy.incomeForCenter = game_config.economy.incomeForCenter
                end

                for _, otherTeam in ipairs(all_teams) do
                    if otherTeam ~= team then
                        for _, player in ipairs(otherTeam.players) do
                            player.economy.incomeForCenter = 0
                        end
                    end
                end
            end
        end)
    end
end
Debug.endFile()
Debug.beginFile('damage-detect-trigger.lua')
function damageDetectTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGED)
    TriggerAddAction(trig, function()
        local source = GetEventDamageSource()
        if GetUnitTypeId(source) == FourCC(units_special.tower) or GetUnitTypeId(source) == FourCC(units_special.base) then
            return
        end
        local sourcePlayer = GetOwningPlayer(source)
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if sourcePlayer == player.spawnPlayerId then
                    player.totalDamage = math.floor(player.totalDamage + GetEventDamage())
                    local userData = GetUnitUserData(source)
                    if userData >= START_INDEX_HEROES then
                        for _, hero in ipairs(player.heroes) do
                            if hero.id == userData then
                                hero.damage = math.floor(hero.damage + GetEventDamage())
                            end
                        end
                    end
                    return
                end
            end
        end
    end)
end
Debug.endFile()
Debug.beginFile('dead-detect-trigger.lua')
function deadDetectTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trig, function()
        local source = GetKillingUnit()
        if GetUnitTypeId(source) == FourCC(units_special.tower) or GetUnitTypeId(source) == FourCC(units_special.base) then
            return
        end
        local sourcePlayer = GetOwningPlayer(source)
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if sourcePlayer == player.spawnPlayerId then
                    player.totalKills = math.floor(player.totalKills + 1)
                    local userData = GetUnitUserData(source)
                    if userData >= START_INDEX_HEROES then
                        for _, hero in ipairs(player.heroes) do
                            if hero.id == userData then
                                hero.kills = hero.kills + 1
                            end
                        end
                    end
                    return
                end
            end
        end
    end)
end

function isHeroOrSummon(id)
    for _, hero in ipairs(heroes_for_build) do
        if hero.id == id then
            return true
        end
    end
    return false
end
Debug.endFile()
Debug.beginFile('enable-update-trigger.lua')
function enableUpdateTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH, nil)
            TriggerAddAction(trig, function()

                local unit = GetTriggerUnit()
                local id = GetUnitTypeId(unit)
                local upgrades = getUpgradesById(('>I4'):pack(id))

                for _, upgrade in ipairs(upgrades) do
                    SetPlayerTechMaxAllowed(GetTriggerPlayer(), FourCC(upgrade), 3)
                end
            end)
        end
    end
end

function getUpgradesById(id)
    for _, unit in ipairs(units_for_build) do
        if unit.id == id then
            return unit.upgrades
        end
    end
    return {}
end
Debug.endFile()
Debug.beginFile('finish-research-trigger.lua')
function finishResearchTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_RESEARCH_FINISH )
            TriggerAddAction(trig, function()
                SetPlayerTechResearchedSwap(GetResearched(), GetPlayerTechCountSimple(GetResearched(), player.id), player.spawnPlayerId)
            end)
        end
    end
end
Debug.endFile()
Debug.beginFile('gold-extractor-trigger.lua')
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
                player.economy.income = player.economy.income + game_config.economy.incomeBoost
                player.economy.mineLevel = player.economy.mineLevel + 1
                BlzSetAbilityIntegerLevelField(ability, ABILITY_ILF_GOLD_COST_NDT1, 0, player.economy.minePrice)

                SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD) + game_config.economy.nextMineDiffPrice)

                DestroyTextTag(player.economy.mineTextTag)
                player.economy.mineTextTag = CreateTextTagUnitBJ(getMineTag(player), GetTriggerUnit(), 0, 10, 204, 204, 0, 0)
            end)
        end
    end
end

function getMineTag(player)
    return 'Level: ' .. player.economy.mineLevel .. ' (' .. player.economy.income * 60 .. '/m) next: ' .. (player.economy.income + game_config.economy.incomeBoost) * 60 .. '/m'
end

Debug.endFile()
Debug.beginFile('hero-construct-trigger.lua')
START_INDEX_HEROES = 1000
function heroConstructTrigger()
    heroGlobalId = START_INDEX_HEROES
    for _, team in ipairs(all_teams) do
        for playerIndex, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
            TriggerAddAction(trig, function()
                if isHero(('>I4'):pack(GetUnitTypeId(GetTriggerUnit()))) then
                    local group = GetUnitsOfPlayerAndTypeId(player.id, FourCC(units_special.heroBuilder))
                    KillUnit(GroupPickRandomUnit(group))
                    DestroyGroup(group)
                    local unitId = GetUnitTypeId(GetTriggerUnit())

                    if game_config.units.itemCapacity == 0 then
                        UnitRemoveAbility(GetTriggerUnit(), FourCC(abilities.inventory[6]))
                    else
                        UnitAddAbility(GetTriggerUnit(), FourCC(abilities.inventory[game_config.units.itemCapacity]))
                    end
                    if (game_config.units.heroStartLevel > 1) then
                        SetHeroLevel(GetTriggerUnit(), game_config.units.heroStartLevel, false)
                    end
                    table.insert(player.heroes, {
                        status = "new",
                        building = GetTriggerUnit(),
                        name = GetHeroProperName(GetTriggerUnit()),
                        unit = nil,
                        id = heroGlobalId,
                        newSkills = {},
                        unitConfig = getHeroUnitId(('>I4'):pack(unitId)),
                        icon = BlzGetAbilityIcon(unitId),
                        kills = 0,
                        damage = 0
                    })
                    heroGlobalId = heroGlobalId + 1
                    player.food = player.food + 5
                    if isDuplicateHero(('>I4'):pack(unitId), player.heroes) == false then
                        updateAbilityPanel(player, getHeroUnitId(('>I4'):pack(unitId)))
                    end
                    reRollHeroes(player, playerIndex, #player.heroes)
                else
                    player.food = player.food + getFoodCostUnit(('>I4'):pack(GetUnitTypeId(GetTriggerUnit())))
                end
                end)
        end
    end
end

function isDuplicateHero(unitId, heroes)
    local count = 0
    for _, hero in ipairs(heroes) do
        if unitId == hero.unitConfig.id then
            count = count + 1
        end
    end
    if count > 1 then
        return true
    else
        return false
    end
    end

function getHeroUnitId(searchId)
    for _, unit in pairs(heroes_for_build) do
        if unit.id == searchId then
            return unit
        end
    end
    return nil
end
function getFoodCostUnit(unitId)
    for _, unit in pairs(units_for_build) do
        if unit.id == unitId then
            return unit.food
        end
    end
    return 0
end
Debug.endFile()


Debug.beginFile('hero-dead-trigger.lua')
function heroDeadTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                for _, hero in ipairs(player.heroes) do
                    if IsUnitDeadBJ(hero.unit) and hero.status == 'alive' then
                        hero.status = 'dead'
                    end
                end
            end)
        end
    end
end
Debug.endFile()
Debug.beginFile('hero-learn-ability.lua')
function heroLearnAbility()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_HERO_SKILL)
            TriggerAddAction(trig, function()
                local learnedUnit = GetTriggerUnit()
                local learnedSkill = GetLearnedSkill()
                for _, hero in ipairs(player.heroes) do
                    if learnedUnit == hero.building then
                        table.insert(hero.newSkills, learnedSkill)
                        break
                    end
                end
            end)
        end
    end
end
Debug.endFile()
Debug.beginFile('hero-main.lua')
function initHeroTriggers()
    heroResearchTrigger()
    heroConstructTrigger()
    heroDeadTrigger()
    heroTransferExp()
    heroLearnAbility()
    heroNewSkill()
    wardenTrigger()
    summonLabelTrigger()
end
Debug.endFile()
Debug.beginFile('hero-new-skill.lua')
function heroNewSkill()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                for _, hero in ipairs(player.heroes) do
                    if hero.status == 'alive' then
                        for i = #hero.newSkills, 1, -1 do
                            SetPlayerAbilityAvailable(player.spawnPlayerId, hero.newSkills[i], true)
                            SelectHeroSkill(hero.unit, hero.newSkills[i])
                            table.remove(hero.newSkills, i)
                        end
                    end
                end
            end)
        end
    end
end
Debug.endFile()

Debug.beginFile('hero-research-trigger.lua')
function heroResearchTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple(trig, player.id, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
            TriggerAddAction(trig, function()
                if (GetResearched() == FourCC(upgrades_special.summonHeroBuilder)) then
                    CreateUnit(player.id, FourCC(units_special.heroBuilder), GetRectCenterX(player.workerRect), GetRectCenterY(player.workerRect), 270)
                    player.heroBuilderCount = player.heroBuilderCount + 1
                    checkHeroAvailable(player, player.heroBuilderCount)
                end
            end)
        end
    end
end

function checkHeroAvailable(player, heroesCount)
    if game_config.units.maxHeroes <= heroesCount then
        SetPlayerTechMaxAllowed(player.id, FourCC(upgrades_special.summonHeroBuilder), 0)
    end
end
Debug.endFile()
Debug.beginFile('hero-transfer-experiance.lua')
function heroTransferExp()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterTimerEventPeriodic(trig, 1)
            TriggerAddAction(trig, function()
                for _, hero in ipairs(player.heroes) do
                    if hero.status == 'alive' then
                        local unitExp = GetHeroXP(hero.unit)
                        SetHeroXP(hero.building, unitExp, true)
                    end
                end
            end)
        end
    end
end
Debug.endFile()
Debug.beginFile('summon-label-trigger.lua')
function summonLabelTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddAction(trig, function()
        SetUnitUserData(GetSummonedUnit(), GetUnitUserData(GetSummoningUnit()))
        immediatelyMoveUnit(GetSummonedUnit())
    end)
end
Debug.beginFile('warden-trigger.lua')
function wardenTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGING)
    TriggerAddAction(trig, function()
        local unit = GetTriggerUnit()
        if GetUnitTypeId(unit) == FourCC('Ewar') then
            local rect = getPlayerBuildRect(GetOwningPlayer(unit))
            local livePercent = GetUnitLifePercent(unit)
            if livePercent <= 20 then
                IssuePointOrder(unit, 'blink', GetRectCenterX(rect), GetRectCenterY(rect))
            end
        end
    end)
end

function getPlayerBuildRect(player)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                return p.spawnRect
            end
        end
    end
    return nil
end
Debug.endFile()
Debug.beginFile('income-trigger.lua')
function incomeTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do

                player.economy.roundUp = not player.economy.roundUp

                local _, percent = getUpkeepTypeAndPercent(player)

                local income = (player.economy.income + player.economy.incomeForCenter)/60
                local incomeWithPercent = (income * percent) / 100
                if (incomeWithPercent == 0) then
                    return
                end

                local roundedIncome
                if player.economy.roundUp then
                    roundedIncome = math.ceil(incomeWithPercent)
                else
                    roundedIncome = math.floor(incomeWithPercent)
                end

                addGold(player, roundedIncome)
            end
        end
    end)
end

upkeepType = {
    NO = 'NO',
    LOW = 'LOW',
    HIGH = 'HIGH'
}

function getUpkeepTypeAndPercent(player)

    if game_config.economy.upkeep == true then
        if player.food > 10 and player.food <= 100 then
            return upkeepType.LOW, 80
        elseif player.food > 100 then
            return upkeepType.HIGH, 60
        else
            return upkeepType.NO, 100
        end
    end
    return nil, 100
end

function addGold(player, gold)
    local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)
    player.economy.totalGold = player.economy.totalGold + gold
    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + gold)
end
Debug.endFile()
Debug.beginFile('kill-tower-trigger.lua')
function killTowerTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == units_special.tower then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    local unit = GetKillingUnit()
                    local player = GetOwningPlayer(unit)
                    for _, otherTeam in ipairs(all_teams) do
                        if otherTeam.base.player == player then
                            for _, player in ipairs(otherTeam.players) do
                                DisplayTextToPlayer(player.id, 100, 200, '+' .. game_config.economy.goldByTower .. ' gold for killing a tower. ')
                                addGold(player, game_config.economy.goldByTower)
                            end
                            return
                        end
                    end
                end)
            end
        end)
        DestroyGroup(group)
    end
end
Debug.endFile()
Debug.beginFile('lifetime-limit.lua')
function lifetimeLimitTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 5.00)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                local allUnits = GetUnitsOfPlayerAll(player.spawnPlayerId)
                ForGroup(allUnits, function()
                    local unit = GetEnumUnit()
                    if not IsUnitType(unit, UNIT_TYPE_DEAD) then
                        local waveNumber = GetUnitUserData(unit)
                        if waveNumber ~= 0 then
                            if (player.waveNumber - waveNumber >= game_config.units.lifetime) then
                                local removeTimer = CreateTimer()
                                local tick = 10
                                local tag = CreateTextTagUnitBJ(tick, unit, 1,  10, 255, 2, 2, 255)
                                TimerStart(removeTimer, 0.5, true, function()
                                    tick = tick - 1
                                    if tick <= 0 then
                                        local effect = AddSpecialEffectLoc( "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", GetUnitLoc(unit))
                                        BlzSetSpecialEffectScale( effect, ( 0.30 * I2R(GetUnitLevel(unit)) ) )
                                        DestroyEffect( effect )
                                        RemoveUnit(unit)
                                        DestroyTimer(removeTimer)
                                        DestroyTextTag(tag)
                                    else
                                        DestroyTextTag(tag)
                                        tag = CreateTextTagUnitBJ(tick, unit, 1,  10, 255, 2, 2, 255)
                                    end
                                end)
                            end
                        end
                    end
                end)
                DestroyGroup(allUnits)
            end
        end
    end)
end
Debug.endFile()
Debug.beginFile('lose-trigger.lua')
function loseTrigger()
    for _, team in ipairs(all_teams) do
        local group = GetUnitsOfPlayerAll(team.base.player)
        ForGroup(group, function()
            local unit = GetEnumUnit()
            local unitId = ('>I4'):pack(GetUnitTypeId(unit))
            if unitId == units_special.base then
                local trig = CreateTrigger()
                TriggerRegisterUnitEvent(trig, unit, EVENT_UNIT_DEATH)
                TriggerAddAction(trig, function()
                    finishGame(team)
                end)
            end
        end)
        DestroyGroup(group)
    end
end
Debug.endFile()

Debug.beginFile('main-triggers.lua')
function initTriggers()
    incomeTrigger()
    moveTrigger()
    loseTrigger()
    winTrigger()
    goldExtractorTrigger()
    finishResearchTrigger()
    enableUpdateTrigger()
    customCastAITrigger()
    spellFinishTrigger()
    spawnTrigger()
    initHeroTriggers()
    sellTrigger()
    replaceTrigger()
    summonTrigger()
    statusPanelUpdateTrigger()
    damageDetectTrigger()
    KodoTrigger()
    deadDetectTrigger()
    killTowerTrigger()
    centerControlTrigger()
    tierDetectTrigger()
    lifetimeLimitTrigger()
    goldForKillTrigger()
    if IS_DEBUG_TRIGGER_ON then
        debugTrigger()
        debugTriggerGold()
        debugTriggerFinish()
        debugTriggerFinish2()
    end
end
Debug.endFile()
Debug.beginFile('move-trigger.lua')
additionalDir = 500
function moveTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for i = 1, #player.attackPointRect do
                local trig = CreateTrigger()
                TriggerRegisterTimerEventPeriodic(trig, 10)
                TriggerAddAction(trig, function()
                    local group = GetUnitsInRectAll(player.attackPointRect[i].rect)
                    ForGroup(group, function ()
                        local unit = GetEnumUnit()
                        local owner = GetOwningPlayer(unit)
                        if owner == player.spawnPlayerId then
                            if GetUnitCurrentOrder(unit) == 0 or
                                    GetUnitCurrentOrder(unit) == 851983 then
                                moveByLocation(player.attackPointRect[i], unit)
                            end
                        end
                    end)
                    DestroyGroup(group)
                end)
            end
        end
    end
end

function moveByLocation(rect, unit)
    local x, y
    if rect.direction == 'right' then
        x = GetRectMaxX(rect.rect) + additionalDir
        y = GetUnitY(unit)
    elseif rect.direction == 'down' then
        x = GetUnitX(unit)
        y = GetRectMinY(rect.rect) - additionalDir
    elseif rect.direction == 'left' then
        x = GetRectMinX(rect.rect) - additionalDir
        y = GetUnitY(unit)
    elseif rect.direction == 'up' then
        x = GetUnitX(unit)
        y = GetRectMaxY(rect.rect) + additionalDir
    end
    IssuePointOrderLoc(unit, "attack", Location(x, y))
end

function containsValue(value, array)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end
Debug.endFile()
Debug.beginFile('replace-trigger.lua')
function replaceTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.moveLarge) or
                        GetSpellAbilityId() == FourCC(abilities.moveMedium) or
                        GetSpellAbilityId() == FourCC(abilities.moveSmall)
            end))
            TriggerAddAction(trig, function()
                local location = GetSpellTargetLoc()

                if type(player.buildRect) == "table" then
                    for i in ipairs(player.buildRect) do
                        if isLocationInRectangle(location, player.buildRect[i]) then
                            local unit = GetSpellAbilityUnit()
                            SetUnitPositionLoc(unit, location)
                        end
                    end
                else
                    if isLocationInRectangle(location, player.buildRect) then
                        local unit = GetSpellAbilityUnit()
                        SetUnitPositionLoc(unit, location)
                    end
                end
            end)
        end
    end
end

function isLocationInRectangle(location, rect)
    rectMinX = GetRectMinX(rect)
    rectMinY = GetRectMinY(rect)
    rectMaxX = GetRectMaxX(rect)
    rectMaxY = GetRectMaxY(rect)

    local locX = GetLocationX(location)
    local locY = GetLocationY(location)

    return locX >= rectMinX and locX <= rectMaxX and locY >= rectMinY and locY <= rectMaxY
end

function replaceCell(player)
    if type(player.buildRect) == "table" then
        for i in ipairs(player.buildRect) do
            local group = GetUnitsInRectAll(player.buildRect[i])
            replaceGroupCell(group)
        end
    else
        local group = GetUnitsInRectAll(player.buildRect)
        replaceGroupCell(group)
    end
end

function replaceGroupCell(group)
    ForGroup(group, function()
        local unit = GetEnumUnit()
        local ability = BlzGetUnitAbility(unit, FourCC(abilities.sell100))
        if ability ~= nil then
            UnitAddAbility(unit, FourCC(abilities.sell75))
            UnitRemoveAbilityBJ(FourCC(abilities.sell100), unit)
        end
    end)
    DestroyGroup(group)
end
Debug.endFile()
Debug.beginFile('sell-trigger.lua')
function sellTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEvent(trig, player.id, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            TriggerAddCondition(trig, Condition(function()
                return GetSpellAbilityId() == FourCC(abilities.sell100) or GetSpellAbilityId() == FourCC(abilities.sell75)
            end))
            TriggerAddAction(trig, function()
                local unit = GetSpellAbilityUnit()
                local cost = GetUnitGoldCost(GetUnitTypeId(unit))
                TriggerSleepAction(0.1)
                RemoveUnit(unit)
                local currentGold = GetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD)

                if GetSpellAbilityId() == FourCC(abilities.sell100) then
                    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + cost)
                else
                    SetPlayerState(player.id, PLAYER_STATE_RESOURCE_GOLD, currentGold + math.floor(cost * 0.75))
                end
                player.food = player.food - getFoodCostUnit(('>I4'):pack(GetUnitTypeId(unit)))
            end)
        end
    end
end

function replaceCell(player)
    if type(player.buildRect) == "table" then
        for i in ipairs(player.buildRect) do
            local group = GetUnitsInRectAll(player.buildRect[i])
            replaceGroupCell(group)
        end
    else
        local group = GetUnitsInRectAll(player.buildRect)
        replaceGroupCell(group)
    end
end

function replaceGroupCell(group)
    ForGroup(group, function()
        local unit = GetEnumUnit()
        local ability = BlzGetUnitAbility(unit, FourCC(abilities.sell100))
        if ability ~= nil then
            UnitAddAbility(unit, FourCC(abilities.sell75))
            UnitRemoveAbilityBJ(FourCC(abilities.sell100), unit)
        end
    end)
    DestroyGroup(group)
end
Debug.endFile()
Debug.beginFile('spawn-trigger.lua')
function spawnTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1)
    TriggerAddAction(trig, function()
        for _, team in ipairs(all_teams) do
            for _, player in ipairs(team.players) do
                if player.spawnTimer <= 0 then
                    player.waveNumber = player.waveNumber + 1
                    processGroupForSpawn(player)
                    player.spawnTimer = game_config.spawnPolicy.interval * #team.players + game_config.spawnPolicy.dif
                    replaceCell(player)
                end
                player.spawnTimer = player.spawnTimer - 1
            end
        end
    end)
end

function handleUnitSpawn(player, id, x, y)
    local parentId = getParentUnitId(('>I4'):pack(id))
    if parentId then
        local unit = CreateUnit(player.spawnPlayerId, FourCC(parentId), x, y, 270)
        SetUnitUserData(unit, player.waveNumber)
        SetUnitAcquireRangeBJ(unit, GetUnitAcquireRange(unit) * game_config.units.range)
        immediatelyMoveUnit(unit)
    end
end

function handleHeroSpawn(player, unit, x, y)
    local hero = getHero(player.heroes, unit)
    if hero.status == "new" then
        local unit = CreateUnit(player.spawnPlayerId, FourCC(hero.unitConfig.parentId), x, y, 270)
        if (game_config.units.heroStartLevel > 1) then
            SetHeroLevel(unit, game_config.units.heroStartLevel, false)
        end
        SetUnitUserData(unit, hero.id)
        BlzSetHeroProperName(unit, hero.name)
        SetUnitAcquireRangeBJ(unit, GetUnitAcquireRange(unit) * game_config.units.range)
        hero.status = "alive"
        hero.unit = unit
        immediatelyMoveUnit(unit)
    elseif hero.status == "dead" then
        hero.status = "alive"
        ReviveHeroLoc(hero.unit, Location(x, y), false)
        SetUnitManaPercentBJ(hero.unit, 100)
        immediatelyMoveUnit(hero.unit)
    end
    SynchronizeInventory(unit, hero.unit)
end

function SynchronizeInventory(hero1, hero2)
    for slot = 0, 5 do
        local item = UnitItemInSlot(hero1, slot)

        local itemForDelete = UnitItemInSlot(hero2, slot)
        if itemForDelete then
            RemoveItem(itemForDelete)
        end

        if item then
            UnitAddItemToSlotById(hero2, GetItemTypeId(item), slot)
        end
    end
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function getHero(heroes, unit)
    for _, hero in ipairs(heroes) do
        if hero.building == unit then
            return hero
        end
    end
    return nil
end

function processGroupForSpawn(player)
    local function processRect(buildRect, spawnRect)
        local groupForBuild = GetUnitsInRectAll(buildRect)
        ForGroup(groupForBuild, function()
            local unit = GetEnumUnit()
            local id = GetUnitTypeId(unit)
            local owner = GetOwningPlayer(unit)
            if owner == player.id then
                local x, y = calculateDif(buildRect, spawnRect, unit)
                if isHero(('>I4'):pack(id)) then
                    handleHeroSpawn(player, unit, x, y)
                else
                    handleUnitSpawn(player, id, x, y)
                end
            end
        end)
        DestroyGroup(groupForBuild)
    end

    processRect(player.buildRect, player.spawnRect)
end

function getParentUnitId(searchId)
    for _, unit in pairs(units_for_build) do
        if unit.id == searchId then
            return unit.parentId
        end
    end
    return nil
end

function isHero(id)
    for _, hero in ipairs(heroes_for_build) do
        if hero.id == id then
            return true
        end
    end
    return false
end
Debug.endFile()
Debug.beginFile('status-panel-update-trigger.lua')
function statusPanelUpdateTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        updatePanelForAllPlayers()
        updateStatisticPanel()
    end)
end
Debug.endFile()
Debug.beginFile('summon-trigger.lua')
function summonTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddAction(trig, function()
        SetUnitUserData(GetSummonedUnit(), GetUnitUserData(GetSummoningUnit()))
    end)
end
Debug.endFile()
Debug.beginFile('tier-detect-trigger.lua')
function tierDetectTrigger()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local trig = CreateTrigger()
            TriggerRegisterPlayerUnitEventSimple( trig, player.id, EVENT_PLAYER_UNIT_UPGRADE_FINISH )
            TriggerAddAction(trig, function()
                if (GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.t2)) then
                    player.tier = 'T2'
                end
                if (GetUnitTypeId(GetTriggerUnit()) == FourCC(units_special.t3)) then
                    player.tier = 'T3'
                end

            end)
        end
    end
end
Debug.endFile()
Debug.beginFile('gold-for-kill-trigger.lua')
function goldForKillTrigger()
    if game_config.economy.goldForKill == 0 then
        return
    end

    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trig, function()
        local killerUnit = GetKillingUnit()

        local cost = getBuildingCost(('>I4'):pack(GetUnitTypeId(GetTriggerUnit())))
        if cost > 0 then
            local gold = math.floor((game_config.economy.goldForKill/100) * cost)
            local sourcePlayer = GetOwningPlayer(killerUnit)
            for _, team in ipairs(all_teams) do
                for _, player in ipairs(team.players) do
                    if sourcePlayer == player.spawnPlayerId then
                        player.economy.totalGoldForKills = player.economy.totalGoldForKills + gold
                        addGold(player, gold)
                        return
                    end
                end
            end
        end
    end)
end

function getBuildingCost(id)
    for _, unit in ipairs(units_for_build) do
        if unit.parentId == id then
            return GetUnitGoldCost(FourCC(unit.id))
        end
        if unit.otherForm then
            for _, form in ipairs(unit.otherForm) do
                if form == id then
                    return GetUnitGoldCost(FourCC(unit.id))
                end
            end
        end
    end
    for _, hero in ipairs(heroes_for_build) do
        if hero.parentId == id then
            return game_config.units.heroCost
        end
        if hero.otherForm then
            for _, form in ipairs(hero.otherForm) do
                if form == id then
                    return game_config.units.heroCost
                end
            end
        end
    end
    return 0
end
Debug.endFile()
Debug.beginFile('kodo-trigger.lua')
function KodoTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddAction(trig, function()
        local order = GetIssuedOrderId()
        if order == 852104 then
            TriggerSleepAction(3)
            immediatelyMoveUnit(GetTriggerUnit())
        end
    end)
end
Debug.endFile()
Debug.beginFile('spell-cast-trigger.lua')
custom_cast_ai_params = {
    {
        unitId = 'u006',
        order = 'antimagicshell',
        radius = 500,
        timeout = 2.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'ally'
        }
    },
    {
        unitId = 'h00H',
        order = 'innerfire',
        radius = 500,
        timeout = 5.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'ally'
        }
    },
    {
        unitId = 'h00I',
        order = 'invisibility',
        radius = 500,
        timeout = 1.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'ally',
            livePercent = 20
        }
    },
    {
        unitId = 'e00J',
        order = 'rejuvination',
        radius = 500,
        timeout = 2.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'ally',
            livePercent = 90
        }
    },
    {
        unitId = 'e00J',
        order = 'bearform',
        radius = 500,
        timeout = 2.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'itself',
            livePercent = 75
        }
    },
    {
        unitId = 'e00I',
        order = 'revanform',
        radius = 900,
        timeout = 2.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'enemy'
        }
    },
    {
        unitId = 'e00I',
        order = 'cyclone',
        radius = 500,
        timeout = 3.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'enemy'
        }
    },
    {
        unitId = 'Ofar',
        order = 'firebolt',
        radius = 500,
        timeout = 5.00,
        orderTarget = 'conditionUnit',
        condition = {
            target = 'enemy'
        }
    },
    {
        unitId = 'e00I',
        order = 'ravenform',
        radius = 500,
        timeout = 1.00,
        orderTarget = 'itself',
        condition = {
            target = 'enemy',
            isFly = true,
            exceptionUnits = {'u00A'}
        }
    },
    {
        unitId = 'edtm',
        order = 'unravenform',
        radius = 500,
        timeout = 2.00,
        orderTarget = 'itself',
        condition = {
            target = 'itself'
        }
    },
    {
        unitId = 'ucrm',
        order = 'unburrow',
        radius = 500,
        timeout = 5.00,
        orderTarget = 'itself',
        condition = {
            target = 'itself'
        }
    }
}
function customCastAITrigger()
    for _, castParam in ipairs(custom_cast_ai_params) do
        createTriggerByCastParam(castParam)
    end
end

function createTriggerByCastParam(castParam)
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, castParam.timeout)
    TriggerAddAction(trig, function()
        local group = GetUnitsOfTypeIdAll(FourCC(castParam.unitId))
        ForGroup(group, function()

            if castParam.condition.target == 'ally' or castParam.condition.target == 'enemy' then
                local unitsGroup = GetUnitsInRangeOfLocMatching(
                        castParam.radius,
                        GetUnitLoc(GetEnumUnit()),
                        Filter(function()
                            local filterUnit = GetFilterUnit()
                            if castParam.condition then
                                if castParam.condition.exceptionUnits then
                                    for _, unit in ipairs(castParam.condition.exceptionUnits) do
                                        if GetUnitTypeId(filterUnit) == FourCC(unit) then
                                            return false
                                        end
                                    end
                                end
                                if castParam.condition.livePercent then
                                    local livePercent = GetUnitLifePercent(filterUnit)
                                    if castParam.condition.livePercent <= livePercent then
                                        return false
                                    end
                                end
                                if castParam.condition.isFly then
                                    if BlzGetUnitMovementType(filterUnit) == MOVE_TYPE_FLY then
                                        return true
                                    end
                                end
                            end
                            local ownerFilterUnit = GetOwningPlayer(filterUnit)

                            if castParam.condition.target == 'ally' then
                                return isPlayerAlly(GetOwningPlayer(GetEnumUnit()), ownerFilterUnit)
                            elseif castParam.condition.target == 'enemy' then
                                return isPlayerEnemy(GetOwningPlayer(GetEnumUnit()), ownerFilterUnit)
                            end
                        end)
                )

                if CountUnitsInGroup(unitsGroup) >= 1 then
                    local randomUnit = GroupPickRandomUnit(unitsGroup)

                    if castParam.orderTarget == 'conditionUnit' then
                        IssueTargetOrderBJ(GetEnumUnit(), castParam.order, randomUnit)
                    elseif castParam.orderTarget == 'itself' then
                        IssueImmediateOrder(GetEnumUnit(), castParam.order)
                    end
                end
                DestroyGroup(unitsGroup)
            elseif castParam.condition.target == 'itself' then
                if castParam.condition then
                    if castParam.condition.livePercent then
                        local livePercent = GetUnitLifePercent(GetEnumUnit())
                        if castParam.condition.livePercent >= livePercent then
                            IssueImmediateOrder(GetEnumUnit(), castParam.order)
                        end
                    else
                        IssueImmediateOrder(GetEnumUnit(), castParam.order)
                    end
                end
            end

        end)
    end)
end

function isPlayerAlly(player, checkPlayer)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                for _, spawnP in ipairs(getAllSpawnPlayers(team)) do
                    if spawnP == checkPlayer then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function isPlayerEnemy(player, checkPlayer)
    for _, team in ipairs(all_teams) do
        for _, p in ipairs(team.players) do
            if p.spawnPlayerId == player then
                for _, teamOther in ipairs(all_teams) do
                    if (teamOther ~= team) then
                        for _, spawnP in ipairs(getAllSpawnPlayers(teamOther)) do
                            if spawnP == checkPlayer then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end
Debug.endFile()
Debug.beginFile('spell-finish-trigger.lua')
function spellFinishTrigger()
    local trig = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddAction(trig, function()
        immediatelyMoveUnit(GetTriggerUnit())
    end)
end

function immediatelyMoveUnit(unit)
    local attackPointRect = getAttackPointRect(GetOwningPlayer(unit))
    for _, atPointRect in ipairs(attackPointRect) do
        if IsUnitInRect(atPointRect.rect, unit) then
            moveByLocation(atPointRect, unit)
            return
        end
    end
end

function IsUnitInRect(r, u)
    return GetUnitX(u) > GetRectMinX(r)-32 and GetUnitX(u) < GetRectMaxX(r)+32 and GetUnitY(u) > GetRectMinY(r)-32 and GetUnitY(u) < GetRectMaxY(r)+32
end


function getAttackPointRect(castPlayer)
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if player.spawnPlayerId == castPlayer then
                return player.attackPointRect
            end
        end
    end
end
Debug.endFile()
Debug.beginFile('win-trigger.lua')
function winTrigger()
    local trig = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(trig, 1.00)
    TriggerAddAction(trig, function()
        local notLoseTeams = {}
        for _, team in ipairs(all_teams) do
            if team.lose ~= true then
                table.insert(notLoseTeams, team)
            end
        end
        if #notLoseTeams == 1 then
            for _, player in ipairs(notLoseTeams[1].players) do
                CustomVictoryBJ(player.id, true, true)
            end
        end
    end)
end
Debug.endFile()
Debug.beginFile('start-game.lua')
function initAbilitiesPanel()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            local buttonAbility = BlzCreateSimpleFrame('AbilitiesButton', BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0)
            BlzFrameSetAbsPoint(buttonAbility, FRAMEPOINT_BOTTOMLEFT, 0.2, 0.13)
            BlzFrameSetSize(buttonAbility, 0.08, 0.03)
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
                if GetTriggerPlayer() ~= GetLocalPlayer() then
                    return
                end
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
Debug.beginFile('finish-game.lua')
function finishGame(loseTeam)
    local mainBackdrop = BlzCreateFrame('FinishGameBackdrop', BlzGetFrameByName("ConsoleUIBackdrop", 0), 0, 0)
    BlzFrameSetAbsPoint(mainBackdrop, FRAMEPOINT_CENTER, 0.4, 0.35)
    BlzFrameSetLevel(mainBackdrop, 99)

    local weightMultiplyForBigFont = 1.5
    local heightFont = 0.02

    local fakeText = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
    BlzFrameSetSize(fakeText, 0.15, 0.01)
    BlzFrameSetText(fakeText, '')
    BlzFrameSetPoint(fakeText, FRAMEPOINT_TOPLEFT, mainBackdrop, FRAMEPOINT_TOPLEFT, 0.02, -0.01)

    local firstColumn = fakeText
    local prevColumn = fakeText
    local totalWidth
    local totalRows = 4
    for teamNumber, team in ipairs(all_teams) do
        totalWidth = 0
        local tableInfo = getTableInfo(teamNumber)

        local teamLabel = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
        BlzFrameSetSize(teamLabel, 0.15, 0.02)
        BlzFrameSetText(teamLabel, 'Team ' .. teamNumber)
        BlzFrameSetPoint(teamLabel, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
        firstColumn = teamLabel
        prevColumn = teamLabel

        for i, headerColumn in ipairs(tableInfo.header) do
            if headerColumn.text and headerColumn.isFinish then
                local header = BlzCreateFrame("HeaderTableText", mainBackdrop, 0, 0)
                BlzFrameSetSize(header, headerColumn.weight * weightMultiplyForBigFont, heightFont)
                totalWidth = totalWidth + (headerColumn.weight * weightMultiplyForBigFont)
                BlzFrameSetText(header, headerColumn.text)
                BlzFrameSetTextAlignment(header, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                if i == 1 then
                    BlzFrameSetPoint(header, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
                    firstColumn = header
                else
                    BlzFrameSetPoint(header, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0, 0)
                end
                prevColumn = header
            end
        end

        for _, row in ipairs(tableInfo.body) do
            local prevColumn
            totalRows = totalRows + 1
            for j, element in ipairs(row) do
                if element.text and tableInfo.header[j].isFinish then
                    local column = BlzCreateFrame("RowTableText", mainBackdrop, 0, 0)
                    if j == 1 then
                        local line = BlzCreateSimpleFrame("FinishGameLine", mainBackdrop, 0)
                        BlzFrameSetPoint(line, FRAMEPOINT_BOTTOMLEFT, column, FRAMEPOINT_BOTTOMLEFT, -0.005, 0.005)
                        BlzFrameSetSize(line,totalWidth, 0.015)
                        BlzFrameSetAlpha(line, 50)

                        local texture = BlzGetFrameByName("FinishGameLineTexture", 0)
                        BlzFrameSetTexture(texture, "war3mapImported\\line.tga", 0, true)
                        BlzFrameSetVertexColor(texture, element.integerColor)
                    end
                    BlzFrameSetSize(column, tableInfo.header[j].weight * weightMultiplyForBigFont, heightFont)
                    BlzFrameSetTextAlignment(column, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                    BlzFrameSetTextColor(column, element.integerColor)
                    BlzFrameSetText(column, element.text)
                    if j == 1 then
                        BlzFrameSetPoint(column, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
                        firstColumn = column
                    else
                        BlzFrameSetPoint(column, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0, 0)
                    end
                    prevColumn = column
                end
                if element.icon then
                    local frame = BlzCreateFrameByType("BACKDROP", "Any", mainBackdrop, "", 0)
                    BlzFrameSetSize(frame, heightFont, heightFont)
                    BlzFrameSetTexture(frame, element.icon, 0, true)
                    if j == 1 then
                        BlzFrameSetPoint(frame, FRAMEPOINT_TOP, firstColumn, FRAMEPOINT_BOTTOM, 0, 0)
                        firstColumn = column
                    else
                        BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, prevColumn, FRAMEPOINT_TOPRIGHT, 0, 0)
                    end
                    prevColumn = frame
                end
            end
        end
    end

    local mainButton = BlzCreateFrame("ScriptDialogButton", mainBackdrop, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetSize(mainButton, 0.15, 0.04)
    BlzFrameSetPoint(mainButton, FRAMEPOINT_BOTTOMRIGHT, mainBackdrop, FRAMEPOINT_BOTTOMRIGHT, -0.01, 0.01)
    BlzFrameSetText(buttonText, "Exit")
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, mainButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        CustomVictoryBJ(GetTriggerPlayer(), false, true)
    end)

    local victoryOrLosePict = BlzCreateFrameByType("BACKDROP", "Any", mainBackdrop, "", 0)
    BlzFrameSetSize(victoryOrLosePict, 0.14, 0.14)

    if isPlayerIsWinner(loseTeam) then
        BlzFrameSetTexture(victoryOrLosePict, "war3mapImported\\victory1.blp", 0, true)
    else
        BlzFrameSetTexture(victoryOrLosePict, "war3mapImported\\defeat1.blp", 0, true)
    end

    BlzFrameSetPoint(victoryOrLosePict, FRAMEPOINT_BOTTOM, mainButton, FRAMEPOINT_TOP, 0, 0.001)
    BlzFrameSetSize(mainBackdrop, totalWidth + 0.18, 0.35)
end

function isPlayerIsWinner(loseTeam)
    localPlayer = GetLocalPlayer()
    for _, player in ipairs(loseTeam.players) do
        if localPlayer == player.id then
            return false
        end
    end
    return true
end
Debug.endFile()
Debug.beginFile('hero-statistic-panel.lua')

function heroStatisticPanel()
    local tableInfo = getHeroInfo()
    heroMultiboard = CreateMultiboardBJ( #tableInfo.header, 1, "Heroes statistics" )
    heroMultiboardFrame = BlzGetFrameByName("Multiboard",0)
    heroMultiContainer = BlzGetFrameByName("MultiboardListContainer",0)
    heroMultiBackdrop = BlzGetFrameByName("MultiboardBackdrop",0)
    for i, header in ipairs(tableInfo.header) do
        local title = MultiboardGetItem(heroMultiboard, 0, i - 1)
        if header.text ~= nil then
            MultiboardSetItemStyle(title, true, false)
            MultiboardSetItemValue(title, header.text)
            MultiboardSetItemWidth(title, header.weight)
        else
            MultiboardSetItemStyle(title, false, false)
            MultiboardSetItemWidth(title, 0.0001)
        end
        MultiboardReleaseItem(title)
    end

    BlzFrameClearAllPoints(heroMultiboardFrame)
    BlzFrameSetAbsPoint(heroMultiboardFrame, FRAMEPOINT_LEFT, 0.19,0.55)
    BlzFrameSetVisible(heroMultiboardFrame, true)
    MultiboardMinimize(heroMultiboard, true)
end

function updateStatisticPanel()
    local updatedTableInfo = getHeroInfo()


    local function compareRows(row1, row2)
        return row1[5].text > row2[5].text
    end
    table.sort(updatedTableInfo.body, compareRows)

    MultiboardSetRowCount(heroMultiboard,  #updatedTableInfo.body + 1)
    for row, bodyRow in ipairs(updatedTableInfo.body) do
        for col, cell in ipairs(bodyRow) do

            local item = MultiboardGetItem(heroMultiboard, row, col - 1)

            if (col == 1) then
                MultiboardSetItemStyle(item, true, false)
                MultiboardSetItemValue(item, row)
                MultiboardSetItemWidth(item, updatedTableInfo.header[col].weight)
            elseif (cell.text) then
                MultiboardSetItemStyle(item, true, false)
                MultiboardSetItemValue(item, cell.text)
                MultiboardSetItemValueColor(item, cell.color.r, cell.color.g, cell.color.b, cell.color.t)
                MultiboardSetItemWidth(item, updatedTableInfo.header[col].weight)
            elseif (cell.icon) then
                MultiboardSetItemStyle(item, false, true)
                MultiboardSetItemIcon(item, cell.icon)
                MultiboardSetItemWidth(item, 0.01)
            else
                MultiboardSetItemStyle(item, true, false)
                MultiboardSetItemValue(item, "")
                MultiboardSetItemWidth(item, 0.01)
            end
            MultiboardReleaseItem(item)
        end
    end
end

function getHeroInfo()
    local tableInfo = {}
    tableInfo.header = {}
    table.insert(tableInfo.header, { text = 'P', weight = 0.015})
    table.insert(tableInfo.header, { text = '  ', weight = 0.015})
    table.insert(tableInfo.header, { text = 'Name', weight = 0.09})
    table.insert(tableInfo.header, { text = 'Kills', weight = 0.03})
    table.insert(tableInfo.header, { text = 'Damage', weight = 0.05})
    tableInfo.body = {}
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for _, hero in ipairs(player.heroes) do
                if hero.damage >= 1 then
                    local row = {}
                    table.insert(row, {})
                    table.insert(row, {
                        icon = hero.icon,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(row, {
                        text = hero.name,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(row, {
                        text = hero.kills,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(row, {
                        text = hero.damage,
                        color = player.color,
                        integerColor = player.integerColor,
                        isSensitive = false
                    })
                    table.insert(tableInfo.body, row)
                end
            end
        end
    end
    return tableInfo
end
Debug.endFile()
Debug.beginFile('element-check-box.lua')
function createCheckBox(parentPage, lastElement, element)

    local label = BlzCreateFrameByType("TEXT", "", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(label, element.text)
    BlzFrameSetSize(label, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(label, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local tooltipFrame, tooltipLabel = createTooltip(parentPage)
    BlzFrameSetTooltip(label, tooltipFrame)
    BlzFrameSetText(tooltipLabel, element.tooltip)

    local frameCheckBox = BlzCreateFrame("QuestCheckBox2", parentPage, 0, 0)
    BlzFrameSetPoint(frameCheckBox, FRAMEPOINT_LEFT, label, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetScale(frameCheckBox, 1.5)
    BlzFrameSetEnable(frameCheckBox, GetLocalPlayer() == getMainPlayer())

    local trigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_CHECKED)
    BlzTriggerRegisterFrameEvent(trigger, frameCheckBox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    TriggerAddAction(trigger, function()
        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
            element.value = true
        else
            element.value = false
        end
    end)
    return label
end
Debug.endFile()
Debug.beginFile('element-check-box.lua')
function createEditBox(parentPage, lastElement, element)
    local frameText = BlzCreateFrameByType("TEXT", "TextFrame", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, element.text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local tooltipFrame, tooltipLabel = createTooltip(parentPage)
    BlzFrameSetTooltip(frameText, tooltipFrame)
    BlzFrameSetText(tooltipLabel, element.tooltip)

    local editBox = BlzCreateFrame("EscMenuEditBoxTemplate", parentPage, 0, 0) --create the box
    BlzFrameSetPoint(editBox, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetSize(editBox, 0.1, 0.03)
    BlzFrameSetText(editBox, element.defValue)
    BlzFrameSetEnable(editBox, GetLocalPlayer() == getMainPlayer())

    local label = BlzCreateFrame("EscMenuLabelTextTemplate", parentPage, 0, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, editBox, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetText(label, '= ' .. element.defValue)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, editBox, FRAMEEVENT_EDITBOX_ENTER)
    TriggerAddAction(trig, function()
        local value = extractNumber(BlzGetTriggerFrameText())

        local newValue
        if value ~= nil then
            if value <= element.min then
                newValue = element.min
            elseif value >= element.max then
                newValue = element.max
            else
                newValue = value
            end
        else
            newValue = initValue
        end

        if (newValue ~= nil) then
            element.value = value
            BlzFrameSetText(label, '= ' .. newValue)
        end
    end)
    return frameText
end

function extractNumber(inputString)
    local number = string.match(inputString, "%-?%d+")
    return number and tonumber(number) or nil
end
Debug.endFile()

Debug.beginFile('element-slider.lua')
function createSlider(parentPage, lastElement, element)
    local frameText = BlzCreateFrameByType("TEXT", "TextCountHeroes", parentPage, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetText(frameText, element.text)
    BlzFrameSetSize(frameText, ui_params.lengthString, ui_params.widthString)
    BlzFrameSetEnable(frameText, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetPoint(frameText, FRAMEPOINT_TOPLEFT, lastElement, FRAMEPOINT_TOPLEFT, 0, -ui_params.betweenElement)

    local tooltipFrame, tooltipLabel = createTooltip(parentPage)
    BlzFrameSetTooltip(frameText, tooltipFrame)
    BlzFrameSetText(tooltipLabel, element.tooltip)

    local slider = BlzCreateFrame("EscMenuSliderTemplate", parentPage, 0, 0)
    BlzFrameSetPoint(slider, FRAMEPOINT_LEFT, frameText, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetMinMaxValue(slider, element.min, element.max)
    BlzFrameSetValue(slider, element.defValue)
    BlzFrameSetStepSize(slider, element.step)
    BlzFrameSetEnable(slider, GetLocalPlayer() == getMainPlayer())

    local label = BlzCreateFrame("EscMenuLabelTextTemplate", slider, 0, 0)
    BlzFrameSetPoint(label, FRAMEPOINT_LEFT, slider, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetText(label, element.defValue)
    BlzFrameSetEnable(label, GetLocalPlayer() == getMainPlayer())

    local sliderTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(sliderTrigger, slider, FRAMEEVENT_SLIDER_VALUE_CHANGED)
    TriggerAddAction(sliderTrigger, function()
        local value = BlzGetTriggerFrameValue()
        element.value = value
        BlzFrameSetText(label, math.floor(value))
    end)
    return frameText
end
Debug.endFile()
Debug.beginFile('init-start-game-ui.lua')
function initStartGameUI()
    ui_params = {
        lengthString = 0.2,
        widthString = 0.02,
        indent = 0.015,
        width = 0.4,
        betweenElement = 0.029
    }

    elementType = {
        SLIDER = 'slider',
        EDIT_BOX = 'editBox',
        CHECK_BOX = 'checkBox'
    }

    page = {
        GENERAL = 'general',
        ECONOMY = 'economy',
        HEROES = 'heroes',
        UNITS = 'units'
    }

    ui_elements = {
        -- GENERAL
        {
            page = page.GENERAL,
            type = elementType.SLIDER,
            text = 'Wave interval each players',
            tooltip = 'Wave release interval between players. The total interval for each player between their' ..
                    ' turns will be the product of the number of players and the interval.\n\nThe default value of this' ..
                    ' parameter varies depending on the number of players:\n' ..
                    '[1x1] 35 sec * 1 = 35 total\n' ..
                    '[2x2] 35 sec * 2 = 70 total\n' ..
                    '[3x3] 35 sec * 3 = 105 total\n' ..
                    '[4x4] 30 sec * 4 = 120 total\n' ..
                    '[5x5] 25 sec * 4 = 125 total\n',
            defValue = {
                [1] = 35,
                [2] = 35,
                [3] = 35,
                [4] = 35,
                [5] = 35,
                [6] = 35,
                [7] = 30,
                [8] = 30,
                [9] = 25,
                [10] = 25
            },
            max = 120,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.spawnPolicy.interval = self.value
            end
        },
        {
            page = page.GENERAL,
            type = elementType.SLIDER,
            text = 'Wave interval all players',
            tooltip = 'The interval for the next wave after all players have launched waves and a full cycle has passed for the team',
            defValue = 0,
            max = 120,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.spawnPolicy.dif = self.value
            end
        },
        {
            page = page.GENERAL,
            type = elementType.EDIT_BOX,
            text = 'Base HP',
            tooltip = "Maximum health capacity of the team's main base",
            defValue = 4000,
            max = 999999,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.baseHP = self.value
            end
        },
        {
            page = page.GENERAL,
            type = elementType.EDIT_BOX,
            text = 'Tower HP',
            tooltip = "Maximum health capacity of the team's tower",
            defValue = 4000,
            max = 999999,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.towerHP = self.value
            end
        },
        -- ECONOMY
        {
            page = page.ECONOMY,
            type = elementType.EDIT_BOX,
            text = 'Start gold',
            tooltip = "Initial amount of gold with which players start the game",
            defValue = 300,
            max = 999999,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.startGold = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Base income/min',
            tooltip = "Starting amount of income",
            defValue = 300,
            max = 3000,
            min = 0,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.startIncomePerSec = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Added inc for each mine',
            tooltip = "Additional income awarded to the player for each mine upgrade",
            defValue = 30,
            max = 300,
            min = 30,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.incomeBoost = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Added inc for controlling center',
            tooltip = "Additional income for team control of the center.\nThis income is granted to the team that" ..
                    " first crosses the center of the map, until another team crosses the center",
            defValue = 30,
            max = 300,
            min = 0,
            step = 30,
            initConfigValue = function(self)
                game_config.economy.incomeForCenter = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Price first mine',
            tooltip = "Cost of the first upgrade for the mine",
            defValue = 150,
            max = 1500,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.firstMinePrice = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Price diff for each next mine',
            tooltip = "Price increase for each subsequent mine upgrade",
            defValue = 75,
            max = 300,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.nextMineDiffPrice = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Gold for killing the tower',
            tooltip = "Amount of gold awarded to each team member for destroying an enemy tower",
            defValue = 125,
            max = 1500,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.goldByTower = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.SLIDER,
            text = 'Gold for killing units',
            tooltip = "Amount of gold earned for killing enemy units, calculated as a percentage of their cost. \n" ..
                    "For example, if the parameter value is 10%, the player receives 10% of the cost of the defeated unit. \n"..
                    "Players do not receive gold for killing summoned units",
            defValue = 0,
            max = 100,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.economy.goldForKill = self.value
            end
        },
        {
            page = page.ECONOMY,
            type = elementType.CHECK_BOX,
            text = 'Upkeep',
            tooltip = "No Upkeep (0-50 Food: 100% income)\n" ..
                    "Low Upkeep (51-100 Food: 80% income)\n" ..
                    "High Upkeep (101+ Food: 60% income)",
            defValue = false,
            initConfigValue = function(self)
                game_config.economy.upkeep = self.value
            end
        },
        -- UNITS
        {
            page = page.UNITS,
            type = elementType.CHECK_BOX,
            text = 'Mirror units',
            tooltip = "Distribute identical random units to players of opposing teams in corresponding positions.\n" ..
                    "For example, player 1 from team 1 will have the same set of units as player 1 from team 2, and so on",
            defValue = false,
            initConfigValue = function(self)
                game_config.units.isUnitsMirror = self.value
            end
        },
        {
            page = page.UNITS,
            type = elementType.SLIDER,
            text = 'Max lifespan of unit in waves',
            tooltip = "Number of waves after a unit's deployment, upon which the unit will disappear.\n" ..
                    "For example, if the parameter value is 2, then the unit will vanish after two more waves are" ..
                    " released by the player who owns that unit.",
            defValue = 2,
            max = 15,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.lifetime = self.value
            end
        },
        -- HEROES
        {
            page = page.HEROES,
            type = elementType.CHECK_BOX,
            text = 'Mirror heroes',
            tooltip = "Assign identical random heroes to players of opposing teams in the same positions.\n" ..
                    "For instance, player 1 from team 1 will have the same hero as player 1 from team 2, and so forth",
            defValue = false,
            initConfigValue = function(self)
                game_config.units.isHeroesMirror = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Max heroes',
            tooltip = "Maximum possible number of heroes for each player",
            defValue = 3,
            max = 7,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.units.maxHeroes = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Selectable hero count',
            tooltip = "Number of random heroes available for a player to choose from when summoning each subsequent hero.\n"
            .. " For example, if the parameter value is 3, then upon constructing a hero, the player will have a " ..
                    "choice among 3 randomly generated hero options.",
            defValue = 2,
            max = 11,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.countForSelect = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Item capacity',
            tooltip = "Maximum number of items that a hero can carry",
            defValue = 4,
            max = 6,
            min = 0,
            step = 1,
            initConfigValue = function(self)
                game_config.units.itemCapacity = self.value
            end
        },
        {
            page = page.HEROES,
            type = elementType.SLIDER,
            text = 'Start hero level',
            tooltip = "The initial level of the hero after construction.",
            defValue = 1,
            max = 10,
            min = 1,
            step = 1,
            initConfigValue = function(self)
                game_config.units.heroStartLevel = self.value
            end
        }
    }
end
Debug.endFile()
Debug.beginFile('main-start-game.lua')
function startGameUI()
    BlzLoadTOCFile("war3mapimported\\templates.toc")

    local upkeepFrame = BlzGetFrameByName("ResourceBarUpkeepText", 0)
    BlzFrameSetText(upkeepFrame, "alga")

    local parent = BlzCreateFrame("GreenText", BlzGetFrameByName("ConsoleUIBackdrop", 0), 0, 0)
    BlzFrameSetParent(parent, preConfigGameModes)
    BlzFrameSetText(parent, GetPlayerName(getMainPlayer()) .. " is selecting...")
    BlzFrameSetAbsPoint(parent, FRAMEPOINT_CENTER, 0.4, 0.56)
    BlzFrameSetSize(parent, ui_params.width, 0.02)

    local allPages = {}
    local buttonGeneral, pageGeneral, lastElementGeneral = configPage("General", parent, allPages, 0.02)
    BlzFrameSetPoint(buttonGeneral, FRAMEPOINT_TOPLEFT, parent, FRAMEPOINT_BOTTOMLEFT, 0, 0)

    local buttonEconomy, pageEconomy, lastElementEconomy = configPage("Economy", parent, allPages, 0.02)
    BlzFrameSetPoint(buttonEconomy, FRAMEPOINT_LEFT, buttonGeneral, FRAMEPOINT_RIGHT, -0.005, 0)

    local buttonUnits, pageUnits, lastElementUnits = configPage("Units", parent, allPages, 0.13)
    BlzFrameSetPoint(buttonUnits, FRAMEPOINT_LEFT, buttonEconomy, FRAMEPOINT_RIGHT, -0.005, 0)
    local availableUnitsTextFrame = BlzCreateFrameByType('TEXT', 'availableUnitsTextFrame', pageUnits, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableUnitsTextFrame, 'Available units:')
    BlzFrameSetPoint(availableUnitsTextFrame, FRAMEPOINT_TOPLEFT, pageUnits, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableUnitsTextFrame, units_for_build, 5)
    end
    for _, unit in ipairs(units_for_build) do
        initUnitAvailableButton(unit, availableUnitsTextFrame)
    end

    local buttonHeroes, pageHeroes, lastElementHeroes = configPage("Heroes", parent, allPages, 0.16)
    BlzFrameSetPoint(buttonHeroes, FRAMEPOINT_LEFT, buttonUnits, FRAMEPOINT_RIGHT, -0.005, 0)
    local availableHeroesTextFrame = BlzCreateFrameByType('TEXT', 'availableHeroesTextFrame', pageHeroes, 'EscMenuSaveDialogTextTemplate', 0)
    BlzFrameSetText(availableHeroesTextFrame, 'Available heroes:')
    BlzFrameSetPoint(availableHeroesTextFrame, FRAMEPOINT_TOPLEFT, pageHeroes, FRAMEPOINT_TOPLEFT, ui_params.indent, -0.04)
    for i, race in ipairs(main_race) do
        initRaceAvailableButton(race, i, availableHeroesTextFrame, heroes_for_build, 6)
    end
    for _, hero in ipairs(heroes_for_build) do
        initUnitAvailableButton(hero, availableHeroesTextFrame)
    end

    initGameConfig()

    for _, element in ipairs(ui_elements) do
        if type(element.defValue) == 'table' then
            element.defValue = element.defValue[game_config.playersCount]
        end


        element.value = element.defValue


        if element.page == page.GENERAL then
            lastElementGeneral = createElement(element, pageGeneral, lastElementGeneral)
        elseif element.page == page.ECONOMY then
            lastElementEconomy = createElement(element, pageEconomy, lastElementEconomy)
        elseif element.page == page.UNITS then
            lastElementUnits = createElement(element, pageUnits, lastElementUnits)
        elseif element.page == page.HEROES then
            lastElementHeroes = createElement(element, pageHeroes, lastElementHeroes)
        end
    end

    for number, page in ipairs(allPages) do
        if number == 1 then
            BlzFrameSetVisible(page, true)
        else
            BlzFrameSetVisible(page, false)
        end
    end
    local startGameButton = BlzCreateFrame('StartGameButton', parent, 0, 0)
    BlzFrameSetLevel(startGameButton, 99)
    BlzFrameSetText(startGameButton, 'START')
    BlzFrameSetPoint(startGameButton, FRAMEPOINT_BOTTOMRIGHT, pageGeneral, FRAMEPOINT_BOTTOMRIGHT, -ui_params.indent, ui_params.indent)
    BlzFrameSetEnable(startGameButton, GetLocalPlayer() == getMainPlayer())
    BlzFrameSetEnable(startGameButton, GetLocalPlayer() == getMainPlayer())
    local trig1 = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig1, startGameButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig1, function()
        BlzFrameSetVisible(parent, FALSE)
        for _, element in ipairs(ui_elements) do
            element.initConfigValue(element)
        end
        startGame()
    end)
end

function createTooltip(owner)
    local tooltipFrame = BlzCreateFrame('TooltipBackdrop', owner, 0, 0)
    BlzFrameSetPoint(tooltipFrame, FRAMEPOINT_LEFT, owner, FRAMEPOINT_RIGHT, 0, 0)
    BlzFrameSetSize(tooltipFrame, 0.26, 0.26)
    local tooltipLabel = BlzCreateFrameByType("TEXT", "", tooltipFrame, "EscMenuSaveDialogTextTemplate", 0)
    BlzFrameSetSize(tooltipLabel, 0.24, 0.24)
    BlzFrameSetTextAlignment(tooltipLabel, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_MIDDLE)
    BlzFrameSetPoint(tooltipLabel, FRAMEPOINT_CENTER, tooltipFrame, FRAMEPOINT_CENTER, 0, 0)
    BlzFrameSetParent(tooltipLabel, tooltipFrame)
    return tooltipFrame, tooltipLabel
end

function createElement(element, page, lastElement)
    if element.type == elementType.SLIDER then
        return createSlider(page, lastElement, element)
    elseif element.type == elementType.EDIT_BOX then
        return createEditBox(page, lastElement, element)
    elseif element.type == elementType.CHECK_BOX then
        return createCheckBox(page, lastElement, element)
    end

end

function buttonWithAction(text, parentFrame, action)
    local button = BlzCreateFrame('Button', parentFrame, 0, 0)
    BlzFrameSetLevel(button, 99)
    BlzFrameSetText(button, text)
    BlzFrameSetEnable(button, GetLocalPlayer() == getMainPlayer())
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, action)
    return button
end

function configPage(text, parent, allPages, dif)
    local configButton = BlzCreateFrame('ConfigPageButton', parent, 0, 0)
    BlzFrameSetLevel(configButton, 99)
    BlzFrameSetText(configButton, text)
    BlzFrameSetEnable(configButton, GetLocalPlayer() == getMainPlayer())

    local pageFrame = BlzCreateFrame('ConfigPageBackdrop', parent, 0, 0)
    BlzFrameSetPoint(pageFrame, FRAMEPOINT_TOP, parent, FRAMEPOINT_BOTTOM, 0, 0)
    BlzFrameSetSize(pageFrame, ui_params.width, 0.4)
    BlzFrameSetEnable(pageFrame, GetLocalPlayer() == getMainPlayer())
    table.insert(allPages, pageFrame)

    local emptyFrame = BlzCreateFrameByType("FRAME", "", parent, "", 0)
    BlzFrameSetSize(emptyFrame, ui_params.lengthString, 0.001)

    BlzFrameSetPoint(emptyFrame, FRAMEPOINT_TOPLEFT, pageFrame, FRAMEPOINT_TOPLEFT, ui_params.indent, -dif)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, configButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        for _, page in ipairs(allPages) do
            BlzFrameSetVisible(page, false)
        end
        BlzFrameSetVisible(pageFrame, true)
    end)
    return configButton, pageFrame, emptyFrame
end

function initRaceAvailableButton(race, position, frame, unitContainer, max)
    if position >= max then
        return
    end
    local button = BlzCreateFrame("MyIconButtonTemplate", frame, 0, 0)
    BlzFrameSetPoint(button, FRAMEPOINT_TOPLEFT, frame, FRAMEPOINT_TOPLEFT, 0, -(BlzFrameGetHeight(button) * position) + 0.01)

    local buttonTexture = BlzGetFrameByName("MyButtonBackdropTemplate", 0)
    BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(race.id)), 0, true)

    race.active = true
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        if GetTriggerPlayer() ~= getMainPlayer() then
            return
        end
        if race.active == true then
            race.active = false
            BlzFrameSetTexture(buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(race.id))), 0, true)
            for _, unit in ipairs(unitContainer) do
                if unit.race == race.race then
                    unit.active = false
                    BlzFrameSetTexture(unit.buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(unit.parentId))), 0, true)
                end
            end
        else
            race.active = true
            BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(race.id)), 0, true)
            for _, unit in ipairs(unitContainer) do
                if unit.race == race.race then
                    unit.active = true
                    BlzFrameSetTexture(unit.buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
                end
            end
        end
    end)
end

function initUnitAvailableButton(unit, containerFrame)
    local button = BlzCreateFrame("MyIconButtonTemplate", containerFrame, 0, 0)
    BlzFrameSetPoint(button, FRAMEPOINT_TOPLEFT, containerFrame, FRAMEPOINT_TOPLEFT, (BlzFrameGetWidth(button) * unit.position), -(BlzFrameGetHeight(button) * unit.line) + 0.01)

    local buttonTexture = BlzGetFrameByName("MyButtonBackdropTemplate", 0)
    BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)

    unit.active = true
    unit.buttonTexture = buttonTexture
    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        if GetTriggerPlayer() ~= getMainPlayer() then
            return
        end
        if unit.active == true then
            unit.active = false
            BlzFrameSetTexture(buttonTexture, replaceTexture(BlzGetAbilityIcon(FourCC(unit.parentId))), 0, true)
        else
            unit.active = true
            BlzFrameSetTexture(buttonTexture, BlzGetAbilityIcon(FourCC(unit.parentId)), 0, true)
        end
    end)
end

function replaceTexture(inputString)
    local replacedString = inputString:gsub("ReplaceableTextures\\CommandButtons\\(.-)%.blp", "ReplaceableTextures\\CommandButtonsDisabled\\DIS%1.blp")
    return replacedString
end
Debug.endFile()
Debug.beginFile('status-panel.lua')
function getTableInfo(teamId)
    local tableInfo = {}
    tableInfo.header = {}
    table.insert(tableInfo.header, { text = 'Name', weight = 0.085, isFinish = true })
    table.insert(tableInfo.header, { text = 'Wave', weight = 0.04 })
    table.insert(tableInfo.header, { text = 'Inc/min', weight = 0.07 })
    table.insert(tableInfo.header, { text = 'Gold total', weight = 0.045, isFinish = true })

    if game_config.economy.goldForKill > 0 then
        table.insert(tableInfo.header, { text = 'Gold kill', weight = 0.045, isFinish = true })
    end

    table.insert(tableInfo.header, { text = 'Kills', weight = 0.05, isFinish = true })
    table.insert(tableInfo.header, { text = 'Damage', weight = 0.06, isFinish = true })
    table.insert(tableInfo.header, { text = 'Tier', weight = 0.04, isFinish = true })
    table.insert(tableInfo.header, { text = 'Army', weight = 0.04, isFinish = true })
    table.insert(tableInfo.header, { text = 'Heroes', weight = 0.06, isFinish = true })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    table.insert(tableInfo.header, { })
    tableInfo.body = {}

    local teams
    if teamId then
        teams = { all_teams[teamId] }
    else
        teams = all_teams
    end

    for _, team in ipairs(teams) do
        for _, player in ipairs(team.players) do
            local row = {}
            table.insert(row, {
                text = getClearName(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = math.floor(player.spawnTimer),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = getIncome(player),
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                text = player.economy.totalGold,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })

            if game_config.economy.goldForKill  > 0 then
                table.insert(row, {
                    text = player.economy.totalGoldForKills,
                    color = player.color,
                    integerColor = player.integerColor,
                    isSensitive = true
                })
            end

            table.insert(row, {
                text = player.totalKills,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = player.totalDamage,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = false
            })
            table.insert(row, {
                text = player.tier,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                text = player.food,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[1] and player.heroes[1].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[2] and player.heroes[2].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[3] and player.heroes[3].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[4] and player.heroes[4].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[5] and player.heroes[5].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[6] and player.heroes[6].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(row, {
                icon = player.heroes[7] and player.heroes[7].icon or nil,
                color = player.color,
                integerColor = player.integerColor,
                isSensitive = true
            })
            table.insert(tableInfo.body, row)
        end
    end
    return tableInfo
end

function getIncome(player)
    if player.economy.incomeForCenter == 0 then
        return math.floor(player.economy.income)
    else
        return math.floor(player.economy.income) .. '(+' .. math.floor(player.economy.incomeForCenter) .. ')'
    end
end

function getClearName(player)
    return string.gsub(GetPlayerName(player.id), "#.*", "")
end

function updatePanelForAllPlayers()
    local updatedTableInfo = getTableInfo()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            for row, bodyRow in ipairs(updatedTableInfo.body) do
                local isLocalPlayer = false
                local playerName = bodyRow[1].text
                for col, cell in ipairs(bodyRow) do

                    local title = 'Time: ' .. GetFormattedGameTime() .. '   Wave: ' .. math.floor(player.spawnTimer) .. '   Inc/min: ' .. getIncome(player) .. '   Kills: ' .. player.totalKills

                    local upkeep, _ = getUpkeepTypeAndPercent(player)

                    if upkeep then
                        local upkeepFrame = BlzGetFrameByName("ResourceBarUpkeepText", 0)
                        BlzFrameSetText(upkeepFrame, "alga")
                        local upkeepText
                        if upkeep == upkeepType.NO then
                            upkeepText = '  |cff00ff00No Upkeep|r'
                        elseif upkeep == upkeepType.LOW then
                            upkeepText = '  |cffffff00Low Upkeep(80)|r'
                        elseif upkeep == upkeepType.HIGH then
                            upkeepText = '  |cffff0000High Upkeep(60)|r'
                        end
                        title = title .. upkeepText

                    end

                    MultiboardSetTitleText(player.multiboard, title)

                    local item = MultiboardGetItem(player.multiboard, row, col - 1)
                    if isPlayerInTeam(playerName, team.players) then
                        isLocalPlayer = true
                    end

                    if (cell.text) then
                        MultiboardSetItemStyle(item, true, false)
                        if isLocalPlayer == true then
                            MultiboardSetItemValue(item, cell.text)
                        else
                            if cell.isSensitive == true then
                                MultiboardSetItemValue(item, "***")
                            else
                                MultiboardSetItemValue(item, cell.text)
                            end
                        end
                        MultiboardSetItemValueColor(item, cell.color.r, cell.color.g, cell.color.b, cell.color.t)
                        MultiboardSetItemWidth(item, updatedTableInfo.header[col].weight)
                    elseif (cell.icon) then
                        MultiboardSetItemStyle(item, false, true)
                        if isLocalPlayer == true then
                            MultiboardSetItemIcon(item, cell.icon)
                            MultiboardSetItemWidth(item, 0.01)
                        else
                            if cell.isSensitive == true then
                                MultiboardSetItemStyle(item, true, false)
                                MultiboardSetItemValue(item, "")
                                MultiboardSetItemWidth(item, 0.01)
                            else
                                MultiboardSetItemIcon(item, cell.icon)
                                MultiboardSetItemWidth(item, 0.01)
                            end
                        end
                    else
                        MultiboardSetItemStyle(item, true, false)
                        MultiboardSetItemValue(item, "")
                        MultiboardSetItemWidth(item, 0.01)
                    end
                    MultiboardReleaseItem(item)
                end
            end
        end
    end
end

function isPlayerInTeam(text, players)
    for _, player in ipairs(players) do
        if text == getClearName(player) then
            return true
        end
    end
    return false
end

function initPanelForAllPlayers()
    local tableInfo = getTableInfo()
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            player.multiboard = CreateMultiboardBJ( #tableInfo.header, #tableInfo.body + 1, "Board1" )
            local multiFrame = BlzGetFrameByName("Multiboard",0)
            player.multiFrame = multiFrame

            for i, header in ipairs(tableInfo.header) do
                local title = MultiboardGetItem(player.multiboard, 0, i - 1)
                if header.text ~= nil then
                    MultiboardSetItemStyle(title, true, false)
                    MultiboardSetItemValue(title, header.text)
                    MultiboardSetItemWidth(title, header.weight)

                else
                    MultiboardSetItemStyle(title, false, false)
                    MultiboardSetItemWidth(title, 0.0001)
                end
                MultiboardReleaseItem(title)
            end
        end
    end
    for _, team in ipairs(all_teams) do
        for _, player in ipairs(team.players) do
            if GetLocalPlayer() == player.id then
                BlzFrameSetVisible(player.multiFrame, true)
            end
        end
    end
end
Debug.endFile()


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
SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
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
SetPlayerStartLocation(Player(10), 10)
SetPlayerColor(Player(10), ConvertPlayerColor(10))
SetPlayerRacePreference(Player(10), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(10), true)
SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(11), 11)
SetPlayerColor(Player(11), ConvertPlayerColor(11))
SetPlayerRacePreference(Player(11), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(11), true)
SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(12), 12)
SetPlayerColor(Player(12), ConvertPlayerColor(12))
SetPlayerRacePreference(Player(12), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(12), true)
SetPlayerController(Player(12), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(13), 13)
SetPlayerColor(Player(13), ConvertPlayerColor(13))
SetPlayerRacePreference(Player(13), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(13), true)
SetPlayerController(Player(13), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(14), 14)
SetPlayerColor(Player(14), ConvertPlayerColor(14))
SetPlayerRacePreference(Player(14), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(14), true)
SetPlayerController(Player(14), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(15), 15)
SetPlayerColor(Player(15), ConvertPlayerColor(15))
SetPlayerRacePreference(Player(15), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(15), true)
SetPlayerController(Player(15), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(16), 16)
SetPlayerColor(Player(16), ConvertPlayerColor(16))
SetPlayerRacePreference(Player(16), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(16), true)
SetPlayerController(Player(16), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(17), 17)
SetPlayerColor(Player(17), ConvertPlayerColor(17))
SetPlayerRacePreference(Player(17), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(17), true)
SetPlayerController(Player(17), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(18), 18)
SetPlayerColor(Player(18), ConvertPlayerColor(18))
SetPlayerRacePreference(Player(18), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(18), true)
SetPlayerController(Player(18), MAP_CONTROL_COMPUTER)
SetPlayerStartLocation(Player(19), 19)
SetPlayerColor(Player(19), ConvertPlayerColor(19))
SetPlayerRacePreference(Player(19), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(19), true)
SetPlayerController(Player(19), MAP_CONTROL_COMPUTER)
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
SetPlayerTeam(Player(10), 2)
SetPlayerTeam(Player(11), 2)
SetPlayerTeam(Player(12), 2)
SetPlayerTeam(Player(13), 2)
SetPlayerTeam(Player(14), 2)
SetPlayerAllianceStateAllyBJ(Player(10), Player(11), true)
SetPlayerAllianceStateAllyBJ(Player(10), Player(12), true)
SetPlayerAllianceStateAllyBJ(Player(10), Player(13), true)
SetPlayerAllianceStateAllyBJ(Player(10), Player(14), true)
SetPlayerAllianceStateAllyBJ(Player(11), Player(10), true)
SetPlayerAllianceStateAllyBJ(Player(11), Player(12), true)
SetPlayerAllianceStateAllyBJ(Player(11), Player(13), true)
SetPlayerAllianceStateAllyBJ(Player(11), Player(14), true)
SetPlayerAllianceStateAllyBJ(Player(12), Player(10), true)
SetPlayerAllianceStateAllyBJ(Player(12), Player(11), true)
SetPlayerAllianceStateAllyBJ(Player(12), Player(13), true)
SetPlayerAllianceStateAllyBJ(Player(12), Player(14), true)
SetPlayerAllianceStateAllyBJ(Player(13), Player(10), true)
SetPlayerAllianceStateAllyBJ(Player(13), Player(11), true)
SetPlayerAllianceStateAllyBJ(Player(13), Player(12), true)
SetPlayerAllianceStateAllyBJ(Player(13), Player(14), true)
SetPlayerAllianceStateAllyBJ(Player(14), Player(10), true)
SetPlayerAllianceStateAllyBJ(Player(14), Player(11), true)
SetPlayerAllianceStateAllyBJ(Player(14), Player(12), true)
SetPlayerAllianceStateAllyBJ(Player(14), Player(13), true)
SetPlayerAllianceStateVisionBJ(Player(10), Player(11), true)
SetPlayerAllianceStateVisionBJ(Player(10), Player(12), true)
SetPlayerAllianceStateVisionBJ(Player(10), Player(13), true)
SetPlayerAllianceStateVisionBJ(Player(10), Player(14), true)
SetPlayerAllianceStateVisionBJ(Player(11), Player(10), true)
SetPlayerAllianceStateVisionBJ(Player(11), Player(12), true)
SetPlayerAllianceStateVisionBJ(Player(11), Player(13), true)
SetPlayerAllianceStateVisionBJ(Player(11), Player(14), true)
SetPlayerAllianceStateVisionBJ(Player(12), Player(10), true)
SetPlayerAllianceStateVisionBJ(Player(12), Player(11), true)
SetPlayerAllianceStateVisionBJ(Player(12), Player(13), true)
SetPlayerAllianceStateVisionBJ(Player(12), Player(14), true)
SetPlayerAllianceStateVisionBJ(Player(13), Player(10), true)
SetPlayerAllianceStateVisionBJ(Player(13), Player(11), true)
SetPlayerAllianceStateVisionBJ(Player(13), Player(12), true)
SetPlayerAllianceStateVisionBJ(Player(13), Player(14), true)
SetPlayerAllianceStateVisionBJ(Player(14), Player(10), true)
SetPlayerAllianceStateVisionBJ(Player(14), Player(11), true)
SetPlayerAllianceStateVisionBJ(Player(14), Player(12), true)
SetPlayerAllianceStateVisionBJ(Player(14), Player(13), true)
SetPlayerTeam(Player(15), 3)
SetPlayerTeam(Player(16), 3)
SetPlayerTeam(Player(17), 3)
SetPlayerTeam(Player(18), 3)
SetPlayerTeam(Player(19), 3)
SetPlayerAllianceStateAllyBJ(Player(15), Player(16), true)
SetPlayerAllianceStateAllyBJ(Player(15), Player(17), true)
SetPlayerAllianceStateAllyBJ(Player(15), Player(18), true)
SetPlayerAllianceStateAllyBJ(Player(15), Player(19), true)
SetPlayerAllianceStateAllyBJ(Player(16), Player(15), true)
SetPlayerAllianceStateAllyBJ(Player(16), Player(17), true)
SetPlayerAllianceStateAllyBJ(Player(16), Player(18), true)
SetPlayerAllianceStateAllyBJ(Player(16), Player(19), true)
SetPlayerAllianceStateAllyBJ(Player(17), Player(15), true)
SetPlayerAllianceStateAllyBJ(Player(17), Player(16), true)
SetPlayerAllianceStateAllyBJ(Player(17), Player(18), true)
SetPlayerAllianceStateAllyBJ(Player(17), Player(19), true)
SetPlayerAllianceStateAllyBJ(Player(18), Player(15), true)
SetPlayerAllianceStateAllyBJ(Player(18), Player(16), true)
SetPlayerAllianceStateAllyBJ(Player(18), Player(17), true)
SetPlayerAllianceStateAllyBJ(Player(18), Player(19), true)
SetPlayerAllianceStateAllyBJ(Player(19), Player(15), true)
SetPlayerAllianceStateAllyBJ(Player(19), Player(16), true)
SetPlayerAllianceStateAllyBJ(Player(19), Player(17), true)
SetPlayerAllianceStateAllyBJ(Player(19), Player(18), true)
SetPlayerAllianceStateVisionBJ(Player(15), Player(16), true)
SetPlayerAllianceStateVisionBJ(Player(15), Player(17), true)
SetPlayerAllianceStateVisionBJ(Player(15), Player(18), true)
SetPlayerAllianceStateVisionBJ(Player(15), Player(19), true)
SetPlayerAllianceStateVisionBJ(Player(16), Player(15), true)
SetPlayerAllianceStateVisionBJ(Player(16), Player(17), true)
SetPlayerAllianceStateVisionBJ(Player(16), Player(18), true)
SetPlayerAllianceStateVisionBJ(Player(16), Player(19), true)
SetPlayerAllianceStateVisionBJ(Player(17), Player(15), true)
SetPlayerAllianceStateVisionBJ(Player(17), Player(16), true)
SetPlayerAllianceStateVisionBJ(Player(17), Player(18), true)
SetPlayerAllianceStateVisionBJ(Player(17), Player(19), true)
SetPlayerAllianceStateVisionBJ(Player(18), Player(15), true)
SetPlayerAllianceStateVisionBJ(Player(18), Player(16), true)
SetPlayerAllianceStateVisionBJ(Player(18), Player(17), true)
SetPlayerAllianceStateVisionBJ(Player(18), Player(19), true)
SetPlayerAllianceStateVisionBJ(Player(19), Player(15), true)
SetPlayerAllianceStateVisionBJ(Player(19), Player(16), true)
SetPlayerAllianceStateVisionBJ(Player(19), Player(17), true)
SetPlayerAllianceStateVisionBJ(Player(19), Player(18), true)
end

function InitAllyPriorities()
SetStartLocPrioCount(0, 9)
SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 3, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(1, 9)
SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 3, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(2, 9)
SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 3, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(3, 9)
SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 3, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(4, 9)
SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 4, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(5, 9)
SetStartLocPrio(5, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 3, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 4, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 5, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(5, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(6, 9)
SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 3, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 4, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 5, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 6, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(6, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(7, 9)
SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 3, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 4, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 5, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 6, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 7, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(7, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(8, 9)
SetStartLocPrio(8, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 3, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 4, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 5, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 6, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 7, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(8, 8, 9, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(9, 9)
SetStartLocPrio(9, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 1, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 2, 2, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 3, 3, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 4, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 5, 5, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 6, 6, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 7, 7, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(9, 8, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(10, 3)
SetStartLocPrio(10, 0, 4, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(10, 1, 17, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(10, 2, 19, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(10, 1)
SetEnemyStartLocPrio(10, 0, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(11, 4)
SetStartLocPrio(11, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(11, 1, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(11, 2, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrio(11, 3, 19, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(11, 3)
SetEnemyStartLocPrio(11, 0, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(11, 1, 17, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(11, 2, 19, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(12, 3)
SetStartLocPrio(12, 0, 17, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 1, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrio(12, 2, 19, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(12, 3)
SetEnemyStartLocPrio(12, 0, 1, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(12, 1, 18, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(12, 2, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(13, 1)
SetStartLocPrio(13, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(13, 2)
SetEnemyStartLocPrio(13, 0, 4, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(13, 1, 18, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(14, 2)
SetStartLocPrio(14, 0, 8, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(14, 1, 9, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(14, 2)
SetEnemyStartLocPrio(14, 0, 4, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(14, 1, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(15, 1)
SetStartLocPrio(15, 0, 17, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(15, 3)
SetEnemyStartLocPrio(15, 0, 1, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 1, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(15, 2, 19, MAP_LOC_PRIO_LOW)
SetStartLocPrioCount(16, 1)
SetStartLocPrio(16, 0, 19, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(16, 3)
SetEnemyStartLocPrio(16, 0, 4, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrio(16, 1, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrio(16, 2, 19, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(17, 3)
SetStartLocPrio(17, 0, 4, MAP_LOC_PRIO_LOW)
SetStartLocPrio(17, 1, 18, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(17, 2, 19, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(17, 2)
SetEnemyStartLocPrio(17, 0, 18, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(18, 2)
SetStartLocPrio(18, 0, 0, MAP_LOC_PRIO_HIGH)
SetStartLocPrio(18, 1, 17, MAP_LOC_PRIO_HIGH)
SetEnemyStartLocPrioCount(18, 1)
SetStartLocPrioCount(19, 1)
SetStartLocPrio(19, 0, 18, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(19, 1)
SetEnemyStartLocPrio(19, 0, 18, MAP_LOC_PRIO_LOW)
end

function main()
SetCameraBounds(-16128.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 1024.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 2688.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 11264.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -16128.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 11264.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 2688.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 1024.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("LordaeronSummerDay")
SetAmbientNightSound("LordaeronSummerNight")
SetMapMusic("Music", true, 0)
CreateRegions()
InitBlizzard()
InitGlobals()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(20)
SetTeams(20)
SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
DefineStartLocation(0, -15872.0, 11008.0)
DefineStartLocation(1, -15872.0, 11008.0)
DefineStartLocation(2, -15872.0, 11008.0)
DefineStartLocation(3, -15872.0, 11008.0)
DefineStartLocation(4, -15872.0, 11008.0)
DefineStartLocation(5, -15872.0, 11008.0)
DefineStartLocation(6, -15872.0, 11008.0)
DefineStartLocation(7, -15872.0, 11008.0)
DefineStartLocation(8, -15872.0, 11008.0)
DefineStartLocation(9, -15872.0, 11008.0)
DefineStartLocation(10, -15808.0, 11008.0)
DefineStartLocation(11, -15872.0, 11008.0)
DefineStartLocation(12, -15872.0, 11008.0)
DefineStartLocation(13, -15872.0, 11008.0)
DefineStartLocation(14, -15872.0, 11008.0)
DefineStartLocation(15, -15872.0, 11008.0)
DefineStartLocation(16, -15872.0, 11008.0)
DefineStartLocation(17, -15872.0, 11008.0)
DefineStartLocation(18, -15872.0, 11008.0)
DefineStartLocation(19, -15872.0, 11008.0)
InitCustomPlayerSlots()
InitCustomTeams()
InitAllyPriorities()
end

