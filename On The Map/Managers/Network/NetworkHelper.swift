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

    func createNewSession(requestBody: NewSessionRequest, callback: (newSessionResponse:NewSessionResponse?, error:NSError?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.SESSION_PATH, params: nil)
        executePostRequest(url, body: requestBody.convertToJson(), completionHandler: {
            (data, error) in
            if let data = data {
                let json = self.extractJson(data)
                callback(newSessionResponse: NewSessionResponse(response: json), error: nil)
            } else {
                callback(newSessionResponse: nil, error: error!)
            }
        })
    }

    func fetchUserData(callback: (fetchUserDataResponse:FetchUserDataResponse?, error:NSError?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.USER_DATA_PATH, params: nil)
        executeGetRequest(url, completionHandler: {
            (data, error) in
            if let data = data {
                let json = self.extractJson(data)
                callback(fetchUserDataResponse: FetchUserDataResponse(response: json), error: nil)
            } else {
                callback(fetchUserDataResponse: nil, error: error!)
            }
        })
    }

    func deleteSession(callback: (deleteSessionResponse:DeleteSessionResponse?, error:NSError?) -> Void) {
        let url = buildUdacityUrl(NetworkHelper.SESSION_PATH, params: nil)
        executeDeleteRequest(url, completionHandler: {
            (data, error) in
            if let data = data {
                let json = self.extractJson(data)
                callback(deleteSessionResponse: DeleteSessionResponse(response: json), error: nil)
            } else {
                callback(deleteSessionResponse: nil, error: error!)
            }
        })
    }

    private func buildUdacityUrl(path: String, params: [String:String]?) -> NSURL {
        if let params = params {
            return NSURL(string: (NetworkHelper.BASE_UDACITY_URL + path + escapedParameters(params)))!
        }
        return NSURL(string: (NetworkHelper.BASE_UDACITY_URL + path))!
    }

    private func executeGetRequest(url: NSURL, completionHandler: (data:NSData?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, error: error)
        }).resume()
    }

    private func executePostRequest(url: NSURL, body: String, completionHandler: (data:NSData?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, error: error)
        }).resume()
    }

    private func executeDeleteRequest(url: NSURL, completionHandler: (data:NSData?, error:NSError?) -> Void) {
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
            completionHandler(data: data, error: error)
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
