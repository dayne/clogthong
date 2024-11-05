# go-lang
if [[ -d $HOME/.go && -f $HOME/.go/bin/go ]]; then
  export GOROOT=$HOME/.go
  export PATH=$GOROOT/bin:$PATH
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH
fi
