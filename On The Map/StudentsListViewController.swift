//
//  LocationsListViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class StudentsListViewController: UIViewController, StudentsTabContractView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblLocations: UITableView!
    @IBOutlet weak var lblNoLocations: UILabel!
    
    var presenter: StudentsTabContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StudentsTabPresenter(view: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadStudentsInformation()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let studentsInformation = presenter.studentsInformation {
            return studentsInformation.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("studentCell")! as! StudentCell
        let info = presenter.studentsInformation![indexPath.row]
        cell.setStudentInformation(info)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presenter.onStudentInformationClick(presenter.studentsInformation![indexPath.row])
    }
    
    func toggleActivityIndicator(visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
            tblLocations.alpha = 0.5
        } else {
            activityIndicator.stopAnimating()
            tblLocations.alpha = 1
        }
    }
    
    func showStudentsInformation() {
        let studentsInformation = presenter.studentsInformation
        tblLocations.reloadData()
        
        if let studentsInformation = studentsInformation where studentsInformation.count > 0 {
            lblNoLocations.hidden = true
        } else {
            lblNoLocations.hidden = false
        }
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showStudentUrl(url: NSURL) {
        UIApplication.sharedApplication().openURL(url)
    }
    
}