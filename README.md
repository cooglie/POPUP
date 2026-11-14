# Popup Apocalypse

Native macOS app built with SwiftUI and AppKit. Minimum target: macOS 10.15 Catalina.

## Features
- Start/stop controlled desktop chaos
- Random fake system alerts
- Adjustable chaos level
- Optional beep sound effects
- Maximum 12 fake popup windows at once
- Emergency stop closes all generated popups

The app creates harmless fake windows only. It does not change system settings, terminate real apps, or execute shell commands.

## Requirements
- macOS 10.15 or newer
- Xcode Command Line Tools (or Xcode)
- Swift compiler

Check:
```bash
xcode-select -p
swift --version
```

## Build
Run from the project directory:
```bash
chmod +x build.sh
./build.sh
```

The app will be created at `build/Popup Apocalypse.app`.

Launch:
```bash
open "build/Popup Apocalypse.app"
```

## Compatibility
The build script targets Intel x86_64 with macOS 10.15 as deployment target. Apple Silicon Macs can usually run the Intel app using Rosetta.
