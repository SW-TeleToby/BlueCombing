//
//  User.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import Foundation

struct User: Identifiable {
    var id: String
    var totalDistance: Int
    var totalTime: Int
    var myBadges: [String]
    var myCards: [String]
    var representBadge: String
}
