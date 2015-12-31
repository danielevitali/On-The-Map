//
//  StudentLocationsResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentLocationsResponse {
    
    var results: [StudentLocationResponse]
    
    init(response: NSDictionary) {
        self.results = [StudentLocationResponse]()
        let array = response["results"] as! NSArray
        for element in array {
            results.append(StudentLocationResponse(response: element as! NSDictionary))
        }
    }
    
}