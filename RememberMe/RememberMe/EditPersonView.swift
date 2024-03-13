//
//  AddPersonSheet.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/12/24.
//

import SwiftData
import SwiftUI

struct EditPersonView: View {
    @Environment(\.dismiss) var dismiss

    let person: Person

    @State private var name: String

    init(person: Person) {
        self.person = person
        _name = State(initialValue: person.name)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if let uiImage = UIImage(data: person.imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .accessibilityLabel("Photo of \(person.name)")
                    } else {
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .accessibilityLabel("Missing photo")
                    }
                    TextField("Person name", text: $name)
                }
            }
            .navigationTitle(name.isEmpty ? "Add person" : name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        person.name = name
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)

        container.mainContext.insert(Person.example)

        return EditPersonView(person: Person.example)
            .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
