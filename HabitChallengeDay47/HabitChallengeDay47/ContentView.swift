//
//  ContentView.swift
//  HabitChallengeDay47
//
//  Created by Matthew Hanlon on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var habits = Habits()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165))], spacing: 35.5) {
                    if habits.items.isEmpty {
                        NavigationLink {
                            AddView(habits: habits)
                        } label: {
                            VStack {
                                Text("Add your first habit")
                                Image(systemName: "plus.circle.fill")
                            }
                            .padding()
                            .frame(width: 165, height: 165)
                            .background(.indigo)
                            .foregroundStyle(.white)
                            .font(.system(size: 28, weight: .semibold))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 42)
                            )
                        }
                        HabitPlaceholder()
                        HabitPlaceholder()
                    } else {
                        ForEach(habits.items) { habit in
                            NavigationLink {
                                HabitView(habits: habits, habit: habit)
                            } label: {
                                HabitGridCell(habit: habit)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddView(habits: habits)
                    } label: {
                        Label("Add habit", systemImage: "plus.circle.fill")
                    }
                    .tint(.indigo)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
