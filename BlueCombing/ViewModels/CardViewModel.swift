//
//  CardViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//
import SwiftUI
import Foundation
import MapKit

class CardViewModel: ObservableObject {
    @Published var newCard = Card(id: 0, distance: 0, time: 0, location: "포항시 영일대 해수욕장", backgroundImage: UIImage(named: "img_card_default")!, badge: Badge(id: 1, badgeImage: UIImage(named: "testBadge1")!, longExplanation: "1번 배지 설명입니다\n1번 배지는 이러이러합니다."))
    

    public static var longitude: Double = 0.0
    public static var latitude: Double = 0.0
    public static var location: String = ""
    init() {
        
    }
    
    func checkLocation() {
        let location = CLLocation(latitude: CardViewModel.latitude, longitude: CardViewModel.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, _ in
            guard let placemarks = placemarks,
            let address = placemarks.last
            else {return}
            DispatchQueue.main.async {
                var collab = ""
                if let doo = address.administrativeArea {
                    collab += doo + " "
                }
                
                if let si = address.locality {
                    collab += si
                }
                CardViewModel.location = collab
            }
            
        }
    }
    
    func makeNewCard(card: Card) {
        newCard = card
    }
    
    func changeBackgroundImage(image: UIImage) {
        newCard.backgroundImage = image
    }
    
}
