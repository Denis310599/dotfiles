# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd
bindkey -e
# Download Znap, if it's not there yet.
[[ -r ~/cosasMias/ricing/repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/cosasMias/ricing/repos/znap
source ~/cosasMias/ricing/repos/znap/znap.zsh  # Start Znap
#Inicializamos los plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
source ~/cosasMias/ricing/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh<D-
echo ""
fastfetch -c ~/cosasMias/ricing/dotfiles/fastfetch/14.jsonc
