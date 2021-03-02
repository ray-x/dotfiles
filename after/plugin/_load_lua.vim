" note luafile works with packer, may not dein

if exists('g:dein#install_max_processes') 
  let s:load_dir = expand('<sfile>:p:h:h:h')
  exec printf('luafile %s/lua/init.lua', s:load_dir)
endif
