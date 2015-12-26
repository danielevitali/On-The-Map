//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class UserResponse {

    let firstName: String
    let lastName: String
    let nickname: String

    init(response: NSDictionary) {
        firstName = response["first_name"] as! String
        lastName = response["last_name"] as! String
        nickname = response["nickname"] as! String
    }
}
