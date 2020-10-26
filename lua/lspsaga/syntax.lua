local M = {}
local api = vim.api

function M.add_highlight()
  api.nvim_command("hi LspFloatWinBorder guifg=#c594c5")
  api.nvim_command("hi TargetWord guifg=#EC5f67 gui=bold")
  api.nvim_command("hi ReferencesCount guifg=#2e6ce8 gui=bold")
  api.nvim_command("hi DefinitionCount guifg=#2e6ce8 gui=bold")
  api.nvim_command("hi TargetFileName guifg=#c0c5ce gui=bold")
  api.nvim_command("hi DefinitionIcon guifg=#d8a657")
  api.nvim_command("hi ReferencesIcon guifg=#d8a657")
  api.nvim_command("hi link HelpTitle Comment")
  api.nvim_command("hi link HelpItem Comment")
  -- diagnostic
  api.nvim_command("hi DiagnosticTruncateLine guifg=#6699cc gui=bold")
  api.nvim_command("hi DiagnosticError guifg=#EC5f67 gui=bold")
  api.nvim_command("hi DiagnosticWarning guifg=#d8a657 gui=bold")
  api.nvim_command("hi DiagnosticInformation guifg=#6699cc gui=bold")
  api.nvim_command("hi DiagnosticHint guifg=#56b6c2 gui=bold")

  api.nvim_command("hi DefinitionPreviewTitle guifg=#56b6c2 gui=bold")

  api.nvim_command("hi DiagnosticBufferTitle guifg=#c594c5 gui=bold")
  api.nvim_command("hi DiagnosticFloatError guifg=#EC5f67")
  api.nvim_command("hi DiagnosticFloatWarn guifg=#d8a657")
  api.nvim_command("hi DiagnosticFloatInfo guifg=#6699cc")
  api.nvim_command("hi DiagnosticFloatHint guifg=#56b6c2")
end

return M

