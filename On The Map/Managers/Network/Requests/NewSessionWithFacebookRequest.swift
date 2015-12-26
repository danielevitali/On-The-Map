//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class NewSessionWithFacebookRequest {

    let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func convertToJson() -> String {
        return "{\"facebook_mobile\": {\"access_token\": \"\(accessToken)\"}}"
    }

}
