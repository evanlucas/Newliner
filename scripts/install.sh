#!/bin/bash

set -e

# Since Coda can be run without being in /Applications,
# check if $HOME/Library/Application\ Support/Coda\ 2 exists

PLUGIN_DIR="$HOME/Library/Application Support/Coda 2"

if [[ ! -d "$PLUGIN_DIR" ]]; then
  echo "error: Coda 2 plugin directory cannot be found"
  echo "error: Is Coda 2 installed?"
  exit 1
fi

echo "info: Coda 2 plugin directory exists..."
echo "info: installing..."

cp -r Newliner.codaplugin "$PLUGIN_DIR/Plug-ins/"

echo "info: successfully installed plugin"
