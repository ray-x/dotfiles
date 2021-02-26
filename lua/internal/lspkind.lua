local fmt = string.format
lspkind = {}
local kind_symbols = {
  Text = '',
  Method = 'ƒ',
  Function = '',
  Constructor = '',
  Field = 'ﴲ',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = 'ﳅ',
  Operator ='',
  TypeParameter = '',
  Default = '',
}

function lspkind.init()
   require('vim.lsp.protocol').CompletionItemKind = {'', 'ƒ', '', '', 'ﴲ', '', '', 'ﰮ', '', '', '', '', '了', '', '﬌', '', '', '', '', '', '', '', 'ﳅ', '', '', ''}
end


return lspkind
