//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class DataManager {

    private static let instance = DataManager()
    private let networkHelper: NetworkHelper

    private var account: Account?
    private var studentLocations: [StudentLocation]?
    
    class func getInstance() -> DataManager {
        return instance
    }

    private init() {
        networkHelper = NetworkHelper.getInstance()
    }

    func loginAndGetUserInfo(email: String, password: String, userInfoCompleteHandler: (account: Account?, errorMessage: String?) -> Void) {
        let requestBody = NewSessionRequest(email: email, password: password)
        networkHelper.createNewSession(requestBody, callback: { (newSessionResponse, errorResponse) in
            if let newSessionResponse = newSessionResponse {
                let accountKey = newSessionResponse.account.key
                self.account = Account(id: accountKey)
                self.getUserInfo(accountKey, userInfoCompleteHandler: userInfoCompleteHandler)
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    userInfoCompleteHandler(account: nil, errorMessage: errorResponse!.error)
                })
            }
        })
    }

    func loginAndGetUserInfo(facebookAccessToken: String, userInfoCompleteHandler: (account: Account?, errorMessage: String?) -> Void) {
        let requestBody = NewSessionWithFacebookRequest(accessToken: facebookAccessToken)
        networkHelper.createNewSession(requestBody, callback: { (newSessionResponse, errorResponse) in
            if let newSessionResponse = newSessionResponse {
                let accountKey = newSessionResponse.account.key
                self.account = Account(id: accountKey)
                self.getUserInfo(accountKey, userInfoCompleteHandler: userInfoCompleteHandler)
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    userInfoCompleteHandler(account: nil, errorMessage: errorResponse!.error)
                })
            }
        })
    }

    private func getUserInfo(accountId: String, userInfoCompleteHandler: (account: Account?, errorMessage: String?) -> Void) {
        networkHelper.fetchUserData(accountId, callback: { (fetchUserDataResponse, errorResponse) in
            if let fetchUserDataResponse = fetchUserDataResponse {
                let user = fetchUserDataResponse.user
                self.account!.firstName = user.firstName
                self.account!.lastName = user.lastName
                self.account!.nickname = user.nickname
                UserDefaultsUtils.saveAccount(self.account!)
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
    
    func getUserInfo() -> Account? {
        return UserDefaultsUtils.getAccount()
    }
    
    func getStudentLocations(studentLocationsCompleteHandler: (studentLocations: [StudentLocation]?, errorMessage: String?) -> Void) {
        if let studentLocations = studentLocations {
            return studentLocationsCompleteHandler(studentLocations: studentLocations, errorMessage: nil)
        } else {
            networkHelper.fetchStudentLocations { (studentLocationsResponse, errorResponse) in
                if let studentLocationsResponse = studentLocationsResponse {
                    self.studentLocations = [StudentLocation]()
                    for studentLocationResponse in studentLocationsResponse.results {
                        self.studentLocations!.append(StudentLocation(studentLocationResponse: studentLocationResponse))
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        studentLocationsCompleteHandler(studentLocations: self.studentLocations!, errorMessage: nil)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        studentLocationsCompleteHandler(studentLocations: nil, errorMessage: errorResponse!.error)
                    })
                }
            }
        }
    }
    
    func forceUpdateStudentLocations(studentLocationsCompleteHandler: (studentLocations: [StudentLocation]?, errorMessage: String?) -> Void) {
        studentLocations = nil
        getStudentLocations(studentLocationsCompleteHandler)
    }
}
