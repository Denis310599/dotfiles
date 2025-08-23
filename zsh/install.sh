#!/bin/bash

#Install zsh
pacman -Sy zsh
chsh -s $(which zsh)

# Install autocomplete
mkdir -p ~/cosasMias/ricing/repos/
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/cosasMias/ricing/repos/zsh-syntax-highlighting
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


# Install starship
pacman -S starship

# Copy the .zsh into the config place
cp ./.zshrc ~/

# Style starship
mkdir -p ~/.config/ && touch ~/.config/starship.toml

