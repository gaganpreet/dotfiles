#!/bin/bash
mkdir -p $HOME/.config/nvim/ && ln -s $(pwd)/dotfiles/coc-settings.json     $HOME/.config/nvim/coc-settings.json
ln -s $(pwd)/dotfiles/init.vim              $HOME/.config/nvim/init.vim

mkdir -p $HOME/.config/albert && ln -s $(pwd)/dotfiles/albert.conf           $HOME/.config/albert/albert.conf

ln -s $(pwd)/dotfiles/tmux.conf             $HOME/.tmux.conf
ln -s $(pwd)/dotfiles/zshrc                 $HOME/.zshrc
