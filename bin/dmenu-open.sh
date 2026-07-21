#!/bin/bash
# Opens a file via dmenu. Shows the 10 most recently opened files first,
# then falls back to a full search of $HOME for anything else.

histfile="$HOME/.cache/dmenu_open_recent"
mkdir -p "$(dirname "$histfile")"
touch "$histfile"

# keep the history file from growing forever
tail -n 500 "$histfile" > "$histfile.tmp" && mv "$histfile.tmp" "$histfile"

# most-recent-first, deduplicated, capped at 10 — and skip any that no
# longer exist, so deleted/moved files don't clutter the list
recent=$(tac "$histfile" | awk '!seen[$0]++' | while read -r f; do [ -e "$f" ] && printf '%s\n' "$f"; done | head -n 10)

if [ -n "$recent" ]; then
	rest=$(find "$HOME" -maxdepth 4 -type f 2>/dev/null | grep -vFxf <(printf '%s\n' "$recent"))
else
	rest=$(find "$HOME" -maxdepth 4 -type f 2>/dev/null)
fi

file=$(printf '%s\n%s\n' "$recent" "$rest" | dmenu -c -l 20 -i -p "Open:")

[ -n "$file" ] || exit 0
echo "$file" >> "$histfile"
xdg-open "$file"
