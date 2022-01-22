vim.g.LanguageClient_serverCommands = {
    cpp = {
        'cquery', -- cquery 程序
        '--log-file=.cquery/log/cquery.log', -- log文件
        '--init={\"cacheDirectory\":\".cquery/cache\"}' -- 缓存位置
    }
}

vim.completefunc = 'LanguageClient#complete'
-- vim.g.LanguageClient_rootMarkers = {
--     cpp = { 'build', 'compile_commands.json' }
-- }