//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class Account {

    var sessionId: String
    var firstName: String!
    var lastName: String!
    var nickname: String!

    init(sessionId: String) {
        self.sessionId = sessionId
    }

}
