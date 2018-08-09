# /etc/skel/.bashrc:
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash/files/dot-bashrc,v 1.3 2005/07/06 22:10:22 vapier Exp $
# 
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
# Shell is non-interactive.  Be done now
  return
fi

# Shell is interactive.  It is okay to produce output at this point,
# though this example doesn't produce any.  Do setup for
# command-line interactivity.

export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE=cd*:ls:la:l:ll:su
export HISTFILESIZE=
export HISTSIZE=

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export GOPATH=$HOME/Code/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

alias ls="ls -G"
alias la="ls -Glah"
alias ll="ls -Glh"
alias l="ls -Gh"
alias screen="screen -RD"
alias cal="cal -m"
alias svndiff="svn diff | less -r"
alias gits="git status"
alias gitd="git diff"
alias gitc="git commit -a"
alias gitp="git push"
alias dum="du -hx --max-depth=1"
alias homesick="~/.homeshick"
alias vim="vim -p"
# MAC manipulators
alias random_mac='sudo ifconfig en0 ether `openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"`'
alias restore_mac='sudo ifconfig en0 ether YOUR_ORIGINAL_MAC_ADDRESS_GOES_HERE'

# uncomment the following to activate bash-completion:
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

# additions by samuel

[ -d /home/samuel/.bin ] && export PATH=/home/samuel/.bin:$PATH
[ -d /home/samuel/bin ] && export PATH=/home/samuel/bin:$PATH
[ -d /opt/android-studio/bin ] && export PATH=/opt/android-studio/bin:$PATH
[ -d "/usr/local/opt/node@8/bin" ] && export PATH="/usr/local/opt/node@8/bin":$PATH

if [[ ${TERM} == xterm ]] ; then
   export TERM=xterm-256color
fi

shopt -s extglob
shopt -s cdspell
shopt -s dotglob
shopt -s histappend

set bell-style none

POWERLINE_PATH=~/Library/Python/2.7/lib/python/site-packages/powerline
source $POWERLINE_PATH/bindings/bash/powerline.sh

export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi
export HH_CONFIG=hicolor

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

