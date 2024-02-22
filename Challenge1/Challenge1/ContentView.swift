//
//  ContentView.swift
//  Challenge1
//
//  Created by Matthew Hanlon on 12/22/23.
//

import SwiftUI

enum Units: String, CaseIterable {
    case inches, feet, yards, miles
    case millimeters, centimeters, meters, kilometers
}

struct ContentView: View {
    @State private var inputValue = 1.0
    @State private var inputUnit: Units = Units.inches
    @State private var outputUnit: Units = Units.centimeters
    @FocusState private var inputFocused: Bool

    private var inputValueCm: Double {
        switch inputUnit {
        case .inches:
            return inputValue * 2.54
        case .feet:
            return inputValue * 12 * 2.54
        case .yards:
            return inputValue * 3 * 12 * 2.54
        case .miles:
            return inputValue * 5280 * 12 * 2.54
        case .millimeters:
            return inputValue / 10
        case .centimeters:
            return inputValue
        case .meters:
            return inputValue * 100
        case .kilometers:
            return inputValue * 1000 * 100
        }
    }

    private var convertedValue: Double {
        switch outputUnit {
        case .inches:
            return inputValueCm / 2.54
        case .feet:
            return inputValueCm / 2.54 / 12
        case .yards:
            return inputValueCm / 2.54 / 12 / 3
        case .miles:
            return inputValueCm / 2.54 / 12 / 5280
        case .millimeters:
            return inputValueCm * 10
        case .centimeters:
            return inputValueCm
        case .meters:
            return inputValueCm / 100
        case .kilometers:
            return inputValueCm / 100 / 1000
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Input value") {
                    TextField("Input value", value: $inputValue, format: .number)
                        .focused($inputFocused)
                    Picker("units", selection: $inputUnit) {
                        ForEach(Units.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                Section("Output unit") {
                    Picker("units", selection: $outputUnit) {
                        ForEach(Units.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                Section("Converted value") {
                    Text(convertedValue, format: .number)
                }
            }
            .navigationTitle("Convert units")
            .toolbar {
                if inputFocused {
                    Button("Done") {
                        inputFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
