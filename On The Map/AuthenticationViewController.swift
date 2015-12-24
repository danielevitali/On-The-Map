//
//  ViewController.swift
//  On The Map
//
//  Created by Daniele Vitali on 12/23/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate, AuthenticationContractView {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnUdacityLogin: UIButton!
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
        btnFacebookLogin.enabled = false
        aiUdacityLogin.hidden = false
        aiFacebookLogin.hidden = true
    }

    func logginInWithFacebook() {
        tfEmail.enabled = false
        tfPassword.enabled = false
        btnUdacityLogin.enabled = false
        btnFacebookLogin.enabled = false
        aiUdacityLogin.hidden = true
        aiFacebookLogin.hidden = false
    }

    func awaitingUserCredentials() {
        tfEmail.enabled = true
        tfPassword.enabled = true
        btnUdacityLogin.enabled = true
        btnFacebookLogin.enabled = true
        aiUdacityLogin.hidden = true
        aiFacebookLogin.hidden = true
    }

    func showNoInternetConnectionError() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func showInvalidCredentialError() {
        let alert = UIAlertController(title: "Error", message: "Check your credentials and try again", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func showMap() {

    }
    
}

