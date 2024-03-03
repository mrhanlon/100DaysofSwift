//
//  UserRow.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//

import SwiftUI

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            Text(user.name)
            Spacer()
            if user.isActive {
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundStyle(.green)
            } else {
                Image(systemName: "circle")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    List {
        UserRow(user: User.sample(UserAttrs(isActive: true)))
        UserRow(user: User.sample(UserAttrs(isActive: false)))
    }
}
