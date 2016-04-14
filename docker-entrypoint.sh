#!/bin/sh
set -e

# Geth supported commands
geth_commands="account attach console dump export gpubench gpuinfo h help import init js makedag monitor removedb upgradedb version wallet"

for command in $geth_commands ; do
  # If first argument starts with "-" then assumes geth, or if is a supported geth command
  if [[ $(echo "$1" | cut -c1) = "-" -o "$command" = "$1" ]]; then
    mkdir -p "$GETH_DATA"
    chmod 700 "$GETH_DATA"
    chown -R ethereum "$GETH_DATA"

    echo "$0: setting data directory to $GETH_DATA"

    exec su-exec ethereum geth --datadir "$GETH_DATA" "$@"
  fi
done

# Fallback cases for other commands.
exec "$@"
