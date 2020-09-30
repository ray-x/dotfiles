
local generator = function()
    local el_segments = {}
    local builtin = require('el.builtin')
    local extensions = require('el.extensions')
    local log = require('el.log')
    local meta = require('el.meta')
    local processor = require('el.processor')
    local sections = require('el.sections')
    local subscribe = require('el.subscribe')

    local lsp_statusline = require('el.plugins.lsp_status')
    local extensions = require('el.extensions')
    return {
        extensions.mode,
        sections.split,
        builtin.file,
        sections.collapse_builtin {
          ' ',
          builtin.modified_flag
        },
        sections.split,
        lsp_statusline.segment,
        lsp_statusline.current_function,
        subscribe.buf_autocmd(
          "el_git_status",
          "BufWritePost",
          function(window, buffer)
            return extensions.git_changes(window, buffer)
          end
        ),
        extensions.git_icon, 
        ' ',
        subscribe.buf_autocmd(
          "el_git_branch",
          "BufEnter",
          function(window, buffer)
            return extensions.git_branch(window, buffer)
          end
        ),' ', 
        '[', builtin.line, ' : ',  builtin.column, ']',
        sections.collapse_builtin{
          '[',
          builtin.help_list,
          builtin.readonly_list,
          ']',
        },
        ' ', subscribe.buf_autocmd(
          "el_file_icon",
          "BufRead",
          function(_, buffer)
            return extensions.file_icon(_, buffer)
          end
        ), ' ',
        builtin.filetype,
      }

end



-- And then when you're all done, just call
-- require('el').setup { generator = generator }
require('el').setup { generator = generator }