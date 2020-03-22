#!/bin/bash

   . lib/viSets.sh
   . lib/repos.sh
   . lib/pkgs.sh

   pathogen='execute pathogen#infect()'

   echo "$pathogen" >> ~/.vimrc

   mkdir -p ~/.vim/autoload ~/.vim/bundle

   curl -LSso                     \
     ~/.vim/autoload/pathogen.vim \
     https://tpo.pe/pathogen.vim
   
   yummy() { yum install -y "$i"; }
   
   unsPlug() { rm -rf ~/.vim/bundle/"$1"; }
   upPlug() { unsPlug "$2"; getPlug "$1" "$2"; }

   setting() { grep -q "$1" ~/.vimrc || echo "$1" >> ~/.vimrc; }
   apply() { for i in "$@"; do "$2" "$i"; done; }

   getPlug() {
     if [ ! -d ~/.vim/bundle/"$2" ]; then
         git clone  "https://github.com/"$1"/"$2".git" ~/.vim/bundle/"$2"
     fi
    }
   
   usage() { echo "  bash: $0 $1 $2 ${-:3}"; }

   notify() {
     echo '  no params given || params spelled wrong'
     echo '  run without params for usage'
     echo '  default plugins are idempotent'
    # usage ' uninstall' 'repoName'
    # usage ' install' 'repoUser' 'repoName' 
    # usage ' upgrade' 'repoUser' 'repoName'
     echo -e '...\n '
    }

   apply "${pkgs[@]}" yummy  
   apply "${repos[@]}" getPlug
   apply "${viSets[@]}" setting
