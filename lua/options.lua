local global = require 'global'
local vim = vim
local options = {}

function options:new()
  local instance = {}
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function options:load_options()
  self.ttyfast        = true;  -- Indicate fast terminal conn for faster redraw
  self.mouse          = "a";
  self.report         = 0;
  self.errorbells     = false;             -- No beeps
  self.visualbell     = false;
  self.hidden         = true;             -- Buffer should still exist if window is closed
  self.fileformats    = "unix,mac,dos";
  self.magic          = true;
  self.virtualedit    = "block";
  self.synmaxcol      = 2500;
  self.formatoptions  = "1jcroql";
  self.encoding       = "utf-8";
  self.fileencoding   = "utf-8";  --fenc
  self.viewoptions    = "folds,cursor,curdir,slash,unix";
  self.sessionoptions = "curdir,help,tabpages,winsize";
  self.clipboard      = "unnamed,unnamedplus";
  self.wildignorecase = true;

  self.wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.so,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,_site,*/__pycache__/,*/venv/*,*/target/*,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.ist,*/.fdb_latex";
  self.backup         = false;
  self.writebackup    = false;
  self.undofile       = true;
  self.swapfile       = false;
  self.directory      = global.cache_dir .. "swag/";
  self.undodir        = global.cache_dir .. "undo/";
  self.backupdir      = global.cache_dir .. "backup/";
  self.viewdir        = global.cache_dir .. "view/";
  self.spellfile      = global.cache_dir .. "spell/en.uft-8.add";
  self.history        = 2000;
  self.shada          = "!,'300,<50,@100,s10,h";
  self.backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";

  self.textwidth      = 120;   -- wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
  self.expandtab      = true;  -- " expand tabs to spaces
  -- self.tabstop        = 2;
  -- self.shiftwidth     = 2;
  -- self.softtabstop    = -1;
  self.smarttab       = true;
  self.autoindent     = true;
  self.shiftround     = true;
  self.breakindentopt = "shift:2,min:20";

  self.timeout        = true;
  self.ttimeout       = true;
  self.timeoutlen     = 500;
  self.ttimeoutlen    = 10;
  self.updatetime     = 400;   -- Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime
  self.redrawtime     = 1500;

  self.ignorecase     = true;  -- Search case insensitive...
  self.smartcase      = true;  -- ... but not it begins with upper case
  self.infercase      = true;
  self.incsearch      = true;  -- Shows the match while typing
  self.hlsearch       = true;  -- Highlight found searches
  self.wrapscan       = true;

  self.complete       = ".,w,b,k";
  self.inccommand     = "nosplit";

  self.grepformat     =  "%f:%l:%m,%m\\ %f\\ match%ts,%f"; --"%f:%l:%c:%m";
  self.grepprg        = 'rg --hidden --vimgrep --smart-case --';

  self.wrap           = false;
  self.linebreak      = true;
  self.breakat        = [[\ \	;:,!?]];
  self.startofline    = false;
  self.whichwrap      = "h,l,<,>,[,],~";
  self.splitbelow     = true;  -- Horizontal windows should split to bottom
  self.splitright     = true;  --Vertical windows should be split to right
  self.switchbuf      = "useopen";
  self.backspace      = "indent,eol,start"; --Makes backspace key more powerful.
  self.diffopt        = "filler,iwhite,internal,algorithm:patience";
  self.completeopt    = "menu,menuone,noselect,noinsert";  -- Show popup menu, even if there is one entry
  self.jumpoptions    = "stack";

  self.showmode       = false;
  self.shortmess      = "aoOTIcF";
  self.scrolloff      = 2;
  self.sidescrolloff  = 5;
  self.ruler          = false;

  self.showtabline    = 2;
  self.winwidth       = 30;
  self.winminwidth    = 10;
  self.pumheight      = 15;  -- Completion window max size
  self.helpheight     = 12;
  self.previewheight  = 12;

  self.number         = true;
  self.relativenumber = true;  -- turn hybrid line numbers off set nonu nornu
  self.showcmd        = true;
  self.cmdheight      = 1;
  self.cmdwinheight   = 5;
  self.equalalways    = false;
  self.laststatus     = 2;     -- Show status line always
  -- self.colorcolumn    = "100";
  self.display        = "lastline";

  self.foldenable     = true;
  self.foldmethod     = "indent";
  self.foldlevelstart = 99;

  self.signcolumn     = "yes";
  self.showbreak      = "↳  ";
  self.list           = true;

  self.listchars      = "tab:┊ ,nbsp:+,trail:·,extends:→,precedes:←";  -- tab:»·, 
  self.conceallevel   = 2;
  self.concealcursor  = "niv";

  self.pumblend       = 10;
  self.winblend       = 10;
  self.autowrite      = true;  -- Automatically save before :next, :make etc.
  self.autoread       = true;  -- Automatically read changed files
  -- self.termencoding   = "utf-8";  -- decprecate
  self.cindent        = true;
  self.wrap           = true;
  self.breakindent    = true;
  self.smartindent    = true;  -- use intelligent indentation
  self.numberwidth    = 3;
  self.showmatch      = true;  -- highlight matching braces
  if global.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
      },
      paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
      },
      cache_enabled = 0
    }
    vim.g.python_host_prog = '/usr/bin/python'
    vim.g.python3_host_prog = '/usr/local/bin/python3'
  end
  for name, value in pairs(self) do
    vim.o[name] = value
  end
end

return options
