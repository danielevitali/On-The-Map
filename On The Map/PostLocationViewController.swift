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

class PostLocationViewController: UIViewController, PostLocationContractView {
    
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
    }
    
    @IBAction func onSubmitClick(sender: AnyObject) {
        presenter.onSubmitClick(tfLink.text!)
    }
    
    @IBAction func onFindPlaceClick(sender: AnyObject) {
        presenter.onFindPlaceClick(tfAddress.text!)
    }
    
    @IBAction func onCancelClick(sender: AnyObject) {
        presenter.onCancelClick()
    }
    
    func showMapWithLocation(coordinate: CLLocationCoordinate2D) {
        addAnnotationonMap(coordinate)
        tfAddress.hidden = true
    }
    
    private func addAnnotationonMap(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
    }
    
    func showLinkInput() {
        lblPlace.hidden = true
        tfLink.hidden = false
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
    
}