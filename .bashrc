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

EDITOR=vi
VISUAL=vi
PAGER=less
LESS=meiX

export PATH EDITOR VISUAL PAGER LESS

# Give other users read-only access to most new files  
umask 022

# Automatically start ssh-agent on login
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi
