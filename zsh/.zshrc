# zmodload zsh/zprof

# zprof

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand suffix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/ian/.zshrc'

fpath=(~/.config/zsh/completions $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt autocd extendedglob nomatch notify
unsetopt beep

# Load Prompts
fpath=(~/.config/zsh/prompts $fpath)
autoload -U promptinit
promptinit

# Load Widgets
fpath=(~/.config/zsh/widgets $fpath)
for widget in $(ls ~/.config/zsh/widgets); do
    case "$widget" in
        *".disabled") continue ;;
    esac

    autoload -U "$widget"
    zle -N "$widget"
done

# ZLE
# ----------------

# Emacs Editing Mode
bindkey -e

# Navigate Words with Ctrl-[Left|Right]
bindkey ';5C' forward-word
bindkey ';5D' backward-word

# Search history on up/down
bindkey '^[[A' atuin-up-line-or-search
bindkey '^[[B' atuin-down-line

_atuin_reset_hist_pos() { 
    _atuin_hist_pos=0
}
typeset -a precmd_functions
precmd_functions+=(_atuin_reset_hist_pos)

prompt simple

# History
# -----------------
 
HISTFILE="$HOME/.histfile"
HISTSIZE="4294967295" # max histsize is UINT32_MAX (at least on my system...)
SAVEHIST="$HISTSIZE"

# Environemnt
# ------------------
## XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

## Locale

export LANG="en_US.UTF-8"
export LC_CTYPE="$LANG"

## Applications
command_exists() { (( $+commands[$1] )); }
for editor in micro nvim vim nano vi; do
    if command_exists "$editor"; then
        export VISUAL="$editor"
        break
    fi
done
if ! [[ -v VISUAL ]]; then
    echo "WARNING: could not find an editor, leaving \$EDITOR and \$VISUAL unset"
else
    export EDITOR="$VISUAL"
fi

export PAGER="less"

## Application Config

# LESS. enable mouse, disable bell, forward color escape sequences
export LESS="--mouse --quiet --RAW-CONTROL-CHARS"

## User-local Paths
# prioritize ~/.local/bin over system paths
export PATH="$HOME/.local/bin:$PATH" 

command_exists cargo && test -d ~/.cargo/bin && export PATH="$HOME/.cargo/bin:$PATH"

## Set hledger journal
export LEDGER_FILE="$HOME/.ledger/main.journal"

export GUILE_LOAD_COMPILED_PATH="$GUILE_LOAD_COMPILED_PATH:/usr/lib64/guile/3.0/site-ccache"
export GUILE_LOAD_PATH="$GUILE_LOAD_PATH:/usr/share/guile/site/3.0"

alias trim="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'"

if [ -f ~/.npmrc ]; then
    # npm config get prefix is really slow, so just get it the hacky way with grep
    npm_prefix="$(awk -F= '$1 = "pefix" { print $2 }' ~/.npmrc | trim)"
    if [[ -n "$npm_prefix" ]]; then
        export PATH="$PATH:$npm_prefix/bin"

        # Preserve MANPATH if you already defined it somewhere in your config.
        # Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
        export MANPATH="${MANPATH-$(manpath)}:$npm_prefix/share/man"
    fi
fi


# Ruby

if command_exists rbenv; then
	eval "$(rbenv init -)"
fi

# Aliases
# ------------------

# Always use a common terminal when ssh'ing
alias ssh="TERM=xterm ssh"

# Language Version Manager Config
# ------------------

test -f "$HOME/.ghcup/env" && source "$HOME/.ghcup/env"

# Functions
# ------------------

if command_exists mise; then
    eval "$(mise activate)"
fi
