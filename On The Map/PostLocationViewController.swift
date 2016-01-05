//
//  PostLocationViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PostLocationViewController: UIViewController, PostLocationContractView, UITextFieldDelegate {
    
    private static let MAP_ZOOM_LATITUDE_DELTA = 0.05
    private static let MAP_ZOOM_LONGITUDE_DELTA = 0.05
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var btnFindPlace: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfLink: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: PostLocationContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PostLocationPresenter(view: self)
        
        tfAddress.delegate = self
        tfLink.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onSubmitClick(sender: AnyObject) {
        presenter.onSubmitClick(tfLink.text!)
        dismissKeyboard()
    }
    
    @IBAction func onFindPlaceClick(sender: AnyObject) {
        presenter.onFindPlaceClick(tfAddress.text!)
        dismissKeyboard()
    }
    
    @IBAction func onCancelClick(sender: AnyObject) {
        presenter.onCancelClick()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func showMapWithLocation(coordinate: CLLocationCoordinate2D) {
        addAnnotationonMap(coordinate)
        tfAddress.hidden = true
    }
    
    private func addAnnotationonMap(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: PostLocationViewController.MAP_ZOOM_LATITUDE_DELTA, longitudeDelta: PostLocationViewController.MAP_ZOOM_LONGITUDE_DELTA))
        self.map.setRegion(region, animated: true)
    }
    
    func showLinkInput() {
        lblPlace.hidden = true
        tfLink.hidden = false
        map.hidden = false
    }
    
    func swapFindPlaceWithSubmitButton() {
        btnFindPlace.hidden = true
        btnSubmit.hidden = false
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func toggleActivityIndicator(visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func disableUIForFindingPlace() {
        btnFindPlace.enabled = false
        btnFindPlace.alpha = 0.5
        tfAddress.enabled = false
        tfAddress.alpha = 0.5
    }
    
    func enableUI() {
        btnFindPlace.enabled = true
        btnFindPlace.alpha = 1
        tfAddress.enabled = true
        tfAddress.alpha = 1
    }
}