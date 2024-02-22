//
//  AstronautView.swift
//  Moonshot
//
//  Created by Matthew Hanlon on 2/17/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return NavigationStack {
        AstronautView(astronaut: astronauts["grissom"]!)
    }
    .preferredColorScheme(.dark)
}
