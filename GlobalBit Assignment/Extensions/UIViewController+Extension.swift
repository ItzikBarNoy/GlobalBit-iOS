//
//  UIViewController+Extension.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 28/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showGenericError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "O.K.", style: .destructive)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
