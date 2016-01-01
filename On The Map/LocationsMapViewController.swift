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

class LocationsMapViewController: UIViewController, LocationsMapContractView, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: LocationsMapContractPresenter!
    var studentLocations: [StudentLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationsMapPresenter(view: self)
        map.delegate = self
        
        DataManager.getInstance().getStudentLocations { (studentLocations, errorMessage) in
            if let studentLocations = studentLocations {
                self.studentLocations = studentLocations
                self.map.removeAnnotations(self.map.annotations)

                for studentLocation in studentLocations {
                    let annotation = Pin(studentLocation: studentLocation)
                    self.map.addAnnotation(annotation)
                }
            } else {
                self.showError(errorMessage!)
            }
        }
    }
    
    private func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = annotation as! Pin
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(Pin.VIEW_ID) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = pin.createAnnotationView()
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let pin = view.annotation as! Pin
        if let url = pin.url {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    func toggleActivityIndicator(visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showLocations(studentLocations: [StudentLocation]?) {
        //TODO show locations on map
    }
    
}