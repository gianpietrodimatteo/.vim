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
    backup_vimrc "$(($i + 1))"
  fi
}
backup_vimrc

# Install vimrcs
ln -sv ~/.vim/vimrcs/main.vim ~/.vimrc
# Make directories
mkdir -p ~/.vim/temp/{.backup,.swp,.undo}

# Install plugins pathogen style
if [ -d ~/.vim/bundle ]; then
  rm -rf ~/.vim/bundle/*
else
  mkdir ~/.vim/bundle
fi
cd ~/.vim/bundle/

auto-pairs https://github.com/jiangmiao/auto-pairs
ale https://github.com/w0rp/ale
vim-yankstack https://github.com/maxbrunsfeld/vim-yankstack
ack.vim https://github.com/mileszs/ack.vim
bufexplorer https://github.com/jlanzarotta/bufexplorer
ctrlp.vim https://github.com/ctrlpvim/ctrlp.vim
mayansmoke https://github.com/vim-scripts/mayansmoke
nerdtree https://github.com/scrooloose/nerdtree
nginx.vim https://github.com/chr4/nginx.vim
open_file_under_cursor.vim https://github.com/amix/open_file_under_cursor.vim
tlib https://github.com/vim-scripts/tlib
vim-addon-mw-utils https://github.com/MarcWeber/vim-addon-mw-utils
vim-bundle-mako https://github.com/sophacles/vim-bundle-mako
vim-coffee-script https://github.com/kchmck/vim-coffee-script
vim-colors-solarized https://github.com/altercation/vim-colors-solarized
vim-indent-object https://github.com/michaeljsmith/vim-indent-object
vim-less https://github.com/groenewege/vim-less
vim-pyte https://github.com/therubymug/vim-pyte
vim-snipmate https://github.com/garbas/vim-snipmate
vim-snippets https://github.com/honza/vim-snippets
vim-surround https://github.com/tpope/vim-surround
vim-expand-region https://github.com/terryma/vim-expand-region
vim-multiple-cursors https://github.com/terryma/vim-multiple-cursors
vim-fugitive https://github.com/tpope/vim-fugitive
goyo.vim https://github.com/junegunn/goyo.vim
vim-zenroom2 https://github.com/amix/vim-zenroom2
vim-repeat https://github.com/tpope/vim-repeat
vim-commentary https://github.com/tpope/vim-commentary
vim-gitgutter https://github.com/airblade/vim-gitgutter
gruvbox https://github.com/morhetz/gruvbox
vim-flake8 https://github.com/nvie/vim-flake8
vim-pug https://github.com/digitaltoad/vim-pug
lightline.vim https://github.com/itchyny/lightline.vim
lightline-ale https://github.com/maximbaz/lightline-ale
vim-abolish https://github.com/tpope/tpope-vim-abolish
mru.vim https://github.com/vim-scripts/mru.vim
rust.vim https://github.com/rust-lang/rust.vim
vim-markdown https://github.com/plasticboy/vim-markdown
vim-gist https://github.com/mattn/vim-gist
vim-ruby https://github.com/vim-ruby/vim-ruby
typescript-vim https://github.com/leafgarland/typescript-vim
vim-javascript https://github.com/pangloss/vim-javascript
vim-python-pep8-indent https://github.com/Vimjas/vim-python-pep8-indent

# Specify a directory for plugins
# - For Neovim: stdpath('data') . '/plugged'
call plug#begin('~/.vim/plugged')
# # Syntax
# Plug 'w0rp/ale'

# tpope is love. tpope is life.
# # Comentary
# Plug 'tpope/vim-commentary'
# Extend dot functionality
Plug 'tpope/vim-repeat'
# Extend find and replace functionality
Plug 'tpope/vim-abolish'
# # Git
# Plug 'tpope/vim-fugitive'
# Sorrounding
Plug 'tpope/vim-surround'

#Improved copypaste
# Separate cut and delete
Plug 'svermeulen/vim-cutlass'
# Yank history
Plug 'svermeulen/vim-yoink'
# Easier find and replace
Plug 'svermeulen/vim-subversive'

# # Fuzzy finder
# Plug 'ctrlpvim/ctrlp.vim'

# Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

# Code completion
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --all' }

# # On-demand loading
# Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

# Emmet
Plug 'mattn/emmet-vim'

# Status
# Plug 'vim-airline/vim-airline'

# Autoclosing tags
Plug 'alvan/vim-closetag'

# Beloved easymotion
Plug 'easymotion/vim-easymotion'

# # Beloved multi cursors
# Plug 'terryma/vim-multiple-cursors'

# Beloved code formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'branch': 'release/1.x'}

# Syntax Highlighting for typescript
Plug 'leafgarland/typescript-vim'

# Smarter pairing
Plug 'jiangmiao/auto-pairs'

# Javascript support
Plug 'pangloss/vim-javascript'

# More typescritp support
Plug 'https://github.com/Shougo/vimproc.vim', {'do' : 'make'}
Plug 'https://github.com/Quramy/tsuquyomi'

# Autosave and session/workspace saving
Plug 'thaerkh/vim-workspace'
