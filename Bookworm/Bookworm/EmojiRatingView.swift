//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Matthew Hanlon on 2/26/24.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    var body: some View {
        switch rating {
        case 1:
            Text("🌧️")
                .accessibilityLabel("1 star")
        case 2:
            Text("☁️")
                .accessibilityLabel("2 stars")
        case 3:
            Text("🌤️")
                .accessibilityLabel("3 stars")
        case 4:
            Text("☀️")
                .accessibilityLabel("4 stars")
        default:
            Text("🌈")
                .accessibilityLabel("5 stars")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 5)
}
