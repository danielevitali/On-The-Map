//
//  StudentLocationRequest.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class StudentInformationRequest {

    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaUrl: String
    let latitude: Double
    let longitude: Double
    
    init(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaUrl: String, latitude: Double, longitude: Double) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaUrl = mediaUrl
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func convertToJson() -> String {
        return "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaUrl)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}"
    }
    
}