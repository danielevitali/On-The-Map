//
//  LocationsListViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LocationsListViewController: UIViewController, LocationsTabContractView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblLocations: UITableView!
    @IBOutlet weak var lblNoLocations: UILabel!
    
    var presenter: LocationsTabContractPresenter!
    var studentLocations: [StudentLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationsTabPresenter(view: self)
        
        presenter.loadLocations()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let studentLocations = studentLocations {
            return studentLocations.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
        tblLocations.reloadData()
        
        if studentLocations != nil || studentLocations!.count == 0 {
            lblNoLocations.hidden = true
        } else {
            lblNoLocations.hidden = false
        }
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
}