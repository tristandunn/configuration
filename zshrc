# Force usage of the Kitty terminal.
if [ "$TERM" = "xterm-256color" ]; then
  open -a "Kitty"
  killall "Terminal"
fi

# Completion.
autoload -U compinit
compinit -D

# Automatically enter directories without `cd`.
setopt auto_cd

# Use vim as the visual editor.
export VISUAL=vim
export EDITOR=$VISUAL

# Aliases.
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Use vi mode.
bindkey -v

# Use incremental search.
bindkey ^R history-incremental-search-backward

# Expand functions in the prompt.
setopt prompt_subst

# Ignore duplicate history entries.
setopt histignoredups

# Keep more history.
export HISTSIZE=256

# Hide the history file.
export HISTFILE="/tmp/.zsh_history"

# Disable less file.
export LESSHISTFILE=-

# Homebrew doctors orders.
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# No emoji for Homebrew.
export HOMEBREW_NO_EMOJI=1
# No analytics for Homebrew.
export HOMEBREW_NO_ANALYTICS=1
# Enable auto-complete for Homebrew.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Load the asdf magic.
source $(brew --prefix asdf)/asdf.sh

# Access to custom executables.
export PATH="$PATH:$HOME/.configuration/bin"

# Set the ripgrep configuration path.
export RIPGREP_CONFIG_PATH="$HOME/.configuration/ripgreprc"

# Use all available CPU cores for compiling to speed up Bundler and more.
export MAKE="make -j$(nproc)"

# Load private shell configuration.
if [ -f "$HOME/.zshrc.private" ]; then
  source "$HOME/.zshrc.private"
fi

# Fix CMD+S shortcut.
stty -ixon

