//
//  DetailView.swift
//  Bookworm
//
//  Created by Matthew Hanlon on 2/27/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                if book.genre == "" {
                    ZStack {
                        Color.gray
                            .frame(maxWidth: .infinity, minHeight: 200)
                        Image(systemName: "books.vertical.fill")
                            .font(.system(size: 128))
                            .foregroundStyle(.white)
                    }
                } else {
                    Image(book.genre)
                        .resizable()
                        .scaledToFit()
                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                }
            }

            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)


            Text(book.review)
                .padding()

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)

            Text("Read on \(book.dateReadFormatted)")
                .font(.footnote)
                .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }

    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "", review: "This was a great book; I really enjoyed it.", rating: 4)

        return NavigationStack {
            DetailView(book: example)
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
