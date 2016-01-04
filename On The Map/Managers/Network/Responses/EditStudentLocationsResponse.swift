//
//  EditStudentLocationsResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class EditStudentLocationResponse {

    let createdAt: String
    
    init(response: NSDictionary) {
        createdAt = response["updatedAt"] as! String
    }
}