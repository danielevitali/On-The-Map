//
//  EditStudentLocationsResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class EditStudentInformationResponse {

    private static let DATE_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
    
    let updatedAt: NSDate
    
    init(response: NSDictionary) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = EditStudentInformationResponse.DATE_FORMAT
        updatedAt = dateFormatter.dateFromString(response["updatedAt"] as! String)!
    }
}