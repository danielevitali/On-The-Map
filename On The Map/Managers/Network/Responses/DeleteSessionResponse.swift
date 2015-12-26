//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class DeleteSessionResponse {

    let session: SessionResponse

    init(response: NSDictionary) {
        session = SessionResponse(response: response["session"] as! NSDictionary)
    }
}
