//
//  ContentView.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/12/24.
//  Day 77 - Challenge

import SwiftData
import SwiftUI
import PhotosUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Person.name, order: .forward)]) var people: [Person]

    @State private var pickerItem: PhotosPickerItem?
    @State private var editPerson: Person?

    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        HStack {
                            VStack {
                                if let uiImage = UIImage(data: person.imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }.frame(width: 150, height: 75)
                            Text(person.name)
                            Spacer()
                        }
                    }
                }
            }
            .toolbar {
                PhotosPicker(selection: $pickerItem, matching: .all(of: [.images, .not(.screenshots)])) {
                    Label("Add person", systemImage: "person.crop.rectangle.badge.plus")
                }
                .onChange(of: pickerItem, addPersonForImage)

            }
            .navigationTitle("Remember me")
            .navigationDestination(for: Person.self) {
                DetailView(person: $0)
            }
            .sheet(item: $editPerson) { person in
                EditPersonView(person: person)
            }
        }
    }

    func addPersonForImage() {
        Task {
            guard let imageData = try await pickerItem?.loadTransferable(type: Data.self) else { return }
            let newPerson = Person(name: "", imageData: imageData)
            modelContext.insert(newPerson)

            editPerson = newPerson
            pickerItem = nil
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)

        container.mainContext.insert(Person.example)

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
