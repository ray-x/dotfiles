local vim = vim
local options = setmetatable({}, { __index = { global_local = {},window_local = {} } })
function options:load_options()
  self.global_local = {}
  self.window_local = {}
  if vim.wo.diff then
    self.global_local = {
      foldmethod=diff;
      diffopt="context:0";
      foldlevel=0;
      mouse="a";
    }
    self.window_local   = {
      foldmethod     = "expr";  -- indent?
      cursorline = true;
      -- noreadonly = false;
      -- signcolumn     = "yes";   -- auto
    }
  else
    self.global_local = {
      ttyfast        = true;  -- Indicate fast terminal conn for faster redraw
      errorbells     = false;             -- No beeps
      hidden         = true;             -- Buffer should still exist if window is closed
      fileencoding   = "utf-8";  --fenc
      mouse          = "a";

      textwidth      = 120;   -- wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
      expandtab      = true;  -- " expand tabs to spaces
      updatetime     = 500;   -- Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime
      ignorecase     = true;  -- Search case insensitive...
      smartcase      = true;  -- ... but not it begins with upper case
      incsearch      = true;  -- Shows the match while typing
      hlsearch       = true;  -- Highlight found searches
      grepformat     =  "%f:%l:%m,%m\\ %f\\ match%ts,%f"; --"%f:%l:%c:%m"; 
      grepprg        = 'rg --hidden --vimgrep --smart-case --';

      splitbelow     = true;  -- Horizontal windows should split to bottom
      splitright     = true;  --Vertical windows should be split to right
      backspace      = "indent,eol,start"; --Makes backspace key more powerful.
      diffopt        = "filler,iwhite,internal,algorithm:patience";
      completeopt    = "menuone,noselect,noinsert";  -- Show popup menu, even if there is one entry  menuone?
      pumheight      = 15;  -- Completion window max size
      laststatus     = 2;     -- Show status line always
      listchars      = "tab:┊ ,nbsp:+,trail:·,extends:→,precedes:←";  -- tab:»·, 
      autowrite      = true;  -- Automatically save before :next, :make etc.
      autoread       = true;  -- Automatically read changed files
      breakindent    = true;  -- Make it so that long lines wrap smartly
      smartindent    = true;  -- use intelligent indentation
      showmatch      = true;  -- highlight matching braces
    }

    self.window_local   = {
      foldmethod     = "expr";  -- indent?
      -- signcolumn     = "yes";   -- auto
    }
  end 
  for name, value in pairs(self.global_local) do
    vim.o[name] = value
  end
  for name, value in pairs(self.window_local) do
    vim.wo[name] = value
  end
end

options:load_options()
return options
