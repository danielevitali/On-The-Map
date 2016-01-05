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
    
    var studentInformation: StudentInformation
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(studentInformation: StudentInformation) {
        self.studentInformation = studentInformation
        coordinate = CLLocationCoordinate2D(latitude: studentInformation.latitude, longitude: studentInformation.longitude)
        title = "\(studentInformation.firstName) \(studentInformation.lastName)"
        subtitle = studentInformation.url
    }
    
    func createAnnotationView() -> MKPinAnnotationView {
        let pinView = MKPinAnnotationView(annotation: self, reuseIdentifier: Pin.VIEW_ID)
        pinView.pinTintColor = UIColor.blueColor()
        pinView.canShowCallout = true
        pinView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        return pinView
    }
}