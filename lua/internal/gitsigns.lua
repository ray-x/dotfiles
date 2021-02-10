local function load_gitsigns()
  require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitGutterAdd'   , text = '│', numhl='GitSignsAddNr'},
      change       = {hl = 'GitGutterChange', text = '│', numhl='GitSignsChangeNr'},
      delete       = {hl = 'GitGutterDelete', text = 'ﬠ', numhl='GitSignsDeleteNr'},
      topdelete    = {hl = 'GitGutterDelete', text = 'ﬢ', numhl='GitSignsDeleteNr'},
      changedelete = {hl = 'GitGutterChangeDelete', text = '┊', numhl='GitSignsChangeNr'},
    },
    numhl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
      ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

      ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

      -- Text objects
      ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
    watch_index = {
      interval = 1000
    },
    sign_priority = 6,
    status_formatter = nil, -- Use default
  }
end

load_gitsigns()