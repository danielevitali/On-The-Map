//
//  AuthenticationPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AuthenticationPresenter: AuthenticationContractPresenter {

    private static let EMAIL_REGEX = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
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

    func onLoginWithFacebookClick(viewController: UIViewController) {
        view.logginInWithFacebook()
        FBSDKLoginManager().logInWithReadPermissions(["public_profile"], fromViewController: viewController, handler: { (result, error) -> Void in
            
            guard error == nil else {
                FBSDKLoginManager().logOut()
                self.view.awaitingUserCredentials()
                self.view.showError("Error logging in with Facebook")
                return
            }
            
            guard !result.isCancelled else {
                FBSDKLoginManager().logOut()
                self.view.awaitingUserCredentials()
                return
            }
            
            let fbToken = result.token.tokenString
            
            self.loginWithFacebook(fbToken)
        })
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
        let emailTest = NSPredicate(format: "SELF MATCHES %@", AuthenticationPresenter.EMAIL_REGEX)
        return emailTest.evaluateWithObject(email)
    }

    private func isValidPassword(password: String) -> Bool {
        return password != ""
    }

    private func loginWithUdacity(email: String, password: String) {
        view.logginInWithUdacity()
        DataManager.getInstance().loginAndGetUserInfo(email, password: password, userInfoCompleteHandler: { (account, errorMessage) -> Void in
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
    
    /*
    HOW CAN I EXTRACT THE SAME CODE IN userInfoCompleteHandler FOR THE ABOVE AND BELOW FUNCTIONS INTO A SINGLE CLOSURE? SO THAT I DON'T HAVE TO WRITE THE SAME CODE TWICE.
    */
    
    private func loginWithFacebook(facebookToken: String) {
        DataManager.getInstance().loginAndGetUserInfo(facebookToken, userInfoCompleteHandler: { (account, errorMessage) -> Void in
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