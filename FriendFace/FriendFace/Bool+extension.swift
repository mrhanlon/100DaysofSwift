//
//  Utils.swift
//  FriendFace
//
//  Created by Matthew Hanlon on 3/3/24.
//

import Foundation

extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        !lhs && rhs
    }
}
