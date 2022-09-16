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
    
    func makeUIView(context: Context) -> some UIView {
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

