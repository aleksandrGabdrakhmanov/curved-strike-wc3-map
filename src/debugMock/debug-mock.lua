-- mock Debug.beginFile and Debug.endFile for release version
do
    Debug = {}
    function Debug.beginFile(fileName, depth, lastLine)
    end
    function Debug.endFile(depth)
    end
end