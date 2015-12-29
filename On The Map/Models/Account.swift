//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class Account: NSObject, NSCoding {

    private static let KEY_ID = "id"
    private static let KEY_FIRST_NAME = "firstName"
    private static let KEY_LAST_NAME = "lastName"
    private static let KEY_NICKNAME = "nickname"
    
    var id: String
    var firstName: String!
    var lastName: String!
    var nickname: String!

    init(id: String) {
        self.id = id
    }

    @objc required init(coder decoder: NSCoder) {
        self.id = decoder.decodeObjectForKey(Account.KEY_ID) as! String
        self.firstName = decoder.decodeObjectForKey(Account.KEY_FIRST_NAME) as! String
        self.lastName = decoder.decodeObjectForKey(Account.KEY_LAST_NAME) as! String
        self.nickname = decoder.decodeObjectForKey(Account.KEY_NICKNAME) as! String
    }
    
    @objc func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id, forKey: Account.KEY_ID)
        coder.encodeObject(self.id, forKey: Account.KEY_FIRST_NAME)
        coder.encodeObject(self.id, forKey: Account.KEY_LAST_NAME)
        coder.encodeObject(self.id, forKey: Account.KEY_NICKNAME)
    }
}
