//
//  StudentLocationsResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentInformationArrayResponse {
    
    var results: [StudentInformationResponse]
    
    init(response: NSDictionary) {
        self.results = [StudentInformationResponse]()
        let array = response["results"] as! NSArray
        for element in array {
            results.append(StudentInformationResponse(response: element as! NSDictionary))
        }
    }
    
}