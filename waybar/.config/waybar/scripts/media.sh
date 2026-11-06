#!/usr/bin/env bash
# Media control button for waybar: prints the icon for the given button
# while a player exists, and nothing (hiding the module) otherwise.
# Usage: media.sh prev|play-pause|next

button="$1"

print_icon() {
  local status="$1"
  if [[ -z "$status" ]]; then
    echo ""
    return
  fi
  case "$button" in
    prev) echo "󰒮" ;;
    next) echo "󰒭" ;;
    play-pause)
      if [[ "$status" == "Playing" ]]; then echo "󰏤"; else echo "󰐊"; fi
      ;;
  esac
}

print_icon "$(playerctl status 2>/dev/null)"

playerctl --follow status 2>/dev/null | while read -r status; do
  print_icon "$status"
done
