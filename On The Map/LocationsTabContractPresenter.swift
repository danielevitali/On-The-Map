//
//  LocationTabContractPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/1/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LocationsTabContractPresenter {
    
    var view: LocationsTabContractView {get}
    
    func loadLocations()
    
    func refreshingLocations()
    
    func showLocations(studentLocations: [StudentLocation]?)
    
}