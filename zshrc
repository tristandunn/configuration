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
eval "$(/opt/homebrew/bin/brew shellenv)"
# No emoji for Homebrew.
export HOMEBREW_NO_EMOJI=1
# No analytics for Homebrew.
export HOMEBREW_NO_ANALYTICS=1
# No hints for Homebrew.
export HOMEBREW_NO_ENV_HINTS=1
# Enable auto-complete for Homebrew.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Access to custom executables.
export PATH="$PATH:$HOME/.configuration/bin"

# Set the ripgrep configuration path.
export RIPGREP_CONFIG_PATH="$HOME/.configuration/ripgreprc"

# Load private shell configuration.
if [ -f "$HOME/.zshrc.private" ]; then
  source "$HOME/.zshrc.private"
fi

# Load private Rubygems configuration.
if [ -f "${HOME}/.gemrc.private" ]; then
  export GEMRC="${HOME}/.gemrc.private"
fi

# Fix CMD+S shortcut.
stty -ixon

# Load the asdf magic.
source $(brew --prefix asdf)/asdf.sh

# Automatically set the window title with a hook executed before each prompt.
precmd() {
  local name=$PWD

  if [[ $PWD/ = $HOME/* ]]; then
    name=$(basename $name)
    lower=${name:l}

    if [ $name = $USER -o $lower = $USER ]; then
      name="~"
    fi
  fi

  printf "\e]0;$name\a"
}
