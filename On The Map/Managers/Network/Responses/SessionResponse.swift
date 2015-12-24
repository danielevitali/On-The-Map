//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class AccountResponse {

    let registered: Bool
    let key: String

    init(response: NSDictionary) {
        registered = response["registered"] as! Bool
        key = response["key"] as! String
    }
}
