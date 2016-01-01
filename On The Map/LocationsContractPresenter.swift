//
//  LocationsContractPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LocationsContractPresenter {
    
    var view: LocationsContractView {get}
    var tabPresenter: LocationsTabContractPresenter? {get set}
    
    func onRefreshLocationsClick()
    
    func onUpdateUserLocationClick()
    
    func onLogoutClick()
    
}