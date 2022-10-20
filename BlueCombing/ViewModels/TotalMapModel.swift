//
//  TotalMapModel.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/15.
//

import SwiftUI
import MapKit
import UIKit

struct TotalMapModel {
    var map = MKMapView()
    var currentModal: CustomModal = .startModal
    var isRecordStart = false
}

struct UserActivityData {
    // TODO: GPS 연결되면 초기값 변경해야 합니다.
    var pathCoordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 36.0519679, longitude: 129.378830)]
    var movingTime: Int = 0
    var movingDistance: Double = 0.0
}
