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
    rerollTrigger()
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
