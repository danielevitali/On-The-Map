//
//  LocationsMapViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationsMapViewController: UIViewController, LocationsMapContractView {
    
    @IBOutlet weak var map: MKMapView!
    
    var presenter: LocationsMapContractPresenter!
    var studentLocations: [StudentLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationsMapPresenter(view: self)
        
        DataManager.getInstance().getStudentLocations { (studentLocations, errorMessage) in
            if let studentLocations = studentLocations {
                self.studentLocations = studentLocations
                self.map.removeAnnotations(self.map.annotations)

                for studentLocation in studentLocations {
                    let lat = CLLocationDegrees(studentLocation.latitude)
                    let long = CLLocationDegrees(studentLocation.longitude)
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(studentLocation.firstName) \(studentLocation.lastName)"
                    annotation.subtitle = studentLocation.url
                    
                    self.map.addAnnotation(annotation)
                }                
            } else {
                self.showError(errorMessage!)
            }
        }
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}