# ========================
# Locale (English output)
# ========================
export LANG=en_US.UTF-8
unset LC_ALL
# ========================
# Editor
# ========================
export EDITOR=nvim
# ========================
# History
# ========================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
# ========================
# Completion (fast)
# ========================
autoload -Uz compinit
compinit -C
# ========================
# Starship
# ========================
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
eval "$(sheldon source)"
eval "$(zoxide init zsh --cmd j)"

export FZF_CTRL_R_OPTS="--reverse"
source <(fzf --zsh)
bindkey '^g' fzf-file-widget

setopt interactivecomments

alias el="eza --icons --git --no-user"
alias ell="eza -l --icons --git --no-user"
alias ela="eza -la --icons --git --no-user"
alias etree="eza --tree --icons"

alias g=git
alias ga='git a'
alias ga.='git a .'
alias gc='git c'
alias gcm='git cm'
alias gad='git ad'
alias gadm='git adm'
alias gb='git b'
alias gco='git co'
alias gcob='git cob'
alias gl='git l'
alias glp='git lp'
alias glpn='git lpn'
alias gs='git s'
alias gsl='git sl'
alias gsu='git su'
alias gsum='git sum'
alias gsuk='git suk'
alias gsukm='git sukm'
alias gsp='git sp'
alias greset='git reset'
alias gpull='git pull'
alias gpush='git push'
alias gfetch='git fetch'
alias gmerge='git merge'
alias gri='git ri'
alias grc='git rc'
alias gra='git ra'
alias greflog='git reflog'
alias ginit='git init'
alias gclone='git clone'
alias gremote='git remote'
alias gsub='git submodule'

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins ';;' expand-or-complete
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd 'J' down-line-or-history
bindkey -M vicmd 'K' up-line-or-history
bindkey -M vicmd 'U' redo
bindkey -M vicmd 'x' vi-delete-char
bindkey '^J' self-insert

\$() {
    if [ $# -eq 0 ]; then
        echo "Usage: \$ <command>"
        return 1
    fi
    "$@"
}

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias code=/usr/local/bin/cursor
alias vscode=/usr/local/bin/code

export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/Users/ryota_sasaki/.local/bin:$PATH"
