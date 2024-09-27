#!/usr/bin/bash

# TODO verify hyprland context
# ensure we are in hyprland

config_file="$HOME/.config/hypr/UserConfigs/UserSettings.conf"
xkb_options="caps:ctrl_modifier"

#sed -i 's/Prompt=lts/Prompt=normal/' "$config_file"
#target_line="  kb_options ="
sed_string='s/  kb_options =/  kb_options = '${xkb_options}'/'
echo "sed -i '${sed_string}' $config_file"
sed -i "${sed_string}" "$config_file"
if [ $? -eq 0 ]; then
	echo "success modified: $config_file"
    echo "         to have: $xkb_options"
else
	echo "failed modify: $config_file"
    echo "      to have: $xkb_options"
fi
