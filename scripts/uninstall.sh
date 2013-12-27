#!/bin/bash

set -e

# Since Coda can be run without being in /Applications,
# check if $HOME/Library/Application\ Support/Coda\ 2 exists

PLUGIN_DIR="$HOME/Library/Application Support/Coda 2/Plug-ins/Newliner.codaplugin"

if [[ ! -d "$PLUGIN_DIR" ]]; then
  echo "info: plugin is not installed"
  exit
fi

rm -rf "$PLUGIN_DIR"

echo "info: successfully removed plugin"
