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
    let userId: String
    
    init(studentLocationResponse: StudentLocationResponse) {
        self.id = studentLocationResponse.objectId
        self.firstName = studentLocationResponse.firstName
        self.lastName = studentLocationResponse.lastName
        self.latitude = studentLocationResponse.latitude
        self.longitude = studentLocationResponse.longitude
        self.address = studentLocationResponse.mapString
        self.userId = studentLocationResponse.uniqueKey
        if let mediaUrl = studentLocationResponse.mediaUrl {
            setUrl(mediaUrl)
        }
        self.url = nil
    }
    
    init(id: String, firstName: String, lastName: String, latitude: Double, longitude: Double, address: String, url: String?, userId: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.userId = userId
        setUrl(url)
    }
    
    private func setUrl(url: String) {
        if NSURL(string: mediaUrl) != nil {
            self.url = url
            return
        }
        self.url = nil
    }
}