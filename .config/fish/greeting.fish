function readme_tagline
   set -l taglines (cmark $argv[1] | pcregrep -Muo '(?<=\<p\>)(.*?)((\n)|(?=\<\/p\>))' 2> /dev/null)

    for tagline in $taglines
        if test -z "$tagline"; continue; end
        set -l stripped_tagline (printf $tagline | sed -e 's/<[^>]*[^<]*//g' -e '/<[a-zA-Z]+>/,/<\/[a-zA-Z]+>/p' | tr -d '[:space:]') 
        if test -n "$stripped_tagline"
            if test "." != (printf "%s" "$tagline" | tail -c1); set tagline "$tagline..."; end
            echo "$tagline" | sed -e 's/<[^>]*>//g'
            return
        end 
    end
end


function fish_greeting
    status --is-login
    if test $status -eq 0 
        return;
    end 

    if test -n "$PROJ_CURRENT_PROJECT_NAME"
        set_color --bold cyan
        figlet -fsmslant "$PROJ_CURRENT_PROJECT_NAME"
        set_color white

        set -l readme 
        for f in readme.md readme readme.txt
            set readme (find . -maxdepth 1  -type f -iname "$f")
            if test -n "$readme";
                set -l left_quote (printf "\u201C")
                set -l right_quote (printf "\u201D")
                set -l tagline (readme_tagline $readme)

                if test -n "$tagline"
                    echo
                    printf "   $left_quote%s$right_quote\n" "$tagline"
                    echo   "      ~~ readme"
                    break
                end
            end
        end

        echo
        set_color reset
    else
        ~/.motd
    end
end
