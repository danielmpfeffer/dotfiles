# Command path
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
PATH=$HOME/.local/bin:$HOME/bin:$PATH

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
# LESS=meiX
alias man='MANWIDTH=75 man'

# Give other users read-only access to most new files  
umask 022

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
