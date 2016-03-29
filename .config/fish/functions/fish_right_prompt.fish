function fish_right_prompt -d "Write out the right prompt"
    echo -n (pwd | sed -e "s|^$HOME|~|")
end
