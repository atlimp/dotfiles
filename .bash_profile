#!/bin/bash
source $HOME/.bashrc
if [[ $(pgrep Xorg) == "" ]]; then
	
	for i in {1..1}
	do
		echo -ne "\rStarting X server $i"
		sleep 1
	done	
	echo
	start
fi
