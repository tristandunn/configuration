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

# Use rbenv for Ruby management.
export RBENV_ROOT=/usr/local/opt/rbenv

if which rbenv > /dev/null; then
  eval "$(rbenv init - --no-rehash)";
fi

# Doctors orders.
export PATH="$HOME/.configuration/bin:/usr/local/bin:$PATH"

# Disable less file.
export LESSHISTFILE=-

# Custom options.
export NODE_ENV="local"

# No emoji for Homebrew.
export HOMEBREW_NO_EMOJI=1

# Use nvm for node.js management.
export NVM_DIR=~/.nvm
. /usr/local/opt/nvm/nvm.sh
