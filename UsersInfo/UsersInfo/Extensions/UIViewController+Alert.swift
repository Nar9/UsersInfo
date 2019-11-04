//
//  UIViewController+Alert.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withMessage message: String, andTitle title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Strings.okString, style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
