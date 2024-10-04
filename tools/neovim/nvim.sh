if command -v nvim > /dev/null; then
  alias vi=nvim
  alias vim=nvim
else
  echo "warning: neovim not installed: sudo apt install neovim"
fi

if ! command -v rg > /dev/null; then
  echo "warning: missing ripgrep: sudo apt install ripgrep"
fi
