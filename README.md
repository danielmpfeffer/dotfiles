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

### `dwm/config.h`, `dmenu/config.h`, `st/config.h`, `slstatus/config.h`
Configs for a suckless-based desktop (dwm window manager, replacing i3).
Each is symlinked into its tool's own source tree (`~/src/suckless/<tool>/`)
so `make install` picks it up directly. Source trees themselves aren't
tracked here — just re-clone from git.suckless.org — only the customization
in `config.h` is.

### `bin/`
Scripts referenced by `dwm/config.h` and `dwm-start`'s autostart list:
- `dwm-start` — autostart script exec'd by the display manager, launches
  picom/slstatus/slock/etc. then execs dwm
- `dmenu-recent` — drop-in `dmenu_run` replacement showing the 10 most
  recently launched commands first
- `dmenu-open.sh` — file picker via dmenu, same recent-first behavior
- `dmenunote`, `monitor-setup.sh` — personal utility scripts

## Installation

### Quick Setup (one command)
```bash
git clone https://github.com/danielmpfeffer/dotfiles.git
~/dotfiles/install.sh
```

For the suckless configs specifically, the source trees need to exist first
(`install.sh` only symlinks `config.h` into them, it doesn't clone them):
```bash
mkdir -p ~/src/suckless && cd ~/src/suckless
for repo in dwm dmenu st slstatus; do
	git clone https://git.suckless.org/$repo
done
```
Then apply any patches (`horizontal`, `swallow`, dmenu `center`, st
`scrollback`) before running `install.sh`, since patches touch the `.c`
files directly and aren't tracked here — only `config.h` is.

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

Edit files directly wherever they're symlinked to (e.g. `~/src/suckless/dwm/config.h`,
`~/.local/bin/dmenu-recent`) — the symlink means you're really editing the
copy in `~/dotfiles/`. Then commit from there:
```bash
cd ~/dotfiles
git add -A
git commit -m "Update config"
git push
```

Then sync to other machines with `git pull`.
