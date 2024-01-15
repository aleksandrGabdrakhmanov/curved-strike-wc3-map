Debug.beginFile('page-general.lua')
function createPageGeneral(parentFrame, allPages)
    local buttonGeneral, pageGeneral = configPage("General", parentFrame, allPages)
    return buttonGeneral, pageGeneral
end
Debug.endFile()