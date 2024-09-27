#!/usr/bin/bash


# TODO verify wayland context

# ensure we have dconf-cli
if ! command -v dconf > /dev/null; then
	sudo apt install dconf-cli
else
	echo "dconf-cli available - using to write option"
fi

dconf write \
      /org/gnome/desktop/input-sources/xkb-options \
      "['caps:ctrl_modifier']"
if [ $? -eq 0 ]; then
	echo "success: caps:ctrl_modifier xkb-option set"
else
	echo "dconf write xkb-options failed"
fi
