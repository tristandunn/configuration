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

# Doctors orders.
export PATH="/usr/local/bin:$PATH"

# Disable less file.
export LESSHISTFILE=-

# Custom options.
export NODE_ENV="local"

# No emoji for Homebrew.
export HOMEBREW_NO_EMOJI=1
# No analytics for Homebrew.
export HOMEBREW_NO_ANALYTICS=1
# Use the old caskroom for now.
export HOMEBREW_CASK_OPTS="--caskroom=/opt/homebrew-cask/Caskroom"

# Use nvm for node.js management.
export NVM_DIR=~/.nvm
. ~/.nvm/nvm.sh

# Load the chruby magic.
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Access to the yarn executables.
export PATH="$PATH:$HOME/.yarn/bin"
