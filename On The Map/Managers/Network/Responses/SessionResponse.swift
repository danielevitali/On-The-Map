//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class SessionResponse {

    let id: String
    let expiration: String

    init(response: NSDictionary) {
        id = response["id"] as! String
        expiration = response["expiration"] as! String
    }
}
