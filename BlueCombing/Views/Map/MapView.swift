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
    @Binding var pathCoordinates: [CLLocationCoordinate2D]
    @Binding var movingDistance : Double
    let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    
    @StateObject var locationVM = LocationViewModel()
    
    func makeUIView(context: Context) -> some UIView {
        map.isPitchEnabled = false
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.isRotateEnabled = false
        map.showsTraffic = false
        map.delegate = context.coordinator
        
        map.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.0519679, longitude: 129.378830),
            span: span
        )
        
        for location in locationVM.locations {
            let pin = MKPointAnnotation()
            pin.title = location.thing
            pin.coordinate = location.coordinate
            map.addAnnotation(pin)
        }
        
        return map
    }
    
    func makeCoordinator() -> MapDelegate {
        return MapDelegate()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let firstFromBack = pathCoordinates.last else { return }
        // 마지막에 추가된 좌표를 지도 한가운데로 옮기는 작업입니다.
        let region = MKCoordinateRegion(center: firstFromBack, span: span)
        map.setRegion(region, animated: true)
        
        guard pathCoordinates.count >= 2 else { return }
        
        // 찍혀있던 좌표에서 마지막 좌표와 마지막 두번째 좌표 거리 값 더하는 로직입니다.
        let secondFromBack = pathCoordinates[pathCoordinates.count - 2]
        let firstFromBackLocation = CLLocation(latitude: firstFromBack.latitude, longitude: firstFromBack.longitude)
        let secondFromBackLoaction = CLLocation(latitude: secondFromBack.latitude, longitude: secondFromBack.longitude)
        movingDistance += firstFromBackLocation.distance(from: secondFromBackLoaction)
        
        // 지도상에 경로를 그리는 작업입니다. 경로가 그려져 있다면 경로를 삭제후 다시 그립니다.
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
