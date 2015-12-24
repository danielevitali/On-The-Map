//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class DataManager {

    private static let instance: DataManager

    public static func getInstance() -> DataManager {
        if instance == nil {
            instance = DataManager()
        }
        return instance
    }

    private init() {
        NetworkHelper
    }


}
