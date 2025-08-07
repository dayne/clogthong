echo "you better be Ubuntu .. this is just bonker raw script you should type not run"
echo "I haven't had interest/time to make this be a proper clogthong script because"
echo "I want to get docker like interfaces w/o docker .. but that is more complex"
echo "if you dont' care about that you can edit script and remove the exit 1 line"
echo "and run with scissors at your own risk"
exit 1

# 1. Update the apt package index
sudo apt update

# 2. Install required packages to use repositories over HTTPS
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 3. Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 4. Set up the Docker stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Update apt and install Docker Engine (CLI + daemon)
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. (Optional) Add your user to the docker group to avoid needing `sudo` for Docker commands
sudo usermod -aG docker $USER
