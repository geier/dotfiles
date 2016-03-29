# fish git prompt
set __fish_git_prompt_show_informative_status = 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡ '
set __fish_git_prompt_char_stagedstate '→ '
set __fish_git_prompt_char_stashstate '↩ '
set __fish_git_prompt_char_upstream_ahead '↑ '
set __fish_git_prompt_char_upstream_behind '↓ '
set __fish_git_prompt_char_dirtystate '✚ '
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_char_untrackedfiles '… '
set __fish_git_prompt_char_cleanstate '✔ '

# don't forget to `pip install virtualfish`
eval (python -m virtualfish)
