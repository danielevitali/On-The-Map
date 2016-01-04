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
    
    let view: LocationsContractView
    var tabPresenter: LocationsTabContractPresenter?
    
    init(view: LocationsContractView) {
        self.view = view
    }
    
    func onRefreshLocationsClick() {
        tabPresenter!.refreshingLocations()
        DataManager.getInstance().forceUpdateStudentLocations { (studentLocations, errorMessage) -> Void in
            self.tabPresenter!.showLocations(nil)
            if let errorMessage = errorMessage {
                self.view.showError(errorMessage)
            } else  {
                guard studentLocations != nil else {
                    self.view.showError("Unknown error")
                    return
                }
                self.tabPresenter!.showLocations(studentLocations)
            }
        }
    }
    
    func onUpdateUserLocationClick() {
        view.showUpdateUserLocation()
    }
    
    func onLogoutClick() {
        FBSDKLoginManager().logOut()
        DataManager.getInstance().clearUserInfo()
        view.dismissView()
    }
    
}