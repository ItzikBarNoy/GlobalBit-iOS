//
//  UIActivityIndicatorView+Extensions.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 26/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    
    func setup(in view: UIView) {
        self.center = CGPoint(x: view.layer.bounds.width / 2, y: view.layer.bounds.height / 2)
        self.hidesWhenStopped = true
        self.style = UIActivityIndicatorView.Style.large
        self.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(self)
    }
}
