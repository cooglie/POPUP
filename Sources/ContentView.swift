import SwiftUI
import AppKit

struct ContentView: View {
    @ObservedObject private var chaos = ChaosController.shared

    var body: some View {
        ZStack {
            Color(red: 0.055, green: 0.065, blue: 0.09).edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 22) {
                header

                HStack(spacing: 14) {
                    statusCard
                    countCard
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("CHAOS CONTROL")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.48))
                        .tracking(2)

                    HStack {
                        Text("Chaos-Level")
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(Int(chaos.intensity * 100))%")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(Color(red: 1, green: 0.35, blue: 0.29))
                    }

                    Slider(value: $chaos.intensity, in: 0.2...1.0)

                    HStack {
                        Text("Ruhig")
                        Spacer()
                        Text("Völlig absurd")
                    }
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.4))

                    Toggle(isOn: $chaos.soundEnabled) {
                        HStack(spacing: 8) {
                            Text("♪")
                            Text("Zufällige Soundeffekte")
                        }
                        .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.top, 4)
                }
                .padding(20)
                .background(Color.white.opacity(0.055))
                .cornerRadius(16)

                HStack(spacing: 12) {
                    Button(action: { chaos.startChaos() }) {
                        HStack {
                            Text("🔥")
                            Text(chaos.isRunning ? "CHAOS LÄUFT" : "START CHAOS")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(red: 0.88, green: 0.16, blue: 0.14))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(chaos.isRunning)

                    Button(action: { chaos.stopChaos() }) {
                        HStack {
                            Text("■")
                            Text("NOTFALL-STOPP")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.white.opacity(0.1))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                HStack(alignment: .top, spacing: 10) {
                    Text("ⓘ")
                        .foregroundColor(Color(red: 1, green: 0.65, blue: 0.25))
                    Text("Popup Apocalypse erzeugt ausschließlich harmlose Fake-Fenster. Es verändert keine Systemeinstellungen und schließt keine echten Apps. Maximal 12 Popups gleichzeitig.")
                        .font(.system(size: 11))
                        .foregroundColor(Color.white.opacity(0.55))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
                HStack {
                    Text("POPUP APOCALYPSE")
                        .tracking(2)
                    Spacer()
                    Text("v1.0 • macOS 10.15+")
                }
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundColor(Color.white.opacity(0.28))
            }
            .padding(28)
        }
        .frame(minWidth: 650, minHeight: 520)
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 0.85, green: 0.13, blue: 0.13))
                    .frame(width: 58, height: 58)
                Text("⚠")
                    .font(.system(size: 27, weight: .bold))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("POPUP APOCALYPSE")
                    .font(.system(size: 23, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                Text("Dein Desktop. Deine Regeln. Totales Chaos.")
                    .font(.system(size: 12))
                    .foregroundColor(Color.white.opacity(0.5))
            }
            Spacer()
            Circle()
                .fill(chaos.isRunning ? Color.green : Color.gray)
                .frame(width: 8, height: 8)
            Text(chaos.isRunning ? "AKTIV" : "BEREIT")
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundColor(Color.white.opacity(0.65))
        }
    }

    private var statusCard: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("STATUS")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color.white.opacity(0.4))
            Text(chaos.isRunning ? "APOKALYPSE" : "Alles ruhig")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(chaos.isRunning ? Color(red: 1, green: 0.35, blue: 0.29) : .white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(17)
        .background(Color.white.opacity(0.055))
        .cornerRadius(13)
    }

    private var countCard: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("OFFENE FAKE-POPUPS")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color.white.opacity(0.4))
            Text("\(chaos.popupCount) / 12")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(17)
        .background(Color.white.opacity(0.055))
        .cornerRadius(13)
    }
}
