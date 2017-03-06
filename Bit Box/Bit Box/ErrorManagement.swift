//
//  ErrorManagement.swift
//  Bit Box
//
//  Created by Ashwin Aggarwal on 2/27/17.
//

import UIKit

class ErrorManagement {
    static let sharedInstance = ErrorManagement()
    
    func showAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Uh Oh!", message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismiss)
        return alertController
    }
    

}
