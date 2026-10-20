# Non-login terminals may not inherit the paths set in ~/.profile.
# Add missing system directories without moving them ahead of active tools.
for _dan_path_dir in /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin; do
    case ":${PATH-}:" in
        *:"$_dan_path_dir":*) ;;
        *) PATH="${PATH:+$PATH:}$_dan_path_dir" ;;
    esac
done
unset _dan_path_dir

for _dan_path_dir in "$HOME/bin" "$HOME/.local/bin"; do
    case ":${PATH-}:" in
        *:"$_dan_path_dir":*) ;;
        *) PATH="$_dan_path_dir${PATH:+:$PATH}" ;;
    esac
done
unset _dan_path_dir
export PATH

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
