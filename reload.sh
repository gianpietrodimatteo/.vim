#!/bin/bash

# Instalation script for the custom vim configuration

backup_vimrc() {
  if [ -z "$1"]; then
    i=1
  else
    i="$1"
  fi
  backupName=".vimrc.backup$i"
  if [ ! -f "$backupName" ]; then
    mv -v ~/.vimrc ~/$backupName
  else
    backup_vimrc "$(($i + 1))"
  fi
}

install_vimrc() {
  ln -sv ~/.vim/vimrcs/main.vim ~/.vimrc
  # Make directories
  mkdir -vp ~/.vim/temp/{.backup,.swp,.undo}
}

menu_vimrc() {
  echo "Install vimrc? A backup is created as .vimrc.backup."
  select ivimrc in install no; do
    case $ivimrc in
    install)
      echo "Installing vimrc"
      backup_vimrc
      install_vimrc
      ;;
    no)
      break
      ;;
    *)
      break
      ;;
    esac
  done
}

pull_all_subdirectories() {
  if [ -d ~/.vim/bundle ]; then
    cd ~/.vim/bundle/
    find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
  else
    echo "There is no ~/.vim/bundle directory"
  fi
}

remove_old_plugins() {
  if [ -d ~/.vim/bundle ]; then
    rm -rf ~/.vim/bundle/*
  else
    mkdir ~/.vim/bundle/
  fi
}

install_plugins() {
  if [ -d ~/.vim/bundle ]; then
    cd ~/.vim/bundle/
    ###############################################################################
    # Completion and language support
    ###############################################################################
    # Syntax
    git clone --depth=1 https://github.com/w0rp/ale
    # Code completion
    git clone --depth=1 https://github.com/ycm-core/YouCompleteMe
    cd YouCompleteMe
    python3 install.py --all
    cd ..
    # Code formatting
    git clone --depth=1 https://github.com/prettier/vim-prettier
    cd vim-prettier
    npm install
    cd ..
    # Emmet
    git clone --depth=1 https://github.com/mattn/emmet-vim
    # Snippets
    git clone --depth=1 https://github.com/SirVer/ultisnips
    git clone --depth=1 https://github.com/honza/vim-snippets
    # Javascript support
    git clone --depth=1 https://github.com/pangloss/vim-javascript
    # Syntax Highlighting for typescript
    git clone --depth=1 https://github.com/leafgarland/typescript-vim
    # More typescritp support
    git clone --depth=1 https://github.com/https://github.com/Quramy/tsuquyomi

    ###############################################################################
    # IDELike features
    ###############################################################################
    # Explorer
    git clone --depth=1 https://github.com/scrooloose/nerdtree
    # Fuzzy finder
    git clone --depth=1 https://github.com/ctrlpvim/ctrlp.vim
    # Autosave and session/workspace saving
    git clone --depth=1 https://github.com/thaerkh/vim-workspace
    # Status display
    https://github.com/itchyny/lightline.vim
    https://github.com/maximbaz/lightline-ale
    # Git
    git clone --depth=1 https://github.com/tpope/vim-fugitive
    # Extend dot functionality
    git clone --depth=1 https://github.com/tpope/vim-repeat
    # Separate cut and delete
    git clone --depth=1 https://github.com/svermeulen/vim-cutlass
    # Yank history
    git clone --depth=1 https://github.com/svermeulen/vim-yoink
    # Easier find and replace
    git clone --depth=1 https://github.com/svermeulen/vim-subversive
    # Easy motion
    git clone --depth=1 https://github.com/easymotion/vim-easymotion
    # Multi cursors
    git clone --depth=1 https://github.com/terryma/vim-multiple-cursors
    # Pairing
    git clone --depth=1 https://github.com/jiangmiao/auto-pairs
    # Autoclosing tags
    git clone --depth=1 https://github.com/alvan/vim-closetag
    # Comentary
    git clone --depth=1 https://github.com/tpope/vim-commentary
    # Sorrounding
    git clone --depth=1 https://github.com/tpope/vim-surround
    # Extend find and replace functionality
    git clone --depth=1 https://github.com/tpope/vim-abolish

    ###############################################################################
    # It's true, I saw on the internet
    ###############################################################################
    # amix ultimate vimrc
    git clone --depth=1 https://github.com/jiangmiao/auto-pairs
    git clone --depth=1 https://github.com/maxbrunsfeld/vim-yankstack
    git clone --depth=1 https://github.com/mileszs/ack.vim
    git clone --depth=1 https://github.com/jlanzarotta/bufexplorer
    git clone --depth=1 https://github.com/vim-scripts/mayansmoke
    git clone --depth=1 https://github.com/chr4/nginx.vim
    git clone --depth=1 https://github.com/amix/open_file_under_cursor.vim
    git clone --depth=1 https://github.com/vim-scripts/tlib
    git clone --depth=1 https://github.com/MarcWeber/vim-addon-mw-utils
    git clone --depth=1 https://github.com/sophacles/vim-bundle-mako
    git clone --depth=1 https://github.com/kchmck/vim-coffee-script
    git clone --depth=1 https://github.com/altercation/vim-colors-solarized
    git clone --depth=1 https://github.com/michaeljsmith/vim-indent-object
    git clone --depth=1 https://github.com/groenewege/vim-less
    git clone --depth=1 https://github.com/therubymug/vim-pyte
    git clone --depth=1 https://github.com/garbas/vim-snipmate
    git clone --depth=1 https://github.com/honza/vim-snippets
    git clone --depth=1 https://github.com/terryma/vim-expand-region
    git clone --depth=1 https://github.com/junegunn/goyo.vim
    git clone --depth=1 https://github.com/amix/vim-zenroom2
    git clone --depth=1 https://github.com/airblade/vim-gitgutter
    git clone --depth=1 https://github.com/morhetz/gruvbox
    git clone --depth=1 https://github.com/nvie/vim-flake8
    git clone --depth=1 https://github.com/digitaltoad/vim-pug
    git clone --depth=1 https://github.com/tpope/tpope-vim-abolish
    git clone --depth=1 https://github.com/vim-scripts/mru.vim
    git clone --depth=1 https://github.com/rust-lang/rust.vim
    git clone --depth=1 https://github.com/plasticboy/vim-markdown
    git clone --depth=1 https://github.com/mattn/vim-gist
    git clone --depth=1 https://github.com/vim-ruby/vim-ruby
    git clone --depth=1 https://github.com/leafgarland/typescript-vim
    git clone --depth=1 https://github.com/pangloss/vim-javascript
    git clone --depth=1 https://github.com/Vimjas/vim-python-pep8-indent
  else
    echo "There is nothing to be re-installed, did you mean installed?"
  fi
}

menu_plugins() {
  echo "Attention! The reinstall operation will destroy what's currently in your ~/.vim/bundle/ folder! There is NO coming back from this."
  select iplugins in install update reinstall cancel; do
    case $iplugins in
    install)
      echo "Cloning plugins in ~/.vim/bundle/"
      if [! -d ~/.vim/bundle ]; then
        mkdir ~/.vim/bundle/
      fi
      install_plugins
      ;;
    update)
      echo "Updating cloned plugins"
      pull_all_subdirectories
      ;;
    reinstall)
      echo "Removing and re-installing all plugins"
      remove_old_plugins
      install_plugins
      ;;
    cancel)
      echo "Operation canceled"
      break
      ;;
    *)
      echo "Operation canceled"
      break
      ;;
    esac
  done
}

menu_vimrc
menu_plugins
