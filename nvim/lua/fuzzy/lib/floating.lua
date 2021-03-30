local api = vim.api
local location = require'fuzzy.lib.location'

-- Create a floating buffer with given win_width and win_height in given row and col.
local function floating_buffer(win_width, win_height, loc, readonly, ft, x, y)
  readonly = readonly or false
  ft = ft or 'javascript'
  x = x or 10
  y = y or 10
  local row, col = loc(win_height, win_width, x, y)
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }
  local buf = api.nvim_create_buf(true, true)
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  print("ft:"..ft)
  if readonly then
    api.nvim_buf_set_option(buf, 'readonly', true)
    api.nvim_buf_set_option(buf, 'filetype', ft)
  else
    api.nvim_buf_set_option(buf, 'buftype', 'prompt')
  end

  -- local border_opts = {
  --   style = "minimal",
  --   relative = "editor",
  --   width = win_width + 2,
  --   height = win_height + 2,
  --   row = row - 1,
  --   col = col - 1
  -- }
  -- local border_buf = api.nvim_create_buf(false, true)

  -- local top_line ='╭' .. string.rep('─', win_width) .. '╮'
  -- local middle_line = '│' .. string.rep(' ', win_width) .. '│'
  -- local bottom_line =  '╰' .. string.rep('─', win_width) .. '╯'

  -- local border_lines = {top_line}

  -- for i=1, win_height do
  --   table.insert(border_lines, middle_line)
  -- end

  -- table.insert(border_lines, bottom_line)
  -- for i=0,win_height-1 do
  --   api.nvim_buf_add_highlight(border_buf, 0, 'PopupWindowBorder', i, 0, -1)
  -- end

  -- api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)
  -- local border_win = api.nvim_open_win(border_buf, true, border_opts)
  -- api.nvim_win_set_option(border_win, 'wrap', false)
  -- api.nvim_win_set_option(border_win, 'number', false)
  -- api.nvim_win_set_option(border_win, 'relativenumber', false)
  -- api.nvim_win_set_option(border_win, 'cursorline', false)
  -- api.nvim_win_set_option(border_win, 'signcolumn', 'no')
  local win = api.nvim_open_win(buf, true, opts)
  return buf, win, function()
    -- vim.api.nvim_win_close(border_win, true)
    vim.api.nvim_win_close(win, true)
  end
end
return {
  floating_buffer = floating_buffer
}
