# Barrier

Get the most out of your best keyboard and mouse.

## Tasks


### Install barrier

```
if pgrep -x "Xwayland" > /dev/null; then
    echo "Xwayland is running... barrier does not support Wayland"
    exit 1
fi

if ! command -v barrier; then
    sudo apt install barrier
fi
```
