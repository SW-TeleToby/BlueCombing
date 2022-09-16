//
//  CardViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//
import SwiftUI
import Foundation

class CardViewModel: ObservableObject {
    @Published var card = Card(id: 0, distance: 0, time: 0, location: "", backgroundImage: UIImage(named: "xmark")!, badges: [])
    
}
