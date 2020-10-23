-- local api = vim.api
-- local fn = vim.fn
-- local luv = vim.loop


-- Load lsp config

-- local load = vim.g.full_load
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

-- 
vim.cmd [[nmap <S-F1> :LuaTreeToggle<CR>]]
vim.cmd [[autocmd Filetype LuaTree set cursorline]]
-- 
-- 
vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
-- 
-- 
vim.cmd [[autocmd VimEnter * nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[autocmd VimEnter * nnoremap <buffer> <silent> g<LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.implementation()<CR>]]

require'colorizer'.setup()

