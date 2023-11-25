# Ian's Configuration Files

## Installation

Run

```sh
stow [CONFIGS] [CONFIG...]
```

Where `CONFIGS` is a list of any of the directories in this repo.

## Software

### Terminal: Alacritty

**Dependencies**:

- `alacritty`
- `tmux` The alacritty config launches tmux instead of the default shell
- `Iosevka Term` (Font) The configured font.

### Tmux

**Dependencies**:

- `tmux`
- `copy`, `paste` scripts (run `stow scripts` before tmux).

### ZSH

Set the default shell with `chsh ian -s /bin/zsh`

**Dependencies**:

- `zsh`

**Optional**

- `atuin` Better reverse-search behavior.

### TexStudio

**Dependencies**

- `texlive` (or another latex distro)

Useful arch packages:
`texlive-basic texlive-mathscience texlive-latex texlive-latexextra texlive-latexr ecommended`
