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
    @State var map: MKMapView
    let delegate: MapDelegate
    @Binding var pathCoordinates: [CLLocationCoordinate2D]
    @Binding var movingDistance : Double
    let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    
    func makeUIView(context: Context) -> some UIView {
//        map.isPitchEnabled = false
//        map.isZoomEnabled = false
//        map.isScrollEnabled = false
//        map.isRotateEnabled = false
//        map.showsTraffic = false
        map.delegate = delegate
        
        map.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.662222, longitude: 127.501667),
            span: span
        )
        
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let first = pathCoordinates.first, let last = pathCoordinates.last else { return }
        let region = MKCoordinateRegion(center: last, span: span)
        map.setRegion(region, animated: true)
        
        movingDistance = CLLocation(latitude: first.latitude, longitude: first.longitude).distance(from: CLLocation(latitude: last.latitude, longitude: last.longitude))
        
        if pathCoordinates.count < 1 {
            return
        }

        let line = MKPolyline(coordinates: pathCoordinates, count: pathCoordinates.count)
        
        if map.overlays.isEmpty {
            map.addOverlay(line)
        }
        else {
            map.removeOverlays(map.overlays)
            map.addOverlay(line)
        }
    }
}
