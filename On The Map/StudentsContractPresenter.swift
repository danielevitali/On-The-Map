//
//  LocationsContractPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

protocol StudentsContractPresenter {
    
    var view: StudentsContractView {get}
    var tabPresenter: StudentsTabContractPresenter? {get set}
    
    func onRefreshStudentsInformationClick()
    
    func onUpdateUserLocationClick()
    
    func onLogoutClick()
    
}