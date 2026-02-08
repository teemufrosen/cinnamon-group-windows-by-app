#!/bin/bash

# Cinnamon: Group Windows by Application - Uninstall Script

set -e

echo "========================================"
echo "Cinnamon: Group Windows by Application"
echo "         UNINSTALL"
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

echo "Restoring original files from backups..."

# Restore original files
if [ -f "$CINNAMON_JS/appSwitcher/appSwitcher.js.backup" ]; then
    sudo cp "$CINNAMON_JS/appSwitcher/appSwitcher.js.backup" "$CINNAMON_JS/appSwitcher/appSwitcher.js"
    echo "  Restored appSwitcher.js"
else
    echo "  Warning: appSwitcher.js.backup not found"
fi

if [ -f "$CINNAMON_JS/appSwitcher/classicSwitcher.js.backup" ]; then
    sudo cp "$CINNAMON_JS/appSwitcher/classicSwitcher.js.backup" "$CINNAMON_JS/appSwitcher/classicSwitcher.js"
    echo "  Restored classicSwitcher.js"
else
    echo "  Warning: classicSwitcher.js.backup not found"
fi

if [ -f "$CINNAMON_JS/windowManager.js.backup" ]; then
    sudo cp "$CINNAMON_JS/windowManager.js.backup" "$CINNAMON_JS/windowManager.js"
    echo "  Restored windowManager.js"
else
    echo "  Warning: windowManager.js.backup not found"
fi

if [ -f "$CINNAMON_SETTINGS/cs_windows.py.backup" ]; then
    sudo cp "$CINNAMON_SETTINGS/cs_windows.py.backup" "$CINNAMON_SETTINGS/cs_windows.py"
    echo "  Restored cs_windows.py"
else
    echo "  Warning: cs_windows.py.backup not found"
fi

if [ -f "$SCHEMAS/org.cinnamon.gschema.xml.backup" ]; then
    sudo cp "$SCHEMAS/org.cinnamon.gschema.xml.backup" "$SCHEMAS/org.cinnamon.gschema.xml"
    echo "  Restored org.cinnamon.gschema.xml"
else
    echo "  Warning: org.cinnamon.gschema.xml.backup not found"
fi

echo ""
echo "Recompiling GSettings schemas..."
sudo glib-compile-schemas "$SCHEMAS"

echo "Restoring original keybindings..."
gsettings set org.cinnamon.desktop.keybindings.wm switch-group "[]"
gsettings set org.cinnamon.desktop.keybindings.wm switch-group-backward "[]"

echo ""
echo "========================================"
echo "Uninstallation complete!"
echo "========================================"
echo ""
echo "To apply changes, restart Cinnamon:"
echo "  Press Alt+F2, type 'r', press Enter"
echo ""
