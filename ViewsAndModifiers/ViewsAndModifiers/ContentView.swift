//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Matthew Hanlon on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .titleText()
            .padding()
            .background(.yellow)
            .clipShape(.capsule)
    }
}

struct Titleize : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func titleText() -> some View {
        modifier(Titleize())
    }
}


#Preview {
    ContentView()
}
