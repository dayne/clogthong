
function github_token_instructions() {
  echo "
  To get a GitHub personal access token, you can do the following: 
    Sign in to your GitHub account 
    Click your profile photo in the top right corner 
    Click Settings 
    Click Developer settings in the left sidebar 
    Click Personal access tokens in the left sidebar 
    Click Generate new token 
    Enter a name for your token 
    Select the scopes or permissions you want to grant the token 
    Click Generate token 
    Copy the token and store it in a safe place
  Then put it in $HOME/.env/GITHUB_TOKEN and then do:
    GITHUB_TOKEN=$(cat $HOME/.env/GITHUB_TOKEN)
    export GITHUB_TOKEN
"

}

function sanity_check() {
  if ! command -v go > /dev/null; then
    echo "missing go"
    exit 1
  fi

  if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN empty -- unable to proceed"
    sleep 1
    github_token_instructions
    exit 1
  fi
}

function install_tool() {
  if [ ! -d $HOME/repos/github-contributions-tui ]; then
    mkdir -p $HOME/repos/
    git clone https://github.com/jvanrhyn/github-contributions-tui.git $HOME/repos/
    cd $HOME/repos/github-contributions-tui
    
    echo 'echo "GITHUB_TOKEN=your_github_token" > .env'
  fi
}

sanity_check
install_tool
