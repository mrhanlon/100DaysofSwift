//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Matthew Hanlon on 3/16/24.
//

import SwiftUI

struct EditProspectView: View {
    @Environment(\.dismiss) var dismiss

    let prospect: Prospect

    @State private var name: String
    @State private var emailAddress: String

    init(prospect: Prospect) {
        self.prospect = prospect
        _name = State(initialValue: prospect.name)
        _emailAddress = State(initialValue: prospect.emailAddress)
    }

    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }

            Section("Email address") {
                TextField("Email address", text: $emailAddress)
            }
        }
        .navigationTitle(prospect.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save") {
                prospect.name = name
                prospect.emailAddress = emailAddress
                dismiss()
            }
        }
    }
}
