#!/bin/bash

ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# suckless tool configs — symlinked into the location each tool's own
# Makefile expects, same pattern as .bashrc/.vimrc above
ln -sf ~/dotfiles/dwm/config.h ~/src/suckless/dwm/config.h
ln -sf ~/dotfiles/dmenu/config.h ~/src/suckless/dmenu/config.h
ln -sf ~/dotfiles/st/config.h ~/src/suckless/st/config.h
ln -sf ~/dotfiles/slstatus/config.h ~/src/suckless/slstatus/config.h

# scripts — symlinked into ~/.local/bin, which is what dwm's config.h
# and dwm-start actually reference
mkdir -p ~/.local/bin
for f in dwm-start dmenu-recent dmenu-open.sh dmenunote monitor-setup.sh; do
	ln -sf ~/dotfiles/bin/"$f" ~/.local/bin/"$f"
done
chmod +x ~/dotfiles/bin/*
