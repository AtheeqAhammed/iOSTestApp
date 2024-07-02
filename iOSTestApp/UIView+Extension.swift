//
//  UIView+Extension.swift
//  iOSTestApp
//
//  Created by Ateeq Ahmed on 02/07/24.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {return self.cornerRadius}
        set {self.layer.cornerRadius = newValue}
    }
}
