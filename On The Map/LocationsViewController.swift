//
//  HomeViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LocationsViewController: UITabBarController, LocationsContractView{
    
    private static let SHOW_AUTHENTICATION_SEGUE_ID = "showAuthentication"
    
    private var presenter: LocationsContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationsPresenter(view: self)
    }

    @IBAction func onUpdateLocationClick(sender: AnyObject) {
        presenter.onUpdateLocationClick()
    }
    
    @IBAction func onRefreshClick(sender: AnyObject) {
        presenter.onRefreshLocationsClick()
    }
    
    @IBAction func onLogoutClick(sender: AnyObject) {
        presenter.onLogoutClick()
    }
    
    func showUpdateLocation() {
        
    }
    
    func showAuthentication() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}