#!/usr/bin/fish
source ~/.config/fish/greeting.fish
source ~/.config/fish/prompt.fish

set -x VISUAL_EDITOR code
set -x EDITOR nvim

set -x GOPATH $HOME/Golang
set -x PATH $PATH $GOPATH/bin
set -x LESS "-R"

alias vim='nvim'
alias vi='nvim'
set -x NVIM_LISTEN_ADDRESS /tmp/nvim_server
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

alias code=code-insiders
alias edit="eval $EDITOR"
alias vedit="eval $VISUAL_EDITOR"
alias ls=ls_extended

alias pip2.7="python2.7 -m pip"
alias pip3="python3 -m pip"
alias pip2="python2 -m pip"
