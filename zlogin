# Makes color constants available.
autoload -U colors
colors

# Enable colored output from ls, etc.
export CLICOLOR=1

# Expand functions in the prompt.
setopt prompt_subst

# Custom prompt.
if [ -z "$TMUX" ]; then
  export PS1='$(git_prompt_info)[%{$fg_bold[blue]%}%~%{$reset_color%}] '
else
  export PS1='%{$fg_bold[blue]%}$%{$reset_color%} '
fi

git_prompt_info() {
  if [[ -d .git ]]; then
    ref=$(git branch --show-current)

    if [[ -n $ref ]]; then
      echo "[%{$fg_bold[green]%}${ref}%{$reset_color%}]"
    fi
  fi
}
