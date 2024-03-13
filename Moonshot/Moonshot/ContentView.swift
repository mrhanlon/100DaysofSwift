//
//  ContentView.swift
//  Moonshot
//
//  Created by Matthew Hanlon on 2/15/24.
//

import SwiftUI

enum DisplayMode {
    case grid, list
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [GridItem(.adaptive(minimum: 150))]

    @State private var displayMode = DisplayMode.grid

    var body: some View {
        NavigationStack {
            VStack {
                if displayMode == .grid {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink(value: mission) {
                                    MissionCell(mission: mission)
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
                    List {
                        ForEach(missions) { mission in
                            NavigationLink(value: mission) {
                                MissionRow(mission: mission)
                            }
                            .listRowBackground(Color.darkBackground)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: Astronaut.self) { astronaut in
                AstronautView(astronaut: astronaut)
            }
            .toolbar {
                Button(
                    displayMode == .grid ? "Display as List" : "Display as Grid",
                    systemImage: displayMode == .grid ? "list.bullet" : "square.grid.2x2"
                ) {
                    displayMode = displayMode == .grid ? .list : .grid
                }

            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
