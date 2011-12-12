# Completion.
autoload -U compinit
compinit -D

# Automatically enter directories without `cd`.
setopt auto_cd

# Use vim as an editor.
export EDITOR=vim

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
eval "$(rbenv init -)"

# Shut up Postgres.
export PGOPTIONS='-c client_min_messages=WARNING'

# Doctors orders.
export PATH="/usr/local/bin:$PATH"
