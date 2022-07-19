# Force usage of the Kitty terminal.
if [ "$TERM" = "xterm-256color" ]; then
  open -a "Kitty"
  killall "Terminal"
fi

# Move the history file to hide it.
fc -p /tmp/.zsh_history

# Remove the old history file.
if [ -e "$HOME/.zsh_history" ]; then
  rm "$HOME/.zsh_history"
fi

# Completion.
autoload -U compinit
compinit -D

# Automatically enter directories without `cd`.
setopt auto_cd

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

# Homebrew doctors orders.
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
# Enable auto-complete for Homebrew.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Load private shell configuration.
if [ -f "$HOME/.zshrc.private" ]; then
  source "$HOME/.zshrc.private"
fi

# Fix CMD+S shortcut.
stty -ixon

# Load the asdf magic.
source $(brew --prefix asdf)/asdf.sh

# Automatically set the window title with a hook executed before each prompt.
precmd() {
  local name=$PWD

  if [[ $name/ = $HOME/ ]]; then
    name="~"
  else
    name=$(basename $name)
  fi

  printf "\e]0;$name\a"
}
