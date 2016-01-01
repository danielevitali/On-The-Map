//
//  LocationsTabContractView.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/1/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LocationsTabContractView {
    
    var presenter: LocationsTabContractPresenter! {get set}
    
    func toggleActivityIndicator(visible: Bool)
    
    func showLocations(studentLocations: [StudentLocation]?)
    
    func showError(message: String)
    
}