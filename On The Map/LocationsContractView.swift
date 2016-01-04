//
//  LocationsContractView.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LocationsContractView {
    
    var presenter: LocationsContractPresenter! {get}
    
    func showError(message: String)
    
    func showUpdateUserLocation()
    
    func showAuthentication()
    
}