//
//  CardViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//
import SwiftUI
import Foundation

class CardViewModel: ObservableObject {
    @Published var newCard = Card(id: 0, distance: 0, time: 0, location: "", backgroundImage: UIImage(systemName: "xmark")!, badges: [])
    @Published var checkBadges: [Int] = []
    @Published var myBadges: [Int] = [1,2,3,4]
    init() {
        
    }
    
}
