# Force usage of the Kitty terminal.
if [ "$TERM" = "xterm-256color" ]; then
  open -a "Kitty"
  killall "Terminal"
fi

# Completion which only updates daily.
autoload -Uz compinit

if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
  compinit
else
  compinit -C
fi

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
fi

# Enable auto-complete for Homebrew.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Activate mise.
if [ -f "/opt/homebrew/bin/mise" ]; then
  eval "$(/opt/homebrew/bin/mise activate zsh)"
fi

# Load private shell configuration.
if [ -f "$HOME/.zshrc.private" ]; then
  source "$HOME/.zshrc.private"
fi

# Fix CMD+S shortcut.
stty -ixon

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
