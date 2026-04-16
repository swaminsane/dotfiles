# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# vim mode
set -o vi

#info panel

function __git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " $branch"
}

function __git_dirty() {
    [[ -n $(git status --porcelain 2>/dev/null) ]] && echo "dirty"
}

function __battery() {
    local bat
    bat=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
    [[ -n "$bat" ]] && echo "${bat}%" || echo "N/A"
}

function __set_prompt() {
    local reset="\[\e[0m\]"
    local path="\[\e[34m\]"
    local git_clean="\[\e[35m\]"       # magenta - clean
    local git_dirty="\[\e[38;5;208m\]" # orange - dirty
    local time="\[\e[32m\]"
    local batt="\[\e[33m\]"
    local arrow="\[\e[36m\]"

    local branch="$(__git_branch)"
    local git_color="$git_clean"
    [[ "$(__git_dirty)" == "dirty" ]] && git_color="$git_dirty"

    local right_side="$(date +%H:%M) $(__battery)"
    local cols=$(tput cols)
    local left="${PWD/#$HOME/\~}${branch} "
    local pad=$(( cols - ${#left} - ${#right_side} ))
    local padding=$(printf '%*s' "$pad" '')

    PS1="${path}\w${reset}${git_color}${branch}${reset}${padding}${time}$(date +%H:%M)${reset} ${batt}$(__battery)${reset}\n${arrow}>${reset} "
}

#st-samedir
set_title() {
    dir=$(pwd | sed "s|$HOME|~|")
    echo -ne "\033]0;st: $dir\007"
}
PROMPT_COMMAND="__set_prompt; pwd > /tmp/last_dir; set_title"
eval "$(zoxide init bash)"


#Advance aliases
v() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}

# aliases
alias rm="rm -I"
alias shred="shred -v"
alias yta="yt -x -f audbooks"
alias adbc=".local/bin/adbc"
alias apti="sudo apt install"
alias f="lf"
alias nano="nano -l"
alias soundr="systemctl --user restart pipewire.service"
alias dots='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias musicr='systemctl --user restart mpd && mpc update --wait && pkill ncmpcpp 2>/dev/null; ncmpcpp'
alias suu="sudo apt update && sudo apt upgrade"
alias e="emacs"
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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'



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
export PATH="$HOME/.npm-global/bin:$PATH"




export PASSWORD_STORE_ENABLE_EXTENSIONS=true
