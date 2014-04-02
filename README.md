# dotfiles

A gitmirror of my dotfiles

-------------------------------------

don't forget to

    git submodule update --init --recursive
    fc-cache -fv


## configs for (among others)

 * **zsh**
 * **vim** (what else?)
 * **i3** (the window manager)
 * *powerline*

## Mail setup uses

 * *offlineimap* for fetching
 * *msmtp(-queue)* for sending
 * *notmuch* for searching
 * *mutt* and starting with *alot* for reading etc.



# change to vundle cleanup

cat remove_mod.txt | xargs git submodule deinit
cat remove_mod.txt | xargs git rm

