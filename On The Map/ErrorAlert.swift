//
//  SingleButtonAlert.swift
//  On The Map
//
//  Created by Daniele Vitali on 1/1/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlert: UIAlertController {
    
    init(message: String) {
        super.init(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    }
    
    func show(viewController: UIViewController) {
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}