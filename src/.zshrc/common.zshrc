# COMMON START

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
eval "$(starship init zsh)"

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

function shellcolors() {
    echo -e "\033[1m# Basic\033[m"
    echo -e "Set   color: \"\\\033[<attribute>;<foreground>;<background>m\""
    echo -e "Reset color: \"\\\033[m"\"

    echo -e "\033[1m# Attributes:\033[m"
    echo -e "\\\033[0m\033[0mReset\033[m\\\033[m"
    echo -e "\\\033[1m\033[1mBold\033[m\\\033[m"
    echo -e "\\\033[2m\033[2mLowLuminance\033[m\\\033[m"
    echo -e "\\\033[3m\033[3mItalic\033[m\\\033[m"
    echo -e "\\\033[4m\033[4mUnderline\033[m\\\033[m"
    echo -e "\\\033[5m\033[5mBlink\033[m\\\033[m"
    echo -e "\\\033[6m\033[6mHighBlink\033[m\\\033[m"
    echo -e "\\\033[7m\033[7mInvert\033[m\\\033[m"
    echo -e "\\\033[8m\033[8mHide\033[m\\\033[m"
    echo -e "\\\033[9m\033[9mStrikethrough\033[m\\\033[m"

    echo -e "\033[1m# 16 foreground colors:\033[m"
    echo -e "\\\033[30m\033[30mBLACK\033[m\\\033[m\t\\\033[90m\033[90mLIGHT BLACK\033[m\\\033[m"
    echo -e "\\\033[31m\033[31mRED\033[m\\\033[m\t\\\033[91m\033[91mLIGHT RED\033[m\\\033[m"
    echo -e "\\\033[32m\033[32mGREEN\033[m\\\033[m\t\\\033[92m\033[92mLIGHT GREEN\033[m\\\033[m"
    echo -e "\\\033[33m\033[33mYELLOW\033[m\\\033[m\t\\\033[93m\033[93mLIGHT YELLOW\033[m\\\033[m"
    echo -e "\\\033[34m\033[34mBLUE\033[m\\\033[m\t\\\033[94m\033[94mLIGHT BLUE\033[m\\\033[m"
    echo -e "\\\033[35m\033[35mMAGENTA\033[m\\\033[m\t\\\033[95m\033[95mLIGHT MAGENTA\033[m\\\033[m"
    echo -e "\\\033[36m\033[36mCYAN\033[m\\\033[m\t\\\033[96m\033[96mLIGHT CYAN\033[m\\\033[m"
    echo -e "\\\033[37m\033[37mWHITE\033[m\\\033[m\t\\\033[97m\033[97mLIGHT WHITE\033[m\\\033[m"

    echo -e "\033[1m# 16 background colors:\033[m"
    echo -e "\\\033[40m\033[40mBLACK\033[m\\\033[m\t\\\033[100m\033[100mLIGHT BLACK\033[m\\\033[m"
    echo -e "\\\033[41m\033[41mRED\033[m\\\033[m\t\\\033[101m\033[101mLIGHT RED\033[m\\\033[m"
    echo -e "\\\033[42m\033[42mGREEN\033[m\\\033[m\t\\\033[102m\033[102mLIGHT GREEN\033[m\\\033[m"
    echo -e "\\\033[43m\033[43mYELLOW\033[m\\\033[m\t\\\033[103m\033[103mLIGHT YELLOW\033[m\\\033[m"
    echo -e "\\\033[44m\033[44mBLUE\033[m\\\033[m\t\\\033[104m\033[104mLIGHT BLUE\033[m\\\033[m"
    echo -e "\\\033[45m\033[45mMAGENTA\033[m\\\033[m\t\\\033[105m\033[105mLIGHT MAGENTA\033[m\\\033[m"
    echo -e "\\\033[46m\033[46mCYAN\033[m\\\033[m\t\\\033[106m\033[106mLIGHT CYAN\033[m\\\033[m"
    echo -e "\\\033[47m\033[47mWHITE\033[m\\\033[m\t\\\033[107m\033[107mLIGHT WHITE\033[m\\\033[m"

    echo -e "\033[1m# 256 colors:\033[m"
    echo -e "Foreground: \"\\\033[38;5;<color number>mCOLOR\\\033[m\""
    echo -e "Background: \"\\\033[48;5;<color number>mCOLOR\\\033[m\""
    seq 0 255 | xargs -I {} printf "\033[38;5;{}m{}\033[m "
    echo -e ""

    echo -e "\033[1m# 24bit colors\033[m"
    echo -e "Foreground: \"\\\033[38;2;<red(0-255)>;<green(0-255)>;<blue(0-255)>m\\\033[m\""
    echo -e "Background: \"\\\033[48;2;<red(0-255)>;<green(0-255)>;<blue(0-255)>m\\\033[m\""
}

# COMMON END
