//
//  PostStudentLocationResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class PostStudentLocationResponse {
    
    let objectId: String
    let createdAt: String
    
    init(response: NSDictionary) {
        objectId = response["objectId"] as! String
        createdAt = response["createdAt"] as! String
    }
    
}