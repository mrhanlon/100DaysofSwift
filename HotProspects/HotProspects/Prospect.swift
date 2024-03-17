//
//  Prospect.swift
//  HotProspects
//
//  Created by Matthew Hanlon on 3/15/24.
//

import Foundation
import SwiftData

enum ProspectSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1,0,0)
    static var models: [any PersistentModel.Type] {
        [Prospect.self]
    }

    @Model
    class Prospect {
        var name: String
        var emailAddress: String
        var isContacted: Bool

        init(name: String, emailAddress: String, isContacted: Bool) {
            self.name = name
            self.emailAddress = emailAddress
            self.isContacted = isContacted
        }
    }

}

enum ProspectSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2,0,0)
    static var models: [any PersistentModel.Type] {
        [Prospect.self]
    }

    @Model
    class Prospect {
        var name: String
        var emailAddress: String
        var isContacted: Bool
        var dateAdded: Date = Date.now

        init(name: String, emailAddress: String, isContacted: Bool, dateAdded: Date = .now) {
            self.name = name
            self.emailAddress = emailAddress
            self.isContacted = isContacted
            self.dateAdded = dateAdded
        }
    }
}

typealias Prospect = ProspectSchemaV2.Prospect

extension Prospect {
    enum FilterType {
        case none, contacted, uncontacted
    }
}

enum ProspectSchemaMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ProspectSchemaV1.self, ProspectSchemaV2.self]
    }

    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: ProspectSchemaV1.self,
        toVersion: ProspectSchemaV2.self
    )

    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
}
