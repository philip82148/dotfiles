[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# INSERT COMMON

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.yarn/bin:$PATH"

export JAVA_HOME=/usr/java
export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=$HOME/Android/SDK
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

export PATH="$PATH:/opt/nvim/"

alias acl='/home/philip82148/projects/ac-library/expander.py --lib /home/philip82148/projects/ac-library'
