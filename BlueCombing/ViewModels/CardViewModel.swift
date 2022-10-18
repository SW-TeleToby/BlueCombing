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
    @Published var card = CardData(id: 0, distance: 0.0, time: 0, location: "", backgroundImage: UIImage(named: "img_card_default") ?? UIImage(systemName: "xmark")!, badgeImage: UIImage(named: "img_badge_lock") ?? UIImage(systemName: "xmark")!)
    
    public static var longitude: Double = 0.0
    public static var latitude: Double = 0.0
    public static var location: String = ""
    public static var distance: Double = 0.0
    public static var time: Int = 0
    
    private let imagePredictor = ImagePredictor()
    private let predictionsToShow = 2
    
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
                    if let si = address.locality {
                        if doo != si {
                            collab += si
                        }
                    }
                }
                
                
                self.card.location = collab
                CardViewModel.location = collab
            }
            
        }
    }
    
    func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else { return }

        let formattedPredictions = formatPredictions(predictions)
        let predictionString = formattedPredictions.joined(separator: "\n")
        
        let target = predictions[0]
        
        let confidence = target.confidencePercentage.components(separatedBy: CharacterSet.init(charactersIn: "0123456789.").inverted).joined(separator: "")
        
        if Float(confidence) ?? 0 > 85 {
            var name = target.classification

            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            self.card.location = name
        } else {
            self.card.location = CardViewModel.location
        }
        
        
    }

    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
    
    func makeCard(card: CardData) {
        self.card = card
    }
    
    func changeBackgroundImage(image: UIImage) {
        card.backgroundImage = image
    }
    
}
