#!/usr/bin/bash

if ! command -v tmux; then
    sudo apt install -y tmux
else
    echo "skipping install.. tmux detected"
fi

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
    echo "skipping tpm install .. exists in ~/.tmux/plugins already"
fi

if grep '^# clogthong tmux-plugins/tpm' ~/.tmux.conf; then
    echo "skipping tpm setup: detected already in ~/.tmux.conf"
else
    echo "
# clogthong tmux-plugins/tpm setup
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
" >> ~/.tmux.conf
fi

# Initialize variables for plugins to install
cat=""      # catpguucccim/tmux
yank=""     # tmux-yank
sense=""    # tmux sensible # vim keybindings navigation
vim=""      # tmux vim 



