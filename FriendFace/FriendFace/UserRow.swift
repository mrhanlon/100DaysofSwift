//
//  UserRow.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/2/24.
//
import SwiftData
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)

        return List {
            UserRow(user: User.sample(User.UserAttrs(isActive: true)))
            UserRow(user: User.sample(User.UserAttrs(isActive: false)))
        }
        .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
