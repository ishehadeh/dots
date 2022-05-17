# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand suffix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/ian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt autocd extendedglob nomatch notify
unsetopt beep

# Load Prompts
fpath=(~/.config/zsh/prompts $fpath)
autoload -U promptinit
promptinit

# ZLE
# ----------------

# Emacs Editing Mode
bindkey -e

# Navigate Words with Ctrl-[Left|Right]
bindkey ';5C' forward-word
bindkey ';5D' backward-word

# Search history on up/down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

prompt simple

# History
# -----------------
 
HISTFILE="$HOME/.histfile"
HISTSIZE="$((1 << 32 - 1))" # max histsize is UINT32_MAX (at least on my system...)
SAVEHIST="$HISTSIZE"

# Environemnt
# ------------------
## XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

## Locale

export LANG="en_US.UTF-8"
export LC_CTYPE="$LANG"

## Utility Functions
exists() { (( $+commands[$1] )); }

## Applications
export VISUAL="micro"
export EDITOR="$VISUAL"
export PAGER="less"
export TERM="alacritty"

## Application Config

# LESS. enable mouse, disable bell, forward color escape sequences
export LESS="--mouse --quiet --RAW-CONTROL-CHARS"

## User-local Paths
export PATH="$HOME/.local/bin:$PATH" # prioritize ~/.local/bin over system paths

## Set hledger journal
export LEDGER_FILE="$HOME/.ledger/.hledger.journal"

# Aliases
# ------------------

alias copy="xclip -selection clipboard -in"
alias paste="xclip -selection clipboard -out"

# Functions
# ------------------

# source: https://github.com/sfinktah/bash/blob/master/rawurlencode.inc.sh
urlencode() {
    while read -r -k 1 -u 0 -d "\000" c; do
        case "$c" in 
            [-_.~a-zA-Z0-9]) 
                echo -n "$c" 
                ;;
            *) 
                printf '%%%02x' "'$c"
                ;;
        esac
    done 
}

urldecode() {
    while read -r -k 1 -u 0 -d "\000" c; do
        case "$c" in 
           %) 
                read -r -k 2 -u 0 -d "\000" ccode
                echo -n "\x$ccode"
                ;;
            *) 
                echo -n "$c" 
                ;;
        esac
    done
}

'='() {
    bc -l <<<"$@"
}

