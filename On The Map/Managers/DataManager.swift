//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreLocation

class DataManager {

    private static let instance = DataManager()
    private let networkHelper: NetworkHelper

    private var account: Account?
    private var studentLocations: [String:StudentLocation]?
    
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
        if account == nil {
            account = UserDefaultsUtils.getAccount()
        }
        return account
    }
    
    func clearUserInfo() {
        account = nil
        UserDefaultsUtils.clearAccount()
    }
    
    func getStudentLocations(studentLocationsCompleteHandler: (studentLocations: [StudentLocation]?, errorMessage: String?) -> Void) {
        if let studentLocations = studentLocations {
            let locations = Array(studentLocations.values)
            return studentLocationsCompleteHandler(studentLocations: locations, errorMessage: nil)
        } else {
            networkHelper.fetchStudentLocations { (studentLocationsResponse, errorResponse) in
                if let studentLocationsResponse = studentLocationsResponse {
                    self.studentLocations = [String:StudentLocation]()
                    for studentLocationResponse in studentLocationsResponse.results {
                        let location = StudentLocation(studentLocationResponse: studentLocationResponse)
                        self.studentLocations![location.id] = location
                    }
                    let locations = [StudentLocation](self.studentLocations!.values)
                    dispatch_async(dispatch_get_main_queue(), {
                        studentLocationsCompleteHandler(studentLocations: locations, errorMessage: nil)
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
    
    func getStudentLocation(id: String, studentLocationCompleteHandler: (studentLocation: StudentLocation?, errorMessage: String?) -> Void) {
        if let studentLocations = studentLocations {
            studentLocationCompleteHandler(studentLocation: studentLocations[id], errorMessage: nil)
        } else {
            networkHelper.fetchStudentLocation(id, callback: { (studentLocationResponse, errorResponse) in
                if let studentLocationResponse = studentLocationResponse {
                    self.studentLocations = [String:StudentLocation]()
                    let location = StudentLocation(studentLocationResponse: studentLocationResponse)
                    self.studentLocations![location.id] = location
                    dispatch_async(dispatch_get_main_queue(), {
                        studentLocationCompleteHandler(studentLocation: location, errorMessage: nil)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        studentLocationCompleteHandler(studentLocation: nil, errorMessage: errorResponse!.error)
                    })
                }
            })
        }
    }
    
    func setStudentLocation(coordinate: CLLocationCoordinate2D, address: String, url: String, updateLocationCompleteHandler: (userLocation: StudentLocation?, errorMessage: String?) -> Void) {
        if let account = account {
            let studentLocationRequest = StudentLocationRequest(uniqueKey: account.id, firstName: account.firstName, lastName: account.lastName, mapString: address, mediaUrl: url, latitude: coordinate.latitude, longitude: coordinate.longitude)
            if let locationId = account.locationId {
                networkHelper.editStudentLocation(locationId, studentLocationRequest: studentLocationRequest, callback: { (editStudentLocationResponse, errorResponse) in
                    if editStudentLocationResponse != nil {
                        let userLocation = StudentLocation(id: account!.locationId, firstName: account!.firstName, lastName: account!.lastName, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address, url: url, userId: account!.id)
                        dispatch_async(dispatch_get_main_queue(), {
                            updateLocationCompleteHandler(userLocation: userLocation, errorMessage: nil)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            updateLocationCompleteHandler(userLocation: nil, errorMessage: errorResponse!.error)
                        })
                    }
                })
            } else {
                networkHelper.postStudentLocation(studentLocationRequest, callback: { (postStudentLocationResponse, errorResponse) in
                    if let postStudentLocationResponse = postStudentLocationResponse {
                        self.account!.locationId = postStudentLocationResponse.objectId
                        let userLocation = StudentLocation(id: account!.locationId, firstName: account!.firstName, lastName: account!.lastName, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address, url: url, userId: account!.id)
                        dispatch_async(dispatch_get_main_queue(), {
                            updateLocationCompleteHandler(userLocation: userLocation, errorMessage: nil)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            updateLocationCompleteHandler(userLocation: nil, errorMessage: errorResponse!.error)
                        })
                    }
                })
            }
        } else {
            updateLocationCompleteHandler(account: nil, errorMessage: "You have to been logged in")
        }
    }
    
    private func addUserToStudentLocations(userLocation: StudentLocation) {
        if let studentLocations = studentLocations {
            studentLocations[userLocation.id] = userLocation
        }
    }
}
