//
//  Global.swift
//  BeerTracker
//
//  Created by Doron Katz on 3/10/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation

struct Global{
    static let kLoginFlowEnabled = false
    static let kEncryptionEnabled = false
    static let kSyncEnabled = false
    static let kServerDbURL = URL(string: "localhost:4984/db")!
    static let kDatabaseName = "db"
    static let kLoggingEnabled = false
    static let kUsePrebuiltDb = false
    static let kConflictResolution = false
}
