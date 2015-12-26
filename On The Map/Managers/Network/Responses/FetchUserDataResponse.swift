//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class FetchUserDataResponse {

    let user: UserResponse

    init(response: NSDictionary) {
        user = UserResponse(response: response["user"] as! NSDictionary)
    }
}
