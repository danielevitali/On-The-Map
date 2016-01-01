//
//  LocationsMapPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class LocationsMapPresenter: LocationsMapContractPresenter, LocationsTabContractPresenter {
    
    private let view: LocationsMapContractView
    
    init(view: LocationsMapContractView) {
        self.view = view
    }
    
}