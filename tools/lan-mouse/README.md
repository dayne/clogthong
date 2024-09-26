# Lan-mouse

Alternative to Barrier.
https://github.com/feschber/lan-mouse


## Tasks

### Ubuntu-Deps

```sh
sudo apt update
sudo apt install -y libadwaita-1-dev libgtk-4-dev libx11-dev libxtst-dev
```

### Clone-Build

```sh
if [ ! -d $HOME/repos ]; then
    mkdir $HOME/repos
fi

cd $HOME/repos
if [ ! -d lan-mouse ]; then
    git clone https://github.com/feschber/lan-mouse.git
fi
```

### Cargo-Install
depends: Ubuntu-Deps

```
if command -v cargo > /dev/null; then
    cargo install lan-mouse
else
    echo "error: missing cargo - unable to use for install"
fi
```
