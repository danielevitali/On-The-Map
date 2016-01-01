//
//  AuthenticationContractPresenter.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

protocol AuthenticationContractPresenter {

    var view: AuthenticationContractView {get}
    
    func onLoginWithUdacityClick(email: String, password: String)

    func onLoginWithFacebookClick(viewController: UIViewController)

    func onSignUpClick()

    func onReturnKeyClickTypingUdacityEmail(email: String, password: String)

    func onReturnKeyClickTypingUdacityPassword(email: String, password: String)

}