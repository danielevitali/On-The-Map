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
    
    init(view: StudentsTabContractView) {
        self.view = view
    }
    
    func loadStudentsInformation() {
        self.view.toggleActivityIndicator(true)
        DataManager.getInstance().getStudentsInformation({ (studentsInformation, errorMessage) in
            self.view.toggleActivityIndicator(false)
            if let studentsInformation = studentsInformation {
                self.view.showStudentsInformation(studentsInformation)
            } else {
                self.view.showError(errorMessage!)
            }
        })
    }
    
    func refreshingStudentsInformation() {
        view.toggleActivityIndicator(true)
    }
    
    func showStudentsInformation(studentsInformation: [StudentInformation]?) {
        view.toggleActivityIndicator(false)
        view.showStudentsInformation(studentsInformation)
    }
    
    func onStudentInformationClick(studentInformation: StudentInformation) {
        if let urlString = studentInformation.url {
            let url = NSURL(string: urlString)
            if let url = url {
                self.view.showStudentUrl(url)
            }
        }
    }
    
    func showError(message: String) {
        view.showError(message)
    }
    
    func loggingOut() {
        view.toggleActivityIndicator(true)
    }
    
}