//
//  MapView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @Binding var map: MKMapView
    let delegate = MapDelegate()
    
    func makeUIView(context: Context) -> some UIView {
        map.isPitchEnabled = false
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.isRotateEnabled = false
        map.region.span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        map.delegate = delegate
        
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
