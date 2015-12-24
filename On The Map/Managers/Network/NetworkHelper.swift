//
// Created by Daniele Vitali on 12/24/15.
// Copyright (c) 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class NetworkHelper {

    private static let BASE_UDACITY_URL = "https://www.udacity.com/api"

    private static let POST_SESSION_PATH = "/session"

    private static let instance: NetworkHelper

    private let sharedSession: NSURLSession!

    public static func getInstance() -> NetworkHelper {
        if instance == nil {
            instance = NetworkHelper()
        }
        return instance
    }

    private init() {
        sharedSession = NSURLSession.sharedSession()
    }

    public func createNewSession(requestBody: NewSessionRequest, completionHandler: (newSessionResponse:NewSessionResponse?, error:NSError?) -> Void) {
        let url = buildUdacityUrl(POST_SESSION_PATH, params: nil)
        let requestBody = NewSessionRequest(email, password: password)
        executePostRequest(url, requestBody, completionHandler: {
            (data, error) in
            if let error = error {
                completionHandler(newTokenResponse: nil, error: error)
            } else {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                completionHandler(newSessionResponse: NewSessionResponse(response: json), error: nil)
            }
        })
    }


    private func buildUdacityUrl(path: String, var params: [String:String]?) -> NSURL {
        if let params = params {
            return NSURL(string: (BASE_UDACITY_URL + path + escapedParameters(params)))!
        }
        return NSURL(string: (BASE_UDACITY_URL + path))!
    }

    private func executeGetRequest(url: NSURL, completionHandler: (data:NSData?, error:NSError?) -> Void) {
        let request = NSURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sharedSession.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            completionHandler(data: data, error: error)
        }).resume()
    }

    private func executePostRequest(url: NSURL, body: NSData, completionHandler: (data:NSData?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
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
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
}
