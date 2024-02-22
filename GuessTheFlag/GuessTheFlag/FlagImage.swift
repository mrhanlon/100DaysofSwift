//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Matthew Hanlon on 1/22/24.
//

import SwiftUI

struct FlagImage: View {
    let country: String

    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(country: "US")
}
