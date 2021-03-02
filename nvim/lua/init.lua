local load = vim.g.min_load
if vim.g.min_load == 1 then 
  return ''
end

if vim.wo.diff then
  return ''
end

-- command! Dg :lua require'lspsaga.diagnostic'.show_buf_diagnostics()

require('lsp_config')

-- RELOAD = require('plenary.reload').reload_module

-- R = function(name)
--   RELOAD(name)
--   return require(name)
-- end

-- TODO: Experiment with lua tree sitter and make it the coolest ever.

-- require('expressline')
require('eviline')

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
    max_name_length = 14,
    max_prefix_length = 10,
    tab_size = 16,
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or ""  -- "" or "" 
      return "" .. icon .. count
    end,
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


-- require('internal.gitsigns')


-- 
vim.cmd [[nmap <S-F1> :NvimTreeToggle<CR>]]
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
