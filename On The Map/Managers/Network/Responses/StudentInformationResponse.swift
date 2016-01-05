//
//  StudentLocation.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentInformationResponse {
    
    private static let DATE_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
    
    let objectId: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaUrl: String?
    let latitude: Double
    let longitude: Double
    let uniqueKey: String
    let updateAt: NSDate
    
    init(response: NSDictionary) {
        objectId = response["objectId"] as! String
        firstName = response["firstName"] as! String
        lastName = response["lastName"] as! String
        mapString = response["mapString"] as! String
        mediaUrl = response["mediaURL"] as? String
        latitude = response["latitude"] as! Double
        longitude = response["longitude"] as! Double
        uniqueKey = response["uniqueKey"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = StudentInformationResponse.DATE_FORMAT
        updateAt = dateFormatter.dateFromString(response["updatedAt"] as! String)!
    }
    
}