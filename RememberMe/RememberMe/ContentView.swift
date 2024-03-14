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

    @State private var path = NavigationPath()

    @State private var pickerItem: PhotosPickerItem?
    @State private var editPerson: Person?

    var body: some View {
        NavigationStack(path: $path) {
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
                            }
                            .frame(width: 100, height: 75)
                            .padding(.trailing)

                            Text(person.name)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    for i in indexSet {
                        modelContext.delete(people[i])
                    }
                })
            }
            .overlay {
                if people.isEmpty {
                    ContentUnavailableView {
                        Label("No photos", systemImage: "person.crop.rectangle.badge.plus")
                    } description: {
                        Text("Add a photos to remember people's names")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $pickerItem, matching: .all(of: [.images, .not(.screenshots)])) {
                        Label("Add person", systemImage: "person.crop.rectangle.badge.plus")
                    }
                    .onChange(of: pickerItem, addPersonForImage)
                }
            }
            .navigationTitle("Remember me")
            .navigationDestination(for: Person.self) { person in
                if person.name.isEmpty {
                    EditPersonView(person: person)
                } else {
                    DetailView(person: person)
                }
            }
        }
    }

    func addPersonForImage() {
        Task {
            guard let imageData = try await pickerItem?.loadTransferable(type: Data.self) else { return }

            let newPerson = Person(name: "", imageData: imageData)
            path.append(newPerson)
            modelContext.insert(newPerson)
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
