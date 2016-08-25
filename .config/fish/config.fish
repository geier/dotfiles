# fish git prompt
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_dirtystate red

#set __fish_git_prompt_char_cleanstate '✔'

set PATH ~/bin $PATH

# don't forget to `pip install virtualfish`
eval (python -m virtualfish)


# old aliases imported from my zshrc
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

alias errcat='less *.err(L+0)'
#alias ipython='PAGER=more ipython'

alias cs='condor_status'
alias cq='condor_q'

if status --is-interactive
  keychain --eval --quiet -Q id_rsa | source
end
