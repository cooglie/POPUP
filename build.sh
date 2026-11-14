#!/bin/bash
set -e

cd "$(dirname "$0")"

APP="build/Popup Apocalypse.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

echo "Building Popup Apocalypse..."
swiftc -O \
  -target x86_64-apple-macosx10.15 \
  -framework Cocoa \
  -framework SwiftUI \
  Sources/AppDelegate.swift \
  Sources/ContentView.swift \
  Sources/ChaosController.swift \
  -o "$APP/Contents/MacOS/PopupApocalypse"

cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>PopupApocalypse</string>
    <key>CFBundleIdentifier</key>
    <string>de.cooglie.popupapocalypse</string>
    <key>CFBundleName</key>
    <string>Popup Apocalypse</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
PLIST

chmod +x "$APP/Contents/MacOS/PopupApocalypse"
echo "Built: $APP"
echo "Launch with: open \"$APP\""
