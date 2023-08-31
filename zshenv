# Disable sessions.
export SHELL_SESSIONS_DISABLE=1

# Use neovim as the visual editor.
export VISUAL=nvim
export EDITOR=$VISUAL

# Keep more history.
export HISTSIZE=4096
# Move history out of the home directory.
export HISTFILE="/tmp/.zsh_history"

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

# Load private Rubygems configuration.
if [ -f "${HOME}/.gemrc.private" ]; then
  export GEMRC="${HOME}/.gemrc.private"
fi
