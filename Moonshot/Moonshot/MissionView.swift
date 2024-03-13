//
//  MissionView.swift
//  Moonshot
//
//  Created by Matthew Hanlon on 2/17/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            fatalError("Missing \(member.name)")
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { w, a in
                        w * 0.6
                    }
                    .padding(.vertical)
                    .accessibilityLabel("\(mission.displayName) mission patch")

                if let _ = mission.launchDate {
                    VStack {
                        Text(mission.formattedLaunchDate)
                            .font(.title2)
                        Text("Launch Date")
                            .font(.caption)
                    }.accessibilityElement()
                        .accessibilityLabel("Launch Date: \(mission.formattedLaunchDate)")
                } else {
                    Text("(Did not launch)")
                        .font(.caption)
                }

                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)

                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)

                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)

                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(value: crewMember.astronaut) {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.circle)
                                        .overlay(
                                            Circle()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                .padding(.horizontal)
                                .accessibilityElement()
                                .accessibilityLabel("\(crewMember.astronaut.name): \(crewMember.role)")
                            }
                        }
                    }
                }
            }
            .padding(.bottom)

        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return NavigationStack {
        MissionView(mission: missions[6], astronauts: astronauts)
    }
    .preferredColorScheme(.dark)
}
