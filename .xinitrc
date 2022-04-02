alacritty &
mkdir -p ~/.local/share/picom
picom --log-file ~/.local/share/picom/picom.log --write-pid-path ~/.local/share/picom/picom.pid &
exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
