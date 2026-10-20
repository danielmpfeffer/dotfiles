# Add a dir to PATH unless it's already there; never reorders, so an active
# venv or nix profile stays in front. System dirs go last, personal ones first.
path_add() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) if [ "$2" = after ]; then PATH="${PATH:+$PATH:}$1"; else PATH="$1${PATH:+:$PATH}"; fi ;;
  esac
}
for d in /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin; do path_add "$d" after; done
path_add ~/bin
path_add ~/.local/bin
unset -f path_add; unset d

# PS1: \u username \h hostname \w current directory
# \! history number \s shell name \$ $ if not root
PS1='\[\033[34m\]\W \[\033[0m\]\$ '

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

LS_COLORS='di=34:ln=35:ex=31'
export LS_COLORS

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A'
alias l='ls -la --color=auto'

# Additions to default config
# Bigger history with timestamps
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%F %T "
# Append each command to the history file as soon as it runs, instead of each
# shell overwriting the file when it exits (which lost other terminals' history)
shopt -s histappend
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# Skip repeated commands, and commands typed with a leading space
HISTCONTROL=ignoreboth

# EDITOR and VISUAL determine the editor that programs such as less
EDITOR=vi
VISUAL=vi

# PAGER is the default text file viewer for programs such as man
PAGER=less

# These are some handy options for less.
#LESS=meiX
alias man='MANWIDTH=75 man'

# Give other users read-only access to most new files  
umask 022

eval $(keychain --eval --quiet ~/.ssh/id_ed25519)

[ -f "/home/dan/.ghcup/env" ] && . "/home/dan/.ghcup/env" # ghcup-env

# Pause clipmenu while `pass -c` copies a password, so it never lands in the
# clipboard history. Refuses to copy if clipmenud is running but won't pause.
pass() {
  local arg
  for arg; do
    case $arg in
    -c*|--clip*)
      if pgrep -xu "$USER" clipmenud >/dev/null; then
        clipctl disable || return
        command pass "$@"
        local ret=$?
        clipctl enable
        return $ret
      fi
      ;;
    esac
  done
  command pass "$@"
}

# Warn when one of install.sh's symlinks has been replaced by a regular file
# (sed -i, installers and AI agents do this), since edits then stop reaching
# ~/dotfiles. Diff the two copies before re-linking, or the live edits are lost.
for _dot in ~/dotfiles/.[!.]* ~/dotfiles/bin/* ~/dotfiles/*/config.h; do
  case ${_dot#"$HOME"/dotfiles/} in
    .git*) continue ;;
    bin/*) _live=~/.local/bin/${_dot##*/} ;;
    */config.h) _live=~/src/suckless/${_dot#"$HOME"/dotfiles/} ;;
    *) _live=~/${_dot##*/} ;;
  esac
  if [ -e "$_live" ] && [ ! -L "$_live" ]; then
    echo "dotfiles: $_live is a regular file, not a symlink (diff it against $_dot before re-linking)" >&2
  fi
done
unset _dot _live
