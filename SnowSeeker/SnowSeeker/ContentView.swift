//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Matthew Hanlon on 3/25/24.
//

import SwiftUI

struct ContentView: View {
    enum ResortSort: String, CaseIterable {
        case name = "Name"
        case country = "Country"
    }

    @State private var searchText = ""
    @State private var sort: ResortSort?
    @State var favorites = Favorites()

    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }

                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        let selectedSort = Binding<ResortSort?>(
                            get: { self.sort },
                            set: { self.sort = $0 == self.sort ? nil : $0 }
                        )
                        Picker("Sort", selection: selectedSort) {
                            ForEach(ResortSort.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag(Optional($0))
                            }
                        }
                    }
                }
            }

            WelcomeView()
        }
        .environment(favorites)
//        .phoneOnlyStackNavigationView()
    }

    var sortedResorts: [Resort] {
        print(sort ?? "none")

        switch sort {
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted {
                if $0.country == $1.country {
                    return $0.name < $1.name
                }
                return $0.country < $1.country
            }
        default:
            return filteredResorts
        }
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }

        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

#Preview {
    ContentView()
}
