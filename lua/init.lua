-- local api = vim.api
-- local fn = vim.fn
-- local luv = vim.loop


-- Load lsp config

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

-- TODO: Experiment with lua tree sitter and make it the coolest ever.



require('expressline')
-- require('spaceline')

-- Run the first time to install it

local ok, _ = pcall(function() require('completion').on_attach() end)

require'bufferline'.setup{  options = {
   view = "multiwindow",
   numbers = "buffer_id",
   number_style = "superscript",
   mappings = true,
   close_icon = "x",
   max_name_length = 18,
   tab_size = 16,
   show_buffer_close_icons = false,
   separator_style = "thin",
   enforce_regular_tabs = false,
   always_show_bufferline = false,
 }
}


--- telescope
require('telescope').setup {
  defaults = {
    shorten_path = false -- currently the default value is true
  }
}





-- 
vim.cmd [[nmap <S-F1> :LuaTreeToggle<CR>]]
vim.cmd [[autocmd Filetype LuaTree set cursorline]]
-- 
-- 
vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
-- 
-- vim.cmd [[nnoremap <leader>gr <cmd>lua require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>]]
-- vim.cmd [[autocmd VimEnter * nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>]]
-- vim.cmd [[autocmd VimEnter * nnoremap <buffer> <silent> g<LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.implementation()<CR>]]

require'colorizer'.setup()

require'core'
