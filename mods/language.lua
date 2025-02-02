LanguageTable_Simplified_Chinese = {
    应急食品 = "应急食品",
    loc = "zh-CN",
    home = {
        跳过 = "Meal time | 跳过",
    },
    relicscore_player = {
        角色评分 = "角色评分",
        获取失败 = "获取失败",
        等级 = "等级",
        世界等级 = "世界等级",
    },
}
LanguageTable_traditional_Chinese = {
    应急食品 = "應急食品",
    loc = "zh-TW",
}
LanguageTable_English = {
    应急食品 = "MGenshinTool",
    loc = "en",
}

function setLanguage(lan)
    if lan == "Simplified_Chinese" then
        --print("中文")
        LanguageTable = LanguageTable_Simplified_Chinese
    elseif lan == "traditional_Chinese" then
        --print("繁体中文")
        LanguageTable = LanguageTable_traditional_Chinese
    elseif lan == "English" then
        --print("英文")
        LanguageTable = LanguageTable_English
    else
        --print("-中文")
        LanguageTable = LanguageTable_Simplified_Chinese
    end
end

function getLanguage(name, root)
    if ACTIVITY == nil then
        return "未设置ACTIVITY"
    end
    if root ~= nil then
        if LanguageTable[name] then
            return LanguageTable[name]
        else
            return LanguageTable_Simplified_Chinese[name]
        end
    else
        if LanguageTable[ACTIVITY] then
            if LanguageTable[ACTIVITY][name] then
                return LanguageTable[ACTIVITY][name]
            else
                return LanguageTable_Simplified_Chinese[ACTIVITY][name]
            end
        else
            return LanguageTable_Simplified_Chinese[ACTIVITY][name]
        end
    end
end
