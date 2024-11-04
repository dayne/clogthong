#!/usr/bin/bash
# lives in $HOME/.bash.d/chruby.sh
# 
# Hacking & want to test hacks - try this funny dance:
# CMD="chruby.sh" # be in the same dir as the script
# docker run -it --rm -v "$(pwd)/${CMD}:/${CMD}" ubuntu bash 
# # now inside that docker instance test it out:
# . chruby.sh

function ct-install-ruby() {
  echo "###############################################"
  echo "# ruby-install install running                #"
  echo "# https://github.com/postmodern/ruby-install  #"
  echo "###############################################"
  sleep 1
  echo "Apt install for the library and build dependancies" 
  if ! command -v sudo > /dev/null; then
    # needed for docker test environment
    apt update && apt install -y sudo
  fi
  sudo apt update
  if [ $? -eq 0 ]; then
    echo "apt cache updated"
  else
    echo "Error: unable to run sudo apt update"
    exit 1
  fi
  sudo apt-get install wget git curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev zlib1g libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config
  
  if [ $? -eq 0 ]; then
    echo "Library and build dependancies are available"
  else
    echo "Error: unable to install needed build dependancies"
    read -p "Do you want to continue? (Y/y/yes to proceed): " answer
    case $answer in
        [Yy][Ee][Ss]|[Yy])
            echo "Continuing..."
            ;;
        *)
            echo "Exiting..."
            exit 1
            ;;
    esac
  fi
  pushd . > /dev/null
  if [ ! -d $HOME/.local/share/ruby-install ]; then
    echo "# mkdir -p $HOME/.local/share/ruby-install    #"
    sleep 0.5
    mkdir -p $HOME/.local/share/ruby-install
  fi
  cd $HOME/.local/share/ruby-install
  local RBI_VER="0.9.3"
  echo "# wget ruby-install-$RBI_VER.tar.gz           #"
  wget -q "https://github.com/postmodern/ruby-install/releases/download/v${RBI_VER}/ruby-install-${RBI_VER}.tar.gz"
  if [ $? -eq 0 ]; then
    echo "# DOWNLOADED: ruby-install-$RBI_VER.tar.gz    #"
  else
    echo "# Failed download                             #"
    return 1
  fi

  tar -xzvf ruby-install-$RBI_VER.tar.gz
  if [ $? -eq 0 ]; then
    cd ruby-install-$RBI_VER/
  else
    echo "# Failed tar xvfz                             #"
    return 1
  fi

  PREFIX="$HOME/.local" make install
  if [ $? -eq 0 ]; then
    echo "ruby-install-$RBI_VER installed"
  else
    echo "SAD: ruby-install-$RBI_VER failed to install"
    return 1
  fi

  echo $PATH | grep ".local/bin" > /dev/null
  if [ ! $? -eq 0 ]; then
    echo "Warning: $HOME/.local/bin not in PATH. Not attempting chruby install"
    exit 1
  fi

  if [ ! -d $CT_CHRUBY_INSTALL_DIR ]; then
    mkdir -p $CT_CHRUBY_INSTALL_DIR
  fi

  cd $CT_CHRUBY_INSTALL_DIR

  CHRUBY_VERSION="0.3.9"
  # wget or clone? how to pick latest version?
  CHRUBY_URL="https://github.com/postmodern/chruby/releases/download/v${CHRUBY_VERSION}/chruby-${CHRUBY_VERSION}.tar.gz"
  wget --quiet -O chruby-${CHRUBY_VERSION}.tar.gz  $CHRUBY_URL
  if [ ! $? -eq 0 ]; then
    echo "Failed to download chruby: $CHRUBY_URL"
    exit 1
  fi

  tar -xzvf chruby-${CHRUBY_VERSION}.tar.gz
  if [ ! $? -eq 0 ]; then
    echo "Failed to tar xvfz chruby-${CHRUBY_VERSION}"
    exit 1
  fi

  cd chruby-${CHRUBY_VERSION}
  if [ ! $? -eq 0 ]; then
    echo "failed to enter chruby-${CHRUBY_VERSION}"
    exit 1
  fi
  PREFIX="$HOME/.local" make install
  if [ ! $? -eq 0 ]; then
    echo "Failed to install chruby: PREFIX=$HOME/.local make install"
    exit 1
  fi

  # just make sure that new bin dir is in path now
  if [ -d $HOME/.local/bin ]; then
    echo "bin check"

    echo $PATH | grep ".local/bin" > /dev/null
    if [ $? -ne 0 ]; then
      export PATH=$PATH:$HOME/.local/bin
    fi
  fi

  if [ -f $HOME/.ruby-version ]; then
    ruby-install -U
    ruby-install $(cat $HOME/.ruby-version)
  else
    echo "no $HOME/.ruby-version exists"
    ruby-install ruby
  fi

  popd > /dev/null
  return 0
}

CT_CHRUBY_INSTALL_DIR="$HOME/.local/share/chruby"

if [ -d $HOME/.local/bin ]; then
  echo $PATH | grep ".local/bin" > /dev/null
  if [ $? -ne 0 ]; then
    export PATH=$PATH:$HOME/.local/bin
  fi
fi

if ! command -v ruby-install > /dev/null ; then
  echo "Missing ruby-install: FIX: ct-install-ruby"
else
  unset -f ct-install-ruby
fi

if [ -f $CT_CHRUBY_INSTALL_DIR/chruby.sh ]; then
  unset CT_CHRUBY_INSTALL_DIR # clean up name space
  unset -f ct-install-chruby
  source $HOME/.local/share/chruby/chruby.sh
  if [ -f $HOME/.ruby-version ]; then
    chruby `cat $HOME/.ruby-version`
    if [ $? -eq 0 ]; then
      #echo "chruby `cat $HOME/.ruby-version`"
      true
    else
      echo "FAILED: chruby `cat $HOME/.ruby-version`"
    fi
  else
    echo "Warning: Missing $HOME/.ruby-version"  
  fi
  source $HOME/.local/share/chruby/auto.sh
else
  if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    # The script is being sourced.
    echo "Warning: Missing chruby.  Fix this with: ct-install-ruby"
  else
    # The script is being executed. so just run it
    ct-install-ruby
  fi
fi
