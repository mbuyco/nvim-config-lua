vim.g.php_cs_fixer_path = '~/src/dev/tools/php-cs-fixer/vendor/bin/php-cs-fixer'
vim.g.php_cs_fixer_config_file = vim.fn['getcwd']() .. '/phpcs.xml'



-- vim.cmd [[
--   autocmd BufWritePre *.php :call PhpCsFixerFixFile()
-- ]]
