#!/usr/bin/env bash
set -euo pipefail

# Install Atuin (https://atuin.sh)
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --no-modify-path

# Store database in ~/.cache so it persists across devcontainer rebuilds
# (~/.cache is a named Docker volume in the devcontainer setup)
mkdir -p ~/.config/atuin
cat > ~/.config/atuin/config.toml <<'TOML'
data_dir = "~/.cache/atuin"
TOML

# Add shell integration
ATUIN_BIN="${HOME}/.atuin/bin/atuin"
grep -q 'atuin init' ~/.bashrc 2>/dev/null || echo "eval \"\$(${ATUIN_BIN} init bash)\"" >> ~/.bashrc
grep -q 'atuin init' ~/.zshrc 2>/dev/null || echo "eval \"\$(${ATUIN_BIN} init zsh)\"" >> ~/.zshrc
