//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Matthew Hanlon on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 10

    var body: some View {
        VStack {
            Button("John Fitzgerald Kennedy") {
                print("Button tapped")
            }
            .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
        }
    }
}

#Preview {
    ContentView()
}
