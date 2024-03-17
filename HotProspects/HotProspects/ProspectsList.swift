//
//  ProspectsList.swift
//  HotProspects
//
//  Created by Matthew Hanlon on 3/16/24.
//

import SwiftData
import SwiftUI

struct ProspectsList<ListRow: View>: View {
    @Environment(\.modelContext) var modelContext

    @Query var prospects: [Prospect]
    private var selectedProspects: Binding<Set<Prospect>>

    let filter: Prospect.FilterType
    let listRow: (Prospect) -> ListRow

    init(filter: Prospect.FilterType, sortOrder: [SortDescriptor<Prospect>], selectedProspects: Binding<Set<Prospect>>, @ViewBuilder listRow: @escaping (Prospect) -> ListRow) {
        self.filter = filter

        if filter != .none {
            let showContactedOnly = filter == .contacted

            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        } else {
            _prospects = Query(sort: sortOrder)
        }

        self.selectedProspects = selectedProspects
        self.listRow = listRow
    }

    var body: some View {
        VStack {
            List(prospects, selection: selectedProspects) { prospect in
                listRow(prospect)
            }
            .overlay {
                if prospects.isEmpty {
                    Button("Add Example Prospects") {
                        let examples = [
                            Prospect(name: "Paul Hudson", emailAddress: "paul@hackingwithswift.com", isContacted: false),
                            Prospect(name: "Matt Hanlon", emailAddress: "matt@mrhanlon.com", isContacted: true)
                        ]
                        examples.forEach {
                            modelContext.insert($0)
                        }
                    }
                }
            }
        }
    }
}
