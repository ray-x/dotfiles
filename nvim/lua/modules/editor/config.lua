local config = {}

function config.delimimate()
  vim.g.delimitMate_expand_cr = 0
  vim.g.delimitMate_expand_space = 1
  vim.g.delimitMate_smart_quotes = 1
  vim.g.delimitMate_expand_inside_quotes = 0
  vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
end

function config.nvim_colorizer()
  require 'colorizer'.setup {
    '*';
    css = { rgb_fn = true; };
    scss = { rgb_fn = true; };
    sass = { rgb_fn = true; };
    stylus = { rgb_fn = true; };
    vim = { names = true; };
    tmux = { names = false; };
  }
end

function config.vim_cursorwod()
  vim.api.nvim_command('augroup user_plugin_cursorword')
  vim.api.nvim_command('autocmd!')
  vim.api.nvim_command('autocmd FileType defx,denite,fern,clap,vista let b:cursorword = 0')
  vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
  vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
  vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
  vim.api.nvim_command('augroup END')
end

function config.vim_smartchar()
  vim.api.nvim_command("autocmd FileType go inoremap <buffer><expr> ; smartchr#loop(':=',';')")
end


function  config.nerdcommenter()
    -- Add spaces after comment delimiters by default
  vim.g.NERDSpaceDelims = 1

  -- Use compact syntax for prettified multi-line comments
  vim.g.NERDCompactSexyComs = 1

  -- Align line-wise comment delimiters flush left instead of following code indentation
  vim.g.NERDDefaultAlign = 'left'

  -- Set a language to use its alternate delimiters by default
  -- vim.g.NERDAltDelims_java = 1

  -- Add your own custom formats or override the defaults
  -- vim.g.NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

  -- Allow commenting and inverting empty lines (useful when commenting a region)
  vim.g.NERDCommentEmptyLines = 1

  -- Enable trimming of trailing whitespace when uncommenting
  vim.g.NERDTrimTrailingWhitespace = 1

  -- Enable NERDCommenterToggle to check all selected lines is commented or not 
  vim.g.NERDToggleCheckAllLines = 1
end

function config.vmulti()
  vim.g.VM_mouse_mappings = 1
  -- mission control takes <C-up/down> so remap <M-up/down> to <C-Up/Down>
  vim.api.nvim_set_keymap("n", "<M-n>", "<C-n>",{silent =true})
  vim.api.nvim_set_keymap("n", "<M-Down>", "<C-Down>",{silent =true})
  vim.api.nvim_set_keymap("n", "<M-Up>", "<C-Up>",{silent =true})
  -- for mac C-L/R was mapped to mission control
  -- print('vmulti')
  -- vim.g.VM_maps = {}
  -- vim.g.VM_maps['Find Under']         = '<M-d>'
  -- vim.g.VM_maps['Find Subword Under'] = '<M-d>'
  -- vim.g.VM_maps["Select Cursor Down"] = '<M-Down>'
  -- vim.g.VM_maps["Select Cursor Up"]   = '<M-Up>'
end

return config
