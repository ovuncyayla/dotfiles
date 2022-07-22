export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

source $HOME/dotfiles/zsh/zsh/config/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/dotfiles/zsh/zsh/config/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/dotfiles/zsh/zsh/config/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOME/dotfiles/zsh/zsh/config/config.zsh

export PATH=$HOME/bin:$PATH
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

source $HOME/.cargo/env

eval "$(zoxide init zsh)"
export EDITOR=nvim

# eval "$(luarocks path)" 

eval "$(starship init zsh)" 

pgrep -x ssh-agent > /dev/null || ssh-agent -a $SSH_AUTH_SOCK

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#source ~/powerlevel10k/powerlevel10k.zsh-theme
