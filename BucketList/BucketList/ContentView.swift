//
//  ContentView.swift
//  BucketList
//
//  Created by Matthew Hanlon on 3/7/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    enum MapMode: String, CaseIterable {
        case Standard, Hybrid, Realistic
    }

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    @State private var viewModel = ViewModel()
    @State private var mode: MapMode = .Standard

    var body: some View {
        NavigationStack {
            if viewModel.isUnlocked {
                ZStack(alignment: .topLeading) {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .mapStyle(
                            mode == .Standard ? .standard : (
                                mode == .Hybrid ? .hybrid : .hybrid(elevation: .realistic)
                            )
                        )
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem {
                            Menu("Map settings", systemImage: "gear") {
                                Picker("Map type", selection: $mode) {
                                    ForEach(MapMode.allCases, id: \.self) {
                                        Text($0.rawValue)
                                    }
                                }
                            }
                        }
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                }
            } else if viewModel.isBiometricsUnavailable {
                Text("Authentication unavailable!")
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Authentication failed", isPresented: $viewModel.isAuthenticationError) { } message: {
            Text(viewModel.authenticationErrorMessage)
        }
    }
}

#Preview {
    ContentView()
}
