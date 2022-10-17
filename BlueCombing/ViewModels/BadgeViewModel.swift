//
//  BadgeViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import Foundation
import SwiftUI

class BadgeViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var badgeImage: UIImage = UIImage(named: "img_badge_coral")!
    
    func changeDescription(presentBadge: String) {
        let badge = presentBadge.translateBadge()
        description = badge.badgeDescription
        badgeImage = badge.badgeImage
    }
    
}
