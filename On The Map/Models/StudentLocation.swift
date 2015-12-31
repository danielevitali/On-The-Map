//
//  Location.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentLocation {
    
    let id: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let address: String
    let url: String?
    let uniqueKey: String
    
    init(studentLocationResponse: StudentLocationResponse) {
        self.id = studentLocationResponse.objectId
        self.firstName = studentLocationResponse.objectId
        self.lastName = studentLocationResponse.objectId
        self.latitude = studentLocationResponse.latitude
        self.longitude = studentLocationResponse.longitude
        self.address = studentLocationResponse.mapString
        self.uniqueKey = studentLocationResponse.uniqueKey
        
        if let mediaUrl = studentLocationResponse.mediaUrl {
            
            //Check that media URL is actually a valid URL
            if NSURL(string: mediaUrl) != nil {
                self.url = studentLocationResponse.mediaUrl
                return
            }
        }
        self.url = nil
    }
    
}