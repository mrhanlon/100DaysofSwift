//
//  PathStore.swift
//  Navigation
//
//  Created by Matthew Hanlon on 2/19/24.
//

import Foundation
import SwiftUI

@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }

        // Still here? Start with an empty path.
        path = []
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

//@Observable
//class PathStore {
//    var path: NavigationPath {
//        didSet {
//            save()
//        }
//    }
//
//    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
//
//    init() {
//        if let data = try? Data(contentsOf: savePath) {
//            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
//                path = NavigationPath(decoded)
//                return
//            }
//        }
//
//        // Still here? Start with an empty path.
//        path = NavigationPath()
//    }
//
//    func save() {
//        guard let representation = path.codable else { return }
//
//        do {
//            let data = try JSONEncoder().encode(representation)
//            try data.write(to: savePath)
//        } catch {
//            print("Failed to save navigation data")
//        }
//    }
//}
