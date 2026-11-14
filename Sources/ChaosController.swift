import Cocoa
import SwiftUI

final class ChaosController: ObservableObject {
    static let shared = ChaosController()

    @Published var intensity: Double = 0.6
    @Published var soundEnabled: Bool = true
    @Published private(set) var isRunning = false
    @Published private(set) var popupCount = 0

    private var timer: Timer?
    private var popupWindows: [NSWindow] = []

    private let messages: [(String, String)] = [
        ("SYSTEMÜBERLASTUNG", "Dein Computer hat zu viele Gedanken gleichzeitig."),
        ("KRITISCHER KARTOFFELFEHLER", "Die digitale Kartoffel konnte nicht gefunden werden."),
        ("WARNUNG 0xBADA55", "Ein besonders verdächtiger Mauszeiger wurde entdeckt."),
        ("UPDATE VERFÜGBAR", "Version 0.0.0.2 bringt noch weniger Funktionen."),
        ("MOTIVATION.EXE", "Motivation wurde unerwartet beendet."),
        ("ZU VIELE TABS", "Dein Browser möchte kurz mit dir reden."),
        ("WICHTIGE MITTEILUNG", "Diese Mitteilung ist wirklich sehr wichtig. Vielleicht."),
        ("FEHLER 418", "Ich bin eine Teekanne. Bitte später erneut versuchen."),
        ("CPU DENKT NACH", "Bitte nicht stören. Die CPU erinnert sich an etwas."),
        ("APOKALYPSE FAST FERTIG", "Noch 7 bis 9000 völlig unnötige Schritte.")
    ]

    private init() {}

    func startChaos() {
        guard !isRunning else { return }
        isRunning = true
        spawnPopup()

        let interval = max(0.45, 2.2 - (intensity * 1.5))
        let chaosTimer = Timer(timeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.spawnPopup()
        }
        timer = chaosTimer
        RunLoop.main.add(chaosTimer, forMode: .common)
    }

    func stopChaos() {
        timer?.invalidate()
        timer = nil
        isRunning = false

        for window in popupWindows {
            window.close()
        }
        popupWindows.removeAll()
        popupCount = 0
    }

    private func spawnPopup() {
        popupWindows = popupWindows.filter { $0.isVisible }
        guard popupWindows.count < 12 else { return }

        let item = messages[Int.random(in: 0..<messages.count)]
        var popupWindow: NSWindow?
        let popup = FakePopupView(
            title: item.0,
            message: item.1,
            onDismiss: { [weak self] in
                popupWindow?.close()
                self?.removeClosedWindows()
            }
        )

        let width: CGFloat = 330
        let height: CGFloat = 170
        let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1200, height: 800)
        let maxX = max(screenFrame.minX, screenFrame.maxX - width)
        let maxY = max(screenFrame.minY, screenFrame.maxY - height)
        let x = CGFloat.random(in: screenFrame.minX...maxX)
        let y = CGFloat.random(in: screenFrame.minY...maxY)

        let window = NSWindow(
            contentRect: NSRect(x: x, y: y, width: width, height: height),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        popupWindow = window
        window.title = "Systemmeldung"
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: popup)

        // Ensure macOS brings the fake popup in front of the main app window.
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()

        popupWindows.append(window)
        popupCount = popupWindows.count

        if soundEnabled && Int.random(in: 0..<3) == 0 {
            NSSound.beep()
        }
    }

    private func removeClosedWindows() {
        popupWindows = popupWindows.filter { $0.isVisible }
        popupCount = popupWindows.count
    }
}

struct FakePopupView: View {
    let title: String
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text("⚠")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.95, green: 0.24, blue: 0.19))
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
            }

            Text(message)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Spacer()
                Button("Na gut") {
                    onDismiss()
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.windowBackgroundColor))
    }
}
