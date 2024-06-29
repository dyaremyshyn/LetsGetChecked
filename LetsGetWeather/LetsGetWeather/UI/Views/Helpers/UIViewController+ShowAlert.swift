//
//  UIViewController+ShowAlert.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 28/06/2024.
//

import UIKit
import Combine

extension UIViewController {
    
    func showAlert(title: String?, message: String?, actionTitle: String?, messageAlignment: NSTextAlignment = .natural) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.setMessageAlignment(messageAlignment)
        
        let okAction = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}

