//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class NetworkHelper {

    private static let BASE_UDACITY_URL = "https://www.udacity.com/api"

    private static let SESSION_PATH = "/session"
    private static let USER_DATA_PATH = "/users/{id}"

    private static let instance = NetworkHelper()

    private let sharedSession: NSURLSession!

    static func getInstance() -> NetworkHelper {
        return instance
    }

    private init() {
        sharedSession = NSURLSession.sharedSession()
    }

    func createNewSession(requestBody: NewSessionRequest, callback: (newSessionResponse: NewSessionResponse?, errorResponse: ErrorResponse?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.SESSION_PATH, params: nil)
        executePostRequest(url, body: requestBody.convertToJson(), completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractJson(data)
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
        let url = buildUdacityUrl(NetworkHelper.SESSION_PATH, params: nil)
        executePostRequest(url, body: requestBody.convertToJson(), completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractJson(data)
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
        var path = NetworkHelper.USER_DATA_PATH
        path.replaceRange(path.rangeOfString("{id}")!, with: id)
        let url = buildUdacityUrl(path, params: nil)
        executeGetRequest(url, completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractJson(data)
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
        let url = buildUdacityUrl(NetworkHelper.SESSION_PATH, params: nil)
        executeDeleteRequest(url, completionHandler: {
            (data, response, error) in
            if let response = response, let data = data{
                let json = self.extractJson(data)
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

    private func buildUdacityUrl(path: String, params: [String:String]?) -> NSURL {
        if let params = params {
            return NSURL(string: (NetworkHelper.BASE_UDACITY_URL + path + escapedParameters(params)))!
        }
        return NSURL(string: (NetworkHelper.BASE_UDACITY_URL + path))!
    }

    private func executeGetRequest(url: NSURL, completionHandler: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }

    private func executePostRequest(url: NSURL, body: String, completionHandler: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }

    private func executeDeleteRequest(url: NSURL, completionHandler: (data: NSData?, response: NSHTTPURLResponse?, error: NSError?) -> Void) {
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

    private func escapedParameters(parameters: [String:String]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let escapedValue = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (urlVars.isEmpty ? "" : "?") + urlVars.joinWithSeparator("&")
    }

    private func extractJson(data: NSData) -> NSDictionary {
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
        return try! NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments) as! NSDictionary
    }
}
