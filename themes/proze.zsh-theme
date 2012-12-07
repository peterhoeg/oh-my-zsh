#  -*- mode: shell-script;-*-
# vim: filetype=sh
#
# proze.zsh-theme
# Most of this was taken from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# Determine what character to use in place of the '$' for my prompt.
function repo_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '$'
}

# requires https://bitbucket.org/sjl/hg-prompt
function hg_prompt_info {
  hg prompt --angle-brackets "\
< on <branch>>\
< at <tags|, >>\
<status|modified|unknown><update><
patches: <patches|join( → )>>" 2>/dev/null
}

# Display any virtual env stuff with python.
function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# All of my git variables.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# I like a new line between my result and the next prompt. Makes it easier to see
PROMPT='
%n%{$reset_color%} at %{$fg[green]%}%m%{$reset_color%} in %{$fg[white]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)$(repo_char) '

# Do not show when running mc
if [[ /proc/$PPID/exe -ef /usr/bin/mc ]] ; then
  RPROMPT=''
else
  RPROMPT='$(date "+%x %T %Z")'
fi
