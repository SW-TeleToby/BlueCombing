//
//  MapDelegate.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import Foundation
import UIKit
import MapKit

class MapDelegate: UIViewController, MKMapViewDelegate {
    var map =  MKMapView()
    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if overlay is MKPolyline {
//            let current = mapView.region.center
//            let forward = overlay.coordinate
//
//            // MARK: 오차범위 변수로 표시하기
//            if fetchDistance(current: current, forward: forward) < 15 {
//                return MKOverlayRenderer()
//            }
//            let render = MKPolylineRenderer(overlay: overlay)
//            render.strokeColor = .blue
//            render.lineWidth = 3
//            return render
//        }
//        return MKOverlayRenderer()
//    }
//
//    private func fetchDistance(current: CLLocationCoordinate2D, forward: CLLocationCoordinate2D) -> CLLocationDistance {
//        let currentLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
//        let forwardLocation = CLLocation(latitude: forward.latitude, longitude: forward.longitude)
//
//        return currentLocation.distance(from: forwardLocation)
//    }
}
