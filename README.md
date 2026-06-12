# dotfiles

Personal configuration files for bash and vim.

## What's Included

### `.bashrc`
Bash shell configuration with:
- Custom prompt (blue directory name)
- Expanded history with timestamps (10,000 entries)
- Completion support
- Preferred editors: `vi`, `less` pager
- Custom PATH including `~/bin`

### `.vimrc`
Vim configuration with:
- Syntax highlighting and filetype detection
- Mouse support and line numbers
- 4-space tabs/indentation
- LaTeX support with vimtex (Zathura viewer, latexmk compiler)
- Parenthesis matching

## Installation

### Quick Setup (one command)
```bash
git clone https://github.com/danielmpfeffer/dotfiles.git
~/dotfiles/install.sh
```

### Manual Setup
```bash
git clone https://github.com/danielmpfeffer/dotfiles.git
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
```

Then reload your shell:
```bash
source ~/.bashrc
```

## Syncing on Other Machines

After cloning, pull the latest:
```bash
cd ~/dotfiles
git pull
```

## Customization

Edit files directly in `~/dotfiles/` and commit changes:
```bash
cd ~/dotfiles
git add .bashrc .vimrc
git commit -m "Update config"
git push
```

Then sync to other machines with `git pull`.
