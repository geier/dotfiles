# options {{{
HISTFILE=$HOME/.zsh_history
SAVEHIST=65536
HISTSIZE=100000
DIRSTACKSIZE=10

if [[ $USER == root ]]; then
    TMOUT=300
fi

setopt auto_cd              # change to dir without using cd
setopt auto_pushd           # push old idr on dir stack
unset MAILCHECK             # no MailChecks
setopt complete_in_word     # don't jump to end of word on [TAB]
#setopt rm_star_wait         # waits on rm *
unset correct               # tries to correct the spelling
setopt glob_dots            # no leading . for explicit matching
setopt extended_glob        # 
setopt share_history        # share history between multiply running zsh
setopt extended_history     # safe time and length of execution
setopt hist_ignore_all_dups # don't save duplicates
setopt hist_no_store        # don't store hist and fc commands
setopt hist_reduce_blanks   # 
setopt append_history       # append history, don't overwrite
setopt hist_ignore_space    # don't save lines with blank as first charakter, good for clear passwds
setopt notify               # report on background job status immediately
setopt check_jobs           # report on job status when leaving zsh
setopt long_list_jobs       #
setopt cdable_vars          # try to extend args to cd
setopt prompt_subst         # needed for colored prompt
setopt nobeep               # no beeping, honking, whistling... }}}

autoload -U colors && colors
autoload zmv
autoload -U compinit && compinit

export PATH="/opt/local/bin:/opt/local/sbin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/games:/usr/X11/bin:$HOME/bin/android/tools"


#eval `dircolors`

# solarized dircolors
# eval `dircolors ~/.dircolors.256dark`




export EDITOR=vim
export PAGER=less
export BROWSER=firefox
export LANG=en_US.UTF-8
export REPORTTIME=2

bindkey -v # vim mode
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line



# alias {{{
# bsd und gnu ls fressen verschiedene optionen *kotz* 
if [[ $OSTYPE == linux-gnu ]] || [[ $OSTYPE == linux ]]; then

    alias ls='/bin/ls -p --color'
    alias la='/bin/ls -alhp --color'
    alias l='/bin/ls -lhp --color'
    alias ll='/bin/ls -alph --color | less -r'
    alias lssmall='/bin/ls -alhS |tail -n12 | head -n10'
    alias lsbig='/bin/ls -alhS |head -n11'
    # solarized dircolors
    eval `dircolors ~/.dircolors.256dark`

else
    alias ls='/bin/ls -Gp'
    alias la='/bin/ls -alhGp'
    alias l='/bin/ls -lhGp'
    alias ll='/bin/ls -alhp | /usr/bin/less'
fi


alias lsnew='/bin/ls -lhtp | head'
alias lsold='/bin/ls -lhtp | tail'


alias c='clear'



alias ..='cd ..'
alias ...='cd ../..'

alias z='vim ~/.zshrc'
alias v='vim ~/.vimrc'
alias utar='tar -xvzf'
alias bc='bc -l'
alias t='task'
alias tw='task list +work'

alias mmv='noglob zmv -W'
alias zln='zmv -L'
alias zcp='zmv -C'

alias j='jobs -l'

alias g='git'
alias ga='git add'
alias gs='git status'
alias gc='git checkout'
alias gl='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch --color=auto'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

alias A='sudo aptitude'
alias Ai='sudo aptitude install'
alias As='sudo aptitude search'
alias Ar='sudo aptitude remove'
alias Au='sudo aptitude update'
alias Ag='sudo aptitude upgrade'
alias Ad='sudo aptitude dist-upgrade'
alias pi='pip install'

alias cok='colout OK 28'
alias cerror='colout Error 1'

#alias ipython='PAGER=more ipython'

if [[ -x /usr/bin/tmux || -x /usr/local/bin/tmux ]]; then 
	alias screen='echo "all the cool kids are using tmux!"'
fi
alias cs='condor_status'
alias cq='condor_q'


if [[ -x /usr/bin/ack-grep ]]; then
	alias ack='ack-grep'
fi

  #read documents
alias -s pdf=zathura
alias -s PDF=zathura
alias -s chm=xchm
alias -s djvu=djview


# }}}



###
# See if we can use colors.
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"

###
# Decide if we need to set titlebar text.
case $TERM in
xterm*)
    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
;;
screen)
    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
;;
*)
    PR_TITLEBAR=''
;;
esac


export TERM=xterm-256color
###
# Decide whether to set a screen title
if [[ "$TERM" == "screen" ]]; then
PR_STITLE=$'%{\ekzsh\e\\%}'
else
PR_STITLE=''
fi

# %n, $USERNAME username
# %m hostname up to first .
# %? return code of last command
# %# # or %
# %B (%b) start (stop) boldface mode
# %S (%s) start (stop) standout mode.
# %(x.true-text.false-text) left ( may be preceded or followed by an int N
#  ? True if exit code of last command was N
#  ! True if shell is running with privileges


if [[ -e ~/.zsh/git-prompt/zshrc.sh ]]; then 
	setopt prompt_subst
	source ~/.zsh/git-prompt/zshrc.sh
else
	alias git_super_status=test
fi

if [ $SSH_CONNECTION ]; then SSH="%B%n%b@%B%m%b"; else SSH=""; fi

#PROMPT='%(?..$PR_RED%?\
#
#)%{$reset_color%}%(!.$PR_RED%SROOT%s.%B%n)%b@%B%{$SSH%}%b%(!.$PR_RED.)$(git_super_status)%# $PR_NO_COLOUR'

PROMPT='%(?..$PR_RED%?\

)%{$reset_color%}%(!.$PR_RED%SROOT%s$PR_NO_COLOUR@%B%m%b.$SSH)$(git_super_status)%# '

RPROMPT='%~'

# }}}

compile=(install clean remove uninstall deinstall)
compctl -k compile make

bindkey "^[[A" history-beginning-search-backward            # [arrow-up]
bindkey "^[[B" history-beginning-search-forward      # [arrow-down]
bindkey "^?" backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^Z"    which-command               # <STRG>-Z
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line


run-with-sudo() { LBUFFER="sudo $LBUFFER" }
zle -N run-with-sudo
bindkey '^Xs' run-with-sudo

# farbige man-pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
[ $DISPLAY ] || export DISPLAY=:0.0

export LESS=XFRaeiM

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# eigene IP im WAN, falls hinter router
alias myip='lynx -dump checkip.dyndns.org | sed "s/[^0-9]*//" | fgrep .'

# Completions


#kill completions
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' insert-ids menu
zstyle ':completion:*:*:kill:*' menu yes select=2
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zshcompcache
zstyle ':completion::complete:*' rehash true

##kill completion for ALL processes owned by me..
zstyle ':completion:*:kill:*:processes' command 'ps -u $USER -o pid,s,nice,stime,args'

# The following lines were added by compinstall

zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
#zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}" 'ma=01;41'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' '+m:{a-zA-Z}={A-Za-z} l:|=* r:|=*'
zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s


autoload -Uz compinit
compinit
# End of lines added by compinstall


export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

#PYTHON

[ -d ~/python ] && export PYTHONPATH=~/python
export WORKON_HOME=~/.virtualenvs
export PATH=~/.local/bin:$PATH
[ -x /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
[ -f /etc/bash_completion.d/virtualenvwrapper ] && source /etc/bash_completion.d/virtualenvwrapper

# Maschinen spezifisches {{{ 
if [[ `uname -n` == "yvonne" || `uname -n` == "theseus" ]]
    then
        export CPLUS_INCLUDE_PATH=/usr/local/include/:$CPLUS_INCLUDE_PATH
        #source /usr/condor/condor.sh
        export LIBRARY_PATH=/usr/local/lib/:$LIBRARY_PATH
        alias pidgin='pidgin -f'
fi

if [[ `uname -n` == "oberon" ]]
    then
        #export LIBRARY_PATH="/sw/include:/sw/lib"
        #alias vim="vim -X"
fi

if [[ `uname -n` == "brutus.lostpackets.de" ]]
    then
        # für abby ocr
        export LD_LIBRARY_PATH=/opt/ABBYYOCR:$LD_LIBRARY_PATH
	#alias rm='trash-put'
	export PATH=/usr/local/texlive/2012/bin/amd64-freebsd:$PATH
    fi

if [[ `uname -n` == "theseus" ]]
then
	export PATH=/usr/local/texlive/2011/bin/x86_64-linux:$PATH
	export MANPATH=/usr/local/texlive/2011/texmf/doc/man:$MANPATH
	export INFOPATH=/usr/local/texlive/2011/texmf/doc/info:$INFOPATH
	export TEXMFCNF="/usr/local/texlive/2011/texmf/web2c"
	#alias rm='trash'
fi
#}}}


# Funktionen {{{
# Usage: extract <file>
# Description: extracts archived files (maybe)
  extract () {
        if [[ -f $1 ]]
        then
		if [[ -x /usr/bin/pbzip2 || -x /usr/local/bin/pbzip2 ]]
		then
			BZIP=pbzip2
		else
			BZIP=bzip2
		fi
                case $1 in
                        *.tar.bz2)  `$BZIP -v -d $1`    ;;
                        *.tar.gz)   tar -xvzf $1        ;;
                        *.rar)      unrar x $1          ;;
                        *.deb)      ar -x $1            ;;
                        *.bz2)      `$BZIP -d $1`       ;;
                        *.lzh)      lha x $1            ;;
                        *.gz)       gunzip -d $1        ;;
                        *.tar)      tar -xvf $1         ;;
                        *.tgz)      tar -xvzf $1        ;;
                        *.tbz2)     tar -jxvf $1        ;;
                        *.zip)      unzip $1            ;;
                        *.Z)        uncompress $1       ;;
                        *.xz)       xz -d $1            ;;
                        *)          echo "'$1' Error. Please go away" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
  }

  rmtex() {
      find . -maxdepth 1 -regex ".*\(\~\|\.log\|\.nav\|\.snm\|\.toc\|\.cp\|\.fn\|\.tp\|\.vr\|\.pg\|\.bbl\|\#\|\.blg\|\.ilg\|\.dvi\|\.aux\)" -exec rm -vf {} \; ; find . -maxdepth 1 -type d -name "auto" -exec rm -vfr {} \;}


psgrep() {
	if [[ -x /bin/pgrep || -x /usr/bin/pgrep ]]; then
		echo "please get used to pgrep"
		return 1
	elif [ ! -z $1 ] ; then
		ps aux | grep $1 | grep -v grep
	else
		echo "!! Need name to grep for"
	fi
}

pskill() {
	if [[ -x /bin/pkill || -x /usr/bin/pkill ]]; then
		echo "please get used to pkill"
		return 1
	elif  [ ! -z $1 ] ; then
		kill -9 `ps aux | grep $1 | grep -v grep  | awk '{ print $2}'`
	else 
		echo "!! Need name to grep for"
	fi
}

mcd () {
    mkdir "$@" && cd "$@"
}

qrdisplay() {         
    qrencode -o - "$1" | display
}

unspace() {
mv -iv "$1" "${1// /_}" ; }

# zd 
if [[ -e ~/.zsh/z/z.sh ]]; then
	export _Z_CMD=zd
	. ~/.zsh/z/z.sh
fi

# 2011-10-19: tmux shortcut for creating/attaching named sessions 
# cannot remember where I stole it from
  tm() {
    [[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }
    tmux has -t $1 && tmux attach -t $1 || tmux new -s $1
  }

function __tmux-sessions() {
    local expl
    local -a sessions
    sessions=( ${${(f)"$(command tmux list-sessions 2> /dev/null)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}
compdef __tmux-sessions tm

# tab on empty command line lists dir contents
  complete-or-list() {
    [[ $#BUFFER != 0 ]] && { zle complete-word ; return 0 }
    echo
ls
    zle reset-prompt
  }
  zle -N complete-or-list
  bindkey '^I' complete-or-list


# taken http://stackoverflow.com/questions/171563/whats-in-your-zshrc/904023#904023
function most_useless_use_of_zsh {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done

}


# }}}
