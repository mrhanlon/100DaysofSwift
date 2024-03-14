//
//  AddPersonSheet.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/12/24.
//

import MapKit
import SwiftData
import SwiftUI

struct EditPersonView: View {

    @Environment(\.dismiss) var dismiss

    let person: Person
    @State private var name: String
    @State private var includeLocation = true
    @State private var locationFetcher = LocationFetcher()

    init(person: Person) {
        self.person = person
        _name = State(initialValue: person.name)
    }

    var body: some View {
        Form {
            Section("Name") {
                TextField("Person name", text: $name)
            }

            Section("Location") {
                Toggle("Include location?", isOn: $includeLocation)

                if includeLocation {
                    if let coordinate = locationFetcher.lastKnownLocation {
                        let position = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                            )
                        )
                        Map(initialPosition: position, interactionModes: []) {
                            Marker("", coordinate: coordinate)
                        }
                        .frame(maxWidth: .infinity, idealHeight: 200)
                    } else {
                        Text("No location available")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section("Picture") {
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
        }
        .navigationTitle(name.isEmpty ? "Add person" : name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    person.name = name
                    if includeLocation {
                        person.coordinate = locationFetcher.lastKnownLocation
                    }
                    dismiss()
                }
            }
        }
        .onAppear {
            locationFetcher.start()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)

        container.mainContext.insert(Person.example)

        return NavigationStack {
            EditPersonView(person: Person.example)
        }.modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
