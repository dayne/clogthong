# rclone


console.cloud.google.com

IAM -> Service Accounts -> New

* [Main]-YYYY-[SubTopic]-[RO|RW]
  * example: `pepsi-2024-vendingmachine-ro`
  * Details: See email for the pepsi-2024-vendingmachine-ro@someprojectname
* Keys: 
  * Add Key --> Create New Key --> JSON --> Downloads the .json key file

### rclone config

`rclone config`
* Give the thing a name
* Select 18 for Google Drive
* Get the client_id from somebody smarter than this README.  You can leave it blank
* put the json file in .config/rclone
* configure the secret using the $RCLONE_CONFIG_DIR/name-of-file.json
* try it out

```
rclone listremotesd
rclone ls NAME-OF-REMOTE:
```


## Tasks

### Install

```
./setup.sh
```
