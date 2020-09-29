#!/bin/zsh
VIMFILENAME=""

if [ "$1" != "" ]; then
	VIMFILENAME=$(realpath "$1")
else
	echo "$1"
fi

echo "launch zsh -c 'nvim ${VIMFILENAME}'\n">${HOME}/tmp/kv.conf

kitty --session ${HOME}/tmp/kv.conf  2>/dev/null &
