local config = {}

function config.nvim_lsp()
  require('lsp.config')
end

function config.nvim_compe()
  vim.cmd('inoremap <silent><expr> <C-Space> compe#complete()')
  vim.cmd("inoremap <silent><expr> <CR>      compe#confirm({ 'keys': '<Plug>delimitMateCR', 'mode': '' })")
  vim.cmd("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")
  vim.cmd("inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })")
  vim.cmd("inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })")
  vim.cmd([[imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>']])
  vim.cmd([[smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>']])
  vim.cmd([[imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
  vim.cmd([[smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
  vim.cmd([[imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']])
  vim.cmd([[smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']])
  vim.cmd([[imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']])
  vim.cmd([[smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']])
  -- vim.cmd([[nmap        s   <Plug>(vsnip-select-text)]])
  -- vim.cmd([[xmap        s   <Plug>(vsnip-select-text)]])
  -- vim.cmd([[nmap        S   <Plug>(vsnip-cut-text)]])
  -- vim.cmd([[xmap        S   <Plug>(vsnip-cut-text)]])
  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = true;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 30;
    max_kind_width = 4;
    max_menu_width = 4;
    documentation = true;
    source = {
      path = {
        menu = "率";
      };
      buffer = {
        menu = "﬘";
      };
      calc = {
        menu = "";
      };
      vsnip =  {
        menu = "";
      };
      nvim_lsp = {
        -- menu = "";
        menu = "";
      };
      nvim_lua = true;
      tabnine = false;
      -- tabnine = {
      --   max_line = 100;
      --   max_num_results = 10;
      --   priority = 20;
      --   menu = "";
      -- };
      spell = {menu = "暈"};
      tags = {menu = ""};
      snippets_nvim = false;
      treesitter = {menu = ""};
    };
  }

end
  -- ?
  -- function! s:check_back_space() abort
  --     let col = col('.') - 1
  --     return !col || getline('.')[col - 1]  =~ '\s'
  -- endfunction

  -- inoremap <silent><expr> <TAB>
  --   \ pumvisible() ? "\<C-n>" :
  --   \ <SID>check_back_space() ? "\<TAB>" :
  --   \ completion#trigger_completion()

  --   }

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snips'
end

function config.telescope()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
    vim.cmd [[packadd popup.nvim]]
    vim.cmd [[packadd telescope-fzy-native.nvim]]
  end
  require('telescope').setup {
    defaults = {
      prompt_prefix = '🍔 ',
      prompt_position = 'top',
      sorting_strategy = 'ascending',
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
  }
  require('telescope').load_extension('fzy_native')
  require'telescope'.load_extension('dotfiles')
  require'telescope'.load_extension('gosource')
end

function config.emmet()
  vim.g.user_emmet_complete_tag = 0
  vim.g.user_emmet_install_global = 0
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = 'i'
end

return config
