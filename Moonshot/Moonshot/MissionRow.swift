//
//  MissionRow.swift
//  Moonshot
//
//  Created by Matthew Hanlon on 2/17/24.
//

import SwiftUI

struct MissionRow: View {
    let mission: Mission
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")

    return List {
        MissionRow(mission: missions[0])
            .listRowBackground(Color.darkBackground)
    }
    .listStyle(.plain)
    .preferredColorScheme(.dark)
}
