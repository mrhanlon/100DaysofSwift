//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Matthew Hanlon on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(makeColor(proxy.frame(in: .global), fullView.frame(in: .global), index == 20))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(proxy.frame(in: .global).minY / 200)
                            .scaleEffect(scale(proxy.frame(in: .global), fullView.frame(in: .global), index == 20))
                    }
                    .frame(height: 40)
                }
            }
        }
    }

    func scale(_ inner: CGRect, _ outer: CGRect, _ log: Bool) -> Double {
        return (inner.minY / outer.maxY) + 0.5
    }

    func makeColor(_ inner: CGRect, _ outer: CGRect, _ log: Bool) -> Color {

        if log {
            print(max(0, min(1, inner.maxY / outer.maxY)))
        }

        return Color(hue: max(0, min(1, inner.maxY / outer.maxY)), saturation: 1.0, brightness: 1.0)
    }
}

#Preview {
    ContentView()
}
