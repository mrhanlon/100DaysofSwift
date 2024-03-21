//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Matthew Hanlon on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
                .offset(x: 100, y: 100)
                .background(.red)
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

#Preview {
    ContentView()
}
