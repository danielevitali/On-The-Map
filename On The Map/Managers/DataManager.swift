//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit

class DataManager {

    private static let instance = DataManager()
    private let networkHelper: NetworkHelper

    private var account: Account?
    private var studentsInformation: [String:StudentInformation]?
    
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
    
    func logout(userLogoutCompleteHandler: (errorMessage: String?) -> Void) {
        networkHelper.deleteSession { (deleteSessionResponse, errorResponse) in
            if let _ = deleteSessionResponse {
                self.account = nil
                FBSDKLoginManager().logOut()
                UserDefaultsUtils.clearAccount()
                dispatch_async(dispatch_get_main_queue(), {
                    userLogoutCompleteHandler(errorMessage: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    userLogoutCompleteHandler(errorMessage: errorResponse!.error)
                })
            }
        }
    }
    
    func getUserInfo() -> Account? {
        if account == nil {
            account = UserDefaultsUtils.getAccount()
        }
        return account
    }
    
    func getStudentsInformation(studentsInformationCompleteHandler: (studentsInformation: [StudentInformation]?, errorMessage: String?) -> Void) {
        if let studentsInformation = studentsInformation {
            let studentsInformation = sortStudentsInformation(Array(studentsInformation.values))
            return studentsInformationCompleteHandler(studentsInformation: studentsInformation, errorMessage: nil)
        } else {
            networkHelper.fetchStudentsInformation({ (studentInformationArrayResponse, errorResponse) in
                if let studentInformationArrayResponse = studentInformationArrayResponse {
                    self.studentsInformation = [String:StudentInformation]()
                    for result in studentInformationArrayResponse.results {
                        let info = StudentInformation(studentInformationResponse: result)
                        self.studentsInformation![info.id] = info
                    }
                    let infoArray = self.sortStudentsInformation([StudentInformation](self.studentsInformation!.values))
                    dispatch_async(dispatch_get_main_queue(), {
                        studentsInformationCompleteHandler(studentsInformation: infoArray, errorMessage: nil)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        studentsInformationCompleteHandler(studentsInformation: nil, errorMessage: errorResponse!.error)
                    })
                }
            })
        }
    }
    
    func forceUpdateStudentsInformation(studentsInformationCompleteHandler: (studentsInformation: [StudentInformation]?, errorMessage: String?) -> Void) {
        studentsInformation = nil
        getStudentsInformation(studentsInformationCompleteHandler)
    }
    
    func getStudentInformation(id: String, studentInformationCompleteHandler: (studentInformation: StudentInformation?, errorMessage: String?) -> Void) {
        if let studentsInformation = studentsInformation {
            studentInformationCompleteHandler(studentInformation: studentsInformation[id], errorMessage: nil)
        } else {
            networkHelper.fetchStudentInformation(id, callback: { (studentInformationResponse, errorResponse) in
                if let studentInformationResponse = studentInformationResponse {
                    let info = StudentInformation(studentInformationResponse: studentInformationResponse)
                    self.addToStudentsInformation(info)
                    dispatch_async(dispatch_get_main_queue(), {
                        studentInformationCompleteHandler(studentInformation: info, errorMessage: nil)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        studentInformationCompleteHandler(studentInformation: nil, errorMessage: errorResponse!.error)
                    })
                }
            })
        }
    }
    
    func setStudentInformation(coordinate: CLLocationCoordinate2D, address: String, url: String, updateInformationCompleteHandler: (userInformation: StudentInformation?, errorMessage: String?) -> Void) {
        if let account = account {
            let studentInformationRequest = StudentInformationRequest(uniqueKey: account.id, firstName: account.firstName, lastName: account.lastName, mapString: address, mediaUrl: url, latitude: coordinate.latitude, longitude: coordinate.longitude)
            if let studentInformationId = account.studentInformationId {
                networkHelper.editStudentInformation(studentInformationId, studentInformationRequest: studentInformationRequest, callback: { (editStudentInformationResponse, errorResponse) in
                    if let editStudentInformationResponse = editStudentInformationResponse {
                        let userInformation = StudentInformation(id: self.account!.studentInformationId!, firstName: self.account!.firstName, lastName: self.account!.lastName, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address, url: url, userId: self.account!.id, lastUpdate: editStudentInformationResponse.updatedAt)
                        self.addToStudentsInformation(userInformation)
                        dispatch_async(dispatch_get_main_queue(), {
                            updateInformationCompleteHandler(userInformation: userInformation, errorMessage: nil)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            updateInformationCompleteHandler(userInformation: nil, errorMessage: errorResponse!.error)
                        })
                    }
                })
            } else {
                networkHelper.postStudentInformation(studentInformationRequest, callback: { (postStudentInformationResponse, errorResponse) in
                    if let postStudentInformationResponse = postStudentInformationResponse {
                        self.account!.studentInformationId = postStudentInformationResponse.objectId
                        UserDefaultsUtils.saveAccount(self.account!)
                        let userInformation = StudentInformation(id: postStudentInformationResponse.objectId, firstName: self.account!.firstName, lastName: self.account!.lastName, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address, url: url, userId: self.account!.id, lastUpdate: postStudentInformationResponse.createdAt)
                        self.addToStudentsInformation(userInformation)
                        dispatch_async(dispatch_get_main_queue(), {
                            updateInformationCompleteHandler(userInformation: userInformation, errorMessage: nil)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            updateInformationCompleteHandler(userInformation: nil, errorMessage: errorResponse!.error)
                        })
                    }
                })
            }
        } else {
            updateInformationCompleteHandler(userInformation: nil, errorMessage: "You have to been logged in")
        }
    }
    
    private func addToStudentsInformation(userInformation: StudentInformation) {
        if studentsInformation == nil {
            studentsInformation = [String:StudentInformation]()
        }
        studentsInformation![userInformation.id] = userInformation
    }
    
    private func sortStudentsInformation(array: [StudentInformation]) -> [StudentInformation] {
        return array.sort({
            return $0.lastUpdate.compare($1.lastUpdate) == NSComparisonResult.OrderedDescending
        })
    }
}
