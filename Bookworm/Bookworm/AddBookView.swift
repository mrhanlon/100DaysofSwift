//
//  AddBookView.swift
//  Bookworm
//
//  Created by Matthew Hanlon on 2/26/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var rating = 3
    @State private var review = ""
    @State private var dateRead = Date.now

    private var saveEnabled: Bool {
        !(
            title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        )
    }

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)

                    RatingView(rating: $rating)

                    DatePicker("Date read:", selection: $dateRead, in: ...Date.now, displayedComponents: .date)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(saveEnabled == false)
                }
            }
            .navigationTitle("Add book")
        }
    }
}

#Preview {
    AddBookView()
}
