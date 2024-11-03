# Snapper

http://snapper.io/

Works with btrfs, **ext4 (discontinued)** and thin-provisioned LVM volumes

## Usage

To create a snapshot of your home directory using Snapper, you first need to ensure Snapper is installed and configured on your system. Assuming that Snapper is already set up, here’s a step-by-step guide to create a snapshot:

### 1. Install Snapper (if not installed yet)
If Snapper is not installed, you can install it using your package manager:

For **Debian/Ubuntu** based systems:
```bash
sudo apt install snapper
```

### 2. Set Up a Snapper Configuration for Your Home Directory
If you don’t have a Snapper configuration for your home directory, you need to create one. Run the following command to create a configuration for `/home`:

```bash
sudo snapper -c home create-config /home
```

### 3. Create a Snapshot of Your Home Directory
Once the configuration is set up, you can create a snapshot for the home directory:

```bash
sudo snapper -c home create --description "Snapshot of home directory"
```

This command creates a snapshot with a description like "Snapshot of home directory". You can modify the description to something more meaningful if needed.

### 4. Verify Snapshot Creation
You can list your snapshots with the following command:

```bash
sudo snapper -c home list
```

This will show you the list of snapshots created for the home directory.
