#!/usr/bin/bash
set -e # exit on any error

REPO="https://github.com/JaKooLit/Ubuntu-Hyprland.git"
BRANCH="24.04"
REPO_DIR="JaKooLit-Ubuntu-Hyprland-$BRANCH"

#verify BRANCH is same as this Ubuntu
. /etc/os-release
if [[ $VERSION_ID == $BRANCH ]]; then
  echo "Verified BRANCH==VERSION_ID : $BRANCH -- continuing"
else
  echo "Error: mismatch: BRANCH=$BRANCH and OS's VERSION_ID=$VERSION_ID"
  exit 1
fi

cd $HOME
if [ ! -d repos ]; then
  mkdir -v repos
fi

cd repos

if [ ! -d  $REPO_DIR ]; then
  git clone -b $BRANCH --depth 1 $REPO $REPO_DIR
  if [[ $? -eq 0 ]]; then
    echo "success:  cloned into $REPO_DIR"
  else
    echo "fail: unable to clone $REPO"
    exit 1
  fi
  cd $REPO_DIR
else
  cd $REPO_DIR
  git pull
fi

chmod +x install.sh
./install.sh
