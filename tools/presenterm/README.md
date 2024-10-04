# presenterm

https://mfontanini.github.io/presenterm/

https://github.com/mfontanini/presenterm/tree/master/examples

## Tasks

### Install Locked

```
cargo install --locked presenterm
```


### Install Latest

```
cargo install --git https://github.com/mfontanini/presenterm
```

### Clone Repo Examples

```
cd $HOME
mkdir -p $HOME/repos
cd $HOME/repos
if [ ! -d presenterm ]; then
    git clone https://github.com/mfontanini/presenterm.git
fi
echo cd $HOME/repos/presenterm/examples
echo presenterm demo.md
```
