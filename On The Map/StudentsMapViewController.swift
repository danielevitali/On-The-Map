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

class StudentsMapViewController: UIViewController, StudentsTabContractView, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: StudentsTabContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StudentsTabPresenter(view: self)
        map.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadStudentsInformation()
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
        presenter.onStudentInformationClick(pin.studentInformation)
    }
    
    func toggleActivityIndicator(visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
            map.alpha = 0.5
        } else {
            activityIndicator.stopAnimating()
            map.alpha = 1
        }
    }
    
    func showStudentsInformation() {
        self.map.removeAnnotations(self.map.annotations)
        if let studentsInformation = presenter.studentsInformation {
            for studentInformation in studentsInformation {
                let pin = Pin(studentInformation: studentInformation)
                self.map.addAnnotation(pin)
            }
        }
    }
    
    func showStudentUrl(url: NSURL) {
        UIApplication.sharedApplication().openURL(url)
    }
    
}