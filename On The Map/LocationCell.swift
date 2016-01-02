//
//  LocationCell.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    
    func setLocation(studentLocation: StudentLocation) {
        lblName.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
    }
    
}