//
//  StudentLocationsResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentLocationsResponse {
    
    let results: [StudentLocationResponse]
    
    init(response: NSDictionary) {
        results = response["results"] as! [StudentLocationResponse]
    }
    
}