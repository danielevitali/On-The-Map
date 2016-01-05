//
//  LocationTabContractPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/1/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol StudentsTabContractPresenter {
    
    var view: StudentsTabContractView {get}
    var studentsInformation: [StudentInformation]? {get set}
    
    func loadStudentsInformation()
    
    func refreshingStudentsInformation()
    
    func showStudentsInformation(studentsInformation: [StudentInformation]?)
    
    func onStudentInformationClick(studentInformation: StudentInformation)
    
    func showError(message: String)
    
    func loggingOut()
}