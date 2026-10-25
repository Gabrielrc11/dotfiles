#!/usr/bin/env bash
# Power menu using hyprlauncher in dmenu mode

choice=$(printf '%s\n' \
  "󰐥  Shut down" \
  "󰜉  Reboot" \
  "󰒲  Suspend" \
  "󰍃  Exit Hyprland" | hyprlauncher -m)

confirm() {
  [[ $(printf '%s\n' "󰄬  Yes, $1" "󰅖  Cancel" | hyprlauncher -m) == *Yes* ]]
}

case "$choice" in
  *"Shut down"*) confirm "shut down" && systemctl poweroff ;;
  *Reboot*)      confirm "reboot"    && systemctl reboot ;;
  *Suspend*)     systemctl suspend ;;
  *Exit*)        confirm "exit"      && hyprctl dispatch 'hl.dsp.exit()' ;;
esac
