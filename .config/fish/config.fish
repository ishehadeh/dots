set -x GOPATH "$HOME/Golang"
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x PATH "$PATH" "$GOPATH/bin"

alias code code-insiders
alias vi    nvim
alias vim   nvim
alias edit  nvim
alias vedit code
