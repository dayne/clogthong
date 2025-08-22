https://hub.docker.com/r/linuxserver/obsidian

podman pull lscr.io/linuxserver/obsidian:latest

mkdir -p ~/obsidian/config ~/obsidian/data

use obmanserver to help 

./obmanserver [command] 
  start   - launch container server
  stop    - stop container server
  setup   - validate the setup and pull image
  status  - check status
  help    - this message
