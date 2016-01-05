//
//  ViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate, AuthenticationContractView {

    private static let SHOW_LOCATIONS_SEGUE_ID = "showStudentsSegue"
    private static let BTN_UDACITY_LOGIN_TEXT = "LOGIN WITH UDACITY"
    private static let BTN_FACEBOOK_LOGIN_TEXT = "LOGIN WITH FACEBOOK"

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnUdacityLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var aiUdacityLogin: UIActivityIndicatorView!
    @IBOutlet weak var btnFacebookLogin: UIButton!
    @IBOutlet weak var aiFacebookLogin: UIActivityIndicatorView!

    var presenter: AuthenticationContractPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthenticationPresenter(view: self)

        tfEmail.delegate = self
        tfPassword.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tfEmail.text = ""
        tfPassword.text = ""
    }

    @IBAction func onUdacityLoginClick(sender: AnyObject) {
        presenter.onLoginWithUdacityClick(tfEmail.text!, password: tfPassword.text!)
    }

    @IBAction func onFacebookLoginClick(sender: AnyObject) {
        presenter.onLoginWithFacebookClick(self)
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
        btnUdacityLogin.setTitle("", forState: .Normal)
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
        btnFacebookLogin.setTitle("", forState: .Normal)
        aiUdacityLogin.stopAnimating()
        aiFacebookLogin.startAnimating()
    }

    func awaitingUserCredentials() {
        tfEmail.enabled = true
        tfPassword.enabled = true
        btnUdacityLogin.enabled = true
        btnUdacityLogin.setTitle(AuthenticationViewController.BTN_UDACITY_LOGIN_TEXT, forState: .Normal)
        btnSignUp.enabled = true
        btnFacebookLogin.enabled = true
        btnFacebookLogin.setTitle(AuthenticationViewController.BTN_FACEBOOK_LOGIN_TEXT, forState: .Normal)
        aiUdacityLogin.stopAnimating()
        aiFacebookLogin.stopAnimating()
    }

    func openUdacityWebsite() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.udacity.com/account/auth#!/signup")!)
    }

    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }

    func showInvalidCredentialError() {
        ErrorAlert(message: "Check your email and password and try again").show(self)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func showMap() {
        performSegueWithIdentifier(AuthenticationViewController.SHOW_LOCATIONS_SEGUE_ID, sender: self)
    }
    
}

