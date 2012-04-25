# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="afowler"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git kate ruby)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
function alarm()
{
    sleep $1 && mplayer /home/gagan/alarm.mp3 -loop 0
}

function random_st()
{
    cd "/media/6/TV/Star Trek TNG - Complete" && smplayer "$(ls **/*avi | sort -R | head -1)"
}

alias rst="random_st"
alias grep="grep --color=auto"
alias pc="killall -9 plugin-container"
alias bc="bc -l"
alias vps="ssh -t gaganpreet.in 'su -'"
alias pie="perl -p -i -e"

# Bind alt+y to cd -
bindkey -s '\ey' "cd -\n"
# Bind alt+r to ls -trl
bindkey -s '\er' "ls -trl\n"

# If wildcard doesn't expand, pass it on to the command
setopt no_nomatch

export EDITOR="vim"
export PYTHONSTARTUP=$HOME/.pythonrc.py

# Rehash completion index to pick up new commands automatically
zstyle ":completion:*:commands" rehash 1

fortune
