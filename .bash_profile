#!/bin/bash

[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

if [[ $(pgrep Xorg) == "" ]]; then
	
	for i in {1..1}
	do
		echo -ne "\rStarting X server $i"
		sleep 1
	done	
	echo
	startx && exit
fi
