#!/bin/bash

# Cinnamon: Group Windows by Application - Install Script

set -e

echo "========================================"
echo "Cinnamon: Group Windows by Application"
echo "========================================"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run as root. The script will ask for sudo when needed."
    exit 1
fi

# Define paths
CINNAMON_JS="/usr/share/cinnamon/js/ui"
CINNAMON_SETTINGS="/usr/share/cinnamon/cinnamon-settings/modules"
SCHEMAS="/usr/share/glib-2.0/schemas"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES_DIR="$SCRIPT_DIR/files"

echo "Creating backups..."

# Backup original files
sudo cp "$CINNAMON_JS/appSwitcher/appSwitcher.js" "$CINNAMON_JS/appSwitcher/appSwitcher.js.backup" 2>/dev/null || true
sudo cp "$CINNAMON_JS/appSwitcher/classicSwitcher.js" "$CINNAMON_JS/appSwitcher/classicSwitcher.js.backup" 2>/dev/null || true
sudo cp "$CINNAMON_JS/windowManager.js" "$CINNAMON_JS/windowManager.js.backup" 2>/dev/null || true
sudo cp "$CINNAMON_SETTINGS/cs_windows.py" "$CINNAMON_SETTINGS/cs_windows.py.backup" 2>/dev/null || true
sudo cp "$SCHEMAS/org.cinnamon.gschema.xml" "$SCHEMAS/org.cinnamon.gschema.xml.backup" 2>/dev/null || true

echo "Backups created."
echo ""
echo "Installing modified files..."

# Copy modified files
sudo cp "$FILES_DIR/appSwitcher.js" "$CINNAMON_JS/appSwitcher/appSwitcher.js"
sudo cp "$FILES_DIR/classicSwitcher.js" "$CINNAMON_JS/appSwitcher/classicSwitcher.js"
sudo cp "$FILES_DIR/windowManager.js" "$CINNAMON_JS/windowManager.js"
sudo cp "$FILES_DIR/cs_windows.py" "$CINNAMON_SETTINGS/cs_windows.py"
sudo cp "$FILES_DIR/org.cinnamon.gschema.xml" "$SCHEMAS/org.cinnamon.gschema.xml"

echo "Compiling GSettings schemas..."
sudo glib-compile-schemas "$SCHEMAS"

echo ""
echo "========================================"
echo "Installation complete!"
echo "========================================"
echo ""
echo "To activate, restart Cinnamon:"
echo "  Press Alt+F2, type 'r', press Enter"
echo ""
echo "Then enable the feature in:"
echo "  System Settings → Windows → Alt-Tab"
echo "  Toggle: 'Group windows by application'"
echo ""
