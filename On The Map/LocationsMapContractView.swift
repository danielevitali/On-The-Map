//
//  LocationsMapContractView.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LocationsMapContractView: LocationsTabContractView {
    
    var presenter: LocationsMapContractPresenter! {get set}
    
    func toggleActivityIndicator(visible: Bool)
    
    func showLocations(studentLocations: [StudentLocation]?)
    
    func showError(message: String)
}