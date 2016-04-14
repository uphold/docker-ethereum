#!/bin/sh
set -e

# If has no arguments (or geth) then assumes geth
if [ "$1" = "geth" -o "$1" = "version" ]; then
  set -- geth "$@"
  exec gosu ethereum "$@"
fi

# If it has arguments beginning with '-' then assumes geth with datadir included.
if [ $(echo "$1" | cut -c1) = "-" ]; then
  mkdir -p "$GETH_DATA"
  chmod 700 "$GETH_DATA"
  chown -R ethereum "$GETH_DATA"
  echo "$0: setting data directory to $GETH_DATA"

  set -- --datadir "$GETH_DATA" "$@"
  set -- geth "$@"

  exec gosu ethereum "$@"
fi

# Fallback cases for other commands.
echo
exec "$@"
