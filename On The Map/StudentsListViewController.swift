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
    var studentsInformation: [StudentInformation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StudentsTabPresenter(view: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadStudentsInformation()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let studentsInformation = studentsInformation {
            return studentsInformation.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("studentCell")! as! StudentCell
        let info = studentsInformation![indexPath.row]
        cell.setStudentInformation(info)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presenter.onStudentInformationClick(studentsInformation![indexPath.row])
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
    
    func showStudentsInformation(studentsInformation: [StudentInformation]?) {
        self.studentsInformation = studentsInformation
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