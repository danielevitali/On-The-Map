//
//  LocationCell.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    func setStudentInformation(studentInformation: StudentInformation) {
        lblName.text = "\(studentInformation.firstName) \(studentInformation.lastName)"
        lblLocation.text = studentInformation.address
    }
    
}