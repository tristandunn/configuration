# Disable sessions.
export SHELL_SESSIONS_DISABLE=1

# Use neovim as the visual editor.
export VISUAL=nvim
export EDITOR=$VISUAL

# Disable less file.
export LESSHISTFILE=-

# Access to custom executables.
export PATH="$PATH:$HOME/.configuration/bin"

# Set the ripgrep configuration path.
export RIPGREP_CONFIG_PATH="$HOME/.configuration/ripgreprc"

# No emoji for Homebrew.
export HOMEBREW_NO_EMOJI=1
# No analytics for Homebrew.
export HOMEBREW_NO_ANALYTICS=1
# No hints for Homebrew.
export HOMEBREW_NO_ENV_HINTS=1

# Disable statistics from Selenium Manager.
export SE_AVOID_STATS=true
