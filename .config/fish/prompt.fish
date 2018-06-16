function new_section 
    set_color "$argv[1]" 
    set_color -r 
    printf "\ue0b0"
    set_color normal
    set_color -b "$argv[1]"
    set_color "white"
end

function fish_prompt --description "Write out the prompt"
    new_section cyan
    printf " $USER@"(prompt_hostname)" "
    if test -n "$PROJ_CURRENT_PROJECT_NAME"
        new_section blue
        printf " $PROJ_CURRENT_PROJECT_NAME"
        if test -d "$PROJ_CURRENT_PROJECT_BASE"/.git
            set_color bryellow
            printf " ->  "(git rev-parse --abbrev-ref HEAD)
            set_color white
        end
        printf " "
        new_section red
        printf " %s " (string replace "$PROJ_CURRENT_PROJECT_BASE" "" "$PWD/")
    else
        new_section red
        printf " %s " (prompt_pwd)
    end
    set_color reset
    set_color red
    printf "\ue0b0 "
    set_color reset
end
