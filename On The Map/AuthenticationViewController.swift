//
//  ViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate, AuthenticationContractView {

    private static let SHOW_MAP_SEGUE_ID = "showMap"

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnUdacityLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var aiUdacityLogin: UIActivityIndicatorView!
    @IBOutlet weak var btnFacebookLogin: UIButton!
    @IBOutlet weak var aiFacebookLogin: UIActivityIndicatorView!

    private var presenter: AuthenticationContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthenticationPresenter(view: self)

        tfEmail.delegate = self
        tfPassword.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    @IBAction func onUdacityLoginClick(sender: AnyObject) {
        presenter.onLoginWithUdacityClick(tfEmail.text!, password: tfPassword.text!)
    }

    @IBAction func onFacebookLoginClick(sender: AnyObject) {
        presenter.onLoginWithFacebookClick()
    }

    @IBAction func onSignUpClick(sender: AnyObject) {
        presenter.onSignUpClick()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == tfEmail {
            presenter.onReturnKeyClickTypingUdacityEmail(tfEmail.text!, password: tfPassword.text!)
        } else {
            presenter.onReturnKeyClickTypingUdacityPassword(tfEmail.text!, password: tfPassword.text!)
        }
        return true
    }

    func logginInWithUdacity() {
        tfEmail.enabled = false
        tfPassword.enabled = false
        btnUdacityLogin.enabled = false
        btnSignUp.enabled = false
        btnFacebookLogin.enabled = false
        aiUdacityLogin.startAnimating()
        aiFacebookLogin.stopAnimating()
    }

    func logginInWithFacebook() {
        tfEmail.enabled = false
        tfPassword.enabled = false
        btnUdacityLogin.enabled = false
        btnSignUp.enabled = false
        btnFacebookLogin.enabled = false
        aiUdacityLogin.stopAnimating()
        aiFacebookLogin.startAnimating()
    }

    func awaitingUserCredentials() {
        tfEmail.enabled = true
        tfPassword.enabled = true
        btnUdacityLogin.enabled = true
        btnSignUp.enabled = true
        btnFacebookLogin.enabled = true
        aiUdacityLogin.stopAnimating()
        aiFacebookLogin.stopAnimating()
    }

    func openUdacityWebsite() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.udacity.com/account/auth#!/signup")!)
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func showInvalidCredentialError() {
        let alert = UIAlertController(title: "Error", message: "Check your email and password and try again", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func showMap() {
        performSegueWithIdentifier(AuthenticationViewController.SHOW_MAP_SEGUE_ID, sender: self)
    }
    
}

