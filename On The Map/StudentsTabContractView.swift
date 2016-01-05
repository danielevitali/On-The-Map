//
//  LocationsTabContractView.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/1/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol StudentsTabContractView {
    
    var presenter: StudentsTabContractPresenter! {get set}
    
    func toggleActivityIndicator(visible: Bool)
    
    func showStudentsInformation(studentsInformation: [StudentInformation]?)
    
    func showError(message: String)
    
    func showStudentUrl(url: NSURL)
    
}