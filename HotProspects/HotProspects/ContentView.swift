//
//  ContentView.swift
//  HotProspects
//
//  Created by Matthew Hanlon on 3/14/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
