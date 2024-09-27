#!/usr/bin/bash
config_file="$HOME/.config/hypr/UserConfigs/UserSettings.conf"
xkb_options="caps:ctrl_modifier"

# verify hyprland context
if ! command-v hyprland; then
    echo "hyprland not available - no point in messing with this"
    exit 1
fi

# verify hyprland config_file setup
if [[ ! -f $config_file ]]; then
    echo "error: config_file not found $config_file"
    exit 1
fi

grep "${xkb_options}" ${config_file} > /dev/null
if [ $? -eq 0 ]; then
    echo "success: kb_options=${xkb_options} already set in ${config_file}"
    exit 0
fi

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
