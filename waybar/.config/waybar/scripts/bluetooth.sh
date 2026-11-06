#!/usr/bin/env bash
# Bluetooth menu using hyprlauncher in dmenu mode

MAC_REGEX='([0-9A-F]{2}:){5}[0-9A-F]{2}'

menu() { hyprlauncher -m; }
is_powered()   { bluetoothctl show | grep -q "Powered: yes"; }
is_connected() { bluetoothctl info "$1" | grep -q "Connected: yes"; }
extract_mac()  { grep -oE "$MAC_REGEX"; }

# "Name (MAC)" for each device in the given list (Paired, Connected...)
list_devices() {
  bluetoothctl devices "$@" | while read -r _ mac name; do
    [[ $name == "${mac//:/-}" ]] && continue   # device has no advertised name
    echo "$name ($mac)"
  done
}

device_menu() {
  local mac=$1 action
  if is_connected "$mac"; then
    action=$(printf '%s\n' "󰂲  Disconnect" "󰆴  Remove" | menu)
  else
    action=$(printf '%s\n' "󰂱  Connect" "󰆴  Remove" | menu)
  fi
  case "$action" in
    *Disconnect*) bluetoothctl disconnect "$mac" ;;
    *Connect*)    bluetoothctl connect "$mac" ;;
    *Remove*)     bluetoothctl remove "$mac" ;;
  esac
}

scan_and_pair() {
  notify-send "Bluetooth" "Procurando dispositivos..." 2>/dev/null
  bluetoothctl --timeout 8 scan on >/dev/null

  local paired mac
  paired=$(bluetoothctl devices Paired)
  mac=$(list_devices | grep -vFf <(echo "$paired" | extract_mac) | menu | extract_mac)
  [[ -z $mac ]] && return

  bluetoothctl pair "$mac" && bluetoothctl trust "$mac" && bluetoothctl connect "$mac"
}

if ! is_powered; then
  [[ $(printf '%s\n' "󰂯  Turn on" | menu) == *"Turn on"* ]] && bluetoothctl power on
  exit
fi

devices=$(list_devices Paired | while read -r line; do
  mac=$(echo "$line" | extract_mac)
  if is_connected "$mac"; then echo "󰂱  $line"; else echo "󰂯  $line"; fi
done)

choice=$(printf '%s\n' "󰂲  Turn off" "󰂰  Scan for devices" "$devices" | grep -v '^$' | menu)

case "$choice" in
  *"Turn off"*) bluetoothctl power off ;;
  *Scan*)       scan_and_pair ;;
  *)            mac=$(echo "$choice" | extract_mac); [[ -n $mac ]] && device_menu "$mac" ;;
esac
