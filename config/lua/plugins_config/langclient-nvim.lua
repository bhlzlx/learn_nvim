local config_path = "~/AppData/Local/nvim"

-- vim.cmd [[
--     let g:LanguageClient_serverCommands = {
--         'cpp' : ['c]
--     }
-- ]]

vim.g.LanguageClient_rootMarkers = {
    cpp = {
        "compile_commmands.json", "build"
    }
}

vim.g.LanguageClient_serverCommands = {
    cpp = {
        config_path..'/bin/cquery', -- cquery 程序
        '--log-file='..config_path..'/log/cquery.log', -- log文件
        '--init={\"cacheDirectory\":\"'..config_path..'/cache/cquery' -- 缓存位置
    }
}

print(vim.g.LanguageClient_serverCommands.cpp[1])