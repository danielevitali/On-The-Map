//
//  Location.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    private static let DATE_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
    
    var id: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var address: String
    var url: NSURL?
    var userId: String
    var lastUpdate: NSDate
    
    init(studentInformationResponse: StudentInformationResponse) {
        self.id = studentInformationResponse.objectId
        self.firstName = studentInformationResponse.firstName
        self.lastName = studentInformationResponse.lastName
        self.latitude = studentInformationResponse.latitude
        self.longitude = studentInformationResponse.longitude
        self.address = studentInformationResponse.mapString
        self.userId = studentInformationResponse.uniqueKey
        self.lastUpdate = studentInformationResponse.updateAt
        
        if let mediaUrl = studentInformationResponse.mediaUrl {
            url = NSURL(string: mediaUrl)
        }
    }
    
    init(response: NSDictionary) {
        id = response["objectId"] as! String
        firstName = response["firstName"] as! String
        lastName = response["lastName"] as! String
        address = response["mapString"] as! String
        if let mediaUrl = response["mediaURL"] as? String {
            url = NSURL(string: mediaUrl)
        }
        latitude = response["latitude"] as! Double
        longitude = response["longitude"] as! Double
        userId = response["uniqueKey"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = StudentInformation.DATE_FORMAT
        lastUpdate = dateFormatter.dateFromString(response["updatedAt"] as! String)!
    }
    
    init(id: String, firstName: String, lastName: String, latitude: Double, longitude: Double, address: String, url: NSURL?, userId: String, lastUpdate: NSDate) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.lastUpdate = lastUpdate
        self.userId = userId
        self.url = url
    }
}