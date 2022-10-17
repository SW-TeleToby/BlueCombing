//
//  BadgeDescription.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/10/15.
//

import UIKit

enum BadgeDescription: String {
    case coral = "산호초"
    case clam = "조개"
    case hippocampus = "해마"
    case jellyfish = "해파리"
    case dolphin = "돌고래"
    case turtle = "거북이"
    case fishs = "물고기 떼"
    case whale = "고래"
    
    var badgeDescription: String {
        switch self {
        case .coral:
            return "당신은 산호초처럼\n파릇파릇한 바다지킴이네요"
        case .clam:
            return "오늘도 바다를 꾸준히 지킨\n당신은 바다의 조개같은 존재예요!"
        case .hippocampus:
            return "이젠 바다를 지키는게\n익숙한 당신은 바다의 해마에요"
        case .jellyfish:
            return "바다 주변을 끊임없이 둘러보는\n당신은 바다의 해파리 같아요"
        case .dolphin:
            return "멋진 돌고래 같은 당신!\n덕분에 오늘도 바다가 깨끗해요"
        case .turtle:
            return "오늘도 장로 거북이처럼\n노련하게 바다를 지키고 계시는군요!"
        case .fishs:
            return "작은 노력을 모아 바다를 돌보는\n당신은 거대한 물고기 떼 같아요"
        case .whale:
            return "항상 변함없이 바다를 지키는\n당신은 바다의 주인인 고래 같아요"
        }
    }
    
    var badgeImage: UIImage {
        switch self {
        case .coral:
            return UIImage(named: "img_badge_coral")!
        case .clam:
            return UIImage(named: "img_badge_clam")!
        case .hippocampus:
            return UIImage(named: "img_badge_hippocampus")!
        case .jellyfish:
            return UIImage(named: "img_badge_jellyfish")!
        case .dolphin:
            return UIImage(named: "img_badge_dolphin")!
        case .turtle:
            return UIImage(named: "img_badge_turtle")!
        case .fishs:
            return UIImage(named: "img_badge_fishs")!
        case .whale:
            return UIImage(named: "img_badge_whale")!
        }
    }
    
    var myBadges: Array<String> {
        let badgeList = ["산호초", "조개", "해마", "해파리", "돌고래", "거북이", "물고기 떼", "고래"]
        switch self {
        case .coral:
            return Array(badgeList[0...0])
        case .clam:
            return Array(badgeList[0...0])
        case .hippocampus:
            return Array(badgeList[0...0])
        case .jellyfish:
            return Array(badgeList[0...0])
        case .dolphin:
            return Array(badgeList[0...0])
        case .turtle:
            return Array(badgeList[0...0])
        case .fishs:
            return Array(badgeList[0...0])
        case .whale:
            return Array(badgeList[0...0])
        }
    }
}
