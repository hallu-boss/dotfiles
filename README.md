# DOTFILES

**Dependencies**
- nvim
- alacritty
- ripgrep
- stow

```bash
rm -rf ~/.config/nvim ~/.config/alacritty
mv ~/.bashrc{,.bak}

stow --dotfiles .
```
