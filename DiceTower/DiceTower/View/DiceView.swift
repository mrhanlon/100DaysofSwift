//
//  DiceView.swift
//  DiceTower
//
//  Created by Matthew Hanlon on 3/22/24.
//

//import CoreHaptics
import SwiftData
import SwiftUI

struct DiceView: View {
    @Bindable var diceSet: DiceSet

//    @State private var engine: CHHapticEngine?
    @State private var timer = Timer.publish(every: 0.1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var timerStart: Date?
    @State private var rolling = false
    @State private var rollTime = 0.0

    let onRoll: ([Die]) -> Void
    let rollDuration = 3.0

    var body: some View {
        VStack {
            HStack {
                ForEach(diceSet.dice) { die in
                    VStack {
                        Text("\(die.type.rawValue)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .diceStyle(color: .clear)

                        if die.currentValue > 0 {
                            Text("\(die.currentValue)")
                                .diceStyle(color: .cyan)
                                .rollingRotation(rolling, rollAmount: rollTime)
                        } else {
                            Text("?")
                                .diceStyle(color: .gray)
                        }
                    }
                    .accessibilityElement()
                    .accessibilityLabel(rolling ? "Die is rolling" : (
                        die.currentValue > 0 ? "Die value is \(die.currentValue)" : "Die has not been rolled")
                    )
                    .accessibilityHint("\(die.type.rawValue)-sided die")
                }
            }
            .sensoryFeedback(.decrease, trigger: rollDuration - rollTime)
            .padding()

            Button("Roll dice", action: rollDice)
                .disabled(rolling)
                .buttonStyle(.bordered)

            if !rolling &&  diceSet.hasRolled {
                Text("Dice roll total is: \(diceSet.currentRollTotal)")
                    .padding(.top)
            }
        }
        .onReceive(timer) { time in
            guard rolling else { return }

            diceSet.roll()

            if let start = timerStart {
                rollTime = time.timeIntervalSince(start)

                if rollTime > rollDuration {
                    stopTimer()
                    onRoll(diceSet.dice)
                }
            } else {
                timerStart = time
            }
        }
        .onAppear {
            stopTimer()
//            prepareHaptics()
        }
    }

    func rollDice() {
        rolling = true
        diceSet.roll()
        timer = Timer.publish(every: 0.1, tolerance: 0.5, on: .main, in: .common).autoconnect()
//        rollingHapticEffect()
    }

    func stopTimer() {
        timer.upstream.connect().cancel()
        rolling = false
        timerStart = nil
        rollTime = 0
    }


//    func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("There was an error creating the engine: \(error.localizedDescription)")
//        }
//    }
//
//    func rollingHapticEffect() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        var events = [CHHapticEvent]()
//
//        for i in stride(from: 0, to: 3, by: 0.1) {
//            let value = Float(3 - i)
//
//            let intensity = CHHapticEventParameter(
//                parameterID: .hapticIntensity,
//                value: value
//            )
//            let sharpness = CHHapticEventParameter(
//                parameterID: .hapticSharpness,
//                value: value
//            )
//            let event = CHHapticEvent(
//                eventType: .hapticTransient,
//                parameters: [intensity, sharpness],
//                relativeTime: i
//            )
//            events.append(event)
//        }
//
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
}

#Preview {
    DiceView(diceSet: DiceSet()) { _ in }
}
