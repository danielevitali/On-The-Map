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
    let latitude: Float
    let longitude: Float
    let address: String
    let url: String
    let uniqueKey: String
    
    init(studentLocationResponse: StudentLocationResponse) {
        self.id = studentLocationResponse.objectId
        self.firstName = studentLocationResponse.objectId
        self.lastName = studentLocationResponse.objectId
        self.latitude = studentLocationResponse.latitude
        self.longitude = studentLocationResponse.longitude
        self.address = studentLocationResponse.mapString
        self.url = studentLocationResponse.mediaUrl
        self.uniqueKey = studentLocationResponse.uniqueKey
    }
    
}