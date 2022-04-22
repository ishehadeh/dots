mkdir -p ~/.local/share/picom
mkdir -p ~/.cache/xsettingsd

picom --log-file ~/.local/share/picom/picom.log --write-pid-path ~/.local/share/picom/picom.pid &
xsettingsd >~/.cache/xsettingsd/xsettingsd.log &
exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
