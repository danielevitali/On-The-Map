//
//  StudentLocation.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentLocationResponse {
    
    let objectId: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaUrl: String
    let latitude: Float
    let longitude: Float
    let uniqueKey: String
    
    init(response: NSDictionary) {
        objectId = response["objectId"] as! String
        firstName = response["firstName"] as! String
        lastName = response["lastName"] as! String
        mapString = response["mapString"] as! String
        mediaUrl = response["mediaUrl"] as! String
        latitude = response["latitude"] as! Float
        longitude = response["longitude"] as! Float
        uniqueKey = response["uniqueKey"] as! String
    }
    
}