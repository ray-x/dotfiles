local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('modules.lang.treesitter')
end

function config.ale()
  vim.g.ale_sign_error = 'ﴫ'
  vim.g.ale_sign_warning = ''
  vim.g.ale_go_gopls_executable = 'gopls'
  vim.g.ale_go_revive_executable = 'revive'
  vim.g.ale_go_gopls_options = "-remote=auto"
  vim.g.ale_go_golangci_lint_options = '--enable-all --disable dogsled --disable gocognit --disable godot --disable godox --disable lll --disable nestif --disable wsl --disable gocyclo --disable asciicheck --disable gochecknoglobals'
  vim.g.ale_lint_delay = 1000                -- " begin lint after 1s
  vim.g.ale_lint_on_save = 1
   --" vim.g.ale_lint_on_text_changed = 'never'   --" do not lint when I am typing  'normal (def)'   'never' 
  vim.g.ale_sign_column_always = 1
  vim.g.ale_go_golangci_lint_package = 1

  --" 'go vet' not working
  vim.g.ale_linters = {
     javascript = {'eslint', 'flow-language-server'},
     --javascript['jsx']  = {'eslint', 'flow-language-server'},
     go = {'govet', 'golangci-lint', 'revive'},
     markdown = {'mdl', 'languagetool'},
     sql = {'sqlint'},
     python = {'flake8', 'pylint'}
  }

  vim.g.ale_fixers = {
     go = {'goimports'},
     javascript = {'prettier', 'eslint'},
     --javascript['jsx'] = {'prettier', 'eslint'},
     typescript = {'eslint', 'tslint'},
     markdown = {'prettier'},
     json = {'prettier'},
     sql = {'pgformatter'},
     css = {'prettier'},
     php = {'php-cs-fixer'},
     ale_fixers = {'prettier', 'remark'},
     lua = {'luafmt'},
     python = {'autopep8', 'yapf'},
  }
end

function config.sqls()

end

function config.go()
  vim.g.go_fmt_command = "golines"
  vim.g.go_fmt_options = { golines ='-m 128 --base-formatter=gofumports', }
  vim.g.go_autodetect_gopath = 1
  vim.g.go_list_type = "quickfix"
  vim.g.go_fmt_autosave = 0
  vim.g.go_fmt_fail_silently = 1
  
  vim.g.go_list_type = "quickfix"
  vim.g.go_addtags_transform = "camelcase"
  vim.g.go_metalinter_deadline = "5s"
  
  vim.g.go_highlight_structs = 0
  vim.g.go_highlight_methods = 0
  vim.g.go_highlight_operators = 0
  vim.g.go_highlight_build_constraints = 0
  
  vim.g.go_highlight_types = 0
  vim.g.go_highlight_fields = 0
  vim.g.go_highlight_functions = 0
  vim.g.go_highlight_function_calls = 0
  vim.g.go_highlight_function_parameters  = 0
  vim.g.go_highlight_extra_types = 0
  vim.g.go_highlight_format_strings = 0
  vim.g.go_highlight_variable_declarations = 0
  vim.g.go_highlight_variable_assignments = 0
  vim.g.go_highlight_generate_tags = 0
  
  
  vim.g.go_code_completion_enabled = 0 -- use neovim-lsp
  vim.g.go_gopls_enabled = 0 -- use neovim-lsp
  vim.g.go_gopls_options = {'-remote=auto'}  --  still not working with nvim-lsp
  -- vim.g.go_info_mode = "guru"  --  use -- --  to disalbe coc or use gopls/guru
  vim.g.go_auto_type_info = 0  -- causing delay because it is sync
  vim.g.go_doc_keywordprg_enabled = 0  -- godoc use <slient> K conflict with coc, also it is slow....
  vim.g.go_textobj_enable = 0  -- use coc for textobj  if, af, ic, ac
  vim.g.go_echo_go_info = 1 -- guru is too slow, pls too much memory if multiple proj opens
  vim.g.go_def_mapping_enabled = 0 -- disable default key mapping because we disabled gopls gd/gr/gf wont work
  
   
    -- vim.g.go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
  vim.g.go_fold_enable = {}
  
  vim.cmd('nnoremap <leader>gi :GoImport <C-R><C-W><cr>')
  vim.cmd('inoremap <leader>gi <Esc>:GoImport <C-R><C-W><cr>A.')
  
  
  vim.cmd('augroup go')
    vim.cmd('autocmd!')
    vim.cmd('autocmd FileType go nmap <leader>gb  <Plug>(go-build)')
    vim.cmd('autocmd FileType go nmap <leader>r  <Plug>(go-run)')
    --  Show by default 4 spaces for a tab')
    vim.cmd('autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4')
    --  :GoBuild and :GoTestCompile')
    --vim.cmd('autocmd FileType go nmap <leader><leader>gb :<C-u>call <SID>build_go_files()<CR>')
    --  :GoTest')
    vim.cmd('autocmd FileType go nmap <leader>gt  <Plug>(go-test)')
    --  :GoRun
    vim.cmd('autocmd FileType go nmap <leader>r  <Plug>(go-run)')
  
    vim.cmd('autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)')
  
    vim.cmd('autocmd FileType go nmap <Leader><Leader>l <Plug>(go-metalinter)')
    vim.cmd('au FileType go nmap <Leader>ge <Plug>(go-rename)')
  
    vim.cmd("autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')")
    vim.cmd("autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')")
    vim.cmd("autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')")
    vim.cmd("autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')")
    vim.cmd('autocmd FileType go nmap <leader><F7>  :GoDebugTestFunc <CR>')
    vim.cmd('autocmd FileType go nmap <F7>  :GoDebugRestart <CR>')
    vim.cmd('autocmd FileType go nmap <F8>  :GoDebugStepOut <CR>')
    vim.cmd('au FileType go command! GoT :GoBuildTags integration | GoTest')
    vim.cmd('au FileType go command! Gtn :TestNearest -v -tags=integration')
    vim.cmd('au FileType go command! Gts :TestSuite -v -tags=integration')
  
  vim.cmd('augroup END')

-- function! s:build_go_files()
--   let l:file = expand('%')
--   if l:file =~# '^\f\+_test\.go$'
--     call go#test#Test(0, 1)
--   elseif l:file =~# '^\f\+\.go$'
--     call go#cmd#Build(0)
--   endif
-- endfunction


end




return config
