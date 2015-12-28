//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class NetworkHelper {

    private static let BASE_UDACITY_URL = "https://www.udacity.com/api"
    private static let UDACITY_SESSION_PATH = "/session"
    private static let UDACITY_USER_DATA_PATH = "/users/{id}"
    
    private static let BASE_PARSE_URL = "https://api.parse.com/1"
    private static let PARSE_STUDENT_LOCATIONS_PATH = "/classes/StudentLocation"
    private static let PARSE_STUDENT_LOCATION_PATH = "/classes/StudentLocation/{id}"
    
    private static let APPLICATION_JSON_HEADER_VALUE = "application/json"
    private static let CONTENT_TYPE_HEADER_NAME = "Content-Type"
    private static let ACCEPT_HEADER_NAME = "Accept"
    private static let PARSE_APP_ID_HEADER_NAME = "X-Parse-Application-Id"
    private static let PARSE_APP_ID_HEADER_VALUE = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    private static let PARSE_API_KEY_HEADER_NAME = "X-Parse-REST-API-Key"
    private static let PARSE_API_KEY_HEADER_VALUE = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"

    private static let instance = NetworkHelper()

    private let sharedSession: NSURLSession!

    static func getInstance() -> NetworkHelper {
        return instance
    }

    private init() {
        sharedSession = NSURLSession.sharedSession()
    }

    func createNewSession(requestBody: NewSessionRequest, callback: (newSessionResponse: NewSessionResponse?, errorResponse: ErrorResponse?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.UDACITY_SESSION_PATH, params: nil)
        executeUdacityPostRequest(url, body: requestBody.convertToJson(), completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractUdacityJson(data)
                if response.statusCode == 200 {
                    let newSessionResponse = NewSessionResponse(response: json)
                    callback(newSessionResponse: newSessionResponse, errorResponse: nil)
                } else {
                    let errorResponse = ErrorResponse(response: json)
                    callback(newSessionResponse: nil, errorResponse: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(newSessionResponse: nil, errorResponse: errorResponse)
            }
        })
    }

    func createNewSession(requestBody: NewSessionWithFacebookRequest, callback: (newSessionResponse: NewSessionResponse?, errorResponse: ErrorResponse?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.UDACITY_SESSION_PATH, params: nil)
        executeUdacityPostRequest(url, body: requestBody.convertToJson(), completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractUdacityJson(data)
                if response.statusCode == 200 {
                    let newSessionResponse = NewSessionResponse(response: json)
                    callback(newSessionResponse: newSessionResponse, errorResponse: nil)
                } else {
                    let errorResponse = ErrorResponse(response: json)
                    callback(newSessionResponse: nil, errorResponse: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(newSessionResponse: nil, errorResponse: errorResponse)
            }
        })
    }

    func fetchUserData(id: String, callback: (fetchUserDataResponse: FetchUserDataResponse?, errorResponse: ErrorResponse?) -> Void) {
        let path = replacePlaceholderPathWithId(path: NetworkHelper.UDACITY_USER_DATA_PATH, id: id)
        let url = buildUdacityUrl(path, params: nil)
        executeUdacityGetRequest(url, completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractUdacityJson(data)
                if response.statusCode == 200 {
                    let fetchUserDataResponse = FetchUserDataResponse(response: json)
                    callback(fetchUserDataResponse: fetchUserDataResponse, errorResponse: nil)
                } else {
                    let errorResponse = ErrorResponse(response: json)
                    callback(fetchUserDataResponse: nil, errorResponse: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(fetchUserDataResponse: nil, errorResponse: errorResponse)
            }
        })
    }

    func deleteSession(callback: (deleteSessionResponse: DeleteSessionResponse?, errorResponse: ErrorResponse?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.UDACITY_SESSION_PATH, params: nil)
        executeUdacityDeleteRequest(url, completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractUdacityJson(data)
                if response.statusCode == 200 {
                    let deleteSessionResponse = DeleteSessionResponse(response: json)
                    callback(deleteSessionResponse: deleteSessionResponse, errorResponse: nil)
                } else {
                    let errorResponse = ErrorResponse(response: json)
                    callback(deleteSessionResponse: nil, errorResponse: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(deleteSessionResponse: nil, errorResponse: errorResponse)
            }
        })
    }
    
    func fetchStudentLocations(callback: (studentLocationsResponse: StudentLocationsResponse?, errorResponse: ErrorResponse?) -> Void) {
        let url = buildParseUrl(NetworkHelper.PARSE_STUDENT_LOCATIONS_PATH, params: nil)
        executeUdacityGetRequest(url, completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractParseJson(data)
                if response.statusCode == 200 {
                    let studentLocationsResponse = StudentLocationsResponse(response: json)
                    callback(studentLocationsResponse: studentLocationsResponse, errorResponse: nil)
                } else {
                    let errorResponse = ErrorResponse(response: json)
                    callback(studentLocationsResponse: nil, errorResponse: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(studentLocationsResponse: nil, errorResponse: errorResponse)
            }
        })
    }
    
    func updateStudentLocation(studentLocationRequest: StudentLocationRequest, callback: (studentLocationsResponse: StudentLocationsResponse?, errorResponse: ErrorResponse?) -> Void) {
        let url = buildParseUrl(NetworkHelper.PARSE_STUDENT_LOCATIONS_PATH, params: nil)
        executeUdacityPostRequest(url, studentLocationRequest.convertToJson(), completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractParseJson(data)
                if response.statusCode == 200 {
                    let studentLocationsResponse = StudentLocationsResponse(response: json)
                    callback(studentLocationsResponse: studentLocationsResponse, errorResponse: nil)
                } else {
                    let errorResponse = ErrorResponse(response: json)
                    callback(studentLocationsResponse: nil, errorResponse: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(studentLocationsResponse: nil, errorResponse: errorResponse)
            }
        })
    }

    private func buildUdacityUrl(path: String, params: [String:String]?) -> NSURL {
        if let params = params {
            return NSURL(string: (NetworkHelper.BASE_UDACITY_URL + path + escapedParameters(params)))!
        }
        return NSURL(string: (NetworkHelper.BASE_UDACITY_URL + path))!
    }

    private func executeUdacityGetRequest(url: NSURL, completionHandler: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.addValue(NetworkHelper.APPLICATION_JSON_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.ACCEPT_HEADER_NAME)
        request.addValue(NetworkHelper.APPLICATION_JSON_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.CONTENT_TYPE_HEADER_NAME)
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }

    private func executeUdacityPostRequest(url: NSURL, body: String, completionHandler: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue(NetworkHelper.APPLICATION_JSON_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.ACCEPT_HEADER_NAME)
        request.addValue(NetworkHelper.APPLICATION_JSON_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.CONTENT_TYPE_HEADER_NAME)
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }

    private func executeUdacityDeleteRequest(url: NSURL, completionHandler: (data: NSData?, response: NSHTTPURLResponse?, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies as [NSHTTPCookie]! {
            if cookie.name == "XSRF-TOKEN" {
                xsrfCookie = cookie
            }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }
    
    private func buildParseUrl(path: String, params: [String:String]?) -> NSURL {
        if let params = params {
            return NSURL(string: (NetworkHelper.BASE_PARSE_URL + path + escapedParameters(params)))!
        }
        return NSURL(string: (NetworkHelper.BASE_PARSE_URL + path))!
    }
    
    private func executeParseGetRequest(url: NSURL, completionHandler: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.addValue(NetworkHelper.PARSE_APP_ID_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.PARSE_APP_ID_HEADER_NAME)
        request.addValue(NetworkHelper.PARSE_API_KEY_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.PARSE_API_KEY_HEADER_NAME)
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }
    
    private func executeParsePostRequest(url: NSURL, body: String, completionHandler: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue(NetworkHelper.PARSE_APP_ID_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.PARSE_APP_ID_HEADER_NAME)
        request.addValue(NetworkHelper.PARSE_API_KEY_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.PARSE_API_KEY_HEADER_NAME)
        request.addValue(NetworkHelper.APPLICATION_JSON_HEADER_VALUE, forHTTPHeaderField: NetworkHelper.CONTENT_TYPE_HEADER_NAME)
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }

    private func escapedParameters(parameters: [String:String]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let escapedValue = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (urlVars.isEmpty ? "" : "?") + urlVars.joinWithSeparator("&")
    }

    private func extractUdacityJson(data: NSData) -> NSDictionary {
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
        return try! NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments) as! NSDictionary
    }
    
    private func extractParseJson(data: NSData) -> NSDictionary {
        return try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
    }
    
    private func replacePlaceholderPathWithId(path oldPath:String, id: String) -> String {
        var path = oldPath
        path.replaceRange(path.rangeOfString("{id}")!, with: id)
        return path
    }
}
