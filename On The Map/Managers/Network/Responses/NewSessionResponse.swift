//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class NewSessionResponse {

    let account: AccountResponse
    let session: SessionResponse

    init(response: NSDictionary) {
        account = AccountResponse(response["account"])
        session = AccountResponse(response["session"])
    }
}
