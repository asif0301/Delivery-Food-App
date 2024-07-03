//
//  ViewController+Extention.swift
//  Food
//
//  Created by APPLE on 17/05/2023.
//

import UIKit
import Kingfisher

extension UIViewController {
    
    static var identifire : String {
       return String(describing: self)
    }
    static func instatiate () -> Self {
         
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return
        storyboard.instantiateViewController(withIdentifier: identifire) as! Self
        
    }
}
