//
//  Location.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentInformation {
    
    var id: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var address: String
    var url: String?
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
            setUrl(mediaUrl)
        }
    }
    
    init(id: String, firstName: String, lastName: String, latitude: Double, longitude: Double, address: String, url: String?, userId: String, lastUpdate: NSDate) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.lastUpdate = lastUpdate
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