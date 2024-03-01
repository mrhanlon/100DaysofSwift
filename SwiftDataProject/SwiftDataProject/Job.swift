//
//  Job.swift
//  SwiftDataProject
//
//  Created by Matthew Hanlon on 2/29/24.
//

import Foundation
import SwiftData

@Model
class Job {
    var name: String = ""
    var priority: Int = 1
    var owner: User?

    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }

    static func sampleJob(for user: User, modelContext: ModelContext) -> Job {
        let job = Job(name: "Mow the lawn", priority: 2)
        modelContext.insert(job)
        user.jobs?.append(job)

        return job
    }
}
