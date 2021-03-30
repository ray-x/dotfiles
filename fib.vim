" $vim -u fib.vim -U NONE -i NONE -c "quit" --noplugin
set nocompatible

" Interpreter initialization.
lua << EOF
EOF
python << EOF
EOF
ruby << EOF
EOF

function! Fib2(n)
  if a:n < 2
    return a:n
  else
    return Fib2(a:n-1) + Fib2(a:n-2)
  endif
endfunction

function! Fib(n)
  echomsg 'n = ' . a:n
  let start = reltime()
  call Fib2(a:n)
  echomsg 'Vim = ' . reltimestr(reltime(start))
  let start = reltime()


lua << EOF
function fib(n)
  if n < 2 then
    return n
  end
  return fib(n-2) + fib(n-1)
end
fib(tonumber(vim.fn.eval('a:n')))
EOF

  echomsg 'if_lua = ' . reltimestr(reltime(start))

let start = reltime()
python << EOF
import vim
def fib(n):
  if n < 2:
    return n
  else :
    return fib(n-2) + fib(n-1)
fib(int(vim.eval('a:n')))
EOF
echomsg 'if_python = ' . reltimestr(reltime(start))

let start = reltime()
ruby << EOF
def fib n
  return n if n < 2
  fib(n-2) + fib(n-1)
end

fib(VIM::evaluate('a:n').to_i)
EOF
  echomsg 'if_ruby = ' . reltimestr(reltime(start))
endfunction

for n in [5, 10, 15, 20, 25]
  call Fib(n)
endfor
