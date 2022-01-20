vim.g.LanguageClient_serverCommands = {
    cpp = {
        'cquery', -- cquery 程序
        '--log-file=.cquery/log/cquery.log', -- log文件
        '--init={\"cacheDirectory\":\".cquery/cache\"}' -- 缓存位置
    }
}

vim.g.LanguageClient_rootMarkers = {
    cpp = { 'build', 'compile_commands.json' }
}


vim.g.LanguageClient_echoProjectRoot = 1
-- print(vim.g.LanguageClient_serverCommands.cpp[1])