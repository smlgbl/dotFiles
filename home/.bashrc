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
export HISTFILESIZE=1500

alias ls="ls --color=auto"
alias la="ls -lah"
alias ll="ls -lh"
alias l="ls -h"
alias screen="screen -RD"
alias cal="cal -m"
alias svndiff="svn diff | less -r"
alias gits="git status"
alias gitd="git diff"
alias gitc="git commit -a"
alias gitp="git push"
alias dum="du -hx --max-depth=1"
alias homesick="~/.homeshick"

# uncomment the following to activate bash-completion:
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

# additions by samuel

[ -d /home/samuel/.bin ] && PATH=/home/samuel/.bin:$PATH
[ -d /home/samuel/bin ] && PATH=/home/samuel/bin:$PATH

if [[ ${TERM} == xterm ]] ; then
   export TERM=xterm-256color
fi

shopt -s extglob
shopt -s cdspell
shopt -s dotglob
shopt -s histappend

set bell-style none

#PS1="\[\033[01;34m\]\w\n\[\033[01;32m\]\u@\h \[\033[01;34m\]> \[\033[00m\]"
# Change the window title of X terminals 
#case $TERM in
#	xterm*|rxvt*|Eterm)
#		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
#		;;
#	screen*)
#		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
#		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"\\"\033k\033\\" '
#		PROMPT_COMMAND='echo -ne "\033k\033\\"'
#		;;
#esac


#if [ -z "$STY" ]; then
#    exec screen -RD
#fi

. /usr/local/lib/python2.7/dist-packages/Powerline-beta-py2.7.egg/powerline/bindings/bash/powerline.sh
