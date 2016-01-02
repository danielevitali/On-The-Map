//
//  HomeViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LocationsViewController: UITabBarController, LocationsContractView {
    
    var presenter: LocationsContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationsPresenter(view: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let currentView = selectedViewController as! LocationsTabContractView
        presenter.tabPresenter = currentView.presenter
    }

    @IBAction func onUpdateLocationClick(sender: AnyObject) {
        presenter.onUpdateUserLocationClick()
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
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let currentView = selectedViewController as! LocationsTabContractView
        presenter.tabPresenter = currentView.presenter
    }
}