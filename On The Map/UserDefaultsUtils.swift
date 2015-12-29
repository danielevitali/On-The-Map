//
//  UserDefaultsUtils.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/28/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class UserDefaultsUtils {
    
    private static let KEY_ACCOUNT = "KEY_ACCOUNT"
    
    static func saveAccount(account: Account) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(account), forKey: UserDefaultsUtils.KEY_ACCOUNT)
    }
    
    static func getAccount() -> Account? {
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = defaults.dataForKey(UserDefaultsUtils.KEY_ACCOUNT)
        if let data = data {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Account
        }
        return nil
    }
    
}