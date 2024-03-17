//
//  PreviewUtil.swift
//  HotProspects
//
//  Created by Matthew Hanlon on 3/17/24.
//

import Foundation
import SwiftData

struct PreviewUtil {
    static var modelContainer: ModelContainer? {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try? ModelContainer(for: Prospect.self, configurations: config)
    }
}
