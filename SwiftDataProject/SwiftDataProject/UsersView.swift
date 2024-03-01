//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Matthew Hanlon on 2/28/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }

    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                Text(user.name)
            }
        }
    }
}

#Preview {
    UsersView(minimumJoinDate: .distantPast, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
