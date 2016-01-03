//
//  Pin.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/31/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    
    static let VIEW_ID = "pin"
    
    var studentLocation: StudentLocation
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var url: String?
    
    init(studentLocation: StudentLocation) {
        self.studentLocation = studentLocation
        coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
        title = "\(studentLocation.firstName) \(studentLocation.lastName)"
        subtitle = studentLocation.address
        url = studentLocation.url
    }
    
    func createAnnotationView() -> MKPinAnnotationView {
        let pinView = MKPinAnnotationView(annotation: self, reuseIdentifier: Pin.VIEW_ID)
        pinView.pinTintColor = UIColor.blueColor()
        
        if url == nil {
            pinView.canShowCallout = false
        } else {
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        return pinView
    }
}