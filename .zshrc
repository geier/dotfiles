
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
setopt inc_append_history   # save history immediately
#setopt hist_ignore_all_dups # don't save duplicates
setopt hist_no_store        # don't store hist and fc commands
setopt hist_reduce_blanks   # 
setopt append_history       # append history, don't overwrite
setopt hist_ignore_space    # don't save lines with blank as first character, good for clear passwds
setopt notify               # report on background job status immediately
setopt check_jobs           # report on job status when leaving zsh
setopt long_list_jobs       #
setopt cdable_vars          # try to extend args to cd
setopt prompt_subst         # needed for colored prompt
setopt nobeep               # no beeping, honking, whistling... 
# }}}

autoload -U colors && colors
autoload zmv

# Setting and exporting PATH {{{
path=(
    "${KREW_ROOT:-$HOME/.krew}/bin"
    "$HOME/.nixprofile/bin/" "/nix/var/nix/profiles/default/bin"  "/run/current-system/sw/bin"  # setting this here probably shows I don't understand nix well enough yet
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/miniconda3/bin"
    "$HOME/mambaforge/bin/"
    "$HOME/bin/android/tools"
    "$HOME/.npm-packages/bin"
    "/opt/local/bin" "/opt/local/sbin"
    "/usr/local/bin" "/usr/local/sbin"
    "/bin" "/sbin"
    "/usr/bin" "/usr/sbin"
    "/usr/games"
    "/usr/X11/bin"
    "$PATH"
)
export PATH
# }}}

# nix {{{
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi
# End Nix }}}

#eval `dircolors`
# solarized dircolors
# eval `dircolors ~/.dircolors.256dark`

# variables {{{
export EDITOR=vim
export PAGER=less
export BROWSER=firefox
export LANG=en_US.UTF-8
export REPORTTIME=2
# }}}

# bindkeys {{{
bindkey -v # vim mode
# Movement
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history
# Undo
bindkey -a 'u' undo
bindkey -a '^R' redo
# Backspace
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey '\e.' insert-last-word

# Use Ctrl-x,Ctrl-l to get the output of the last command
zmodload -i zsh/parameter
insert-last-command-output() {
LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey "^X^L" insert-last-command-output

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

# }}}

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
   if [[ -e ~/.dircolors.256dark ]]; then
       eval `dircolors ~/.dircolors.256dark`
   fi
elif [[ $OSTYPE == freebsd* ]] || [[ $OSTYPE == darwin* ]]; then
    alias ls='/bin/ls -Gp'
    alias la='/bin/ls -alhGp'
    alias l='/bin/ls -lhGp'
    alias ll='/bin/ls -alhp | /usr/bin/less'
else
    alias ls='/bin/ls -p'
    alias la='/bin/ls -alhp'
    alias l='/bin/ls -lhp'
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
alias gw='git switch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gri="git rebase -i"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gdeletemerged="git branch --merged | egrep -v \"(^\*|master|main|dev)\" | xargs git branch -d"

alias A='sudo aptitude'
alias Ai='sudo aptitude install'
alias As='sudo aptitude search'
alias Ar='sudo aptitude remove'
alias Au='sudo aptitude update'
alias Ag='sudo aptitude upgrade'
alias Ad='sudo aptitude dist-upgrade'

alias k='kubectl'

if type ack-grep > /dev/null; then
	alias ack='ack-grep'
fi

if type nvim > /dev/null; then
    export EDITOR=nvim
fi

if type bat > /dev/null; then
    alias cat='bat'
    export BAT_THEME="gruvbox-dark"
fi

# use neomutt and neovim instead of mutt and vim if available
which neomutt &> /dev/null && alias mutt=neomutt || true
which nvim &> /dev/null && alias vim=nvim || true

#  read documents
alias -s pdf=zathura
alias -s PDF=zathura
alias -s chm=xchm
alias -s djvu=djview

# eigene IP im WAN, falls hinter router
alias myip='lynx -dump checkip.dyndns.org | sed "s/[^0-9]*//" | fgrep .'

# }}}

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

export TERM=xterm-256color

# source fzf history bindings if found
if [[ -e ~/.zsh/fzf/key-bindings.zsh ]]; then
	source ~/.zsh/fzf/key-bindings.zsh
fi

# Prompt {{{
# %n, $USERNAME username
# %m hostname up to first .
# %? return code of last command
# %# # or %
# %B (%b) start (stop) boldface mode
# %S (%s) start (stop) standout mode.
# %(x.true-text.false-text) left ( may be preceded or followed by an int N
#  ? True if exit code of last command was N
#  ! True if shell is running with privileges
# %f resets foreground color

if [[ -e ~/.zsh/zsh-vcs-prompt/zshrc.sh ]]; then
	source ~/.zsh/zsh-vcs-prompt/zshrc.sh
	ZSH_VCS_PROMPT_AHEAD_SIGIL='↑'
	ZSH_VCS_PROMPT_BEHIND_SIGIL='↓'
	ZSH_VCS_PROMPT_STAGED_SIGIL='●'
	ZSH_VCS_PROMPT_CONFLICTS_SIGIL='✖'
	ZSH_VCS_PROMPT_UNSTAGED_SIGIL='✚'
	ZSH_VCS_PROMPT_UNTRACKED_SIGIL='…'
	ZSH_VCS_PROMPT_STASHED_SIGIL='⚑'
	ZSH_VCS_PROMPT_CLEAN_SIGIL='✔'
else
	alias vcs_super_info=test
fi
if [ $SSH_CONNECTION ]; then SSH="%B%n%b@%B%m%b"; else SSH=""; fi

function normal-mode () { echo "-- NORMAL --" }

function set-prompt () {
    case ${KEYMAP} in
      (vicmd)      VI_MODE="$(normal-mode)" ;;
      (main|viins) VI_MODE="%~" ;;
      (*)          VI_MODE="%~" ;;
    esac
    }
PROMPT='%(!.%F{red}%SROOT%s%f@%B%m%b.$SSH)$(vcs_super_info)%(?..[%F{red}%?%f])%# '
RPROMPT='$VI_MODE'

function zle-line-init zle-keymap-select {
    set-prompt
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
# }}}

# farbige man-pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export LESS=XFRaeiM

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Completions {{{
# add custom completion scripts
fpath=(~/.zsh/completion ~/zsh/ $fpath)

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

compile=(install clean remove uninstall deinstall)
compctl -k compile make

autoload -Uz compinit
compinit
# }}}

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# python {{{
[ -d ~/python ] && export PYTHONPATH=~/python
export WORKON_HOME=~/.virtualenvs

# find virtualenwrapper.sh, if it exists, source it
which virtualenvwrapper.sh > /dev/null && source `which virtualenvwrapper.sh`
[ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ] && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
[ -x /usr/local/bin/virtualenvwrapper.sh ] && sourcVe /usr/local/bin/virtualenvwrapper.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/cg/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/cg/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/cg/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/cg/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# }}}

# Funktionen {{{
# Usage: extract <file>
# Description: extracts archived files (maybe)
extract () {
	if [[ -f $1 ]] then
		if [[ -x /usr/bin/pbzip2 || -x /usr/local/bin/pbzip2 ]] then
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
    if [[ $OSTYPE == linux-gnu ]] || [[ $OSTYPE == linux ]]; then
        FIRSTARG=''
        SECONDARG=('-regextype' 'posix-extended')
    elif [[ $OSTYPE == freebsd* ]] || [[ $OSTYPE == darwin* ]]; then
        FIRSTARG='-E'
        SECONDARG=''
    fi
    find $FIRSTARG . -maxdepth 1 $SECONDARG -regex '.*\.(log|nav|snm|toc|cp|fn|tp|vr|pg|bbl|#|blg|ilg|dvi|out|-blx.bib|bcf|fls|fdb_latexmk|aux)' -exec rm -vf {} \;
    find . -maxdepth 1 -type d -name "auto" -exec rm -vfr {} \;
}

psgrep() {
	if [ ! -z $1 ] ; then
		ps aux | grep $1 | grep -v grep
	else
		echo "!! Need name to grep for"
	fi
}

pskill() {
	if  [ ! -z $1 ] ; then
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
	mv -iv "$1" "${1// /_}" ;
}

# zd 
if [[ -e ~/.zsh/z/z.sh ]]; then
	export _Z_CMD=zd
	. ~/.zsh/z/z.sh
fi

# 2011-10-19: tmux shortcut for creating/attaching named sessions 
# cannot remember where I stole it from
tm() {
	[[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }
	print -Pn "\e]0;tmux: $1\a"  # set the icon and terminal's title
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

sudo() {  # sudo vi/vim => sudoedit (only if sudoedit exists)
    [[ $1 == (vi|vim) ]] && (( $+commands[sudoedit] )) && shift && sudoedit "$@" || command sudo "$@";
}


# Go up N directories
# usage: up N
# taken from https://github.com/anishathalye/dotfiles/commit/c7256407e27263abc21bed2667a81373fa958d25#diff-1f7e07657816dcfba81e81892df0eac7R30
function up()
{
    if [[ "${1}" == "" ]]; then
        cd ..
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    elif ! [[ "${1}" -gt "0" ]]; then
        echo "Error: argument must be positive"
    else
        for i in {1..${1}}; do
            cd ..
        done
    fi
}

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

# STARTUP
zstyle :omz:plugins:ssh-agent identities id_rsa id_github

# set the terminal's title to the current command {{{
# despite its name, it works in most terminals
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn '\e]0;%~ \a'
}
function xterm_title_preexec () {
	print -Pn '\e]0;%~: '
	print -n "${(q)1}\a"
}
if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi
# }}}

# vim: foldmethod=marker
