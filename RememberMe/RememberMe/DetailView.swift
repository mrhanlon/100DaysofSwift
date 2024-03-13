//
//  DetailView.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/13/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let person: Person

    var body: some View {
        ScrollView {
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
        }
        .navigationTitle(person.name)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)

        container.mainContext.insert(Person.example)

        return NavigationStack {
            DetailView(person: Person.example)
        }
        .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
