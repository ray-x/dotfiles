local vim,api = vim,vim.api
local M = {}

-- 1 thin
-- 2 radio
-- 3 crude
local border_style = {
  {top_left = "┌",top_mid = "─",top_right = "┐",mid = "│",bottom_left = "└",bottom_right= "┘" };
  {top_left = "╭",top_mid = "─",top_right = "╮",mid = "│",bottom_left = "╰",bottom_right= "╯" };
  {top_left = "┏",top_mid = "━",top_right = "┓",mid = "┃",bottom_left = "┗",bottom_right = "┛"};
}

function M.get_max_contents_width(contents)
  local max_length = 0
  for i=1,#contents-1,1 do
    if #contents[i] > #contents[i+1] then
      max_length = #contents[i]
    end
  end
  return max_length
end

function M.make_floating_popup_options(width, height, opts)
  vim.validate {
    opts = { opts, 't', true };
  }
  opts = opts or {}
  vim.validate {
    ["opts.offset_x"] = { opts.offset_x, 'n', true };
    ["opts.offset_y"] = { opts.offset_y, 'n', true };
  }
  local new_option = {}

  new_option.style = 'minimal'
  new_option.width = width
  new_option.height = height

  if opts.relative ~= nil then
    new_option.relative = opts.relative
  else
    new_option.relative = 'cursor'
  end

  if opts.anchor ~= nil then
    new_option.anchor = opts.anchor
  end

  if opts.row == nil and opts.col == nil then

    local lines_above = vim.fn.winline() - 1
    local lines_below = vim.fn.winheight(0) - lines_above
    new_option.anchor = ''

    if lines_above < lines_below then
      new_option.anchor = new_option.anchor..'N'
      height = math.min(lines_below, height)
      new_option.row = 1
    else
      new_option.anchor = new_option.anchor..'S'
      height = math.min(lines_above, height)
      new_option.row = 0
    end

    if vim.fn.wincol() + width <= api.nvim_get_option('columns') then
      new_option.anchor = new_option.anchor..'W'
      new_option.col = 0
    else
      new_option.anchor = new_option.anchor..'E'
      new_option.col = 1
    end
  else
    new_option.row = opts.row
    new_option.col = opts.col
  end

  return new_option
end

local function make_border_option(contents,opts)
  opts = opts or {}
  local win_width,win_height = vim.lsp.util._make_floating_popup_size(contents,opts)
  local border_option = M.make_floating_popup_options(win_width+2, win_height+2, opts)
  return win_width+2,win_height,border_option
end


local function create_float_boder(contents,border,opts)
  local win_width,win_height,border_option = make_border_option(contents,opts)

  local top_left = border_style[border].top_left
  local top_mid  = border_style[border].top_mid
  local top_right = border_style[border].top_right
  local mid_line = border_style[border].mid
  local bottom_left= border_style[border].bottom_left
  local bottom_right = border_style[border].bottom_right
  -- set border
  local top = top_left .. vim.fn["repeat"](top_mid, win_width-2) ..top_right
  local mid = mid_line .. vim.fn["repeat"](" ", win_width-2) .. mid_line
  local bot = bottom_left .. vim.fn["repeat"](top_mid, win_width-2) .. bottom_right
  local lines = {top}
  for _,v in pairs(vim.fn["repeat"]({mid},win_height)) do
    table.insert(lines,v)
  end
  table.insert(lines,bot)
  local border_bufnr = vim.api.nvim_create_buf(false, true)
  -- buffer settings for border buffer
  api.nvim_buf_set_lines(border_bufnr, 0, -1, true, lines)
  api.nvim_buf_set_option(border_bufnr, 'buftype', 'nofile')
  api.nvim_buf_set_option(border_bufnr, 'filetype', 'lspwinborder')
  api.nvim_buf_set_option(border_bufnr, 'modifiable', false)

  -- create border
  local border_winid = api.nvim_open_win(border_bufnr, false, border_option)
  api.nvim_win_set_option(border_winid,"winhl","Normal:LspFloatWinBorder")
  api.nvim_win_set_option(border_winid,"cursorcolumn",false)
  return border_bufnr,border_winid
end

local function create_float_contents(contents, filetype,enter,modifiable,opts)
  -- create contents buffer
  local contents_bufnr = api.nvim_create_buf(false, true)
  -- buffer settings for contents buffer
  -- Clean up input: trim empty lines from the end, pad
  local content = vim.lsp.util._trim_and_pad(contents,{pad_left=0,pad_right=0})

  if filetype then
    api.nvim_buf_set_option(contents_bufnr, 'filetype', filetype)
  end

  api.nvim_buf_set_lines(contents_bufnr,0,-1,true,content)
  api.nvim_buf_set_option(contents_bufnr, 'modifiable', modifiable)
  local contents_winid = api.nvim_open_win(contents_bufnr, enter, opts)
  if filetype == 'markdown' then
    api.nvim_win_set_option(contents_winid, 'conceallevel', 2)
  end
  api.nvim_win_set_option(contents_winid,"winhl","Normal:LspFloatNormal")
  return contents_bufnr, contents_winid
end

function M.create_float_window(contents,filetype,border,enter,modifiable,opts)
  local _,_,border_option = make_border_option(contents,opts)
  local contents_option= border_option
  contents_option.width = border_option.width - 2
  contents_option.height = border_option.height - 2
  if border_option.row ~= 0 then
    contents_option.row = border_option.row + 1
  else
    contents_option.row = border_option.row - 1
  end
  contents_option.col = border_option.col + 1

  if enter then
    local border_bufnr,border_winid = create_float_boder(contents,border,opts)
    local contents_bufnr,contents_winid = create_float_contents(contents,filetype,enter,modifiable,border_option)
    return contents_bufnr,contents_winid,border_bufnr,border_winid
  else
    local contents_bufnr,contents_winid = create_float_contents(contents,filetype,enter,modifiable,contents_option)
    local border_bufnr,border_winid = create_float_boder(contents,border,opts)
    return contents_bufnr,contents_winid,border_bufnr,border_winid
  end
end

-- use our float window instead of.
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/util.lua#L755
function M.fancy_floating_markdown(contents, opts)
  vim.validate {
    contents = { contents, 't' };
    opts = { opts, 't', true };
  }
  opts = opts or {}

  local stripped = {}
  local highlights = {}
  do
    local i = 1
    while i <= #contents do
      local line = contents[i]
      -- TODO(ashkan): use a more strict regex for filetype?
      local ft = line:match("^```([a-zA-Z0-9_]*)$")
      -- local ft = line:match("^```(.*)$")
      -- TODO(ashkan): validate the filetype here.
      if ft then
        local start = #stripped
        i = i + 1
        while i <= #contents do
          line = contents[i]
          if line == "```" then
            i = i + 1
            break
          end
          table.insert(stripped, line)
          i = i + 1
        end
        table.insert(highlights, {
          ft = ft;
          start = start + 1;
          finish = #stripped + 1 - 1;
        })
      else
        table.insert(stripped, line)
        i = i + 1
      end
    end
  end
  -- Clean up and add padding
  stripped = vim.lsp.util._trim_and_pad(stripped, opts)

  -- Compute size of float needed to show (wrapped) lines
  opts.wrap_at = opts.wrap_at or (vim.wo["wrap"] and api.nvim_win_get_width(0))
  local width, height = vim.lsp.util._make_floating_popup_size(stripped, opts)

  -- Insert blank line separator after code block
  local insert_separator = opts.separator or true
  if insert_separator then
    for i, h in ipairs(highlights) do
      h.start = h.start + i - 1
      h.finish = h.finish + i - 1
      if h.finish + 1 <= #stripped then
        table.insert(stripped, h.finish + 1, string.rep("─", width))
        height = height + 1
      end
    end
  end

  -- Make the floating window.
  local contents_bufnr,contents_winid,border_bufnr,border_winid = M.create_float_window(stripped,'',1,false,false,opts)

  -- Switch to the floating window to apply the syntax highlighting.
  -- This is because the syntax command doesn't accept a target.
  local cwin = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(contents_winid)

  vim.cmd("ownsyntax markdown")
  local idx = 1
  --@private
  local function apply_syntax_to_region(ft, start, finish)
    if ft == '' then return end
    local name = ft..idx
    idx = idx + 1
    local lang = "@"..ft:upper()
    -- TODO(ashkan): better validation before this.
    if not pcall(vim.cmd, string.format("syntax include %s syntax/%s.vim", lang, ft)) then
      return
    end
    vim.cmd(string.format("syntax region %s start=+\\%%%dl+ end=+\\%%%dl+ contains=%s", name, start, finish + 1, lang))
  end
  -- Previous highlight region.
  -- TODO(ashkan): this wasn't working for some reason, but I would like to
  -- make sure that regions between code blocks are definitely markdown.
  -- local ph = {start = 0; finish = 1;}
  for _, h in ipairs(highlights) do
    -- apply_syntax_to_region('markdown', ph.finish, h.start)
    apply_syntax_to_region(h.ft, h.start, h.finish)
    -- ph = h
  end

  vim.api.nvim_set_current_win(cwin)
  return contents_bufnr, contents_winid,border_bufnr,border_winid
end

return M
