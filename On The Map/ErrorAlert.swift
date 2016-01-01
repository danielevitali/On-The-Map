//
//  SingleButtonAlert.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/1/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlert {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    func show(viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}