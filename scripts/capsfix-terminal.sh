#!/usr/bin/bash


# ensure we have setxkbmap
if ! command -v setxkbmap > /dev/null; then
	#sudo apt install dconf-cli
	echo "missing setxkbmap .. skipping run"
else
	setxkbmap -option "ctrl:nocaps"
fi


# Define file to be edited
KEYBOARD_CONFIG_FILE="/etc/default/keyboard"
BACKUP_FILE="${KEYBOARD_CONFIG_FILE}.orig"

# Check if backup exists, if not, create it
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Creating a backup of $KEYBOARD_CONFIG_FILE to $BACKUP_FILE..."
    sudo cp "$KEYBOARD_CONFIG_FILE" "$BACKUP_FILE"
else
    echo "Backup already exists, skipping backup step."
fi

# Check if XKBOPTIONS line exists
if grep -q '^XKBOPTIONS=' "$KEYBOARD_CONFIG_FILE"; then
    # XKBOPTIONS line exists, check if it is set correctly
    if grep -q 'XKBOPTIONS="ctrl:nocaps"' "$KEYBOARD_CONFIG_FILE"; then
        echo "XKBOPTIONS is already set to ctrl:nocaps. No changes needed."
    else
        # Update the existing XKBOPTIONS line to set Caps Lock as Control key
        echo "Updating XKBOPTIONS in $KEYBOARD_CONFIG_FILE to set Caps Lock as Control key..."
        sudo sed -i '/^XKBOPTIONS=/c\XKBOPTIONS="ctrl:nocaps"' "$KEYBOARD_CONFIG_FILE"
    fi
else
    # XKBOPTIONS line doesn't exist, so add it
    echo "Adding XKBOPTIONS to $KEYBOARD_CONFIG_FILE to set Caps Lock as Control key..."
    echo 'XKBOPTIONS="ctrl:nocaps"' | sudo tee -a "$KEYBOARD_CONFIG_FILE" > /dev/null
fi

# Apply the new keyboard configuration
echo "Applying the new keyboard configuration..."
sudo dpkg-reconfigure -f noninteractive keyboard-configuration

echo "Configuration complete."

