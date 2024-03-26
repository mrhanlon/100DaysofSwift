//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Matthew Hanlon on 3/25/24.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }

            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }

    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }

    var price: String {
        String(repeating: "$", count: resort.price)
    }
}

#Preview {
    ResortDetailsView(resort: Resort.example)
}
