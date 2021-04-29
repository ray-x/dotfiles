local treesitter = function()
  print("loading ts")
  if vim.fn.line('$') > 20000 then  -- skip for large file
    vim.cmd[[syntax on]]
    print('skip treesitter')
    return 
  end
  print('load treesitter', vim.fn.line('$'))
  if not packer_plugins['nvim-treesitter'] or not packer_plugins['nvim-treesitter'].loaded then
    vim.cmd [[packadd nvim-treesitter]]
  end
  if not packer_plugins['nvim-treesitter-textobjects'] or not packer_plugins['nvim-treesitter-textobjects'].loaded then
    vim.cmd [[packadd nvim-treesitter-textobjects]]
  end
  if not packer_plugins['nvim-treesitter-refactor'] or not packer_plugins['nvim-treesitter-refactor'].loaded then
    vim.cmd [[packadd nvim-treesitter-refactor]]
  end


  require "nvim-treesitter.configs".setup {
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {"elm"}, -- list of language that will be disabled
      custom_captures = {},
      use_languagetree = true
    },
    incremental_selection = {
      enable = true,
      disable = {"elm"},
      keymaps = {
        -- mappings for incremental selection (visual mappings)
        init_selection = "gnn", -- maps in normal mode to init the node/scope selection
        node_incremental = "grn", -- increment to the upper named parent
        scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm" -- decrement to the previous node
      }
    },
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = true
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr" -- mapping to rename reference under cursor
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
          list_definitions = "gnD", -- mapping to list all definitions in current file
          list_definitions_toc = "gO",
          -- goto_next_usage = "<c->>",
          -- goto_previous_usage = "<c-<>",
        }
      }
    },
    textobjects = {
      -- syntax-aware textobjects
      enable = true,
      disable = {"elm"},
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          ["df"] = "@function.outer",
          ["dF"] = "@class.outer"
        }
      },
      keymaps = {
        ["iL"] = {
          -- you can define your own textobjects directly here
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          go = "(function_definition) @function",
          java = "(method_declaration) @function"
        },
        -- or you use the queries from supported languages with textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner"
      },
      move = {
        enable = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer"
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer"
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer"
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer"
        }
      },
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          -- Or you can define your own textobjects like this
          ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
            go = "(method_declaration) @function"
          }
        }
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner"
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner"
        }
      }
    },
    ensure_installed = "maintained"
    --{ "go", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx", "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue"}
  }

  if packer_plugins['nvim-ts-autotag'] and not packer_plugins['nvim-ts-autotag'].loaded then
    require'nvim-treesitter.configs'.setup {
      autotag = {
        enable = true,
      }
    }
    vim.cmd [[packadd nvim-ts-autotag]]
    packer_plugins['nvim-ts-autotag'] = {loaded=true}
  end
  if packer_plugins['nvim-ts-rainbow'] and not packer_plugins['nvim-ts-rainbow'].loaded then
    require'nvim-treesitter.configs'.setup {
      rainbow = {
        enable = false,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      }
    }
    vim.cmd [[packadd nvim-ts-rainbow]]
    packer_plugins['nvim-ts-rainbow'] = {loaded=true}
  end

  require('modules.ui.config').blankline()
  if not packer_plugins['indent-blankline.nvim'] or not packer_plugins['indent-blankline.nvim'].loaded then
    vim.cmd [[packadd indent-blankline.nvim]]
    packer_plugins['indent-blankline.nvim'] = {loaded=true}
  end
  vim.api.nvim_command('IndentBlanklineEnableAll')

  if packer_plugins['windwp/nvim-autopairs'] == nil or not packer_plugins['windwp/nvim-autopairs'].loaded then
    vim.cmd [[packadd nvim-autopairs]]
    packer_plugins['windwp/nvim-autopairs'] = {loaded=true}
  end
  require('modules.editor.config').autopairs()

  -- vim.cmd [[packadd pears.nvim]]
  -- require('modules.editor.config').pears_setup()
end

treesitter()
return {treesitter = treesitter}
