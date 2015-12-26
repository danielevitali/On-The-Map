//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class DataManager {

    private static let instance = DataManager()
    private let networkHelper: NetworkHelper

    private var account: Account?

    class func getInstance() -> DataManager {
        return instance
    }

    private init() {
        networkHelper = NetworkHelper.getInstance()
    }

    func loginAndGetUserInfo(email: String, password: String, userInfoCompleteHandler: (account: Account?, errorMessage: String?) -> Void) {
        let requestBody = NewSessionRequest(email: email, password: password)
        networkHelper.createNewSession(requestBody, callback: {
            (newSessionResponse, errorResponse) in
            if let newSessionResponse = newSessionResponse {
                let sessionId = newSessionResponse.session.id
                self.account = Account(sessionId: sessionId)
                self.getUserInfo(sessionId, userInfoCompleteHandler: userInfoCompleteHandler)
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    userInfoCompleteHandler(account: nil, errorMessage: errorResponse!.error)
                })
            }
        })
    }

    func loginAndGetUserInfo(facebookAccessToken: String, userInfoCompleteHandler: (account: Account?, errorMessage: String?) -> Void) {
        let requestBody = NewSessionWithFacebookRequest(accessToken: facebookAccessToken)
        networkHelper.createNewSession(requestBody, callback: {
            (newSessionResponse, errorResponse) in
            if let newSessionResponse = newSessionResponse {
                let sessionId = newSessionResponse.session.id
                self.account = Account(sessionId: sessionId)
                self.getUserInfo(sessionId, userInfoCompleteHandler: userInfoCompleteHandler)
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    userInfoCompleteHandler(account: nil, errorMessage: errorResponse!.error)
                })
            }
        })
    }

    private func getUserInfo(sessionId: String, userInfoCompleteHandler: (account: Account?, errorMessage: String?) -> Void) {
        networkHelper.fetchUserData({
            (fetchUserDataResponse, errorResponse) in
            if let fetchUserDataResponse = fetchUserDataResponse {
                let user = fetchUserDataResponse.user
                self.account!.firstName = user.firstName
                self.account!.lastName = user.lastName
                self.account!.nickname = user.nickname
                dispatch_async(dispatch_get_main_queue(), {
                    userInfoCompleteHandler(account: self.account, errorMessage: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    userInfoCompleteHandler(account: nil, errorMessage: errorResponse!.error)
                })
            }
        })
    }
}
