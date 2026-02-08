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

# Prompt for keybinding preference
echo "Choose the keybinding for switching windows of the same application:"
echo "1) Alt+§ (default)"
echo "2) Ctrl+§"
read -p "Enter your choice (1 or 2): " choice
case $choice in
    1)
        KEYBINDING="<Alt>Above_Tab"
        ;;
    2)
        KEYBINDING="<Control>Above_Tab"
        ;;
    *)
        echo "Invalid choice. Using default Alt+§."
        KEYBINDING="<Alt>Above_Tab"
        ;;
esac

# Define paths
CINNAMON_JS="/usr/share/cinnamon/js/ui"
CINNAMON_SETTINGS="/usr/share/cinnamon/cinnamon-settings/modules"
SCHEMAS="/usr/share/glib-2.0/schemas"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES_DIR="$SCRIPT_DIR/files"

echo "Creating backups (if not already exist)..."

# Backup original files (only if backup doesn't exist)
if [ ! -f "$CINNAMON_JS/appSwitcher/appSwitcher.js.backup" ]; then
    sudo cp "$CINNAMON_JS/appSwitcher/appSwitcher.js" "$CINNAMON_JS/appSwitcher/appSwitcher.js.backup" 2>/dev/null || true
fi
if [ ! -f "$CINNAMON_JS/appSwitcher/classicSwitcher.js.backup" ]; then
    sudo cp "$CINNAMON_JS/appSwitcher/classicSwitcher.js" "$CINNAMON_JS/appSwitcher/classicSwitcher.js.backup" 2>/dev/null || true
fi
if [ ! -f "$CINNAMON_JS/windowManager.js.backup" ]; then
    sudo cp "$CINNAMON_JS/windowManager.js" "$CINNAMON_JS/windowManager.js.backup" 2>/dev/null || true
fi
if [ ! -f "$CINNAMON_SETTINGS/cs_windows.py.backup" ]; then
    sudo cp "$CINNAMON_SETTINGS/cs_windows.py" "$CINNAMON_SETTINGS/cs_windows.py.backup" 2>/dev/null || true
fi
if [ ! -f "$SCHEMAS/org.cinnamon.gschema.xml.backup" ]; then
    sudo cp "$SCHEMAS/org.cinnamon.gschema.xml" "$SCHEMAS/org.cinnamon.gschema.xml.backup" 2>/dev/null || true
fi

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

echo "Configuring keybindings..."
# Set the keybinding for switching windows of the same application
gsettings set org.cinnamon.desktop.keybindings.wm switch-group "['$KEYBINDING']"
gsettings set org.cinnamon.desktop.keybindings.wm switch-group-backward "['<Shift>$KEYBINDING']"

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
if [ "$choice" = "1" ]; then
    echo "Keybindings:"
    echo "  Alt+§ - Switch windows of same application"
    echo "  Shift+Alt+§ - Reverse switch windows of same application"
else
    echo "Keybindings:"
    echo "  Ctrl+§ - Switch windows of same application"
    echo "  Shift+Ctrl+§ - Reverse switch windows of same application"
fi
