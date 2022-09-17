//
//  CanvasView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/17.
//

import Foundation
import SwiftUI
import UIKit
import MapKit

struct CanvasView: View {
//    @State var tempCoordinates: [CLLocationCoordinate2D] = [
//        CLLocationCoordinate2D(latitude: 36.663, longitude: 127.501),
//        CLLocationCoordinate2D(latitude: 36.664, longitude: 127.503),
//        CLLocationCoordinate2D(latitude: 36.665, longitude: 127.501),
//        CLLocationCoordinate2D(latitude: 36.666, longitude: 127.504),
//        CLLocationCoordinate2D(latitude: 36.667, longitude: 127.501),
//        CLLocationCoordinate2D(latitude: 36.668, longitude: 127.480),
//    ]
    @Binding var pathCoordinates: [CLLocationCoordinate2D]

    var body: some View {
        Path { path in
            var highestLat: Float = 0.0
            var lowestLat: Float = 0.0
            var highestLot: Float = 0.0
            var lowestLot: Float = 0.0

            var canvasLat: Float = 0.0
            var canvasLot: Float = 0.0

            var lats = [Float]()
            var lots = [Float]()

            for ele in pathCoordinates {
                lats.append(Float(ele.latitude))
                lots.append(Float(ele.longitude))
            }

            highestLat = lats.max()!
            lowestLat = lats.min()!

            highestLot = lots.max()!
            lowestLot = lots.min()!

            canvasLat = highestLat - lowestLat
            canvasLot = highestLot - lowestLot


            guard let first = pathCoordinates.first else { return }
            let a = UIScreen.main.bounds.height * calcuateRatio(highest: highestLat, current: first.latitude, canvas: canvasLat, hOrW: .height)
            var b = UIScreen.main.bounds.width * calcuateRatio(highest: highestLot, current: first.longitude, canvas: canvasLot, hOrW: .width)


            if b.isNaN {
                b = UIScreen.main.bounds.width / 2
            }

            path.move(to: CGPoint(x: b, y: a))

            for ele in pathCoordinates {
                if ele.latitude == first.latitude && ele.longitude == first.longitude {
                    continue
                }

                var a = UIScreen.main.bounds.height * calcuateRatio(highest: highestLat, current: ele.latitude, canvas: canvasLat, hOrW: .height)
                var b = UIScreen.main.bounds.width * calcuateRatio(highest: highestLot, current: ele.longitude, canvas: canvasLot, hOrW: .width)

                if a.isNaN {
                    a = UIScreen.main.bounds.height / 2
                }

                if b.isNaN {
                    b = UIScreen.main.bounds.width / 2
                }

                print(a, b)

                path.addLine(to: CGPoint(x: b, y: a))
            }

        }
            .stroke(Color("combingBlue4"), lineWidth: 7)
    }

    func calcuateRatio(highest: Float, current: Double, canvas: Float, hOrW: HeightorWidth) -> CGFloat {
        switch hOrW {
        case .height:
            let result = CGFloat((highest - Float(current)) / canvas)
            return result
        case .width:
            return CGFloat((highest - Float(current)) / canvas)
        }
    }

}

enum HeightorWidth: Int {
    case height = 0
    case width = 1
}
