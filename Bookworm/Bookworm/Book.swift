//
//  Book.swift
//  Bookworm
//
//  Created by Matthew Hanlon on 2/26/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int

    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }

    static func sampleData(modelContext: ModelContext) {
        modelContext.insert(Book(title: "Feed", author: "M.T. Anderson", genre: "Kids", review: "A must read for everyone", rating: 4))
        modelContext.insert(Book(title: "Left Hand of Darkness", author: "Ursula K. LeGuin", genre: "Fantasy", review: "A must read for everyone", rating: 5))
        modelContext.insert(Book(title: "Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", genre: "Thriller", review: "A must read for everyone", rating: 3))
        modelContext.insert(Book(title: "Murder on the Orient Express", author: "Agatha Christie", genre: "Mystery", review: "A must read for everyone", rating: 2))
    }
}
