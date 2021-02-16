#!/bin/bash
set -e

echo "Creating virtual environment"

python3 -m venv "$VENV" --system-site-packages --clear

if [ "$CONTINUE_ON_KEY" = true ]; then
	echo "Press any key to continue..."
	read -r -n 1
fi
