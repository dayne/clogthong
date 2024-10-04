# TMUX


## Tasks


### Install

```
sudo apt install tmux
```


### TPM
tmux plugin manager

```bash
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
    echo "Skipped clone - tpm exists in ~/.tmux/plugins"
fi
```

