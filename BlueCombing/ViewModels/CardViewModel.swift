//
//  CardViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//
import SwiftUI
import Foundation

class CardViewModel: ObservableObject {
    @Published var newCard = Card(id: 0, distance: 0, time: 0, location: "", backgroundImage: UIImage(systemName: "xmark")!, badge: Badge(id: 1, badgeImage: UIImage(named: "testBadge1")!, longExplanation: "1번 배지 설명입니다\n1번 배지는 이러이러합니다."))
    init() {
    
    }
    
    func makeNewCard(card: Card) {
        newCard = card
    }
    
    func changeBackgroundImage(image: UIImage) {
        newCard.backgroundImage = image
    }
}
