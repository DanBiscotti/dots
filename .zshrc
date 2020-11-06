PROMPT="%F{yellow}[%~]%F{purple} "

autoload -U colors && colors	# Load colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

export KEYTIMEOUT=1
bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Cursor in vi mode
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 == 'block' ]]; then
            echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == 'main' ]] ||
        [[ ${KEYMAP} == 'viins' ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
            echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Aliases/Functons
alias vim=nvim
download-website() { wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains $(echo $1 | awk -F/ '{print $3}') --no-parent $1 }
alias ls=lsd
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias la=ls -a

# Env vars
export HTTP_HOME="www.duckduckgo.com/lite"
export EDITOR=nvim
export BROWSER=w3m

if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi


export KEYTIMEOUT=1
bindkey -v

#	# Antigen plugin manager
#	source ~/.config/zsh/antigen.zsh
#	antigen bundle zsh-users/zsh-syntax-highlighting

#source /home/dan/repos/zsh-z/zsh-z.plugin.zsh

export PATH="$PATH:/home/dan/.gem/ruby/2.7.0/bin:/home/dan/go/bin/:/home/dan/.dotnet/tools"

source /home/dan/.config/broot/launcher/bash/br
