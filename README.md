# Cinnamon: Group Windows by Application

A clean, stable solution to make Alt+Tab group windows by application in Linux Mint Cinnamon, similar to how macOS handles Cmd+Tab.

## What this does

- **Alt+Tab** shows one icon per application (grouped), not one per window
- **Alt+`** instantly switches between windows of the same application (no popup)
- Shows **application name** instead of window title in the switcher
- Fully **configurable** via System Settings

## Features

- Clean integration with Cinnamon settings (System Settings → Windows → Alt-Tab)
- Toggle on/off anytime - when disabled, Cinnamon behaves exactly as before
- Safe installation with automatic backups
- Easy uninstall to restore original behavior

## Screenshots

### Settings Panel
The new option appears in System Settings → Windows → Alt-Tab:

`Group windows by application`

### Behavior
- **Enabled**: Alt+Tab shows one entry per app, Alt+` cycles windows instantly
- **Disabled**: Original Cinnamon behavior (one entry per window)

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/cinnamon-group-windows-by-app.git
cd cinnamon-group-windows-by-app
chmod +x install.sh
./install.sh
```

Then restart Cinnamon: **Alt+F2** → type `r` → Enter

## Uninstallation

```bash
./uninstall.sh
```

Then restart Cinnamon: **Alt+F2** → type `r` → Enter

## Configuration

After installation, go to:

**System Settings → Windows → Alt-Tab**

Toggle **"Group windows by application"** on or off.

You can also use the terminal:
```bash
# Enable
gsettings set org.cinnamon alttab-switcher-group-by-app true

# Disable
gsettings set org.cinnamon alttab-switcher-group-by-app false

# Check current value
gsettings get org.cinnamon alttab-switcher-group-by-app
```

## How it works

This modification adds a new GSettings key `alttab-switcher-group-by-app` and modifies the Alt+Tab switcher behavior when enabled:

1. **appSwitcher.js** - Groups windows by `wm_class` (application identifier)
2. **classicSwitcher.js** - Displays app name instead of window title
3. **windowManager.js** - Enables instant window cycling with Alt+`
4. **cs_windows.py** - Adds the toggle to System Settings
5. **org.cinnamon.gschema.xml** - Defines the new setting

## Compatibility

- **Cinnamon 6.x** (Linux Mint 22+)
- Should work on older versions but not tested

## Safety

- All original files are backed up during installation (`.backup` extension)
- Only modifies JavaScript/Python files, no compiled binaries
- The uninstall script restores all original files
- When the setting is disabled, behavior is identical to stock Cinnamon

## Files Modified

| File | Location |
|------|----------|
| appSwitcher.js | `/usr/share/cinnamon/js/ui/appSwitcher/` |
| classicSwitcher.js | `/usr/share/cinnamon/js/ui/appSwitcher/` |
| windowManager.js | `/usr/share/cinnamon/js/ui/` |
| cs_windows.py | `/usr/share/cinnamon/cinnamon-settings/modules/` |
| org.cinnamon.gschema.xml | `/usr/share/glib-2.0/schemas/` |

## Troubleshooting

**Q: Alt+Tab still shows individual windows**
A: Make sure "Group windows by application" is enabled in System Settings → Windows → Alt-Tab

**Q: Changes don't take effect**
A: Restart Cinnamon with Alt+F2 → `r` → Enter

**Q: How do I completely remove this?**
A: Run `./uninstall.sh` and restart Cinnamon

## Keywords

Linux Mint, Cinnamon, Alt-Tab, window switcher, group by application, app-centric, window grouping, application switcher, Cmd+Tab, switch windows, desktop environment, window management

## Author

Developed by **Kevin Navarro** ([@berserking](https://github.com/berserking))

Contact: navarro.kevin@pucp.edu.pe

## License

MIT License - Feel free to use, modify, and distribute.

## Contributing

Issues and pull requests are welcome.
