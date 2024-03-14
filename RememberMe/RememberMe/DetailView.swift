//
//  DetailView.swift
//  RememberMe
//
//  Created by Matthew Hanlon on 3/13/24.
//

import MapKit
import SwiftData
import SwiftUI

struct DetailView: View {
    let person: Person

    var body: some View {
        ScrollView {
            VStack {
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

                if let coordinate = person.coordinate {
                    let position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                        )
                    )

                    VStack(alignment: .leading) {
                        Text("Location:")
                            .font(.headline)

                        Map(initialPosition: position, interactionModes: [.zoom]) {
                            Marker("", coordinate: coordinate)
                        }
                        .frame(height: 200)
                    }
                    .padding()
                } else {
                    Text("No location")
                        .foregroundStyle(.secondary)
                        .padding()
                }
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
