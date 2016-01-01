//
//  LocationsMapPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class LocationsTabPresenter: LocationsTabContractPresenter {
    
    let view: LocationsTabContractView
    
    init(view: LocationsTabContractView) {
        self.view = view
    }
    
    func loadLocations() {
        self.view.toggleActivityIndicator(true)
        DataManager.getInstance().getStudentLocations { (studentLocations, errorMessage) in
            self.view.toggleActivityIndicator(false)
            if let studentLocations = studentLocations {
                self.view.showLocations(studentLocations)
            } else {
                self.view.showError(errorMessage!)
            }
        }
    }
    
    func refreshingLocations() {
        view.toggleActivityIndicator(true)
    }
    
    func showLocations(studentLocations: [StudentLocation]?) {
        view.toggleActivityIndicator(false)
        view.showLocations(studentLocations)
    }
    
}