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

# Aliases.
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Ensure the environemtn variables are loaded.
if [ -f "$HOME/.zshenv" ]; then
  source "$HOME/.zshenv"
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
source $(brew --prefix asdf)/libexec/asdf.sh

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

git() {
  if [[ $1 == "d" || $1 == "dc" ]]; then
    clear
  fi

  command git "$@"
}
