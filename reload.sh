#!/bin/bash

# Install and reload everything
backup_vimrc() {
  if [ -z "$1"]; then
	  i=1
  else
	  i="$1"
  fi
  backupName="~/.vimrc.backup$i"
  if [ ! -f "$backupName" ]; then
	cp ~/.vimrc "$backupName"
  else
	backup_vimrc "$(($i+1))"
  fi
}
backup_vimrc

# Install vimrc(s)
ln -sv ~/.vim/vimrcs/main.vim ~/.vimrc

# Install plugins pathogen style
