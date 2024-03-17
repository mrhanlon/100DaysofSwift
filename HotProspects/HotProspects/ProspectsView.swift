//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Matthew Hanlon on 3/15/24.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext

    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var sort: [SortDescriptor<Prospect>] = [SortDescriptor(\Prospect.name)]

    let notificationCenter = UNUserNotificationCenter.current()
    let filter: Prospect.FilterType

    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

    init(filter: Prospect.FilterType) {
        self.filter = filter
        if filter != .none {
            let showContactedOnly = filter == .contacted

            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }

    var body: some View {
        NavigationStack {
            ProspectsList(filter: filter, sortOrder: sort, selectedProspects: $selectedProspects) { prospect in
                NavigationLink {
                    EditProspectView(prospect: prospect)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }

                        if filter == .none && prospect.isContacted {
                            Spacer()
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }

                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)

                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sort) {
                            Text("By name (ascending)")
                                .tag([SortDescriptor(\Prospect.name)])
                            Text("By name (descending)")
                                .tag([SortDescriptor(\Prospect.name, order: .reverse)])
                            Text("Date added (newest first)")
                                .tag([
                                    SortDescriptor(\Prospect.dateAdded, order: .reverse),
                                    SortDescriptor(\Prospect.name)
                                ])
                            Text("Date added (oldest first)")
                                .tag([
                                    SortDescriptor(\Prospect.dateAdded, order: .forward),
                                    SortDescriptor(\Prospect.name)
                                ])
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", role: .destructive, action: delete)
                            .tint(.red)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    func addNotification(for prospect: Prospect) {
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default


            // Notify in 5 seconds
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            // Notify next 9am
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)


            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            notificationCenter.add(request)
        }

        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    guard let modelContainer = PreviewUtil.modelContainer else {
        return Text("Failed to create container")
    }

    return ProspectsView(filter: .none)
        .modelContainer(modelContainer)
}
