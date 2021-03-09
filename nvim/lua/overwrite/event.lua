
local vim = vim

local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function autocmd.load_autocmds()
  local definitions = {
    bufs = {
      {"BufWritePost","*.sum, *.mod",":silent :GoModTidy"};
      {"TextYankPost", "*", ":silent! :lua vim.highlight.on_yank {higroup='IncSearch', timeout=1500, on_visual=false}"};
      {"FileType","css,scss","let b:prettier_exec_cmd = 'prettier-stylelint'"};
      {"FileType","lua","nmap <leader><leader>t <Plug>PlenaryTestFile"};
      {"FileType", "markdown", "let b:prettier_exec_cmd = 'prettier' | let g:prettier#exec_cmd_path = '/usr/local/bin/prettier' | let g:spelunker_check_type = 1"};
      {"BufReadPre", "*", 'if getfsize(expand("%")) > 1000000 | syntax off | endif'};
      {"BufWritePost",  "plugins.lua", "PackerCompile"};
    };
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
return autocmd
