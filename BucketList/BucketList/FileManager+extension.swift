//
//  FileManager+extension.swift
//  BucketList
//
//  Created by Matthew Hanlon on 3/7/24.
//

import Foundation

extension FileManager {
    func readContents(_ file: String) -> String {
        let url = URL.documentsDirectory.appending(path: file)
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to read data at \(url)")
//        }
        guard let contents = try? String(contentsOf: url) else {
            fatalError("Failed to read data at \(url)")
        }
        return contents
    }
}
