//
// Created by Daniele Vitali on 12/26/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class ErrorResponse {

    let status: NSNumber?
    let error: String

    init(error: NSError) {
        self.error = error.localizedDescription
        self.status = nil
    }

    init(response: NSDictionary) {
        self.error = response["error"] as! String
        self.status = response["status"] as? NSNumber
    }
}
