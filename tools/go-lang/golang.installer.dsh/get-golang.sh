#!/usr/bin/bash
source $(t3x -T)
set -e

# inspired areas:
# https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh

GOROOT=${GOROOT:-"$HOME/.go"}
GOPATH=${GOPATH:-"$HOME/go"}
GO_VERSION="1.23.2"

get_platform() {
  if ! command -v uname > /dev/null; then
    echo "Error: We dont' have uname"
    exit 1
  fi

  OS="$(uname -s)"
  ARCH="$(uname -m)"

  case $OS in
      "Linux")
          case $ARCH in
          "x86_64")
              ARCH=amd64
              ;;
          "aarch64")
              ARCH=arm64
              ;;
          "armv6" | "armv7l")
              ARCH=armv6l
              ;;
          "armv8")
              ARCH=arm64
              ;;
          "i686")
              ARCH=386
              ;;
          .*386.*)
              ARCH=386
              ;;
          esac
          PLATFORM="linux-$ARCH"
      ;;
      "Darwin")
            case $ARCH in
            "x86_64")
                ARCH=amd64
                ;;
            "arm64")
                ARCH=arm64
                ;;
            esac
          PLATFORM="darwin-$ARCH"
      ;;
  esac
  echo $PLATFORM
}

get_go_version() {
  # https://go.dev/dl/ 
  echo $GO_VERSION
}

get_go_package_url() {
  local version="$(get_go_version)"
  local platform="$(get_platform)"
  local go_pkg_url="https://storage.googleapis.com/golang/go${version}.${platform}.tar.gz"
  echo "$go_pkg_url"
}

require_package() {
  echo -n "Checking for required package: $1  "
  dpkg -s $1 > /dev/null 2>&1
  if [ $? -eq 0 ]; then 
    echo " ... installed"
    return 0
  else
    echo " ... not installed"
    # ask_to_install_package
    exit 1
  fi
}

require_command wget
require_command git
require_package "build-essential"

if [ -f $GOROOT/.installed ]; then
  echo "Skipping download & install: $GOROOT/.installed exists"
else
  TEMP_DIR=$(mktemp -d)
  PKG_URL="$(get_go_package_url)"

  echo "Downloading $(basename $PKG_URL)"
  wget $PKG_URL -O "$TEMP_DIR/go.tar.gz"

  if [ $? -ne 0 ]; then
    # TODO: check internet access / dns issues 
    # and warn if that appears to be the issue
    echo "Download failed! Exiting."
  fi

  echo "Extracting Go into $GOROOT"
  mkdir -p "$GOROOT"
  tar -C "$GOROOT" --strip-components=1 -xzf "$TEMP_DIR/go.tar.gz"
  if [ $? -ne 0 ]; then
    echo "Failed to extract the tar file into $GOROOT"
    exit 
  fi
  touch $GOROOT/.installed
fi

for D in "${GOPATH}/"{src,pkg,bin}; do
  if [[ ! -d $D ]]; then
    mkdir -vp $D
  fi
done

echo -e '\n# GoLang'
echo "##### TODO: add ~/.bash.d/go.sh stuff"
echo "export GOROOT=${GOROOT}"
echo 'export PATH=$GOROOT/bin:$PATH'
echo "export GOPATH=$GOPATH"
echo 'export PATH=$GOPATH/bin:$PATH'
echo "###########"
