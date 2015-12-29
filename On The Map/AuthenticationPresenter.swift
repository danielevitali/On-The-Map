//
//  AuthenticationPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation

class AuthenticationPresenter: AuthenticationContractPresenter {

    let view: AuthenticationContractView

    init(view: AuthenticationContractView) {
        self.view = view
        if DataManager.getInstance().getUserInfo() != nil {
            view.showMap()
        }
    }

    func onLoginWithUdacityClick(email: String, password: String) {
        guard isValidEmail(email) && isValidPassword(password) else {
            view.showInvalidCredentialError()
            return
        }
        loginWithUdacity(email, password: password)
    }

    func onLoginWithFacebookClick() {
        //TODO implement login with facebook
    }

    func onSignUpClick() {
        view.openUdacityWebsite()
    }

    func onReturnKeyClickTypingUdacityEmail(email: String, password: String) {
        view.dismissKeyboard()
        if isValidEmail(email) && isValidPassword(password) {
            loginWithUdacity(email, password: password)
        }
    }

    func onReturnKeyClickTypingUdacityPassword(email: String, password: String) {
        view.dismissKeyboard()
        if isValidEmail(email) && isValidPassword(password) {
            loginWithUdacity(email, password: password)
        }
    }

    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }

    private func isValidPassword(password: String) -> Bool {
        return password != ""
    }

    private func loginWithUdacity(email: String, password: String) {
        view.logginInWithUdacity()
        DataManager.getInstance().loginAndGetUserInfo(email, password: password, userInfoCompleteHandler: { (account, errorMessage) in
            self.view.awaitingUserCredentials()
            if let errorMessage = errorMessage {
                self.view.showError(errorMessage)
            } else  {
                guard account != nil else {
                    self.view.showError("Unknown error")
                    return
                }
                self.view.showMap()
            }
        })
    }
}