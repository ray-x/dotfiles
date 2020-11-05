local global = require('domain.global')
local vim = vim
local options = setmetatable({}, { __index = { global_local = {},window_local = {} } })

function options:load_options()
  self.global_local = {
    ttyfast        = true;  -- Indicate fast terminal conn for faster redraw
    mouse          = "a";
    report         = 2;
    errorbells     = false;             -- No beeps
    visualbell     = false;
    hidden         = true;             -- Buffer should still exist if window is closed
    fileformats    = "unix,mac,dos";
    magic          = true;
    virtualedit    = "block";
    synmaxcol      = 2500;
    formatoptions  = "1jcroql";
    encoding       = "utf-8";
    fileencoding   = "utf-8";  --fenc
    viewoptions    = "folds,cursor,curdir,slash,unix";
    sessionoptions = "curdir,help,tabpages,winsize";
    clipboard      = "unnamed,unnamedplus";
    wildignorecase = true;

    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.so,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,_site,*/__pycache__/,*/venv/*,*/target/*,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.ist,*/.fdb_latex";
    backup         = false;
    writebackup    = false;
    undofile       = true;
    swapfile       = false;
    directory      = global.cache_dir .. "swag/";
    undodir        = global.cache_dir .. "undo/";
    backupdir      = global.cache_dir .. "backup/";
    viewdir        = global.cache_dir .. "view/";
    spellfile      = global.cache_dir .. "spell/en.uft-8.add";
    history        = 2000;
    shada          = "!,'300,<50,@100,s10,h";
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";

    textwidth      = 120;   -- wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
    expandtab      = true;  -- " expand tabs to spaces
    -- tabstop        = 2;
    -- shiftwidth     = 2;
    -- softtabstop    = -1;
    smarttab       = true;
    autoindent     = true;
    shiftround     = true;
    breakindentopt = "shift:2,min:20";

    timeout        = true;
    ttimeout       = true;
    timeoutlen     = 500;
    ttimeoutlen    = 10;
    updatetime     = 400;   -- Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime
    redrawtime     = 1500;

    ignorecase     = true;  -- Search case insensitive...
    smartcase      = true;  -- ... but not it begins with upper case
    infercase      = true;
    incsearch      = true;  -- Shows the match while typing
    hlsearch       = true;  -- Highlight found searches
    wrapscan       = true;

    complete       = ".,w,b,k";
    inccommand     = "nosplit";

    grepformat     =  "%f:%l:%m,%m\\ %f\\ match%ts,%f"; --"%f:%l:%c:%m";
    grepprg        = 'rg --hidden --vimgrep --smart-case --';

    breakat        = [[\ \	;:,!?]];
    startofline    = false;
    whichwrap      = "h,l,<,>,[,],~";
    splitbelow     = true;  -- Horizontal windows should split to bottom
    splitright     = true;  --Vertical windows should be split to right
    switchbuf      = "useopen";
    backspace      = "indent,eol,start"; --Makes backspace key more powerful.
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    completeopt    = "menu,noselect,noinsert";  -- Show popup menu, even if there is one entry  menuone?
    jumpoptions    = "stack";

    showmode       = false;
    shortmess      = "aoOTIcF";
    scrolloff      = 2;
    sidescrolloff  = 5;
    ruler          = false;

    showtabline    = 2;
    winwidth       = 30;
    winminwidth    = 10;
    pumheight      = 15;  -- Completion window max size
    helpheight     = 12;
    previewheight  = 12;

    showcmd        = true;
    cmdheight      = 1;
    cmdwinheight   = 5;
    equalalways    = false;
    laststatus     = 2;     -- Show status line always
    display        = "lastline";

    foldlevelstart = 99;

    showbreak      = "↳";
    listchars      = "tab:┊ ,nbsp:+,trail:·,extends:→,precedes:←";  -- tab:»·, 
    conceallevel   = 2;

    pumblend       = 17;
    winblend       = 17;
    autowrite      = true;  -- Automatically save before :next, :make etc.
    autoread       = true;  -- Automatically read changed files
    -- termencoding   = "utf-8";  -- decprecate
    cindent        = true;
    breakindent    = true;  -- Make it so that long lines wrap smartly
    smartindent    = true;  -- use intelligent indentation
    numberwidth    = 3;
    showmatch      = true;  -- highlight matching braces
  }

  self.window_local   = {
    list           = true;
    -- breakindentopt = "shift:2,min:20";
    -- wrap           = true;
    linebreak      = true;
    number         = true;
    relativenumber = true;
    colorcolumn    = "100";
    foldenable     = true;
    foldmethod     = "expr";  -- indent?
    -- signcolumn     = "yes";   -- auto
    conceallevel   = 2;
    concealcursor  = "niv";
  }
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
    vim.g.python_host_prog = '/usr/bin/python2'
    vim.g.python3_host_prog = '/usr/local/bin/python3.8'
  end
  for name, value in pairs(self.global_local) do
    vim.o[name] = value
  end
  for name, value in pairs(self.window_local) do
    vim.wo[name] = value
  end
end

return options
