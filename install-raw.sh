#!/usr/bin/env bash
set -euo pipefail

apt-get update
apt-get install -y ttfautohint jq zip

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# shellcheck source=/dev/null
\. "$HOME/.nvm/nvm.sh"
nvm install 24

cp tmux.conf ~/.tmux.conf

echo 'Installation complete! start tmux with: \
tmux new-session -AsIosevka'