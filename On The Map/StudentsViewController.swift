//
//  HomeViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class StudentsViewController: UITabBarController, UITabBarControllerDelegate, StudentsContractView {
    
    var presenter: StudentsContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StudentsPresenter(view: self)
        delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBarHidden = false
        
        let currentView = selectedViewController as! StudentsTabContractView
        presenter.tabPresenter = currentView.presenter
    }

    @IBAction func onUpdateLocationClick(sender: AnyObject) {
        presenter.onUpdateUserLocationClick()
    }
    
    @IBAction func onRefreshClick(sender: AnyObject) {
        presenter.onRefreshStudentsInformationClick()
    }
    
    @IBAction func onLogoutClick(sender: AnyObject) {
        presenter.onLogoutClick()
    }
    
    func showUpdateUserLocation() {
    performSegueWithIdentifier("updateUserLocationSegue", sender: self)
    }
    
    func dismissView() {
        navigationController!.popViewControllerAnimated(true)
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let currentView = selectedViewController as! StudentsTabContractView
        presenter.tabPresenter = currentView.presenter
    }
}