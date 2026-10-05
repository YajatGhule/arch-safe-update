#!/usr/bin/env bash
set -euo pipefail

PREFIX="${PREFIX:-${HOME}/.local}"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/safe-update"

install -Dm755 "$SRC" "${PREFIX}/bin/safe-update"
echo "Installed safe-update to ${PREFIX}/bin/safe-update"

missing=()
for cmd in yay checkupdates checkrebuild timeshift; do
    command -v "$cmd" &>/dev/null || missing+=("$cmd")
done
if (( ${#missing[@]} )); then
    echo "Warning: missing dependencies: ${missing[*]}"
    echo "  sudo pacman -S --needed pacman-contrib rebuild-detector timeshift  (and install yay)"
fi

case ":${PATH}:" in
    *":${PREFIX}/bin:"*) ;;
    *) echo "Note: ${PREFIX}/bin is not on your PATH." ;;
esac
