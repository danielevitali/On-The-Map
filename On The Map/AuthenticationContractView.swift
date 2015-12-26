//
//  AuthenticationContractView.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

protocol AuthenticationContractView {

    func logginInWithUdacity()

    func logginInWithFacebook()

    func awaitingUserCredentials()

    func showInvalidCredentialError()

    func showMap()

    func dismissKeyboard()

    func openUdacityWebsite()

    func showError(message: String)

}