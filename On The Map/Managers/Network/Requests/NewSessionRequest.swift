//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class NewSessionRequest {

    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    func convertToJson() -> String {
        return "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
    }

}
