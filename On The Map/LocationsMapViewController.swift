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

class LocationsMapViewController: UIViewController, LocationsTabContractView, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: LocationsTabContractPresenter!
    var studentLocations: [StudentLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationsTabPresenter(view: self)
        map.delegate = self
        
        presenter.loadLocations()
    }
    
    func showError(message: String) {
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
        presenter.onStudentLocationClick(pin.studentLocation)
    }
    
    func toggleActivityIndicator(visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showLocations(studentLocations: [StudentLocation]?) {
        self.studentLocations = studentLocations
        self.map.removeAnnotations(self.map.annotations)
        
        if let studentLocations = studentLocations {
            for studentLocation in studentLocations {
                let annotation = Pin(studentLocation: studentLocation)
                self.map.addAnnotation(annotation)
            }
        }
    }
    
    func showStudentUrl(url: NSURL) {
        UIApplication.sharedApplication().openURL(url)
    }
    
}