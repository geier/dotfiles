# my dotfiles

## configs for (among others)

 * **zsh**
 * **vim**
 * **i3** (the window manager)

## Mail setup uses

 * *offlineimap* for fetching
 * *msmtp(-queue)* for sending
 * *notmuch* for searching
 * *mutt* and starting with *alot* for reading etc.



## initialize vundle:
# Initialization

    git submodule update --init --recursive
    fc-cache -fv
    

open vim:
     :PlugInstall
