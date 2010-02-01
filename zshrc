# Completion.
autoload -U compinit
compinit

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

# Load rvm, if installed.
if [[ -s ~/.rvm/scripts/rvm ]] ; then
  source ~/.rvm/scripts/rvm
fi

# Add MySQL and Postgres commands to path.
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/Library/PostgreSQL/8.4/bin:$PATH"

# Shut up Postgres.
export PGOPTIONS='-c client_min_messages=WARNING'
