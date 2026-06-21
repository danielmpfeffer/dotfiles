# Command path
PATH=/usr/local/bin:/usr/bin:/bin
PATH=$HOME/bin:$PATH

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

# Export environment variables.
export PATH EDITOR VISUAL PAGER LESS

# Give other users read-only access to most new files  
umask 022

# Start ssh-agent if not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent) > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi
