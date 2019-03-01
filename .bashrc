# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export GOPATH=$HOME/development
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export LGOBIN=$GOPATH/bin
export PATH=$PATH:$LGOBIN
export GOROOT=/usr/local/go
export PATH=$PATH:/home/anjed/.cargo/bin
export EDITOR=vim
export SWIG_PATH=/home/Jerry/library/swigtool/bin
export PATH=$SWIG_PATH:$PATH
source <(kubectl completion bash)

# function to set terminal title
function set-title(){
#  if [[ -z "$ORIG" ]]; then
#    ORIG="$PS1"
#  fi
#  TITLE="\[\e]2;$*\a\]"
#  PS1="${ORIG}${TITLE}"
#  PROMPT_COMMAND='echo -ne "\033]0;$PS1\007"'
#printf "\e]2;$PS1\a"
    echo -e "\033]0;$@\007"


}

. /home/anjed/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval $(thefuck --alias)

alias sv='sudo vim'
alias python=python3
alias ntor='sudo service tor stop'
alias btor='sudo service tor start'
alias ay='sudo apt install -y'
alias au='sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove && sudo apt autoclean && sudo apt clean'
#alias gb='cd /home/anjed/www/bokeh && source /home/anjed/www/bokeh/bin/activate'
alias dd='cd /home/anjed/development'
alias dD='cd /home/anjed/development/DevelopmentKit'
alias dcb=' dD && cd projects/CafeBazaar/capi'
alias dj='cd /home/anjed/development/jarchi'
alias dl='cd /home/anjed/development/Loebat/src/components/advertisement'
alias pd='dD && devkit compose up'
#alias gdu='dD && devkit git update'
alias pj='dj && docker-compose up'
alias pl='cd /home/anjed/development/Loebat && . env-8/bin/activate && echo `nodejs --version` && yarn run dev'
#alias gs='cd /home/anjed/www/saleor && source /home/anjed/www/saleor/bin/activate'
#alias shu='sshuttle --no-latency --dns -r mehran@farang.cafebazaar.ir -x 151.80.182.97 -x 127.0.53.53 -x 79.175.191.212 -x 151.80.182.96 -x 192.168.0.0 -x 172.17.0.0 -x 79.175.191.0 0/0'
alias die='deactivate'
#alias air='./manage.py runserver'
#alias wer='./manage.py createsuperuser'
#alias she='./manage.py shell'

function vie(){
    source $1/bin/activate
}
# Dockers
alias dkcb='docker exec -it devkit_cafebazaar_1 bash'
alias dkj='docker exec -it jarchi_web_1 bash'

function dkkrm(){
    docker kill $(docker ps -a | grep $1 | awk '{print $1}')
    docker rm $(docker ps -a | grep $1 | awk '{print $1}')
}

function dkkrma(){
    docker kill $(docker ps -a -q)
    docker rm $(docker ps -a -q)
}

# exec bash
function dex(){
    docker exec -it $1 bash
}

function dexf(){
    docker exec -it $(docker ps -a | grep $1 | awk '{print $1}') bash
}


# GIT
alias gst='git status'
alias gdf='git diff'
alias gpom='git pull origin master && git submodule update'
alias gfp='git fetch -p'
alias gaa='git add --all'
alias gchm='git checkout master'
alias gsu='git push -u'

function gch(){
    git checkout $1
    git pull
}

function gcom(){
    git commit -m $1
    git push -u
}

function gcb(){
    git checkout -b $1
    git push --set-upstream origin $1
    git fetch -p
    git push -u
}

# xclip shortcuts
alias c='xclip -selection c'
alias v='xclip -o'

# Timestamp to clipboard
alias naw='/home/anjed/bin/now.js | c'

# added by Anaconda3 installer
# export PATH="/home/anjed/anaconda3/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FIND PROCESS
function p(){
        ps aux | grep -i $1 | grep -v grep
}

# MURDER ALL
function ma(){
    p $1
    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs kill -9
}
# MURDER ALL SUDO
function mas(){
    p $1
    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -15
    sleep 0.1
    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -9
    sleep 0.1
    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -2
}

# KUBECTL PART
#logs
function kl(){
    kubectl logs $1
}

# fuzzy logs
function klf(){
    kubectl logs $(kubectl get pods -a| grep $1 | awk '{print $1}')
}

# follow logs
function kf(){
    kubectl logs -f $1
}

# fuzzy follow
function kff(){
    kubectl logs -f $(kubectl get pods -a| grep $1 | awk '{print $1}')
}

# exec bash
function kex(){
    kubectl exec -it $1 bash
}

# fuzzy follow
function kexf(){
    kubectl exec -it $(kubectl get pods | grep $1 | awk '{print $1}') bash
}

alias kgp='kubectl get pods -a'

alias jn='jupyter notebook'

