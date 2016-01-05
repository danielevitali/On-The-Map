//
//  LocationsMapPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class StudentsTabPresenter: StudentsTabContractPresenter {
    
    let view: StudentsTabContractView
    var studentsInformation: [StudentInformation]?
    
    init(view: StudentsTabContractView) {
        self.view = view
    }
    
    func loadStudentsInformation() {
        self.view.toggleActivityIndicator(true)
        DataManager.getInstance().getStudentsInformation({ (studentsInformation, errorMessage) in
            self.view.toggleActivityIndicator(false)
            self.studentsInformation = studentsInformation
            if let errorMessage = errorMessage {
                self.view.showError(errorMessage)
            } else {
                self.view.showStudentsInformation()
            }
        })
    }
    
    func refreshingStudentsInformation() {
        view.toggleActivityIndicator(true)
    }
    
    func showStudentsInformation(studentsInformation: [StudentInformation]?) {
        view.toggleActivityIndicator(false)
        self.studentsInformation = studentsInformation
        view.showStudentsInformation()
    }
    
    func onStudentInformationClick(studentInformation: StudentInformation) {
        if let url = studentInformation.url {
            self.view.showStudentUrl(url)
        }
    }
    
    func showError(message: String) {
        view.showError(message)
    }
    
    func loggingOut() {
        view.toggleActivityIndicator(true)
    }
    
}