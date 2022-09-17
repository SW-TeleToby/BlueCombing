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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = UIColor(.combingBlue4)
            render.lineWidth = 7
            return render
        }
        return MKOverlayRenderer()
    }

    private func fetchDistance(current: CLLocationCoordinate2D, forward: CLLocationCoordinate2D) -> CLLocationDistance {
        let currentLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        let forwardLocation = CLLocation(latitude: forward.latitude, longitude: forward.longitude)

        return currentLocation.distance(from: forwardLocation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //Create View
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            //Assign annotation
            annotationView?.annotation = annotation
        }
        
        //Set image
        switch annotation.title {
        case "trash":
            annotationView?.image = UIImage(named: "img_trash")
        case "picker":
            annotationView?.image = UIImage(named: "img_picker")
        case "trash-bag":
            annotationView?.image = UIImage(named: "img_trash_bag")
        default:
            break
        }
        
        return annotationView
    }
}
