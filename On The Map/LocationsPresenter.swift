//
//  LocationsPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class LocationsPresenter: LocationsContractPresenter {
    
    private let view: LocationsContractView
    
    init(view: LocationsContractView) {
        self.view = view
    }
    
    func onRefreshLocationsClick() {
        
    }
    
    func onUpdateLocationClick() {
        
    }
    
    func onLogoutClick() {
        FBSDKLoginManager().logOut()
        DataManager.getInstance().clearUserInfo()
    }
    
}