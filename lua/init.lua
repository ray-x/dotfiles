local load = vim.g.min_load
if vim.g.min_load == 1 then 
  return ''
end

if vim.wo.diff then
  return ''
end

RELOAD = require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

-- require('lsp_config')

-- TODO: Experiment with lua tree sitter and make it the coolest ever.

require('expressline')
-- require('spaceline')

-- local ok, _ = pcall(function() require('completion').on_attach() end)

require'bufferline'.setup{
  options = {
    view = "multiwindow",
    numbers ="none",  --"none" | "ordinal" | "buffer_id",
    number_style = "superscript" ,
    mappings = true ,
    buffer_close_icon= '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    tab_size = 18,
    show_buffer_close_icons = false,
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    -- 'extension' | 'directory' | 
    sort_by = 'directory'
  }
}

--- telescope


-- require('telescope').setup {
--   defaults = {
--     winblend = 0,
--     layout_strategy = "flex",
--     preview_cutoff = 120,
--     layout_options = {
--       preview_width = 0.75,
--     },

--     sorting_strategy = "descending",
--     prompt_position = "bottom",

--     -- sorting_strategy = "ascending",
--     -- prompt_position = "top",

--     -- border = false,
--     -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

--     -- for the top/right/bottom/left border.  Optionally
--     -- followed by the character to use for the
--     -- topleft/topright/botright/botleft corner.
--     -- border = {},
--     --   true,

--     --   prompt = true,
--     -- },

--     borderchars = {
--       { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

--       preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
--     },

--     -- borderchars = { 'b', 'e', 'g', 'i', 'n', 'b', 'o', 't'}
--   }

-- }

-- 
vim.cmd [[nmap <S-F1> :LuaTreeToggle<CR>]]
vim.cmd [[autocmd Filetype LuaTree set cursorline]]
-- 
-- 
--
-- 
-- vim.cmd [[nnoremap <leader>gr <cmd>lua require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>]]
-- vim.cmd [[autocmd VimEnter * nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>]]
-- vim.cmd [[autocmd VimEnter * nnoremap <buffer> <silent> g<LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.implementation()<CR>]]

require'colorizer'.setup()

require'domain.core'
