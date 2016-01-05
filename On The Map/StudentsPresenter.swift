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

class StudentsPresenter: StudentsContractPresenter {
    
    let view: StudentsContractView
    var tabPresenter: StudentsTabContractPresenter?
    
    init(view: StudentsContractView) {
        self.view = view
    }
    
    func onRefreshStudentsInformationClick() {
        tabPresenter!.refreshingStudentsInformation()
        DataManager.getInstance().forceUpdateStudentsInformation( { (studentsInformation, errorMessage) in
            self.tabPresenter!.showStudentsInformation(nil)
            if let errorMessage = errorMessage {
                self.view.showError(errorMessage)
            } else  {
                guard studentsInformation != nil else {
                    self.view.showError("Unknown error")
                    return
                }
                let studentsInformationSorted = studentsInformation!.sort({
                    return $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == NSComparisonResult.OrderedAscending
                })
                self.tabPresenter!.showStudentsInformation(studentsInformationSorted)
            }
        })
    }
    
    func onUpdateUserLocationClick() {
        view.showUpdateUserLocation()
    }
    
    func onLogoutClick() {
        tabPresenter!.loggingOut()
        DataManager.getInstance().logout( { (errorMessage: String?) -> Void in
            if let errorMessage = errorMessage {
                self.tabPresenter!.showError(errorMessage)
            } else {
                self.view.dismissView()
            }
        })
    }
    
}