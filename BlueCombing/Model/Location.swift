//
//  Location.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/18.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Decodable {
    let id = UUID()
    let thing: String
    let lon: Double
    let lat: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    enum CodingKeys: String, CodingKey {
        case thing, lon, lat
    }
}
