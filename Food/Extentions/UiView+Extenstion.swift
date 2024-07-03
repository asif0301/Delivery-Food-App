//
//  UiView+Extenstion.swift
//  Food
//
//  Created by APPLE on 12/05/2023.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var conerRadius : CGFloat {
        get{ return conerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}


