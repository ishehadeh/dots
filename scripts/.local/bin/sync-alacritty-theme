#!/bin/sh

set -ue -o pipefail

set_themes() {
    if [ "$1" == "light" ]; then
        alacritty_theme="catppuccin.frappe.yml"
    else
        alacritty_theme="grubbox.dark.yml"
    fi
    ALACRITTY_THEME_PATH='~/.config/alacritty/themes/'
    sed -i "s#^  - $ALACRITTY_THEME_PATH.*\.yml#  - $ALACRITTY_THEME_PATH$alacritty_theme#" ~/.config/alacritty/alacritty.yml
}

DCONF_KEY='/org/gnome/desktop/interface/color-scheme'

next_line_is_value=0
dconf watch "$DCONF_KEY" | \
while read line; do
    if [ $next_line_is_value -eq 1 ]; then
        dconf_theme=$(echo $line) # get rid of extra '' for strings
        case $dconf_theme in 
            \'prefer-dark\')
                set_themes dark;;
            \'default\')
                set_themes light;;
            *)
                set_themes dark
                echo "unknown theme '$dconf_theme', defaulting to dark";;
        esac
    fi

    if [ "$line" = "$DCONF_KEY" ]; then
        next_line_is_value=1
    else
        next_line_is_value=0
    fi
        
done