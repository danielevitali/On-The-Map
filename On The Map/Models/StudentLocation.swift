//
//  Location.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentLocation {
    
    var id: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var address: String
    var url: String?
    var userId: String
    
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
    }
    
    init(id: String, firstName: String, lastName: String, latitude: Double, longitude: Double, address: String, url: String?, userId: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.userId = userId
        if let url = url {
            setUrl(url)
        }
    }
    
    private func setUrl(url: String) {
        if NSURL(string: url) != nil {
            self.url = url
            return
        }
        self.url = nil
    }
}