//
//  StringExtension.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/10/16.
//

import Foundation

extension String {
    func translateBadge() -> BadgeDescription {
        switch self {
        case "산호초":
            return .coral
        case "조개":
            return .clam
        case "해마":
            return .hippocampus
        case "해파리":
            return .jellyfish
        case "돌고래":
            return .dolphin
        case "거북이":
            return .turtle
        case "물고기 떼":
            return .fishs
        case "고래":
            return .whale
        default:
            return .coral
        }

    }
}
