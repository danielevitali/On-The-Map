//
//  PostStudentLocationResponse.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/3/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class PostStudentLocationResponse {
    
    private static let DATE_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
    
    let objectId: String
    let createdAt: NSDate
    
    init(response: NSDictionary) {
        objectId = response["objectId"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = PostStudentLocationResponse.DATE_FORMAT
        createdAt = dateFormatter.dateFromString(response["createdAt"] as! String)!
    }
    
}