# Makes color constants available.
autoload -U colors
colors

# Enable colored output from ls, etc.
export CLICOLOR=1

# Expand functions in the prompt.
setopt prompt_subst

# Custom prompt.
export PS1='$(git_prompt_info)$(hg_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '

git_prompt_info() {
  if [[ -d .git ]]; then
    ref=$(git symbolic-ref HEAD 2> /dev/null)

    if [[ -n $ref ]]; then
      echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
    fi
  fi
}

hg_prompt_info() {
  if [[ -d .hg ]]; then
    ref=$(hg branch 2> /dev/null)

    if [[ -n $ref ]]; then
      echo "[%{$fg_bold[yellow]%}${ref}%{$reset_color%}]"
    fi
  fi
}
