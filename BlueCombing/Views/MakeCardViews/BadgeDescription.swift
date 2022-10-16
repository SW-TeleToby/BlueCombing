//
//  BadgeDescription.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/10/15.
//

import UIKit

extension String {
    func englishBadge() -> BadgeDescription {
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


enum BadgeDescription {
    case coral
    case clam
    case hippocampus
    case jellyfish
    case dolphin
    case turtle
    case fishs
    case whale
    
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
        let badgeCount: ArraySlice<String>
        
        switch self {
        case .coral:
            badgeCount =  badgeList[0...0]
        case .clam:
            badgeCount =  badgeList[0...1]
        case .hippocampus:
            badgeCount =  badgeList[0...2]
        case .jellyfish:
            badgeCount =  badgeList[0...3]
        case .dolphin:
            badgeCount =  badgeList[0...4]
        case .turtle:
            badgeCount =  badgeList[0...5]
        case .fishs:
            badgeCount =  badgeList[0...6]
        case .whale:
            badgeCount =  badgeList[0...7]
        }
        let badgesArray = Array(badgeCount)
        return badgesArray
    }
}
