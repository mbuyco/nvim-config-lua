let g:php_cs_fixer_path="~/src/dev/tools/php-cs-fixer/vendor/bin/php-cs-fixer"

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
